package clarion;

import clarion.Editclass;
import clarion.Textwindowclass;
import clarion.equates.Constants;
import clarion.equates.Create;
import clarion.equates.Editaction;
import clarion.equates.Event;
import clarion.equates.Icon;
import clarion.equates.Prop;
import clarion.equates.Proplist;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

public class Edittextclass extends Editclass
{
	public ClarionString title;
	public Edittextclass()
	{
		title=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
	}

	public void createControl()
	{
		this.feq.setValue(CWin.createControl(0,Create.DROPCOMBO,null,null));
		CRun._assert(this.feq.boolValue());
		Clarion.getControl(this.feq).setProperty(Prop.DROP,0);
		Clarion.getControl(this.feq).setProperty(Prop.ICON,Icon.ELLIPSIS);
	}
	public ClarionNumber takeEvent(ClarionNumber e)
	{
		Textwindowclass textWindow=new Textwindowclass();
		{
			ClarionNumber case_1=e;
			boolean case_1_break=false;
			if (case_1.equals(Event.DROPPINGDOWN)) {
				if (!this.title.boolValue()) {
					this.title.setValue(Clarion.getControl(this.listBoxFeq).getProperty(Proplist.HEADER,this.fieldNo));
				}
				textWindow.init(this.feq.like(),this.title.like());
				textWindow.run();
				return (textWindow.response.equals(Constants.REQUESTCOMPLETED) ? Clarion.newNumber(Editaction.IGNORE) : Clarion.newNumber(Editaction.NONE)).getNumber();
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break) {
				return super.takeEvent(e.like());
			}
		}
		return Clarion.newNumber();
	}
}
