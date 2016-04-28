package clarion;

import clarion.AppFrame;
import clarion.Cardr001;
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

public class Thiswindow_1 extends Windowmanager
{
	AppFrame appFrame;
	ClarionArray<ClarionString> displayDayText;
	Toolbarclass toolbar;
	Thiswindow_1 thisWindow;
	public Thiswindow_1(AppFrame appFrame,ClarionArray<ClarionString> displayDayText,Toolbarclass toolbar,Thiswindow_1 thisWindow)
	{
		this.appFrame=appFrame;
		this.displayDayText=displayDayText;
		this.toolbar=toolbar;
		this.thisWindow=thisWindow;
	}
	public Thiswindow_1() {}
	public void __Init__(AppFrame appFrame,ClarionArray<ClarionString> displayDayText,Toolbarclass toolbar,Thiswindow_1 thisWindow)
	{
		this.appFrame=appFrame;
		this.displayDayText=displayDayText;
		this.toolbar=toolbar;
		this.thisWindow=thisWindow;
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
		this.addItem(toolbar);
		Main.globalRequest.clear();
		Main.globalResponse.clear();
		Main.gLOTodaysDate.setValue(CDate.today());
		Main.gLOLowDate.setValue(CDate.today()-30);
		Main.gLOHighDate.setValue(CDate.today());
		Main.appWindowRef=appFrame;
		Main.gLOButton1.setValue(appFrame._buttonPrint);
		Main.gLOButton2.setValue(appFrame._buttonCurrent);
		Main.gLOButton3.setValue(appFrame._buttonHistory);
		Main.gLOButton4.setValue(appFrame._buttonPay);
		appFrame.open();
		this.opened.setValue(Constants.TRUE);
		Main.iNIMgr.fetch(Clarion.newString("Main"),appFrame);
		ClarionSystem.getInstance().setProperty(Prop.ICON,"~credcard.ico");
		Main.appWindowRef.getControl(Main.gLOButton1).setProperty(Prop.DISABLE,Constants.TRUE);
		Main.appWindowRef.getControl(Main.gLOButton2).setProperty(Prop.DISABLE,Constants.TRUE);
		Main.appWindowRef.getControl(Main.gLOButton3).setProperty(Prop.DISABLE,Constants.TRUE);
		Main.appWindowRef.getControl(Main.gLOButton4).setProperty(Prop.DISABLE,Constants.TRUE);
		this.setAlerts();
		return returnValue.like();
	}
	public ClarionNumber kill()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(super.kill());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		if (this.opened.boolValue()) {
			Main.iNIMgr.update(Clarion.newString("Main"),appFrame);
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
				if (case_1==appFrame._buttonPay) {
					Main.gLOMakePayment.setValue(1);
					CWin.pressKey(Constants.INSERTKEY);
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1==appFrame._toolbarTop) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appFrame._toolbarPageUp) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appFrame._toolbarUp) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appFrame._toolbarLocate) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appFrame._toolbarDown) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appFrame._toolbarPageDown) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appFrame._toolbarBottom) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appFrame._toolbarSelect) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appFrame._toolbarInsert) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appFrame._toolbarChange) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appFrame._toolbarDelete) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appFrame._toolbarHistory) {
					case_1_match=true;
				}
				if (case_1_match || case_1==appFrame._toolbarHelp) {
					if (!ClarionSystem.getInstance().getProperty(Prop.ACTIVE).equals(CRun.getThreadID())) {
						CWin.post(Event.ACCEPTED,CWin.accepted(),ClarionSystem.getInstance().getProperty(Prop.ACTIVE).intValue());
						continue;
					}
					case_1_break=true;
				}
				if (!case_1_break) {
					takeAccepted_MenuReportMenu(appFrame);
				}
			}
			returnValue.setValue(super.takeAccepted());
			{
				int case_2=CWin.accepted();
				boolean case_2_break=false;
				if (case_2==appFrame._browseAccounts) {
					{
						CRun.start(new Runnable() { public void run() { Cardr001.browseAccounts(); } } );
					}
					case_2_break=true;
				}
				if (!case_2_break && case_2==appFrame._aboutAuthor) {
					{
						CRun.start(new Runnable() { public void run() { Cardr001.authorInformation(); } } );
					}
					case_2_break=true;
				}
				if (!case_2_break && case_2==appFrame._button1) {
					{
						CRun.start(new Runnable() { public void run() { Cardr001.browseAccounts(); } } );
					}
					case_2_break=true;
				}
				if (!case_2_break && case_2==appFrame._buttonPay) {
					thisWindow.forcedReset.setValue(Constants.TRUE);
					thisWindow.reset();
					case_2_break=true;
				}
				if (!case_2_break && case_2==appFrame._buttonHistory) {
					{
						CRun.start(new Runnable() { public void run() { Cardr001.browseTransactionHistory(); } } );
					}
					case_2_break=true;
				}
				if (!case_2_break && case_2==appFrame._buttonCurrent) {
					{
						CRun.start(new Runnable() { public void run() { Cardr001.browseCurrentTransactions(); } } );
					}
					case_2_break=true;
				}
				if (!case_2_break && case_2==appFrame._buttonPrint) {
					{
						CRun.start(new Runnable() { public void run() { Cardr001.pickaReport(); } } );
					}
					case_2_break=true;
				}
				if (!case_2_break && case_2==appFrame._button16) {
					Cardr001.printCreditCardRegistry();
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
		Cardr001.main_MenuReportMenu(appFrame);
	}
	public ClarionNumber takeWindowEvent()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber looped=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		return Clarion.newNumber(0);
	}
}
