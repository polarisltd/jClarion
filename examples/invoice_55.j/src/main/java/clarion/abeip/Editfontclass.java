package clarion.abeip;

import clarion.abeip.Editclass;
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
public class Editfontclass extends Editclass
{
	public ClarionString title=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
	public Editfontclass()
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
		ClarionString fonts=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
		{
			ClarionNumber case_1=e;
			if (case_1.equals(Event.DROPPINGDOWN)) {
				if (!this.readonly.boolValue()) {
					fonts.setValue(this.usevar);
					if (CWin.fontDialog(this.title.toString(),fonts,null,null,null,null)) {
						this.usevar.setValue(fonts);
						CWin.display(this.feq.intValue());
					}
					return Clarion.newNumber(Editaction.IGNORE);
				}
			}
		}
		return super.takeevent(e.like());
	}
}
