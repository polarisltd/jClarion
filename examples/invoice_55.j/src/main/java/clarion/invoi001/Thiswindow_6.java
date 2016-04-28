package clarion.invoi001;

import clarion.Main;
import clarion.abtoolba.Toolbarclass;
import clarion.abwindow.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.invoi001.Appframe;
import clarion.invoi001.Invoi001;
import clarion.invoi002.Invoi002;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionSystem;
import org.jclarion.clarion.runtime.CDate;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Thiswindow_6 extends Windowmanager
{
	Appframe appframe;
	ClarionArray<ClarionString> displaydaytext;
	Toolbarclass toolbar;
	ClarionNumber splashprocedurethread;
	public Thiswindow_6(Appframe appframe,ClarionArray<ClarionString> displaydaytext,Toolbarclass toolbar,ClarionNumber splashprocedurethread)
	{
		this.appframe=appframe;
		this.displaydaytext=displaydaytext;
		this.toolbar=toolbar;
		this.splashprocedurethread=splashprocedurethread;
	}

	public void ask()
	{
		if (!CRun.inRange(appframe.getProperty(Prop.TIMER),Clarion.newNumber(1),Clarion.newNumber(100))) {
			appframe.setProperty(Prop.TIMER,100);
		}
		appframe.setProperty(Prop.STATUSTEXT,3,displaydaytext.get(CDate.today()%7+1).clip().concat(", ",Clarion.newString(String.valueOf(CDate.today())).format("@D4")));
		appframe.setProperty(Prop.STATUSTEXT,4,Clarion.newString(String.valueOf(CDate.clock())).format("@T3"));
		super.ask();
	}
	public ClarionNumber init()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalerrors.setprocedurename(Clarion.newString("Main"));
		this.request.setValue(Main.globalrequest);
		returnvalue.setValue(super.init());
		if (returnvalue.boolValue()) {
			return returnvalue.like();
		}
		this.firstfield.setValue(1);
		this.vcrrequest=Main.vcrrequest;
		this.errors=Main.globalerrors;
		this.additem(toolbar);
		Main.globalrequest.clear();
		Main.globalresponse.clear();
		appframe.open();
		this.opened.setValue(Constants.TRUE);
		Main.inimgr.fetch(Clarion.newString("Main"),appframe);
		ClarionSystem.getInstance().setProperty(Prop.ICON,"~Order.ico");
		this.setalerts();
		return returnvalue.like();
	}
	public ClarionNumber kill()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnvalue.setValue(super.kill());
		if (returnvalue.boolValue()) {
			return returnvalue.like();
		}
		if (this.opened.boolValue()) {
			Main.inimgr.update(Clarion.newString("Main"),appframe);
		}
		Main.globalerrors.setprocedurename();
		return returnvalue.like();
	}
	public ClarionNumber takeaccepted()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber looped=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		while (true) {
			if (looped.boolValue()) {
				return Clarion.newNumber(Level.NOTIFY);
			}
			else {
				looped.setValue(1);
			}
			{
				int case_1=CWin.accepted();
				boolean case_1_break=false;
				boolean case_1_match=false;
				case_1_match=false;
				if (case_1==appframe._c5rwbutton) {
					if (Main.re.loadreportlibrary(Clarion.newString("Invoice.txr")).boolValue()) {
						Main.re.setpreview();
						Main.re.printreport(Clarion.newString(String.valueOf(4)));
						Main.re.unloadreportlibrary();
					}
					else {
						CWin.message(Clarion.newString("Invoice.txr Load failed"));
					}
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1==appframe._toolbarHelp) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appframe._toolbarHistory) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appframe._toolbarDelete) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appframe._toolbarChange) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appframe._toolbarInsert) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appframe._toolbarSelect) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appframe._toolbarBottom) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appframe._toolbarPagedown) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appframe._toolbarDown) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appframe._toolbarLocate) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appframe._toolbarUp) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appframe._toolbarPageup) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appframe._toolbarTop) {
					if (!ClarionSystem.getInstance().getProperty(Prop.ACTIVE).equals(CRun.getThreadID())) {
						CWin.post(Event.ACCEPTED,CWin.accepted(),ClarionSystem.getInstance().getProperty(Prop.ACTIVE).intValue());
						continue;
					}
					case_1_break=true;
				}
				if (!case_1_break) {
					takeaccepted_menuReportmenu(appframe);
					takeaccepted_menuMaintenance(appframe);
				}
			}
			returnvalue.setValue(super.takeaccepted());
			{
				int case_2=CWin.accepted();
				boolean case_2_break=false;
				if (case_2==appframe._browsecustomers) {
					{
					CRun.start(new Runnable() { public void run() { Invoi001.browsecustomers(); } } ).getId();
					}
					case_2_break=true;
				}
				if (!case_2_break && case_2==appframe._browseallorders) {
					{
					CRun.start(new Runnable() { public void run() { Invoi001.browseallorders(); } } ).getId();
					}
					case_2_break=true;
				}
				if (!case_2_break && case_2==appframe._browseproducts) {
					{
					CRun.start(new Runnable() { public void run() { Invoi002.browseproducts(); } } ).getId();
					}
					case_2_break=true;
				}
				if (!case_2_break && case_2==appframe._helpabout) {
					{
					CRun.start(new Runnable() { public void run() { Invoi002.aboutauthor(); } } ).getId();
					}
					case_2_break=true;
				}
				if (!case_2_break && case_2==appframe._ordbutton) {
					{
					CRun.start(new Runnable() { public void run() { Invoi001.browseallorders(); } } ).getId();
					}
					case_2_break=true;
				}
				if (!case_2_break && case_2==appframe._probutton) {
					{
					CRun.start(new Runnable() { public void run() { Invoi002.browseproducts(); } } ).getId();
					}
					case_2_break=true;
				}
				if (!case_2_break && case_2==appframe._cusbutton) {
					{
					CRun.start(new Runnable() { public void run() { Invoi001.browsecustomers(); } } ).getId();
					}
					case_2_break=true;
				}
			}
			return returnvalue.like();
		}
		// UNREACHABLE! :returnvalue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnvalue.like();
	}
	public void takeaccepted_menuReportmenu(Appframe appframe)
	{
		Invoi001.main_menuReportmenu(appframe);
	}
	public void takeaccepted_menuMaintenance(Appframe appframe)
	{
		Invoi001.main_menuMaintenance(appframe);
	}
	public ClarionNumber takewindowevent()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber looped=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		while (true) {
			if (looped.boolValue()) {
				return Clarion.newNumber(Level.NOTIFY);
			}
			else {
				looped.setValue(1);
			}
			returnvalue.setValue(super.takewindowevent());
			{
				int case_1=CWin.event();
				boolean case_1_break=false;
				if (case_1==Event.OPENWINDOW) {
					{
					splashprocedurethread.setValue(CRun.start(new Runnable() { public void run() { Invoi002.splashscreen(); } } ).getId());
					}
					case_1_break=true;
				}
				if (!case_1_break && case_1==Event.TIMER) {
					appframe.setProperty(Prop.STATUSTEXT,3,displaydaytext.get(CDate.today()%7+1).clip().concat(", ",Clarion.newString(String.valueOf(CDate.today())).format("@D4")));
					appframe.setProperty(Prop.STATUSTEXT,4,Clarion.newString(String.valueOf(CDate.clock())).format("@T3"));
					case_1_break=true;
				}
				if (!case_1_break) {
					if (splashprocedurethread.boolValue()) {
						if (CWin.event()==Event.ACCEPTED) {
							CWin.post(Event.CLOSEWINDOW,null,splashprocedurethread.intValue());
							splashprocedurethread.setValue(0);
						}
					}
				}
			}
			return returnvalue.like();
		}
		// UNREACHABLE! :returnvalue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnvalue.like();
	}
}
