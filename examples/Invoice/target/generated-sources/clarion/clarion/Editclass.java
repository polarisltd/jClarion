package clarion;

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

public class Editclass
{
	public ClarionNumber feq;
	public ClarionAny useVar;
	public ClarionNumber listBoxFeq;
	public ClarionNumber readOnly;
	public ClarionNumber fieldNo;
	public ClarionNumber req;
	public Editclass()
	{
		feq=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		useVar=Clarion.newAny();
		listBoxFeq=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		readOnly=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		fieldNo=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		req=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	}

	public void createControl()
	{
		CRun._assert(Constants.FALSE!=0);
	}
	public void init(ClarionNumber fieldNo,ClarionNumber listBox,ClarionObject useVar)
	{
		this.listBoxFeq.setValue(listBox);
		this.fieldNo.setValue(fieldNo);
		this.createControl();
		CRun._assert(this.feq.boolValue());
		this.useVar.setReferenceValue(useVar);
		Clarion.getControl(this.feq).setProperty(Prop.TEXT,Clarion.getControl(this.listBoxFeq).getProperty(Proplist.PICTURE,this.fieldNo));
		Clarion.getControl(this.feq).setProperty(Prop.USE,useVar);
		this.setAlerts();
	}
	public void kill()
	{
		if (this.feq.boolValue()) {
			CWin.removeControl(this.feq.intValue());
			this.feq.setValue(0);
		}
		this.useVar.setReferenceValue(null);
	}
	public void setAlerts()
	{
		Clarion.getControl(this.feq).setProperty(Prop.ALRT,1,Constants.TABKEY);
		Clarion.getControl(this.feq).setProperty(Prop.ALRT,2,Constants.SHIFTTAB);
		Clarion.getControl(this.feq).setProperty(Prop.ALRT,3,Constants.ENTERKEY);
		Clarion.getControl(this.feq).setProperty(Prop.ALRT,4,Constants.ESCKEY);
		Clarion.getControl(this.feq).setProperty(Prop.ALRT,5,Constants.DOWNKEY);
		Clarion.getControl(this.feq).setProperty(Prop.ALRT,6,Constants.UPKEY);
	}
	public void setReadOnly(ClarionNumber state)
	{
		this.readOnly.setValue(state);
		Clarion.getControl(this.feq).setClonedProperty(Prop.READONLY,state);
	}
	public ClarionNumber takeAccepted(ClarionNumber action)
	{
		CWin.update(this.feq.intValue());
		return action.like();
	}
	public ClarionNumber takeEvent(ClarionNumber e)
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
