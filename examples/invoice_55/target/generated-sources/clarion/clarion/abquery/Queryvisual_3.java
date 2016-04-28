package clarion.abquery;

import clarion.Sectorqueue;
import clarion.abquery.Queryclass_3;
import clarion.abquery.equates.Mconstants;
import clarion.abquery.equates.Mfeq;
import clarion.abresize.Windowresizeclass;
import clarion.abwindow.Windowmanager;
import clarion.equates.Appstrategy;
import clarion.equates.Constants;
import clarion.equates.Create;
import clarion.equates.Event;
import clarion.equates.Prop;
import clarion.equates.Resize;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Queryvisual_3 extends Windowmanager
{
	public Queryclass_3 qc=null;
	public Windowresizeclass resizer=null;
	public Sectorqueue queries=null;
	public Queryvisual_3()
	{
		qc=null;
		resizer=null;
		queries=null;
	}

	public ClarionNumber init()
	{
		this.resizer=new Windowresizeclass();
		if (!(this.qc.inimgr==null)) {
			Clarion.getControl(0).setProperty(Prop.HIDE,Constants.TRUE);
			this.queries=new Sectorqueue();
			this.qc.getqueries(this.queries);
			CWin.createControl(Mfeq.SAVELISTBOX,Create.LIST,Mfeq.SAVERESTORETAB,null);
			Clarion.getControl(Mfeq.SAVELISTBOX).setProperty(Prop.FORMAT,ClarionString.staticConcat("20L(1)~",Mconstants.DEFAULTQUERYLISTTEXT,"~#2#"));
			Clarion.getControl(Mfeq.SAVELISTBOX).setProperty(Prop.FROM,this.queries.getString());
			Clarion.getControl(Mfeq.SAVELISTBOX).setProperty(Prop.VSCROLL,Constants.TRUE);
			Clarion.getControl(Mfeq.SAVELISTBOX).setProperty(Prop.HSCROLL,Constants.TRUE);
			Clarion.getControl(Mfeq.SAVELISTBOX).setProperty(Prop.ALRT,1,Constants.MOUSELEFT2);
			CWin.createControl(Mfeq.SAVEQUERYBUTTON,Create.BUTTON,Mfeq.SAVERESTORETAB,null);
			Clarion.getControl(Mfeq.SAVEQUERYBUTTON).setProperty(Prop.TEXT,Mconstants.DEFAULTSAVETEXT);
			Clarion.getControl(Mfeq.SAVEQUERYBUTTON).setProperty(Prop.HEIGHT,14);
			CWin.createControl(Mfeq.DELETEQUERYBUTTON,Create.BUTTON,Mfeq.SAVERESTORETAB,null);
			Clarion.getControl(Mfeq.DELETEQUERYBUTTON).setProperty(Prop.TEXT,Mconstants.DEFAULTDELETETEXT);
			Clarion.getControl(Mfeq.DELETEQUERYBUTTON).setProperty(Prop.HEIGHT,14);
			CWin.createControl(Mfeq.RESTOREQUERYBUTTON,Create.BUTTON,Mfeq.SAVERESTORETAB,null);
			Clarion.getControl(Mfeq.RESTOREQUERYBUTTON).setProperty(Prop.TEXT,Mconstants.DELETERESTORETEXT);
			Clarion.getControl(Mfeq.RESTOREQUERYBUTTON).setProperty(Prop.DISABLE,Constants.TRUE);
			Clarion.getControl(Mfeq.RESTOREQUERYBUTTON).setProperty(Prop.HEIGHT,14);
			CWin.createControl(Mfeq.QUERYNAMEPROMPT,Create.PROMPT,Mfeq.SAVERESTORETAB,null);
			Clarion.getControl(Mfeq.QUERYNAMEPROMPT).setProperty(Prop.TEXT,Mconstants.DEFAULTNAMEPROMPT);
			Clarion.getControl(Mfeq.QUERYNAMEPROMPT).setProperty(Prop.HEIGHT,10);
			Clarion.getControl(Mfeq.QUERYNAMEPROMPT).setProperty(Prop.TRN,Constants.TRUE);
			CWin.createControl(Mfeq.QUERYNAMEFIELD,Create.ENTRY,Mfeq.SAVERESTORETAB,null);
			Clarion.getControl(Mfeq.QUERYNAMEFIELD).setProperty(Prop.TEXT,"@s50");
			Clarion.getControl(Mfeq.QUERYNAMEFIELD).setProperty(Prop.HEIGHT,10);
			Clarion.getControl(Mfeq.QUERYNAMEFIELD).setProperty(Prop.IMM,Constants.TRUE);
			this.firstfield.setValue(Mfeq.SAVELISTBOX);
		}
		return super.init();
	}
	public ClarionNumber takeaccepted()
	{
		{
			int case_1=CWin.field();
			boolean case_1_break=false;
			if (case_1==Mfeq.QUERYNAMEFIELD) {
				this.reset();
				case_1_break=true;
			}
			if (!case_1_break && case_1==Mfeq.SAVEQUERYBUTTON) {
				this.updatefields();
				this.qc.save(Clarion.getControl(Mfeq.QUERYNAMEFIELD).getProperty(Prop.SCREENTEXT).getString());
				this.qc.getqueries(this.queries);
				this.reset();
				case_1_break=true;
			}
			if (!case_1_break && case_1==Mfeq.RESTOREQUERYBUTTON) {
				this.qc.restore(Clarion.getControl(Mfeq.QUERYNAMEFIELD).getProperty(Prop.SCREENTEXT).getString());
				this.resetfromquery();
				CWin.select(Mfeq.CONTROLTAB);
				case_1_break=true;
			}
			if (!case_1_break && case_1==Mfeq.DELETEQUERYBUTTON) {
				this.qc.delete(Clarion.getControl(Mfeq.QUERYNAMEFIELD).getProperty(Prop.SCREENTEXT).getString());
				this.qc.getqueries(this.queries);
				CWin.select(Mfeq.SAVELISTBOX);
				Clarion.getControl(Mfeq.QUERYNAMEFIELD).setProperty(Prop.SCREENTEXT,"");
				CWin.update(Mfeq.QUERYNAMEFIELD);
				this.reset();
				case_1_break=true;
			}
			if (!case_1_break && case_1==Mfeq.CLEAR) {
				this.qc.clearquery();
				this.resetfromquery();
				CWin.post(Event.ACCEPTED,Mfeq.OK);
				case_1_break=true;
			}
		}
		return super.takeaccepted();
	}
	public ClarionNumber takefieldevent()
	{
		{
			int case_1=CWin.field();
			boolean case_1_break=false;
			if (case_1==Mfeq.QUERYNAMEFIELD) {
				{
					int case_2=CWin.event();
					if (case_2==Event.NEWSELECTION) {
						this.reset();
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1==Mfeq.SAVELISTBOX) {
				{
					int case_3=CWin.event();
					boolean case_3_break=false;
					if (case_3==Event.ALERTKEY) {
						if (CWin.keyCode()==Constants.MOUSELEFT2) {
							this.queries.get(CWin.choice(Mfeq.SAVELISTBOX));
							this.qc.restore(this.queries.item.like());
							this.resetfromquery();
							CWin.post(Event.ACCEPTED,Mfeq.OK);
						}
						case_3_break=true;
					}
					if (!case_3_break && case_3==Event.NEWSELECTION) {
						this.queries.get(CWin.choice(Mfeq.SAVELISTBOX));
						Clarion.getControl(Mfeq.QUERYNAMEFIELD).setClonedProperty(Prop.SCREENTEXT,this.queries.item);
						CWin.update(Mfeq.QUERYNAMEFIELD);
						this.reset();
						case_3_break=true;
					}
				}
				case_1_break=true;
			}
		}
		return super.takefieldevent();
	}
	public ClarionNumber kill()
	{
		ClarionNumber rval=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		rval.setValue(super.kill());
		//this.queries;
		if (!(this.resizer==null)) {
			this.resizer.kill();
			//this.resizer;
		}
		return rval.like();
	}
	public void reset()
	{
		reset(Clarion.newNumber(0));
	}
	public void reset(ClarionNumber force)
	{
		if (!(this.qc.inimgr==null)) {
			if (!Clarion.getControl(Mfeq.QUERYNAMEFIELD).getProperty(Prop.SCREENTEXT).boolValue()) {
				CWin.disable(Mfeq.DELETEQUERYBUTTON);
				CWin.disable(Mfeq.RESTOREQUERYBUTTON);
				CWin.disable(Mfeq.SAVEQUERYBUTTON);
			}
			else {
				this.queries.item.setValue(Clarion.getControl(Mfeq.QUERYNAMEFIELD).getProperty(Prop.SCREENTEXT));
				this.queries.get(this.queries.ORDER().ascend(this.queries.item));
				if (CError.errorCode()!=0) {
					CWin.disable(Mfeq.DELETEQUERYBUTTON);
				}
				else {
					CWin.enable(Mfeq.DELETEQUERYBUTTON);
				}
				CWin.enable(Mfeq.RESTOREQUERYBUTTON);
				CWin.enable(Mfeq.SAVEQUERYBUTTON);
			}
		}
		super.reset();
	}
	public ClarionNumber takewindowevent()
	{
		{
			int case_1=CWin.event();
			boolean case_1_break=false;
			if (case_1==Event.OPENWINDOW) {
				if (!(this.qc.inimgr==null)) {
					CWin.setPosition(Mfeq.SAVELISTBOX,Clarion.getControl(Mfeq.SHEETCONTROL).getProperty(Prop.XPOS).add(4).intValue(),Clarion.getControl(Mfeq.SHEETCONTROL).getProperty(Prop.YPOS).add(16).intValue(),Clarion.getControl(Mfeq.SHEETCONTROL).getProperty(Prop.WIDTH).subtract(10).intValue(),Clarion.getControl(Mfeq.SHEETCONTROL).getProperty(Prop.HEIGHT).subtract(48).intValue());
					CWin.unhide(Mfeq.SAVELISTBOX);
					CWin.setPosition(Mfeq.SAVEQUERYBUTTON,Clarion.getControl(Mfeq.SAVELISTBOX).getProperty(Prop.XPOS).add(Clarion.getControl(Mfeq.SAVELISTBOX).getProperty(Prop.WIDTH)).subtract(45).intValue(),Clarion.getControl(Mfeq.SAVELISTBOX).getProperty(Prop.YPOS).add(Clarion.getControl(Mfeq.SAVELISTBOX).getProperty(Prop.HEIGHT)).add(16).intValue(),45,null);
					CWin.unhide(Mfeq.SAVEQUERYBUTTON);
					CWin.setPosition(Mfeq.DELETEQUERYBUTTON,Clarion.getControl(Mfeq.SAVEQUERYBUTTON).getProperty(Prop.XPOS).subtract(47).intValue(),Clarion.getControl(Mfeq.SAVEQUERYBUTTON).getProperty(Prop.YPOS).intValue(),45,null);
					CWin.unhide(Mfeq.DELETEQUERYBUTTON);
					CWin.setPosition(Mfeq.RESTOREQUERYBUTTON,Clarion.getControl(Mfeq.DELETEQUERYBUTTON).getProperty(Prop.XPOS).subtract(47).intValue(),Clarion.getControl(Mfeq.SAVEQUERYBUTTON).getProperty(Prop.YPOS).intValue(),45,null);
					CWin.unhide(Mfeq.RESTOREQUERYBUTTON);
					CWin.setPosition(Mfeq.QUERYNAMEPROMPT,Clarion.getControl(Mfeq.SAVELISTBOX).getProperty(Prop.XPOS).intValue(),Clarion.getControl(Mfeq.SAVELISTBOX).getProperty(Prop.YPOS).add(Clarion.getControl(Mfeq.SAVELISTBOX).getProperty(Prop.HEIGHT)).add(3).intValue(),null,null);
					CWin.unhide(Mfeq.QUERYNAMEPROMPT);
					CWin.setPosition(Mfeq.QUERYNAMEFIELD,Clarion.getControl(Mfeq.QUERYNAMEPROMPT).getProperty(Prop.XPOS).add(Clarion.getControl(Mfeq.QUERYNAMEPROMPT).getProperty(Prop.WIDTH)).add(3).intValue(),Clarion.getControl(Mfeq.QUERYNAMEPROMPT).getProperty(Prop.YPOS).intValue(),Clarion.getControl(Mfeq.DELETEQUERYBUTTON).getProperty(Prop.XPOS).subtract(Clarion.getControl(Mfeq.QUERYNAMEPROMPT).getProperty(Prop.XPOS).add(Clarion.getControl(Mfeq.QUERYNAMEPROMPT).getProperty(Prop.WIDTH)).add(8)).intValue(),null);
					CWin.unhide(Mfeq.QUERYNAMEFIELD);
				}
				else {
					CWin.hide(Mfeq.SAVERESTORETAB);
				}
				CWin.setPosition(Mfeq.CLEAR,Clarion.getControl(Mfeq.SHEETCONTROL).getProperty(Prop.XPOS).add(Clarion.getControl(Mfeq.SHEETCONTROL).getProperty(Prop.WIDTH)).subtract(Clarion.getControl(Mfeq.CLEAR).getProperty(Prop.WIDTH)).intValue(),Clarion.getControl(Mfeq.SHEETCONTROL).getProperty(Prop.YPOS).add(Clarion.getControl(Mfeq.SHEETCONTROL).getProperty(Prop.HEIGHT)).add(3).intValue(),50,14);
				CWin.setPosition(Mfeq.CANCEL,Clarion.getControl(Mfeq.CLEAR).getProperty(Prop.XPOS).subtract(52).intValue(),Clarion.getControl(Mfeq.CLEAR).getProperty(Prop.YPOS).intValue(),50,14);
				CWin.setPosition(Mfeq.OK,Clarion.getControl(Mfeq.CANCEL).getProperty(Prop.XPOS).subtract(52).intValue(),Clarion.getControl(Mfeq.CANCEL).getProperty(Prop.YPOS).intValue(),50,14);
				this.resizer.init(Clarion.newNumber(Appstrategy.RESIZE),Clarion.newNumber(Resize.SETMINSIZE));
				this.additem(this.resizer);
				this.resizer.setparentdefaults();
				if (!(this.qc.inimgr==null)) {
					this.qc.inimgr.fetch(Clarion.newString(ClarionString.staticConcat("QBE-",this.qc.family)),this.qc.window);
				}
				this.resizer.resize();
				this.resizer.reset();
				Clarion.getControl(0).setProperty(Prop.HIDE,Constants.FALSE);
				case_1_break=true;
			}
			if (!case_1_break && case_1==Event.CLOSEWINDOW) {
				if (!(this.qc.inimgr==null)) {
					this.qc.inimgr.update(Clarion.newString(ClarionString.staticConcat("QBE-",this.qc.family)),this.qc.window);
				}
				this.qc.save(Clarion.newString("tsMRU"));
				case_1_break=true;
			}
		}
		return super.takewindowevent();
	}
	public void resetfromquery()
	{
	}
	public void updatefields()
	{
	}
}
