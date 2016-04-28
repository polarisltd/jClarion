package clarion.abeip;

import clarion.abeip.Abeip;
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
public class Editcolorclass extends Editclass
{
	public ClarionString title=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
	public Editcolorclass()
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
		ClarionNumber val=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		{
			ClarionNumber case_1=e;
			if (case_1.equals(Event.DROPPINGDOWN)) {
				if (!this.readonly.boolValue()) {
					val.setValue(Abeip.getcolorvalue(this.usevar.getString()));
					if (CWin.colorDialog(this.title.toString(),val,null)) {
						this.usevar.setValue(Abeip.getcolortext(val.like()));
						CWin.display(this.feq.intValue());
					}
					return Clarion.newNumber(Editaction.IGNORE);
				}
			}
		}
		return super.takeevent(e.like());
	}
}
