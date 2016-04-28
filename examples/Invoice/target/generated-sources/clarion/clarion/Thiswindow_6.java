package clarion;

import clarion.AppFrame;
import clarion.Invoi001;
import clarion.Invoi002;
import clarion.Main;
import clarion.Toolbarclass;
import clarion.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionSystem;
import org.jclarion.clarion.runtime.CDate;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

public class Thiswindow_6 extends Windowmanager
{
	AppFrame appFrame;
	ClarionArray<ClarionString> displayDayText;
	Toolbarclass toolbar;
	public Thiswindow_6(AppFrame appFrame,ClarionArray<ClarionString> displayDayText,Toolbarclass toolbar)
	{
		this.appFrame=appFrame;
		this.displayDayText=displayDayText;
		this.toolbar=toolbar;
	}

	public void ask()
	{
		if (!CRun.inRange(appFrame.getProperty(Prop.TIMER),Clarion.newNumber(1),Clarion.newNumber(100))) {
			appFrame.setProperty(Prop.TIMER,100);
		}
		appFrame.setProperty(Prop.STATUSTEXT,3,displayDayText.get(CDate.today()%7+1).clip().concat(", ",Clarion.newString(String.valueOf(CDate.today())).format("@D4")));
		appFrame.setProperty(Prop.STATUSTEXT,4,Clarion.newString(String.valueOf(CDate.clock())).format("@T3"));
		super.ask();
	}
	public ClarionNumber init()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalErrors.setProcedureName(Clarion.newString("Main"));
		this.request.setValue(Main.globalRequest);
		returnValue.setValue(super.init());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		this.firstField.setValue(1);
		this.vCRRequest=Main.vCRRequest;
		this.errors=Main.globalErrors;
		Main.globalRequest.clear();
		Main.globalResponse.clear();
		this.addItem(toolbar);
		appFrame.open();
		this.opened.setValue(Constants.TRUE);
		init_DefineListboxStyle();
		ClarionSystem.getInstance().setProperty(Prop.ICON,"~Order.ico");
		this.setAlerts();
		return returnValue.like();
	}
	public void init_DefineListboxStyle()
	{
		Invoi001.main_DefineListboxStyle();
	}
	public ClarionNumber kill()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(super.kill());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		Main.globalErrors.setProcedureName();
		return returnValue.like();
	}
	public ClarionNumber takeAccepted()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
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
				if (case_1==appFrame._toolbarHelp) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appFrame._toolbarHistory) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appFrame._toolbarDelete) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appFrame._toolbarChange) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appFrame._toolbarInsert) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appFrame._toolbarSelect) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appFrame._toolbarBottom) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appFrame._toolbarPageDown) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appFrame._toolbarDown) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appFrame._toolbarLocate) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appFrame._toolbarUp) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appFrame._toolbarPageUp) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appFrame._toolbarTop) {
					if (!ClarionSystem.getInstance().getProperty(Prop.ACTIVE).equals(CRun.getThreadID())) {
						CWin.post(Event.ACCEPTED,CWin.accepted(),ClarionSystem.getInstance().getProperty(Prop.ACTIVE).intValue());
						continue;
					}
					case_1_break=true;
				}
				if (!case_1_break) {
					takeAccepted_MenuReportMenu(appFrame);
					takeAccepted_MenuMaintenance(appFrame);
				}
			}
			returnValue.setValue(super.takeAccepted());
			{
				int case_2=CWin.accepted();
				boolean case_2_break=false;
				if (case_2==appFrame._browseCustomers) {
					{
						CRun.start(new Runnable() { public void run() { Invoi002.browseCustomers(); } } );
					}
					case_2_break=true;
				}
				if (!case_2_break && case_2==appFrame._browseAllOrders) {
					{
						CRun.start(new Runnable() { public void run() { Invoi001.browseAllOrders(); } } );
					}
					case_2_break=true;
				}
				if (!case_2_break && case_2==appFrame._browseProducts) {
					{
						CRun.start(new Runnable() { public void run() { Invoi002.browseProducts(); } } );
					}
					case_2_break=true;
				}
				if (!case_2_break && case_2==appFrame._ordButton) {
					{
						CRun.start(new Runnable() { public void run() { Invoi001.browseAllOrders(); } } );
					}
					case_2_break=true;
				}
				if (!case_2_break && case_2==appFrame._proButton) {
					{
						CRun.start(new Runnable() { public void run() { Invoi002.browseProducts(); } } );
					}
					case_2_break=true;
				}
				if (!case_2_break && case_2==appFrame._cusButton) {
					{
						CRun.start(new Runnable() { public void run() { Invoi002.browseCustomers(); } } );
					}
					case_2_break=true;
				}
			}
			return returnValue.like();
		}
		// UNREACHABLE! :returnValue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnValue.like();
	}
	public void takeAccepted_MenuReportMenu(AppFrame appFrame)
	{
		Invoi001.main_MenuReportMenu(appFrame);
	}
	public void takeAccepted_MenuMaintenance(AppFrame appFrame)
	{
		Invoi001.main_MenuMaintenance(appFrame);
	}
	public ClarionNumber takeWindowEvent()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber looped=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(0);
		return returnValue.like();
	}
}
