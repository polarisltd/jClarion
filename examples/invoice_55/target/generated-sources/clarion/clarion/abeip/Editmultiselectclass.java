package clarion.abeip;

import clarion.abeip.Abeip;
import clarion.abeip.Editclass;
import clarion.abeip.Itemqueue;
import clarion.abeip.Mswindowclass;
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

@SuppressWarnings("all")
public class Editmultiselectclass extends Editclass
{
	public Itemqueue available=null;
	public ClarionString filepattern=Clarion.newString(1024).setEncoding(ClarionString.CSTRING);
	public Itemqueue selected=null;
	public ClarionString title=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
	public Editmultiselectclass()
	{
		available=null;
		filepattern=Clarion.newString(1024).setEncoding(ClarionString.CSTRING);
		selected=null;
		title=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
	}

	public void addvalue(ClarionString p0)
	{
		addvalue(p0,Clarion.newNumber(0));
	}
	public void addvalue(ClarionString value,ClarionNumber marked)
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
	public void createcontrol()
	{
		this.feq.setValue(CWin.createControl(0,Create.DROPCOMBO,null,null));
		CRun._assert(this.feq.boolValue());
		Clarion.getControl(this.feq).setProperty(Prop.DROP,0);
		Clarion.getControl(this.feq).setProperty(Prop.ICON,Icon.ELLIPSIS);
		Clarion.getControl(this.feq).setProperty(Prop.READONLY,Constants.TRUE);
		Clarion.getControl(this.feq).setProperty(Prop.BACKGROUND,Clarion.getControl(this.listboxfeq).getProperty(Prop.BACKGROUND));
	}
	public void init(ClarionNumber fieldno,ClarionNumber listbox,ClarionObject usevar)
	{
		super.init(fieldno.like(),listbox.like(),usevar);
		this.available=new Itemqueue();
		this.selected=new Itemqueue();
	}
	public void kill()
	{
		super.kill();
		//this.available;
		//this.selected;
	}
	public void takeaction(ClarionNumber p0,ClarionString p1,ClarionNumber p2)
	{
		takeaction(p0,p1,p2,Clarion.newNumber(0));
	}
	public void takeaction(ClarionNumber p0,ClarionString p1)
	{
		takeaction(p0,p1,Clarion.newNumber(0));
	}
	public void takeaction(ClarionNumber p0)
	{
		takeaction(p0,(ClarionString)null);
	}
	public void takeaction(ClarionNumber action,ClarionString item,ClarionNumber pos1,ClarionNumber pos2)
	{
	}
	public ClarionNumber takeevent(ClarionNumber e)
	{
		Mswindowclass mswindow=new Mswindowclass();
		{
			ClarionNumber case_1=e;
			boolean case_1_break=false;
			if (case_1.equals(Event.DROPPINGDOWN)) {
				mswindow.init(this);
				Abeip.multiwindow.open();
				Clarion.getControl(0).setClonedProperty(Prop.TEXT,this.title);
				Clarion.getControl(Abeip.multiwindow._available).setClonedProperty(Prop.FROM,this.available.item);
				Clarion.getControl(Abeip.multiwindow._available).setClonedProperty(Prop.MARK,this.available.mark);
				Clarion.getControl(Abeip.multiwindow._selected).setClonedProperty(Prop.FROM,this.selected.item);
				Clarion.getControl(Abeip.multiwindow._selected).setClonedProperty(Prop.MARK,this.selected.mark);
				if (this.readonly.boolValue()) {
					CWin.disable(Abeip.multiwindow._selectsome);
					CWin.disable(Abeip.multiwindow._selectall);
					CWin.disable(Abeip.multiwindow._deselectsome);
					CWin.disable(Abeip.multiwindow._deselectall);
					CWin.disable(Abeip.multiwindow._moveup);
					CWin.disable(Abeip.multiwindow._movedown);
				}
				mswindow.run();
				Abeip.multiwindow.close();
				CWin.display(this.feq.intValue());
				return (mswindow.response.equals(Constants.REQUESTCOMPLETED) ? Clarion.newNumber(Editaction.IGNORE) : Clarion.newNumber(Editaction.NONE)).getNumber();
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break) {
				return super.takeevent(e.like());
			}
		}
		return Clarion.newNumber();
	}
}
