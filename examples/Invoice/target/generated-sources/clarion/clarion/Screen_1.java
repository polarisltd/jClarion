package clarion;

import clarion.equates.Charset;
import clarion.equates.Color;
import clarion.equates.Font;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.PanelControl;
import org.jclarion.clarion.control.StringControl;

public class Screen_1 extends ClarionWindow
{
	public int _boxBodyBackground=0;
	public int _currTime=0;
	public int _monthYear=0;
	public int _theDate=0;
	public int _sun=0;
	public int _mon=0;
	public int _tue=0;
	public int _wed=0;
	public int _thu=0;
	public int _fri=0;
	public int _sat=0;
	public int _day1=0;
	public int _day2=0;
	public int _day3=0;
	public int _day4=0;
	public int _day5=0;
	public int _day6=0;
	public int _day7=0;
	public int _day8=0;
	public int _day9=0;
	public int _day10=0;
	public int _day11=0;
	public int _day12=0;
	public int _day13=0;
	public int _day14=0;
	public int _day15=0;
	public int _day16=0;
	public int _day17=0;
	public int _day18=0;
	public int _day19=0;
	public int _day20=0;
	public int _day21=0;
	public int _day22=0;
	public int _day23=0;
	public int _day24=0;
	public int _day25=0;
	public int _day26=0;
	public int _day27=0;
	public int _day28=0;
	public int _day29=0;
	public int _day30=0;
	public int _day31=0;
	public int _day32=0;
	public int _day33=0;
	public int _day34=0;
	public int _day35=0;
	public int _day36=0;
	public int _day37=0;
	public int _day38=0;
	public int _day39=0;
	public int _day40=0;
	public int _day41=0;
	public int _day42=0;
	public int _today=0;
	public int _prevMonth=0;
	public int _nextMonth=0;
	public int _prevYear=0;
	public int _nextYear=0;
	public int _less7=0;
	public int _more7=0;
	public int _less15=0;
	public int _more15=0;
	public int _exit=0;
	public Screen_1()
	{
		this.setText("Calendar").setAt(null,null,208,136).setFont("Arial",8,null,Font.BOLD,null).setCenter().setTimer(100).setSystem().setGray().setDouble();
		this.setId("calendarsmallclass.ask.screen");
		PanelControl _C1=new PanelControl();
		_C1.setFillColor(Color.GRAY).setAt(1,0,207,136).setBevel(-1,1,null);
		this._boxBodyBackground=this.register(_C1,"calendarsmallclass.ask.screen.boxbodybackground");
		this.add(_C1);
		StringControl _C2=new StringControl();
		_C2.setPicture("@t6").setAt(41,5,null,null).setTransparent().setFont("Arial",8,Color.WHITE,null,Charset.ANSI);
		this._currTime=this.register(_C2,"calendarsmallclass.ask.screen.currtime");
		this.add(_C2);
		StringControl _C3=new StringControl();
		_C3.setPicture("@s15").setAt(9,16,105,15).setTransparent().setCenter(null).setFont("MS Sans Serif",12,Color.LIME,Font.BOLD,null);
		this._monthYear=this.register(_C3,"calendarsmallclass.ask.screen.monthyear");
		this.add(_C3);
		StringControl _C4=new StringControl();
		_C4.setPicture("@D2").setAt(130,16,59,15).setTransparent().setRight(null).setFont("MS Sans Serif",12,Color.LIME,Font.BOLD,Charset.ANSI);
		this._theDate=this.register(_C4,"calendarsmallclass.ask.screen.thedate");
		this.add(_C4);
		StringControl _C5=new StringControl();
		_C5.setText("Sun").setAt(7,34,null,null).setTransparent().setCenter(null).setFont("Arial",7,Color.WHITE,null,null);
		this._sun=this.register(_C5,"calendarsmallclass.ask.screen.sun");
		this.add(_C5);
		StringControl _C6=new StringControl();
		_C6.setText("Mon").setAt(25,34,null,null).setTransparent().setCenter(null).setFont("Arial",7,Color.WHITE,Font.REGULAR,null);
		this._mon=this.register(_C6,"calendarsmallclass.ask.screen.mon");
		this.add(_C6);
		StringControl _C7=new StringControl();
		_C7.setText("Tue").setAt(37,34,16,10).setTransparent().setCenter(null).setFont("Arial",7,Color.WHITE,Font.REGULAR,null);
		this._tue=this.register(_C7,"calendarsmallclass.ask.screen.tue");
		this.add(_C7);
		StringControl _C8=new StringControl();
		_C8.setText("Wed").setAt(57,34,null,null).setTransparent().setCenter(null).setFont("Arial",7,Color.WHITE,Font.REGULAR,null);
		this._wed=this.register(_C8,"calendarsmallclass.ask.screen.wed");
		this.add(_C8);
		StringControl _C9=new StringControl();
		_C9.setText("Thu").setAt(69,34,16,10).setTransparent().setCenter(null).setFont("Arial",7,Color.WHITE,Font.REGULAR,null);
		this._thu=this.register(_C9,"calendarsmallclass.ask.screen.thu");
		this.add(_C9);
		StringControl _C10=new StringControl();
		_C10.setText("Fri").setAt(85,34,16,10).setTransparent().setCenter(null).setFont("Arial",7,Color.WHITE,Font.REGULAR,null);
		this._fri=this.register(_C10,"calendarsmallclass.ask.screen.fri");
		this.add(_C10);
		StringControl _C11=new StringControl();
		_C11.setText("Sat").setAt(101,34,16,10).setTransparent().setCenter(null).setFont("Arial",7,Color.WHITE,Font.REGULAR,null);
		this._sat=this.register(_C11,"calendarsmallclass.ask.screen.sat");
		this.add(_C11);
		ButtonControl _C12=new ButtonControl();
		_C12.setAt(5,46,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day1=this.register(_C12,"calendarsmallclass.ask.screen.day1");
		this.add(_C12);
		ButtonControl _C13=new ButtonControl();
		_C13.setAt(21,46,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day2=this.register(_C13,"calendarsmallclass.ask.screen.day2");
		this.add(_C13);
		ButtonControl _C14=new ButtonControl();
		_C14.setAt(37,46,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day3=this.register(_C14,"calendarsmallclass.ask.screen.day3");
		this.add(_C14);
		ButtonControl _C15=new ButtonControl();
		_C15.setAt(53,46,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day4=this.register(_C15,"calendarsmallclass.ask.screen.day4");
		this.add(_C15);
		ButtonControl _C16=new ButtonControl();
		_C16.setAt(69,46,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day5=this.register(_C16,"calendarsmallclass.ask.screen.day5");
		this.add(_C16);
		ButtonControl _C17=new ButtonControl();
		_C17.setAt(85,46,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day6=this.register(_C17,"calendarsmallclass.ask.screen.day6");
		this.add(_C17);
		ButtonControl _C18=new ButtonControl();
		_C18.setAt(101,46,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day7=this.register(_C18,"calendarsmallclass.ask.screen.day7");
		this.add(_C18);
		ButtonControl _C19=new ButtonControl();
		_C19.setAt(5,60,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day8=this.register(_C19,"calendarsmallclass.ask.screen.day8");
		this.add(_C19);
		ButtonControl _C20=new ButtonControl();
		_C20.setAt(21,60,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day9=this.register(_C20,"calendarsmallclass.ask.screen.day9");
		this.add(_C20);
		ButtonControl _C21=new ButtonControl();
		_C21.setAt(37,60,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day10=this.register(_C21,"calendarsmallclass.ask.screen.day10");
		this.add(_C21);
		ButtonControl _C22=new ButtonControl();
		_C22.setAt(53,60,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day11=this.register(_C22,"calendarsmallclass.ask.screen.day11");
		this.add(_C22);
		ButtonControl _C23=new ButtonControl();
		_C23.setAt(69,60,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day12=this.register(_C23,"calendarsmallclass.ask.screen.day12");
		this.add(_C23);
		ButtonControl _C24=new ButtonControl();
		_C24.setAt(85,60,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day13=this.register(_C24,"calendarsmallclass.ask.screen.day13");
		this.add(_C24);
		ButtonControl _C25=new ButtonControl();
		_C25.setAt(101,60,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day14=this.register(_C25,"calendarsmallclass.ask.screen.day14");
		this.add(_C25);
		ButtonControl _C26=new ButtonControl();
		_C26.setAt(5,74,16,14).setSkip().setFont("Arial",8,Color.BLACK,null,Charset.ANSI);
		this._day15=this.register(_C26,"calendarsmallclass.ask.screen.day15");
		this.add(_C26);
		ButtonControl _C27=new ButtonControl();
		_C27.setAt(21,74,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day16=this.register(_C27,"calendarsmallclass.ask.screen.day16");
		this.add(_C27);
		ButtonControl _C28=new ButtonControl();
		_C28.setAt(37,74,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day17=this.register(_C28,"calendarsmallclass.ask.screen.day17");
		this.add(_C28);
		ButtonControl _C29=new ButtonControl();
		_C29.setAt(53,74,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day18=this.register(_C29,"calendarsmallclass.ask.screen.day18");
		this.add(_C29);
		ButtonControl _C30=new ButtonControl();
		_C30.setAt(69,74,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day19=this.register(_C30,"calendarsmallclass.ask.screen.day19");
		this.add(_C30);
		ButtonControl _C31=new ButtonControl();
		_C31.setAt(85,74,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day20=this.register(_C31,"calendarsmallclass.ask.screen.day20");
		this.add(_C31);
		ButtonControl _C32=new ButtonControl();
		_C32.setAt(101,74,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day21=this.register(_C32,"calendarsmallclass.ask.screen.day21");
		this.add(_C32);
		ButtonControl _C33=new ButtonControl();
		_C33.setAt(5,88,16,14).setSkip().setFont("Arial",8,Color.BLACK,null,Charset.ANSI);
		this._day22=this.register(_C33,"calendarsmallclass.ask.screen.day22");
		this.add(_C33);
		ButtonControl _C34=new ButtonControl();
		_C34.setAt(21,88,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day23=this.register(_C34,"calendarsmallclass.ask.screen.day23");
		this.add(_C34);
		ButtonControl _C35=new ButtonControl();
		_C35.setAt(37,88,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day24=this.register(_C35,"calendarsmallclass.ask.screen.day24");
		this.add(_C35);
		ButtonControl _C36=new ButtonControl();
		_C36.setAt(53,88,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day25=this.register(_C36,"calendarsmallclass.ask.screen.day25");
		this.add(_C36);
		ButtonControl _C37=new ButtonControl();
		_C37.setAt(69,88,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day26=this.register(_C37,"calendarsmallclass.ask.screen.day26");
		this.add(_C37);
		ButtonControl _C38=new ButtonControl();
		_C38.setAt(85,88,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day27=this.register(_C38,"calendarsmallclass.ask.screen.day27");
		this.add(_C38);
		ButtonControl _C39=new ButtonControl();
		_C39.setAt(101,88,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day28=this.register(_C39,"calendarsmallclass.ask.screen.day28");
		this.add(_C39);
		ButtonControl _C40=new ButtonControl();
		_C40.setAt(5,102,16,14).setSkip().setFont("Arial",8,Color.BLACK,null,Charset.ANSI);
		this._day29=this.register(_C40,"calendarsmallclass.ask.screen.day29");
		this.add(_C40);
		ButtonControl _C41=new ButtonControl();
		_C41.setAt(21,102,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day30=this.register(_C41,"calendarsmallclass.ask.screen.day30");
		this.add(_C41);
		ButtonControl _C42=new ButtonControl();
		_C42.setAt(37,102,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day31=this.register(_C42,"calendarsmallclass.ask.screen.day31");
		this.add(_C42);
		ButtonControl _C43=new ButtonControl();
		_C43.setAt(53,102,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day32=this.register(_C43,"calendarsmallclass.ask.screen.day32");
		this.add(_C43);
		ButtonControl _C44=new ButtonControl();
		_C44.setAt(69,102,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day33=this.register(_C44,"calendarsmallclass.ask.screen.day33");
		this.add(_C44);
		ButtonControl _C45=new ButtonControl();
		_C45.setAt(85,102,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day34=this.register(_C45,"calendarsmallclass.ask.screen.day34");
		this.add(_C45);
		ButtonControl _C46=new ButtonControl();
		_C46.setAt(101,102,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day35=this.register(_C46,"calendarsmallclass.ask.screen.day35");
		this.add(_C46);
		ButtonControl _C47=new ButtonControl();
		_C47.setAt(5,116,16,14).setSkip().setFont("Arial",8,Color.BLACK,null,Charset.ANSI);
		this._day36=this.register(_C47,"calendarsmallclass.ask.screen.day36");
		this.add(_C47);
		ButtonControl _C48=new ButtonControl();
		_C48.setAt(21,116,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day37=this.register(_C48,"calendarsmallclass.ask.screen.day37");
		this.add(_C48);
		ButtonControl _C49=new ButtonControl();
		_C49.setAt(37,116,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day38=this.register(_C49,"calendarsmallclass.ask.screen.day38");
		this.add(_C49);
		ButtonControl _C50=new ButtonControl();
		_C50.setAt(53,116,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day39=this.register(_C50,"calendarsmallclass.ask.screen.day39");
		this.add(_C50);
		ButtonControl _C51=new ButtonControl();
		_C51.setAt(69,116,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day40=this.register(_C51,"calendarsmallclass.ask.screen.day40");
		this.add(_C51);
		ButtonControl _C52=new ButtonControl();
		_C52.setAt(85,116,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day41=this.register(_C52,"calendarsmallclass.ask.screen.day41");
		this.add(_C52);
		ButtonControl _C53=new ButtonControl();
		_C53.setAt(101,116,16,14).setSkip().setFont("Arial",9,Color.BLACK,null,Charset.ANSI);
		this._day42=this.register(_C53,"calendarsmallclass.ask.screen.day42");
		this.add(_C53);
		ButtonControl _C54=new ButtonControl();
		_C54.setText("&Today").setAt(123,46,82,14).setFont("MS Sans Serif",8,null,Font.BOLD,null);
		this._today=this.register(_C54,"calendarsmallclass.ask.screen.today");
		this.add(_C54);
		ButtonControl _C55=new ButtonControl();
		_C55.setText("- Month").setAt(123,60,41,14).setFont("MS Sans Serif",8,null,Font.BOLD,null);
		this._prevMonth=this.register(_C55,"calendarsmallclass.ask.screen.prevmonth");
		this.add(_C55);
		ButtonControl _C56=new ButtonControl();
		_C56.setText("+ &Month").setAt(123,74,41,14).setFont("MS Sans Serif",8,null,Font.BOLD,null);
		this._nextMonth=this.register(_C56,"calendarsmallclass.ask.screen.nextmonth");
		this.add(_C56);
		ButtonControl _C57=new ButtonControl();
		_C57.setText("- Year").setAt(123,88,41,14).setFont("MS Sans Serif",8,null,Font.BOLD,null);
		this._prevYear=this.register(_C57,"calendarsmallclass.ask.screen.prevyear");
		this.add(_C57);
		ButtonControl _C58=new ButtonControl();
		_C58.setText("+ &Year").setAt(123,102,41,14).setFont("MS Sans Serif",8,null,Font.BOLD,null);
		this._nextYear=this.register(_C58,"calendarsmallclass.ask.screen.nextyear");
		this.add(_C58);
		ButtonControl _C59=new ButtonControl();
		_C59.setText("- 7 Day").setAt(164,60,41,14).setFont("MS Sans Serif",8,null,Font.BOLD,null);
		this._less7=this.register(_C59,"calendarsmallclass.ask.screen.less7");
		this.add(_C59);
		ButtonControl _C60=new ButtonControl();
		_C60.setText("+ 7 &Day").setAt(164,74,41,14).setFont("MS Sans Serif",8,null,Font.BOLD,null);
		this._more7=this.register(_C60,"calendarsmallclass.ask.screen.more7");
		this.add(_C60);
		ButtonControl _C61=new ButtonControl();
		_C61.setText("- 15 Days").setAt(164,88,41,14).setFont("MS Sans Serif",8,null,Font.BOLD,null);
		this._less15=this.register(_C61,"calendarsmallclass.ask.screen.less15");
		this.add(_C61);
		ButtonControl _C62=new ButtonControl();
		_C62.setText("+ 15 Days").setAt(164,102,41,14).setFont("MS Sans Serif",8,null,Font.BOLD,null);
		this._more15=this.register(_C62,"calendarsmallclass.ask.screen.more15");
		this.add(_C62);
		ButtonControl _C63=new ButtonControl();
		_C63.setText("&Close").setAt(123,116,82,14).setLeft(null);
		this._exit=this.register(_C63,"calendarsmallclass.ask.screen.exit");
		this.add(_C63);
	}
}
