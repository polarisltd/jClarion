package clarion;

import clarion.Abutil;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Font;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CDate;
import org.jclarion.clarion.runtime.CExpression;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

public class Calendarbaseclass
{
	public ClarionNumber ctrlExit;
	public ClarionNumber ctrlToday;
	public ClarionNumber ctrlDay1;
	public ClarionNumber ctrlDay42;
	public ClarionNumber ctrlPrevMonth;
	public ClarionNumber ctrlNextMonth;
	public ClarionNumber ctrlPrevYear;
	public ClarionNumber ctrlNextYear;
	public ClarionNumber ctrlMore7;
	public ClarionNumber ctrlLess7;
	public ClarionNumber ctrlMore15;
	public ClarionNumber ctrlLess15;
	public ClarionNumber ctrlCurrTime;
	public ClarionString ctrlMonthYear;
	public ClarionNumber ctrlTheDate;
	public ClarionNumber ctrlTitleBG;
	public ClarionNumber ctrlBodyBG;
	public ClarionNumber ctrlSun;
	public ClarionNumber xPos;
	public ClarionNumber yPos;
	public ClarionNumber response;
	public ClarionNumber firstWeekDay;
	public ClarionNumber selectedDate;
	public ClarionNumber colorSunday;
	public ClarionNumber colorSaturday;
	public ClarionNumber colorOther;
	public ClarionNumber colorHoliday;
	public ClarionNumber selectOnClose;
	public ClarionNumber rightAlignment;
	public Calendarbaseclass()
	{
		ctrlExit=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ctrlToday=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ctrlDay1=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ctrlDay42=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ctrlPrevMonth=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ctrlNextMonth=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ctrlPrevYear=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ctrlNextYear=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ctrlMore7=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ctrlLess7=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ctrlMore15=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ctrlLess15=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ctrlCurrTime=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ctrlMonthYear=Clarion.newString(15);
		ctrlTheDate=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ctrlTitleBG=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ctrlBodyBG=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ctrlSun=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		xPos=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		yPos=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		response=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		firstWeekDay=Clarion.newNumber(7).setEncoding(ClarionNumber.BYTE);
		selectedDate=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		colorSunday=Clarion.newNumber(0xff).setEncoding(ClarionNumber.LONG);
		colorSaturday=Clarion.newNumber(0xff).setEncoding(ClarionNumber.LONG);
		colorOther=Clarion.newNumber(0).setEncoding(ClarionNumber.LONG);
		colorHoliday=Clarion.newNumber(0x8000).setEncoding(ClarionNumber.LONG);
		selectOnClose=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE);
		rightAlignment=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE);
	}

	public ClarionNumber ask()
	{
		return ask(Clarion.newNumber(0));
	}
	public ClarionNumber ask(ClarionNumber pDate)
	{
		return this.ask(Clarion.newString(""),pDate.like());
	}
	public ClarionNumber ask(ClarionString p0)
	{
		return ask(p0,Clarion.newNumber(0));
	}
	public ClarionNumber ask(ClarionString pTitle,ClarionNumber pDate)
	{
		ClarionNumber windowInitialized=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString dayStr=Clarion.newString(3);
		ClarionNumber currTime=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionString monthYear=Clarion.newString(15);
		ClarionNumber the_date=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber the_last_date=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber the_month=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber the_day=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber the_year=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber base_col=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber last_day=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber base_date=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber cur_mo=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber cur_yr=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber mo_and_yr=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber start_date=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber sunday_date=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber butnum=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber firstButNum=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber daynum=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber satCol=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber sunCol=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionArray<ClarionString> day_array=Clarion.newString(3).dim(7).setOver(Abutil.ask_string_number_Day_group);
		ClarionArray<ClarionString> month_array=Clarion.newString(10).dim(12).setOver(Abutil.ask_string_number_Month_group);
		ClarionNumber locFecha=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber lHIni=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber lHEnd=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		CExpression.pushBind();
		if (this.ctrlCurrTime.boolValue()) {
			Clarion.getControl(this.ctrlCurrTime).setProperty(Prop.USE,currTime);
		}
		if (this.ctrlMonthYear.boolValue()) {
			Clarion.getControl(this.ctrlMonthYear).setProperty(Prop.USE,monthYear);
		}
		if (this.ctrlTheDate.boolValue()) {
			Clarion.getControl(this.ctrlTheDate).setProperty(Prop.USE,the_date);
		}
		this.firstWeekDay.setValue(7);
		this.setUp();
		if (!(this.firstWeekDay.compareTo(1)>=0 && this.firstWeekDay.compareTo(7)<=0)) {
			this.firstWeekDay.setValue(7);
		}
		ask_DoReorderDays(base_col,butnum,day_array,satCol,sunCol);
		firstButNum.setValue(this.ctrlDay1.add(Clarion.newNumber(7).subtract(this.firstWeekDay)));
		this.selectedDate.setValue(0);
		this.response.setValue(Constants.REQUESTCANCELLED);
		if (pDate.equals(0)) {
			start_date.setValue(CDate.today());
		}
		else {
			start_date.setValue(pDate);
		}
		if (!CRun.inRange(start_date,Clarion.newNumber(CDate.date(1,1,1801)),Clarion.newNumber(CDate.date(12,31,2099)))) {
			start_date.setValue(CDate.today());
		}
		the_date.setValue(start_date);
		mo_and_yr.setValue(0);
		cur_mo.setValue(0);
		cur_yr.setValue(0);
		sunday_date.setValue(CDate.date(1,3,1993));
		locFecha.setValue(the_date);
		the_last_date.setValue(the_date);
		if (CWin.keyCode()==Constants.MOUSERIGHT) {
			CWin.setKeyCode(0);
		}
		if (this.xPos.boolValue()) {
			if (this.rightAlignment.boolValue()) {
				Clarion.getControl(0).setProperty(Prop.XPOS,this.xPos.subtract(Clarion.getControl(0).getProperty(Prop.WIDTH)));
			}
			else {
				Clarion.getControl(0).setClonedProperty(Prop.XPOS,this.xPos);
			}
		}
		if (this.yPos.boolValue()) {
			Clarion.getControl(0).setClonedProperty(Prop.YPOS,this.yPos);
		}
		ask_PrepareProcedure(the_month,the_date,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr,currTime);
		lHIni.setValue(Clarion.getControl(0).getProperty(Prop.HEIGHT));
		if (pTitle.clip().boolValue()) {
			Clarion.getControl(0).setClonedProperty(Prop.TEXT,pTitle);
		}
		else {
			Clarion.getControl(0).setProperty(Prop.TEXT,"");
		}
		CWin.display();
		lHEnd.setValue(Clarion.getControl(0).getProperty(Prop.HEIGHT));
		if (!lHIni.equals(lHEnd)) {
			Clarion.getControl(0).setProperty(Prop.HEIGHT,Clarion.getControl(0).getProperty(Prop.HEIGHT).add(lHIni.subtract(lHEnd)));
		}
		this.response.setValue(Constants.REQUESTCANCELLED);
		while (Clarion.getWindowTarget().accept()) {
			{
				int case_1=CWin.event();
				boolean case_1_break=false;
				if (case_1==Event.ALERTKEY) {
					{
						int case_2=CWin.keyCode();
						boolean case_2_break=false;
						if (case_2==Constants.UPKEY) {
							ask_PrevWeek(the_date,the_month,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr,locFecha);
							CWin.select(this.ctrlExit.intValue());
							case_2_break=true;
						}
						if (!case_2_break && case_2==Constants.DOWNKEY) {
							ask_NextWeek(the_date,the_month,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr,locFecha);
							CWin.select(this.ctrlExit.intValue());
							case_2_break=true;
						}
						if (!case_2_break && case_2==Constants.LEFTKEY) {
							ask_PrevDay(the_date,the_month,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr,locFecha);
							CWin.select(this.ctrlExit.intValue());
							case_2_break=true;
						}
						if (!case_2_break && case_2==Constants.RIGHTKEY) {
							ask_NextDay(the_date,the_month,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr,locFecha);
							CWin.select(this.ctrlExit.intValue());
							case_2_break=true;
						}
						if (!case_2_break && case_2==Constants.ENTERKEY) {
							if (!Clarion.newNumber(CWin.focus()).equals(this.ctrlExit)) {
								CWin.pressKey(Constants.TABKEY);
								continue;
							}
							else {
								CWin.post(Event.ACCEPTED,this.ctrlExit.intValue());
								continue;
							}
							// UNREACHABLE! :case_2_break=true;
						}
					}
					case_1_break=true;
				}
				if (!case_1_break && case_1==Event.OPENWINDOW) {
					if (!windowInitialized.boolValue()) {
						CWin.display();
						windowInitialized.setValue(Constants.TRUE);
					}
					CWin.select(this.ctrlExit.intValue());
					case_1_break=true;
				}
				if (!case_1_break && case_1==Event.GAINFOCUS) {
					if (!windowInitialized.boolValue()) {
						windowInitialized.setValue(Constants.TRUE);
					}
					CWin.display();
					case_1_break=true;
				}
				if (!case_1_break && case_1==Event.TIMER) {
					ask_ShowTime(currTime);
					case_1_break=true;
				}
				if (!case_1_break && case_1==Event.REJECTED) {
					CWin.beep();
					CWin.display(CWin.field());
					CWin.select(CWin.field());
					case_1_break=true;
				}
			}
			if (CWin.field()>0) {
				{
					int case_3=CWin.field();
					boolean case_3_break=false;
					if (Clarion.newNumber(case_3).compareTo(this.ctrlDay1)>=0 && Clarion.newNumber(case_3).compareTo(this.ctrlDay42)<=0) {
						{
							int case_4=CWin.event();
							boolean case_4_break=false;
							if (case_4==Event.ACCEPTED) {
								the_date.setValue(CDate.date(the_month.intValue(),Clarion.newNumber(CWin.field()).subtract(this.ctrlDay1).subtract(base_col).add(1).intValue(),the_year.intValue()));
								ask_DoSelect(the_date,locFecha);
								ask_DoUpdateScreen(the_month,the_date,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr);
								the_last_date.setValue(the_date);
								this.response.setValue(Constants.REQUESTCOMPLETED);
								CWin.post(Event.ACCEPTED,this.ctrlExit.intValue());
								continue;
								// UNREACHABLE! :case_4_break=true;
							}
							if (!case_4_break && case_4==Event.SELECTED) {
								the_date.setValue(CDate.date(the_month.intValue(),Clarion.newNumber(CWin.field()).subtract(this.ctrlDay1).subtract(base_col).add(1).intValue(),the_year.intValue()));
								ask_DoSelect(the_date,locFecha);
								ask_DoUpdateScreen(the_month,the_date,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr);
								the_last_date.setValue(the_date);
								case_4_break=true;
							}
						}
						case_3_break=true;
					}
					if (!case_3_break && Clarion.newNumber(case_3).equals(this.ctrlToday)) {
						{
							int case_5=CWin.event();
							if (case_5==Event.ACCEPTED) {
								ask_DoToday(the_date,locFecha,the_month,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr);
								ask_DoSelect(the_date,locFecha);
								ask_DoUpdateScreen(the_month,the_date,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr);
							}
						}
						case_3_break=true;
					}
					if (!case_3_break && Clarion.newNumber(case_3).equals(this.ctrlPrevMonth)) {
						{
							int case_6=CWin.event();
							if (case_6==Event.ACCEPTED) {
								ask_DoPrevMonth(the_month,the_date,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr,locFecha);
							}
						}
						case_3_break=true;
					}
					if (!case_3_break && Clarion.newNumber(case_3).equals(this.ctrlNextMonth)) {
						{
							int case_7=CWin.event();
							if (case_7==Event.ACCEPTED) {
								ask_DoNextMonth(the_month,the_date,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr,locFecha);
							}
						}
						case_3_break=true;
					}
					if (!case_3_break && Clarion.newNumber(case_3).equals(this.ctrlPrevYear)) {
						{
							int case_8=CWin.event();
							if (case_8==Event.ACCEPTED) {
								ask_DoPrevYear(the_year,the_month,the_date,the_day,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr,locFecha);
							}
						}
						case_3_break=true;
					}
					if (!case_3_break && Clarion.newNumber(case_3).equals(this.ctrlNextYear)) {
						{
							int case_9=CWin.event();
							if (case_9==Event.ACCEPTED) {
								ask_DoNextYear(the_year,the_month,the_date,the_day,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr,locFecha);
							}
						}
						case_3_break=true;
					}
					if (!case_3_break && Clarion.newNumber(case_3).equals(this.ctrlLess7)) {
						{
							int case_10=CWin.event();
							if (case_10==Event.ACCEPTED) {
								ask_PrevWeek(the_date,the_month,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr,locFecha);
							}
						}
						case_3_break=true;
					}
					if (!case_3_break && Clarion.newNumber(case_3).equals(this.ctrlMore7)) {
						{
							int case_11=CWin.event();
							if (case_11==Event.ACCEPTED) {
								ask_NextWeek(the_date,the_month,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr,locFecha);
							}
						}
						case_3_break=true;
					}
					if (!case_3_break && Clarion.newNumber(case_3).equals(this.ctrlLess15)) {
						{
							int case_12=CWin.event();
							if (case_12==Event.ACCEPTED) {
								ask_Prev2Week(the_date,the_month,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr,locFecha);
							}
						}
						case_3_break=true;
					}
					if (!case_3_break && Clarion.newNumber(case_3).equals(this.ctrlMore15)) {
						{
							int case_13=CWin.event();
							if (case_13==Event.ACCEPTED) {
								ask_Next2Week(the_date,the_month,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr,locFecha);
							}
						}
						case_3_break=true;
					}
					if (!case_3_break && Clarion.newNumber(case_3).equals(this.ctrlExit)) {
						{
							int case_14=CWin.event();
							if (case_14==Event.ACCEPTED) {
								if (this.selectOnClose.boolValue()) {
									this.response.setValue(Constants.REQUESTCOMPLETED);
								}
								CWin.post(Event.CLOSEWINDOW);
							}
						}
						case_3_break=true;
					}
				}
			}
			Clarion.getWindowTarget().consumeAccept();
		}
		if (this.response.equals(Constants.REQUESTCANCELLED)) {
			locFecha.setValue(start_date);
		}
		this.selectedDate.setValue(locFecha);
		this.xPos.setValue(0);
		this.yPos.setValue(0);
		CExpression.popBind();
		return locFecha.like();
	}
	public void ask_PrevDay(ClarionNumber the_date,ClarionNumber the_month,ClarionNumber the_day,ClarionNumber the_year,ClarionNumber cur_mo,ClarionNumber cur_yr,ClarionNumber the_last_date,ClarionNumber daynum,ClarionNumber butnum,ClarionNumber base_col,ClarionString monthYear,ClarionArray<ClarionString> month_array,ClarionNumber base_date,ClarionNumber sunday_date,ClarionNumber last_day,ClarionString dayStr,ClarionNumber sunCol,ClarionNumber satCol,ClarionNumber mo_and_yr,ClarionNumber locFecha)
	{
		the_date.setValue(the_date.subtract(1));
		ask_DoSelect(the_date,locFecha);
		ask_DoUpdateScreen(the_month,the_date,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr);
		the_last_date.setValue(the_date);
	}
	public void ask_ProcedureReturn()
	{
	}
	public void ask_Next2Week(ClarionNumber the_date,ClarionNumber the_month,ClarionNumber the_day,ClarionNumber the_year,ClarionNumber cur_mo,ClarionNumber cur_yr,ClarionNumber the_last_date,ClarionNumber daynum,ClarionNumber butnum,ClarionNumber base_col,ClarionString monthYear,ClarionArray<ClarionString> month_array,ClarionNumber base_date,ClarionNumber sunday_date,ClarionNumber last_day,ClarionString dayStr,ClarionNumber sunCol,ClarionNumber satCol,ClarionNumber mo_and_yr,ClarionNumber locFecha)
	{
		the_date.setValue(the_date.add(15));
		ask_DoSelect(the_date,locFecha);
		ask_DoUpdateScreen(the_month,the_date,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr);
		the_last_date.setValue(the_date);
	}
	public void ask_DoNextYear(ClarionNumber the_year,ClarionNumber the_month,ClarionNumber the_date,ClarionNumber the_day,ClarionNumber cur_mo,ClarionNumber cur_yr,ClarionNumber the_last_date,ClarionNumber daynum,ClarionNumber butnum,ClarionNumber base_col,ClarionString monthYear,ClarionArray<ClarionString> month_array,ClarionNumber base_date,ClarionNumber sunday_date,ClarionNumber last_day,ClarionString dayStr,ClarionNumber sunCol,ClarionNumber satCol,ClarionNumber mo_and_yr,ClarionNumber locFecha)
	{
		the_year.increment(1);
		ask_FixupMonth(the_month,the_year,the_date,the_day,the_last_date);
		ask_DoSelect(the_date,locFecha);
		ask_DoUpdateScreen(the_month,the_date,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr);
		the_last_date.setValue(the_date);
	}
	public void ask_DoPrevMonth(ClarionNumber the_month,ClarionNumber the_date,ClarionNumber the_day,ClarionNumber the_year,ClarionNumber cur_mo,ClarionNumber cur_yr,ClarionNumber the_last_date,ClarionNumber daynum,ClarionNumber butnum,ClarionNumber base_col,ClarionString monthYear,ClarionArray<ClarionString> month_array,ClarionNumber base_date,ClarionNumber sunday_date,ClarionNumber last_day,ClarionString dayStr,ClarionNumber sunCol,ClarionNumber satCol,ClarionNumber mo_and_yr,ClarionNumber locFecha)
	{
		the_month.decrement(1);
		ask_FixupMonth(the_month,the_year,the_date,the_day,the_last_date);
		ask_DoSelect(the_date,locFecha);
		ask_DoUpdateScreen(the_month,the_date,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr);
		the_last_date.setValue(the_date);
	}
	public void ask_DoPrevYear(ClarionNumber the_year,ClarionNumber the_month,ClarionNumber the_date,ClarionNumber the_day,ClarionNumber cur_mo,ClarionNumber cur_yr,ClarionNumber the_last_date,ClarionNumber daynum,ClarionNumber butnum,ClarionNumber base_col,ClarionString monthYear,ClarionArray<ClarionString> month_array,ClarionNumber base_date,ClarionNumber sunday_date,ClarionNumber last_day,ClarionString dayStr,ClarionNumber sunCol,ClarionNumber satCol,ClarionNumber mo_and_yr,ClarionNumber locFecha)
	{
		the_year.decrement(1);
		ask_FixupMonth(the_month,the_year,the_date,the_day,the_last_date);
		ask_DoSelect(the_date,locFecha);
		ask_DoUpdateScreen(the_month,the_date,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr);
		the_last_date.setValue(the_date);
	}
	public void ask_Prev2Week(ClarionNumber the_date,ClarionNumber the_month,ClarionNumber the_day,ClarionNumber the_year,ClarionNumber cur_mo,ClarionNumber cur_yr,ClarionNumber the_last_date,ClarionNumber daynum,ClarionNumber butnum,ClarionNumber base_col,ClarionString monthYear,ClarionArray<ClarionString> month_array,ClarionNumber base_date,ClarionNumber sunday_date,ClarionNumber last_day,ClarionString dayStr,ClarionNumber sunCol,ClarionNumber satCol,ClarionNumber mo_and_yr,ClarionNumber locFecha)
	{
		the_date.setValue(the_date.subtract(15));
		ask_DoSelect(the_date,locFecha);
		ask_DoUpdateScreen(the_month,the_date,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr);
		the_last_date.setValue(the_date);
	}
	public void ask_DoSelect(ClarionNumber the_date,ClarionNumber locFecha)
	{
		if (the_date.compareTo(0)>0) {
			locFecha.setValue(the_date);
		}
	}
	public void ask_DoReorderDays(ClarionNumber base_col,ClarionNumber butnum,ClarionArray<ClarionString> day_array,ClarionNumber satCol,ClarionNumber sunCol)
	{
		base_col.setValue(this.firstWeekDay);
		for (butnum.setValue(0);butnum.compareTo(6)<=0;butnum.increment(1)) {
			Clarion.getControl(this.ctrlSun.add(butnum)).setClonedProperty(Prop.TEXT,day_array.get(base_col.intValue()));
			if (base_col.equals(6)) {
				satCol.setValue(butnum.add(1));
			}
			if (base_col.equals(7)) {
				sunCol.setValue(butnum.add(1));
			}
			base_col.increment(1);
			if (base_col.compareTo(7)>0) {
				base_col.setValue(1);
			}
		}
	}
	public void ask_NextWeek(ClarionNumber the_date,ClarionNumber the_month,ClarionNumber the_day,ClarionNumber the_year,ClarionNumber cur_mo,ClarionNumber cur_yr,ClarionNumber the_last_date,ClarionNumber daynum,ClarionNumber butnum,ClarionNumber base_col,ClarionString monthYear,ClarionArray<ClarionString> month_array,ClarionNumber base_date,ClarionNumber sunday_date,ClarionNumber last_day,ClarionString dayStr,ClarionNumber sunCol,ClarionNumber satCol,ClarionNumber mo_and_yr,ClarionNumber locFecha)
	{
		the_date.setValue(the_date.add(7));
		ask_DoSelect(the_date,locFecha);
		ask_DoUpdateScreen(the_month,the_date,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr);
		the_last_date.setValue(the_date);
	}
	public void ask_NextDay(ClarionNumber the_date,ClarionNumber the_month,ClarionNumber the_day,ClarionNumber the_year,ClarionNumber cur_mo,ClarionNumber cur_yr,ClarionNumber the_last_date,ClarionNumber daynum,ClarionNumber butnum,ClarionNumber base_col,ClarionString monthYear,ClarionArray<ClarionString> month_array,ClarionNumber base_date,ClarionNumber sunday_date,ClarionNumber last_day,ClarionString dayStr,ClarionNumber sunCol,ClarionNumber satCol,ClarionNumber mo_and_yr,ClarionNumber locFecha)
	{
		the_date.setValue(the_date.add(1));
		ask_DoSelect(the_date,locFecha);
		ask_DoUpdateScreen(the_month,the_date,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr);
		the_last_date.setValue(the_date);
	}
	public void ask_DoUpdateScreen(ClarionNumber the_month,ClarionNumber the_date,ClarionNumber the_day,ClarionNumber the_year,ClarionNumber cur_mo,ClarionNumber cur_yr,ClarionNumber the_last_date,ClarionNumber daynum,ClarionNumber butnum,ClarionNumber base_col,ClarionString monthYear,ClarionArray<ClarionString> month_array,ClarionNumber base_date,ClarionNumber sunday_date,ClarionNumber last_day,ClarionString dayStr,ClarionNumber sunCol,ClarionNumber satCol,ClarionNumber mo_and_yr)
	{
		the_month.setValue(CDate.month(the_date.intValue()));
		the_day.setValue(CDate.day(the_date.intValue()));
		the_year.setValue(CDate.year(the_date.intValue()));
		if (cur_mo.equals(the_month) && cur_yr.equals(the_year)) {
			if (the_last_date.equals(the_date)) {
				return;
			}
			daynum.setValue(CDate.day(the_last_date.intValue()));
			butnum.setValue(daynum.subtract(1).add(base_col).add(this.ctrlDay1));
			Clarion.getControl(butnum).setProperty(Prop.TEXT,daynum.getString().format("@P##P").clip());
			Clarion.getControl(butnum).setProperty(Prop.FONTSTYLE,Font.REGULAR);
			daynum.setValue(CDate.day(the_date.intValue()));
			butnum.setValue(daynum.subtract(1).add(base_col).add(this.ctrlDay1));
			Clarion.getControl(butnum).setProperty(Prop.FONTSTYLE,Font.BOLD+Font.UNDERLINE);
			return;
		}
		monthYear.setValue(month_array.get(the_month.intValue()).clip().concat(" ",the_year));
		base_date.setValue(CDate.date(the_month.intValue(),1,the_year.intValue()));
		base_col.setValue(base_date.subtract(sunday_date.subtract(Clarion.newNumber(7).subtract(this.firstWeekDay))).modulus(7).getDecimal().abs());
		last_day.setValue(CDate.day(CDate.date(the_month.add(1).intValue(),1,the_year.intValue())-1));
		for (butnum.setValue(this.ctrlDay1);butnum.compareTo(this.ctrlDay42)<=0;butnum.increment(1)) {
			daynum.setValue(butnum.subtract(this.ctrlDay1).subtract(base_col).add(1));
			ask_DayToStr(daynum,last_day,dayStr);
			if (dayStr.clip().len()>0) {
				CWin.unhide(butnum.intValue());
				Clarion.getControl(butnum).setProperty(Prop.TEXT,daynum.getString().format("@P##P").clip());
				if (butnum.equals(this.ctrlDay1.add(sunCol.subtract(1))) || butnum.equals(this.ctrlDay1.add(7).add(sunCol.subtract(1))) || butnum.equals(this.ctrlDay1.add(14).add(sunCol.subtract(1))) || butnum.equals(this.ctrlDay1.add(21).add(sunCol.subtract(1))) || butnum.equals(this.ctrlDay1.add(28).add(sunCol.subtract(1))) || butnum.equals(this.ctrlDay1.add(35).add(sunCol.subtract(1)))) {
					Clarion.getControl(butnum).setClonedProperty(Prop.FONTCOLOR,this.colorSunday);
					Clarion.getControl(butnum).setProperty(Prop.FONTSTYLE,Font.REGULAR);
				}
				else {
					if (butnum.equals(this.ctrlDay1.add(satCol.subtract(1))) || butnum.equals(this.ctrlDay1.add(7).add(satCol.subtract(1))) || butnum.equals(this.ctrlDay1.add(14).add(satCol.subtract(1))) || butnum.equals(this.ctrlDay1.add(21).add(satCol.subtract(1))) || butnum.equals(this.ctrlDay1.add(28).add(satCol.subtract(1))) || butnum.equals(this.ctrlDay1.add(35).add(satCol.subtract(1)))) {
						Clarion.getControl(butnum).setClonedProperty(Prop.FONTCOLOR,this.colorSaturday);
						Clarion.getControl(butnum).setProperty(Prop.FONTSTYLE,Font.REGULAR);
					}
					else {
						Clarion.getControl(butnum).setClonedProperty(Prop.FONTCOLOR,this.colorOther);
						Clarion.getControl(butnum).setProperty(Prop.FONTSTYLE,Font.REGULAR);
					}
				}
				if (this.isHoliday(dayStr.getNumber(),the_month.like(),the_year.like(),daynum.like()).boolValue()) {
					Clarion.getControl(butnum).setClonedProperty(Prop.FONTCOLOR,this.colorHoliday);
					Clarion.getControl(butnum).setProperty(Prop.FONTSTYLE,Font.REGULAR);
				}
				if (Clarion.newNumber(CDate.date(the_month.intValue(),dayStr.intValue(),the_year.intValue())).equals(the_date)) {
					Clarion.getControl(butnum).setProperty(Prop.FONTSTYLE,Font.BOLD+Font.UNDERLINE);
				}
			}
			else {
				CWin.hide(butnum.intValue());
			}
		}
		cur_mo.setValue(the_month);
		cur_yr.setValue(the_year);
		mo_and_yr.setValue(the_month.add(the_year));
	}
	public void ask_ShowTime(ClarionNumber currTime)
	{
		currTime.setValue(CDate.clock());
	}
	public void ask_DoToday(ClarionNumber the_date,ClarionNumber locFecha,ClarionNumber the_month,ClarionNumber the_day,ClarionNumber the_year,ClarionNumber cur_mo,ClarionNumber cur_yr,ClarionNumber the_last_date,ClarionNumber daynum,ClarionNumber butnum,ClarionNumber base_col,ClarionString monthYear,ClarionArray<ClarionString> month_array,ClarionNumber base_date,ClarionNumber sunday_date,ClarionNumber last_day,ClarionString dayStr,ClarionNumber sunCol,ClarionNumber satCol,ClarionNumber mo_and_yr)
	{
		the_date.setValue(CDate.today());
		ask_DoSelect(the_date,locFecha);
		ask_DoUpdateScreen(the_month,the_date,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr);
		the_last_date.setValue(the_date);
	}
	public void ask_DayToStr(ClarionNumber daynum,ClarionNumber last_day,ClarionString dayStr)
	{
		if (daynum.compareTo(last_day)>0) {
			daynum.setValue(0);
		}
		if (daynum.compareTo(0)<=0) {
			dayStr.setValue("");
		}
		else {
			dayStr.setValue(daynum.getString().format("@n2"));
		}
	}
	public void ask_DoNextMonth(ClarionNumber the_month,ClarionNumber the_date,ClarionNumber the_day,ClarionNumber the_year,ClarionNumber cur_mo,ClarionNumber cur_yr,ClarionNumber the_last_date,ClarionNumber daynum,ClarionNumber butnum,ClarionNumber base_col,ClarionString monthYear,ClarionArray<ClarionString> month_array,ClarionNumber base_date,ClarionNumber sunday_date,ClarionNumber last_day,ClarionString dayStr,ClarionNumber sunCol,ClarionNumber satCol,ClarionNumber mo_and_yr,ClarionNumber locFecha)
	{
		the_month.increment(1);
		ask_FixupMonth(the_month,the_year,the_date,the_day,the_last_date);
		ask_DoSelect(the_date,locFecha);
		ask_DoUpdateScreen(the_month,the_date,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr);
		the_last_date.setValue(the_date);
	}
	public void ask_FixupMonth(ClarionNumber the_month,ClarionNumber the_year,ClarionNumber the_date,ClarionNumber the_day,ClarionNumber the_last_date)
	{
		if (the_month.compareTo(1)<0) {
			the_year.decrement(1);
			the_month.setValue(12);
		}
		else if (the_month.compareTo(12)>0) {
			the_year.increment(1);
			the_month.setValue(1);
		}
		the_date.setValue(CDate.date(the_month.intValue(),the_day.intValue(),the_year.intValue()));
		the_last_date.setValue(the_date);
	}
	public void ask_PrevWeek(ClarionNumber the_date,ClarionNumber the_month,ClarionNumber the_day,ClarionNumber the_year,ClarionNumber cur_mo,ClarionNumber cur_yr,ClarionNumber the_last_date,ClarionNumber daynum,ClarionNumber butnum,ClarionNumber base_col,ClarionString monthYear,ClarionArray<ClarionString> month_array,ClarionNumber base_date,ClarionNumber sunday_date,ClarionNumber last_day,ClarionString dayStr,ClarionNumber sunCol,ClarionNumber satCol,ClarionNumber mo_and_yr,ClarionNumber locFecha)
	{
		the_date.setValue(the_date.subtract(7));
		ask_DoSelect(the_date,locFecha);
		ask_DoUpdateScreen(the_month,the_date,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr);
		the_last_date.setValue(the_date);
	}
	public void ask_PrepareProcedure(ClarionNumber the_month,ClarionNumber the_date,ClarionNumber the_day,ClarionNumber the_year,ClarionNumber cur_mo,ClarionNumber cur_yr,ClarionNumber the_last_date,ClarionNumber daynum,ClarionNumber butnum,ClarionNumber base_col,ClarionString monthYear,ClarionArray<ClarionString> month_array,ClarionNumber base_date,ClarionNumber sunday_date,ClarionNumber last_day,ClarionString dayStr,ClarionNumber sunCol,ClarionNumber satCol,ClarionNumber mo_and_yr,ClarionNumber currTime)
	{
		CWin.alert(Constants.ENTERKEY);
		CWin.alert(Constants.DOWNKEY);
		CWin.alert(Constants.RIGHTKEY);
		CWin.alert(Constants.UPKEY);
		CWin.alert(Constants.LEFTKEY);
		ask_ShowTime(currTime);
		ask_DoUpdateScreen(the_month,the_date,the_day,the_year,cur_mo,cur_yr,the_last_date,daynum,butnum,base_col,monthYear,month_array,base_date,sunday_date,last_day,dayStr,sunCol,satCol,mo_and_yr);
	}
	public void setUp()
	{
	}
	public void setPosition(ClarionNumber pXPos,ClarionNumber pYPos)
	{
		this.xPos.setValue(pXPos);
		this.yPos.setValue(pYPos);
	}
	public ClarionNumber isHoliday(ClarionNumber pDay,ClarionNumber pMonth,ClarionNumber pYear,ClarionNumber pWeekDay)
	{
		return Clarion.newNumber(Constants.FALSE);
	}
	public void setColor(ClarionNumber pColorSaturday,ClarionNumber pColorSunday,ClarionNumber pColorOther,ClarionNumber pColorHoliday)
	{
		this.colorSaturday.setValue(pColorSaturday);
		this.colorSunday.setValue(pColorSunday);
		this.colorOther.setValue(pColorOther);
		this.colorHoliday.setValue(pColorHoliday);
	}
}
