package clarion.abeip;

import clarion.abeip.Editclass;
import clarion.abeip.Textwindowclass;
import clarion.equates.Constants;
import clarion.equates.Create;
import clarion.equates.Editaction;
import clarion.equates.Event;
import clarion.equates.Icon;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Edittextclass extends Editclass
{
	public ClarionString title=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
	public Edittextclass()
	{
		title=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
	}

	public void createcontrol()
	{
		this.feq.setValue(CWin.createControl(0,Create.DROPCOMBO,null,null));
		CRun._assert(this.feq.boolValue());
		Clarion.getControl(this.feq).setProperty(Prop.DROP,0);
		Clarion.getControl(this.feq).setProperty(Prop.ICON,Icon.ELLIPSIS);
	}
	public ClarionNumber takeevent(ClarionNumber e)
	{
		Textwindowclass textwindow=new Textwindowclass();
		{
			ClarionNumber case_1=e;
			boolean case_1_break=false;
			if (case_1.equals(Event.DROPPINGDOWN)) {
				textwindow.init(this.feq.like(),this.title.like());
				textwindow.run();
				return (textwindow.response.equals(Constants.REQUESTCOMPLETED) ? Clarion.newNumber(Editaction.IGNORE) : Clarion.newNumber(Editaction.NONE)).getNumber();
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break) {
				return super.takeevent(e.like());
			}
		}
		return Clarion.newNumber();
	}
}
