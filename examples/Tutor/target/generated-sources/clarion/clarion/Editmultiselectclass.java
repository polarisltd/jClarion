package clarion;

import clarion.Abeip;
import clarion.Editclass;
import clarion.Itemqueue;
import clarion.Mswindowclass;
import clarion.equates.Constants;
import clarion.equates.Create;
import clarion.equates.Editaction;
import clarion.equates.Event;
import clarion.equates.Icon;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

public class Editmultiselectclass extends Editclass
{
	public Itemqueue available;
	public ClarionString filePattern;
	public Itemqueue selected;
	public ClarionString title;
	public Editmultiselectclass()
	{
		available=null;
		filePattern=Clarion.newString(1024).setEncoding(ClarionString.CSTRING);
		selected=null;
		title=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
	}

	public void addValue(ClarionString p0)
	{
		addValue(p0,Clarion.newNumber(0));
	}
	public void addValue(ClarionString value,ClarionNumber marked)
	{
		if (marked.boolValue()) {
			this.selected.item.setValue(value);
			this.selected.mark.setValue(0);
			this.selected.add();
		}
		else {
			this.available.item.setValue(value);
			this.available.mark.setValue(0);
			this.available.add();
		}
	}
	public void reset()
	{
		this.selected.free();
		this.available.free();
	}
	public void createControl()
	{
		this.feq.setValue(CWin.createControl(0,Create.DROPCOMBO,null,null));
		CRun._assert(this.feq.boolValue());
		Clarion.getControl(this.feq).setProperty(Prop.DROP,0);
		Clarion.getControl(this.feq).setProperty(Prop.ICON,Icon.ELLIPSIS);
		Clarion.getControl(this.feq).setProperty(Prop.READONLY,Constants.TRUE);
		Clarion.getControl(this.feq).setProperty(Prop.BACKGROUND,Clarion.getControl(this.listBoxFeq).getProperty(Prop.BACKGROUND));
	}
	public void init(ClarionNumber fieldNo,ClarionNumber listBox,ClarionObject useVar)
	{
		super.init(fieldNo.like(),listBox.like(),useVar);
		this.available=new Itemqueue();
		this.selected=new Itemqueue();
	}
	public void kill()
	{
		super.kill();
		//this.available;
		//this.selected;
	}
	public void takeAction(ClarionNumber p0,ClarionString p1,ClarionNumber p2)
	{
		takeAction(p0,p1,p2,Clarion.newNumber(0));
	}
	public void takeAction(ClarionNumber p0,ClarionString p1)
	{
		takeAction(p0,p1,Clarion.newNumber(0));
	}
	public void takeAction(ClarionNumber p0)
	{
		takeAction(p0,(ClarionString)null);
	}
	public void takeAction(ClarionNumber action,ClarionString item,ClarionNumber pos1,ClarionNumber pos2)
	{
	}
	public ClarionNumber takeEvent(ClarionNumber e)
	{
		Mswindowclass mSWindow=new Mswindowclass();
		ClarionNumber mSSelectedIndex=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		{
			ClarionNumber case_1=e;
			boolean case_1_break=false;
			if (case_1.equals(Event.DROPPINGDOWN)) {
				mSWindow.init(this);
				Abeip.multiWindow.open();
				Clarion.getControl(0).setClonedProperty(Prop.TEXT,this.title);
				Clarion.getControl(Abeip.multiWindow._available).setClonedProperty(Prop.FROM,this.available.item);
				Clarion.getControl(Abeip.multiWindow._available).setClonedProperty(Prop.MARK,this.available.mark);
				Clarion.getControl(Abeip.multiWindow._selected).setClonedProperty(Prop.FROM,this.selected.item);
				Clarion.getControl(Abeip.multiWindow._selected).setClonedProperty(Prop.MARK,this.selected.mark);
				if (this.readOnly.boolValue()) {
					CWin.disable(Abeip.multiWindow._selectSome);
					CWin.disable(Abeip.multiWindow._selectAll);
					CWin.disable(Abeip.multiWindow._deselectSome);
					CWin.disable(Abeip.multiWindow._deselectAll);
					CWin.disable(Abeip.multiWindow._moveUp);
					CWin.disable(Abeip.multiWindow._moveDown);
				}
				mSWindow.run();
				Abeip.multiWindow.close();
				CWin.display(this.feq.intValue());
				if (mSWindow.response.equals(Constants.REQUESTCOMPLETED)) {
					this.takeCompletedInit(Clarion.newNumber(this.selected.records()));
					for (mSSelectedIndex.setValue(1);mSSelectedIndex.compareTo(this.selected.records())<=0;mSSelectedIndex.increment(1)) {
						this.selected.get(mSSelectedIndex);
						this.takeCompletedProcess(mSSelectedIndex.like(),this.selected.item.like(),this.selected.mark.like());
					}
				}
				return (mSWindow.response.equals(Constants.REQUESTCOMPLETED) ? Clarion.newNumber(Editaction.IGNORE) : Clarion.newNumber(Editaction.NONE)).getNumber();
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break) {
				return super.takeEvent(e.like());
			}
		}
		return Clarion.newNumber();
	}
	public void takeCompletedInit(ClarionNumber pSelectedRecords)
	{
	}
	public void takeCompletedProcess(ClarionNumber pSelectedRecord,ClarionString value,ClarionNumber mark)
	{
	}
}
