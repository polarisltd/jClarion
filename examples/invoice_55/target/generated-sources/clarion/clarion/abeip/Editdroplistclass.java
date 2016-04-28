package clarion.abeip;

import clarion.abeip.Editclass;
import clarion.equates.Constants;
import clarion.equates.Create;
import clarion.equates.Editaction;
import clarion.equates.Event;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Editdroplistclass extends Editclass
{
	public Editdroplistclass()
	{
	}

	public void createcontrol()
	{
		this.feq.setValue(CWin.createControl(0,Create.DROPLIST,null,null));
	}
	public void setalerts()
	{
		Clarion.getControl(this.feq).setProperty(Prop.ALRT,1,Constants.TABKEY);
		Clarion.getControl(this.feq).setProperty(Prop.ALRT,2,Constants.SHIFTTAB);
		Clarion.getControl(this.feq).setProperty(Prop.ALRT,3,Constants.ENTERKEY);
		Clarion.getControl(this.feq).setProperty(Prop.ALRT,4,Constants.ESCKEY);
	}
	public void setreadonly(ClarionNumber state)
	{
		super.setreadonly(state.like());
		if (this.readonly.boolValue()) {
			Clarion.getControl(this.feq).setProperty(Prop.DROP,0);
		}
	}
	public ClarionNumber takeevent(ClarionNumber e)
	{
		{
			ClarionNumber case_1=e;
			boolean case_1_break=false;
			if (case_1.equals(Event.ACCEPTED)) {
				return Clarion.newNumber(Editaction.FORWARD);
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break) {
				return super.takeevent(e.like());
			}
		}
		return Clarion.newNumber();
	}
}
