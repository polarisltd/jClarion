package clarion;

import clarion.Calendarbaseclass;
import clarion.Calendarclass;
import clarion.Editclass;
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

public class Editcalendarclass extends Editclass
{
	public ClarionString title;
	public Calendarbaseclass calendar;
	public Editcalendarclass()
	{
		title=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
		calendar=null;
	}

	public void setCalendar(Calendarbaseclass pCalendar)
	{
		this.calendar=pCalendar;
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
		ClarionNumber lDate=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		Calendarclass lCalendar=new Calendarclass();
		ClarionNumber lResponse=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		{
			ClarionNumber case_1=e;
			if (case_1.equals(Event.DROPPINGDOWN)) {
				if (!this.readOnly.boolValue()) {
					CWin.update(this.feq.intValue());
					lDate.setValue(this.useVar);
					if (this.calendar==null) {
						lDate.setValue(lCalendar.ask(this.title.like(),lDate.like()));
						lResponse.setValue(lCalendar.response);
					}
					else {
						lDate.setValue(this.calendar.ask(this.title.like(),lDate.like()));
						lResponse.setValue(this.calendar.response);
					}
					if (lResponse.equals(Constants.REQUESTCOMPLETED)) {
						this.useVar.setValue(lDate);
						CWin.display(this.feq.intValue());
					}
					return Clarion.newNumber(Editaction.IGNORE);
				}
			}
		}
		return super.takeEvent(e.like());
	}
}
