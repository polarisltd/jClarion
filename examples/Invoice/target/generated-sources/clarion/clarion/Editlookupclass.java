package clarion;

import clarion.Editclass;
import clarion.equates.Constants;
import clarion.equates.Create;
import clarion.equates.Editaction;
import clarion.equates.Event;
import clarion.equates.Icon;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

public class Editlookupclass extends Editclass
{
	public Editlookupclass()
	{
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
		ClarionNumber lEditAction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber lParentEditAction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		{
			ClarionNumber case_1=e;
			if (case_1.equals(Event.DROPPINGDOWN)) {
				if (!this.readOnly.boolValue()) {
					CWin.update(this.feq.intValue());
					lEditAction.setValue(this.askLookup(Clarion.newNumber(Constants.TRUE)));
					CWin.display(this.feq.intValue());
					return lEditAction.like();
				}
			}
		}
		lParentEditAction.setValue(super.takeEvent(e.like()));
		if (!(lParentEditAction.equals(Editaction.CANCEL) || lParentEditAction.equals(Editaction.NONE) || lParentEditAction.equals(Editaction.IGNORE))) {
			lEditAction.setValue(this.askLookup(Clarion.newNumber(Constants.FALSE)));
			CWin.display(this.feq.intValue());
			if (lEditAction.equals(Editaction.IGNORE)) {
				return lParentEditAction.like();
			}
			else {
				return Clarion.newNumber(Editaction.NONE);
			}
		}
		else {
			return lParentEditAction.like();
		}
	}
	public ClarionNumber askLookup(ClarionNumber pForce)
	{
		return Clarion.newNumber(Editaction.IGNORE);
	}
}
