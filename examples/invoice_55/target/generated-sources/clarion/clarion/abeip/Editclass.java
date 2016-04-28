package clarion.abeip;

import clarion.equates.Constants;
import clarion.equates.Editaction;
import clarion.equates.Event;
import clarion.equates.Prop;
import clarion.equates.Proplist;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Editclass
{
	public ClarionNumber feq=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
	public ClarionAny usevar=Clarion.newAny();
	public ClarionNumber listboxfeq=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber readonly=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Editclass()
	{
		feq=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		usevar=Clarion.newAny();
		listboxfeq=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		readonly=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	}

	public void createcontrol()
	{
		CRun._assert(Constants.FALSE!=0);
	}
	public void init(ClarionNumber fieldno,ClarionNumber listbox,ClarionObject usevar)
	{
		this.listboxfeq.setValue(listbox);
		this.createcontrol();
		CRun._assert(this.feq.boolValue());
		this.usevar.setReferenceValue(usevar);
		Clarion.getControl(this.feq).setProperty(Prop.TEXT,Clarion.getControl(listbox).getProperty(Proplist.PICTURE,fieldno));
		Clarion.getControl(this.feq).setProperty(Prop.USE,usevar);
		this.setalerts();
	}
	public void kill()
	{
		if (this.feq.boolValue()) {
			CWin.removeControl(this.feq.intValue());
		}
		this.usevar.setReferenceValue(null);
	}
	public void setalerts()
	{
		Clarion.getControl(this.feq).setProperty(Prop.ALRT,1,Constants.TABKEY);
		Clarion.getControl(this.feq).setProperty(Prop.ALRT,2,Constants.SHIFTTAB);
		Clarion.getControl(this.feq).setProperty(Prop.ALRT,3,Constants.ENTERKEY);
		Clarion.getControl(this.feq).setProperty(Prop.ALRT,4,Constants.ESCKEY);
		Clarion.getControl(this.feq).setProperty(Prop.ALRT,5,Constants.DOWNKEY);
		Clarion.getControl(this.feq).setProperty(Prop.ALRT,6,Constants.UPKEY);
	}
	public void setreadonly(ClarionNumber state)
	{
		this.readonly.setValue(state);
		Clarion.getControl(this.feq).setProperty(Prop.READONLY,Constants.TRUE);
	}
	public ClarionNumber takeevent(ClarionNumber e)
	{
		{
			ClarionNumber case_1=e;
			if (case_1.equals(Event.ALERTKEY)) {
				{
					int case_2=CWin.keyCode();
					boolean case_2_break=false;
					if (case_2==Constants.ENTERKEY) {
						return Clarion.newNumber(Editaction.COMPLETE);
						// UNREACHABLE! :case_2_break=true;
					}
					if (!case_2_break && case_2==Constants.ESCKEY) {
						return Clarion.newNumber(Editaction.CANCEL);
						// UNREACHABLE! :case_2_break=true;
					}
					if (!case_2_break && case_2==Constants.TABKEY) {
						return Clarion.newNumber(Editaction.FORWARD);
						// UNREACHABLE! :case_2_break=true;
					}
					if (!case_2_break && case_2==Constants.SHIFTTAB) {
						return Clarion.newNumber(Editaction.BACKWARD);
						// UNREACHABLE! :case_2_break=true;
					}
					if (!case_2_break && case_2==Constants.DOWNKEY) {
						return Clarion.newNumber(Editaction.NEXT);
						// UNREACHABLE! :case_2_break=true;
					}
					if (!case_2_break && case_2==Constants.UPKEY) {
						return Clarion.newNumber(Editaction.PREVIOUS);
						// UNREACHABLE! :case_2_break=true;
					}
				}
			}
		}
		return Clarion.newNumber(Editaction.NONE);
	}
}
