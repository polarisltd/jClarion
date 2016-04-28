package clarion;

import clarion.Calendarbaseclass;
import clarion.Screen_1;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

public class Calendarsmallclass extends Calendarbaseclass
{
	public Calendarsmallclass()
	{
	}

	public ClarionNumber ask(ClarionString p0)
	{
		return ask(p0,Clarion.newNumber(0));
	}
	public ClarionNumber ask(ClarionString pTitle,ClarionNumber pDate)
	{
		Screen_1 screen=new Screen_1();
		try {
			screen.open();
			this.ctrlSun.setValue(screen._sun);
			this.ctrlExit.setValue(screen._exit);
			this.ctrlToday.setValue(screen._today);
			this.ctrlDay1.setValue(screen._day1);
			this.ctrlDay42.setValue(screen._day42);
			this.ctrlPrevMonth.setValue(screen._prevMonth);
			this.ctrlNextMonth.setValue(screen._nextMonth);
			this.ctrlPrevYear.setValue(screen._prevYear);
			this.ctrlNextYear.setValue(screen._nextYear);
			this.ctrlMore7.setValue(screen._more7);
			this.ctrlLess7.setValue(screen._less7);
			this.ctrlMore15.setValue(screen._more15);
			this.ctrlLess15.setValue(screen._less15);
			this.ctrlCurrTime.setValue(screen._currTime);
			this.ctrlMonthYear.setValue(screen._monthYear);
			this.ctrlTheDate.setValue(screen._theDate);
			this.ctrlTitleBG.setValue(0);
			this.ctrlBodyBG.setValue(screen._boxBodyBackground);
			return super.ask(pTitle.like(),pDate.like());
		} finally {
			screen.close();
		}
	}
	public void setUp()
	{
	}
}
