package clarion;

import clarion.Queryclass;
import clarion.Sectorqueue;
import clarion.Windowmanager;
import clarion.Windowresizeclass;
import clarion.equates.Appstrategy;
import clarion.equates.Constants;
import clarion.equates.Create;
import clarion.equates.Event;
import clarion.equates.Feq;
import clarion.equates.Prop;
import clarion.equates.Resize;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CWin;

public class Queryvisual extends Windowmanager
{
	public Queryclass qc;
	public Windowresizeclass resizer;
	public Sectorqueue queries;
	public Queryvisual()
	{
		qc=null;
		resizer=null;
		queries=null;
	}

	public ClarionNumber init()
	{
		this.resizer=new Windowresizeclass();
		if (!(this.qc.iNIMgr==null)) {
			Clarion.getControl(0).setProperty(Prop.HIDE,Constants.TRUE);
			this.queries=new Sectorqueue();
			this.qc.getQueries(this.queries);
			CWin.createControl(Feq.SAVELISTBOX,Create.LIST,Feq.SAVERESTORETAB,null);
			Clarion.getControl(Feq.SAVELISTBOX).setProperty(Prop.FORMAT,ClarionString.staticConcat("20L(1)~",Constants.DEFAULTQUERYLISTTEXT,"~#2#"));
			Clarion.getControl(Feq.SAVELISTBOX).setProperty(Prop.FROM,this.queries.getString());
			Clarion.getControl(Feq.SAVELISTBOX).setProperty(Prop.VSCROLL,Constants.TRUE);
			Clarion.getControl(Feq.SAVELISTBOX).setProperty(Prop.HSCROLL,Constants.TRUE);
			Clarion.getControl(Feq.SAVELISTBOX).setProperty(Prop.ALRT,1,Constants.MOUSELEFT2);
			CWin.createControl(Feq.SAVEQUERYBUTTON,Create.BUTTON,Feq.SAVERESTORETAB,null);
			Clarion.getControl(Feq.SAVEQUERYBUTTON).setProperty(Prop.TEXT,Constants.DEFAULTSAVETEXT);
			Clarion.getControl(Feq.SAVEQUERYBUTTON).setProperty(Prop.HEIGHT,14);
			CWin.createControl(Feq.DELETEQUERYBUTTON,Create.BUTTON,Feq.SAVERESTORETAB,null);
			Clarion.getControl(Feq.DELETEQUERYBUTTON).setProperty(Prop.TEXT,Constants.DEFAULTDELETETEXT);
			Clarion.getControl(Feq.DELETEQUERYBUTTON).setProperty(Prop.HEIGHT,14);
			CWin.createControl(Feq.RESTOREQUERYBUTTON,Create.BUTTON,Feq.SAVERESTORETAB,null);
			Clarion.getControl(Feq.RESTOREQUERYBUTTON).setProperty(Prop.TEXT,Constants.DELETERESTORETEXT);
			Clarion.getControl(Feq.RESTOREQUERYBUTTON).setProperty(Prop.DISABLE,Constants.TRUE);
			Clarion.getControl(Feq.RESTOREQUERYBUTTON).setProperty(Prop.HEIGHT,14);
			CWin.createControl(Feq.QUERYNAMEPROMPT,Create.PROMPT,Feq.SAVERESTORETAB,null);
			Clarion.getControl(Feq.QUERYNAMEPROMPT).setProperty(Prop.TEXT,Constants.DEFAULTNAMEPROMPT);
			Clarion.getControl(Feq.QUERYNAMEPROMPT).setProperty(Prop.HEIGHT,10);
			Clarion.getControl(Feq.QUERYNAMEPROMPT).setProperty(Prop.TRN,Constants.TRUE);
			CWin.createControl(Feq.QUERYNAMEFIELD,Create.ENTRY,Feq.SAVERESTORETAB,null);
			Clarion.getControl(Feq.QUERYNAMEFIELD).setProperty(Prop.TEXT,"@s50");
			Clarion.getControl(Feq.QUERYNAMEFIELD).setProperty(Prop.HEIGHT,10);
			Clarion.getControl(Feq.QUERYNAMEFIELD).setProperty(Prop.IMM,Constants.TRUE);
			this.firstField.setValue(Feq.SAVELISTBOX);
		}
		return super.init();
	}
	public ClarionNumber takeAccepted()
	{
		{
			int case_1=CWin.field();
			boolean case_1_break=false;
			if (case_1==Feq.QUERYNAMEFIELD) {
				this.reset();
				case_1_break=true;
			}
			if (!case_1_break && case_1==Feq.SAVEQUERYBUTTON) {
				this.updateFields();
				this.qc.save(Clarion.getControl(Feq.QUERYNAMEFIELD).getProperty(Prop.SCREENTEXT).getString());
				this.qc.getQueries(this.queries);
				this.reset();
				case_1_break=true;
			}
			if (!case_1_break && case_1==Feq.RESTOREQUERYBUTTON) {
				this.qc.restore(Clarion.getControl(Feq.QUERYNAMEFIELD).getProperty(Prop.SCREENTEXT).getString());
				this.resetFromQuery();
				CWin.select(Feq.CONTROLTAB);
				case_1_break=true;
			}
			if (!case_1_break && case_1==Feq.DELETEQUERYBUTTON) {
				this.qc.delete(Clarion.getControl(Feq.QUERYNAMEFIELD).getProperty(Prop.SCREENTEXT).getString());
				this.qc.getQueries(this.queries);
				CWin.select(Feq.SAVELISTBOX);
				Clarion.getControl(Feq.QUERYNAMEFIELD).setProperty(Prop.SCREENTEXT,"");
				CWin.update(Feq.QUERYNAMEFIELD);
				this.reset();
				case_1_break=true;
			}
			if (!case_1_break && case_1==Feq.CLEAR) {
				this.qc.clearQuery();
				this.resetFromQuery();
				CWin.post(Event.ACCEPTED,Feq.OK);
				case_1_break=true;
			}
		}
		return super.takeAccepted();
	}
	public ClarionNumber takeFieldEvent()
	{
		{
			int case_1=CWin.field();
			boolean case_1_break=false;
			if (case_1==Feq.QUERYNAMEFIELD) {
				{
					int case_2=CWin.event();
					if (case_2==Event.NEWSELECTION) {
						this.reset();
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1==Feq.SAVELISTBOX) {
				{
					int case_3=CWin.event();
					boolean case_3_break=false;
					if (case_3==Event.ALERTKEY) {
						if (CWin.keyCode()==Constants.MOUSELEFT2) {
							this.queries.get(CWin.choice(Feq.SAVELISTBOX));
							this.qc.restore(this.queries.item.like());
							this.resetFromQuery();
							CWin.post(Event.ACCEPTED,Feq.OK);
						}
						case_3_break=true;
					}
					if (!case_3_break && case_3==Event.NEWSELECTION) {
						this.queries.get(CWin.choice(Feq.SAVELISTBOX));
						Clarion.getControl(Feq.QUERYNAMEFIELD).setClonedProperty(Prop.SCREENTEXT,this.queries.item);
						CWin.update(Feq.QUERYNAMEFIELD);
						this.reset();
						case_3_break=true;
					}
				}
				case_1_break=true;
			}
		}
		return super.takeFieldEvent();
	}
	public ClarionNumber kill()
	{
		ClarionNumber rVal=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		rVal.setValue(super.kill());
		//this.queries;
		if (!(this.resizer==null)) {
			this.resizer.kill();
			//this.resizer;
		}
		return rVal.like();
	}
	public void reset()
	{
		reset(Clarion.newNumber(0));
	}
	public void reset(ClarionNumber force)
	{
		if (!(this.qc.iNIMgr==null)) {
			if (!Clarion.getControl(Feq.QUERYNAMEFIELD).getProperty(Prop.SCREENTEXT).boolValue()) {
				CWin.disable(Feq.DELETEQUERYBUTTON);
				CWin.disable(Feq.RESTOREQUERYBUTTON);
				CWin.disable(Feq.SAVEQUERYBUTTON);
			}
			else {
				this.queries.item.setValue(Clarion.getControl(Feq.QUERYNAMEFIELD).getProperty(Prop.SCREENTEXT));
				this.queries.get(this.queries.ORDER().ascend(this.queries.item));
				if (CError.errorCode()!=0) {
					CWin.disable(Feq.DELETEQUERYBUTTON);
				}
				else {
					CWin.enable(Feq.DELETEQUERYBUTTON);
				}
				CWin.enable(Feq.RESTOREQUERYBUTTON);
				CWin.enable(Feq.SAVEQUERYBUTTON);
			}
		}
		super.reset();
	}
	public ClarionNumber takeWindowEvent()
	{
		{
			int case_1=CWin.event();
			boolean case_1_break=false;
			if (case_1==Event.OPENWINDOW) {
				if (!(this.qc.iNIMgr==null)) {
					CWin.setPosition(Feq.SAVELISTBOX,Clarion.getControl(Feq.SHEETCONTROL).getProperty(Prop.XPOS).add(4).intValue(),Clarion.getControl(Feq.SHEETCONTROL).getProperty(Prop.YPOS).add(16).intValue(),Clarion.getControl(Feq.SHEETCONTROL).getProperty(Prop.WIDTH).subtract(10).intValue(),Clarion.getControl(Feq.SHEETCONTROL).getProperty(Prop.HEIGHT).subtract(48).intValue());
					CWin.unhide(Feq.SAVELISTBOX);
					CWin.setPosition(Feq.SAVEQUERYBUTTON,Clarion.getControl(Feq.SAVELISTBOX).getProperty(Prop.XPOS).add(Clarion.getControl(Feq.SAVELISTBOX).getProperty(Prop.WIDTH)).subtract(45).intValue(),Clarion.getControl(Feq.SAVELISTBOX).getProperty(Prop.YPOS).add(Clarion.getControl(Feq.SAVELISTBOX).getProperty(Prop.HEIGHT)).add(16).intValue(),45,null);
					CWin.unhide(Feq.SAVEQUERYBUTTON);
					CWin.setPosition(Feq.DELETEQUERYBUTTON,Clarion.getControl(Feq.SAVEQUERYBUTTON).getProperty(Prop.XPOS).subtract(47).intValue(),Clarion.getControl(Feq.SAVEQUERYBUTTON).getProperty(Prop.YPOS).intValue(),45,null);
					CWin.unhide(Feq.DELETEQUERYBUTTON);
					CWin.setPosition(Feq.RESTOREQUERYBUTTON,Clarion.getControl(Feq.DELETEQUERYBUTTON).getProperty(Prop.XPOS).subtract(47).intValue(),Clarion.getControl(Feq.SAVEQUERYBUTTON).getProperty(Prop.YPOS).intValue(),45,null);
					CWin.unhide(Feq.RESTOREQUERYBUTTON);
					CWin.setPosition(Feq.QUERYNAMEPROMPT,Clarion.getControl(Feq.SAVELISTBOX).getProperty(Prop.XPOS).intValue(),Clarion.getControl(Feq.SAVELISTBOX).getProperty(Prop.YPOS).add(Clarion.getControl(Feq.SAVELISTBOX).getProperty(Prop.HEIGHT)).add(3).intValue(),null,null);
					CWin.unhide(Feq.QUERYNAMEPROMPT);
					CWin.setPosition(Feq.QUERYNAMEFIELD,Clarion.getControl(Feq.QUERYNAMEPROMPT).getProperty(Prop.XPOS).add(Clarion.getControl(Feq.QUERYNAMEPROMPT).getProperty(Prop.WIDTH)).add(3).intValue(),Clarion.getControl(Feq.QUERYNAMEPROMPT).getProperty(Prop.YPOS).intValue(),Clarion.getControl(Feq.DELETEQUERYBUTTON).getProperty(Prop.XPOS).subtract(Clarion.getControl(Feq.QUERYNAMEPROMPT).getProperty(Prop.XPOS).add(Clarion.getControl(Feq.QUERYNAMEPROMPT).getProperty(Prop.WIDTH)).add(8)).intValue(),null);
					CWin.unhide(Feq.QUERYNAMEFIELD);
				}
				else {
					CWin.hide(Feq.SAVERESTORETAB);
				}
				CWin.setPosition(Feq.CLEAR,Clarion.getControl(Feq.SHEETCONTROL).getProperty(Prop.XPOS).add(Clarion.getControl(Feq.SHEETCONTROL).getProperty(Prop.WIDTH)).subtract(Clarion.getControl(Feq.CLEAR).getProperty(Prop.WIDTH)).intValue(),Clarion.getControl(Feq.SHEETCONTROL).getProperty(Prop.YPOS).add(Clarion.getControl(Feq.SHEETCONTROL).getProperty(Prop.HEIGHT)).add(3).intValue(),50,14);
				CWin.setPosition(Feq.CANCEL,Clarion.getControl(Feq.CLEAR).getProperty(Prop.XPOS).subtract(52).intValue(),Clarion.getControl(Feq.CLEAR).getProperty(Prop.YPOS).intValue(),50,14);
				CWin.setPosition(Feq.OK,Clarion.getControl(Feq.CANCEL).getProperty(Prop.XPOS).subtract(52).intValue(),Clarion.getControl(Feq.CANCEL).getProperty(Prop.YPOS).intValue(),50,14);
				this.resizer.init(Clarion.newNumber(Appstrategy.RESIZE),Clarion.newNumber(Resize.SETMINSIZE));
				this.addItem(this.resizer);
				this.resizer.setParentDefaults();
				if (!(this.qc.iNIMgr==null)) {
					this.qc.iNIMgr.fetch(Clarion.newString(ClarionString.staticConcat("QBE-",this.qc.family)),this.qc.window);
				}
				this.resizer.resize();
				this.resizer.reset();
				Clarion.getControl(0).setProperty(Prop.HIDE,Constants.FALSE);
				case_1_break=true;
			}
			if (!case_1_break && case_1==Event.CLOSEWINDOW) {
				if (!(this.qc.iNIMgr==null)) {
					this.qc.iNIMgr.update(Clarion.newString(ClarionString.staticConcat("QBE-",this.qc.family)),this.qc.window);
				}
				this.qc.save(Clarion.newString("tsMRU"));
				case_1_break=true;
			}
		}
		return super.takeWindowEvent();
	}
	public void resetFromQuery()
	{
	}
	public void updateFields()
	{
	}
}
