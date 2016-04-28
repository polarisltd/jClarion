package clarion;

import clarion.AppFrame;
import clarion.BRW1ViewBrowse;
import clarion.BRW1ViewBrowse_1;
import clarion.BRW1ViewBrowse_2;
import clarion.Brw1;
import clarion.Brw1_1;
import clarion.Brw1_2;
import clarion.Fieldcolorqueue;
import clarion.Fieldcolorqueue_1;
import clarion.Filterlocatorclass;
import clarion.Main;
import clarion.Printpreviewclass;
import clarion.ProcessView;
import clarion.ProcessView_1;
import clarion.ProgressWindow;
import clarion.ProgressWindow_1;
import clarion.QueueBrowse_1;
import clarion.QueueBrowse_1_1;
import clarion.QueueBrowse_1_2;
import clarion.QuickWindow;
import clarion.QuickWindow_1;
import clarion.QuickWindow_2;
import clarion.QuickWindow_3;
import clarion.QuickWindow_4;
import clarion.Report;
import clarion.Report_1;
import clarion.Steplocatorclass;
import clarion.Steplongclass;
import clarion.Stepstringclass;
import clarion.Thisreport;
import clarion.Thisreport_1;
import clarion.Thiswindow;
import clarion.Thiswindow_1;
import clarion.Thiswindow_2;
import clarion.Thiswindow_3;
import clarion.Thiswindow_4;
import clarion.Thiswindow_5;
import clarion.Thiswindow_6;
import clarion.Thiswindow_7;
import clarion.Thiswindow_8;
import clarion.Thiswindow_9;
import clarion.Toolbarclass;
import clarion.Toolbarupdateclass;
import clarion.Window_1;
import clarion.Window_2;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.view.ClarionView;

public class Cardr001
{

	public static void main()
	{
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString currentTab=Clarion.newString(80);
		ClarionNumber splashProcedureThread=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionString displayDayString=Clarion.newString("Sunday   Monday   Tuesday  WednesdayThursday Friday   Saturday ");
		ClarionArray<ClarionString> displayDayText=Clarion.newString(9).dim(7).setOver(displayDayString);
		AppFrame appFrame=new AppFrame();
		Toolbarclass toolbar=new Toolbarclass();
		Thiswindow_1 thisWindow=new Thiswindow_1();
		thisWindow.__Init__(appFrame,displayDayText,toolbar,thisWindow);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			appFrame.close();
		}
	}
	public static void main_MenuReportMenu(AppFrame appFrame)
	{
		{
			int case_1=CWin.accepted();
			if (case_1==appFrame._printACCCreditCardVendorKey) {
				{
					CRun.start(new Runnable() { public void run() { Cardr001.printCreditCardRegistry(); } } );
				}
			}
		}
	}
	public static void authorInformation()
	{
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Window_1 window=new Window_1();
		Toolbarclass toolbar=new Toolbarclass();
		Thiswindow thisWindow=new Thiswindow(window,toolbar);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			window.close();
		}
	}
	public static void updateAccounts()
	{
		ClarionString currentTab=Clarion.newString(80);
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString actionMessage=Clarion.newString(40).setEncoding(ClarionString.CSTRING);
		ClarionNumber recordChanged=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		QuickWindow quickWindow=new QuickWindow();
		Toolbarclass toolbar=new Toolbarclass();
		Toolbarupdateclass toolbarForm=new Toolbarupdateclass();
		Fieldcolorqueue fieldColorQueue=new Fieldcolorqueue();
		ClarionNumber curCtrlFeq=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		Thiswindow_2 thisWindow=new Thiswindow_2();
		thisWindow.__Init__(actionMessage,quickWindow,toolbar,toolbarForm,fieldColorQueue,thisWindow);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			quickWindow.close();
		}
	}
	public static void browseAccounts()
	{
		ClarionString currentTab=Clarion.newString(80);
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString lOCCityStateZip=Clarion.newString(40);
		ClarionString lOCOrdinalExtension=Clarion.newString("'st'");
		ClarionString lOCCardTypeDescription=Clarion.newString(16);
		ClarionDecimal lOCTotalOutstandingDebt=Clarion.newDecimal(8,2);
		ClarionView bRW1ViewBrowse=new BRW1ViewBrowse();
		QueueBrowse_1 queueBrowse_1=new QueueBrowse_1(lOCCityStateZip,lOCOrdinalExtension,lOCCardTypeDescription);
		QuickWindow_1 quickWindow=new QuickWindow_1(queueBrowse_1,lOCTotalOutstandingDebt,lOCOrdinalExtension,lOCCityStateZip);
		Toolbarclass toolbar=new Toolbarclass();
		Brw1 brw1=new Brw1(quickWindow,lOCTotalOutstandingDebt,lOCCityStateZip,lOCOrdinalExtension);
		Filterlocatorclass bRW1Sort0Locator=new Filterlocatorclass();
		Stepstringclass bRW1Sort0StepClass=new Stepstringclass();
		Thiswindow_3 thisWindow=new Thiswindow_3(quickWindow,toolbar,brw1,queueBrowse_1,bRW1ViewBrowse,bRW1Sort0StepClass,bRW1Sort0Locator,lOCCityStateZip,lOCOrdinalExtension,lOCCardTypeDescription);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			quickWindow.close();
			bRW1Sort0Locator.destruct();
		}
	}
	public static void printCreditCardRegistry()
	{
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString lOCCardType=Clarion.newString(20);
		ClarionString lOCOrdinalExtension=Clarion.newString(2);
		ClarionString lOCCityStateZip=Clarion.newString(35);
		ClarionDecimal lOCAvailableFunds=Clarion.newDecimal(7,2);
		ClarionNumber progressThermometer=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionView processView=new ProcessView();
		ProgressWindow progressWindow=new ProgressWindow(progressThermometer);
		Report report=new Report(lOCCardType,lOCCityStateZip,lOCAvailableFunds,lOCOrdinalExtension);
		Thisreport thisReport=new Thisreport(lOCCardType,lOCOrdinalExtension,lOCCityStateZip,lOCAvailableFunds,report);
		Stepstringclass progressMgr=new Stepstringclass();
		Printpreviewclass previewer=new Printpreviewclass();
		Thiswindow_4 thisWindow=new Thiswindow_4(progressWindow,progressMgr,thisReport,processView,progressThermometer,report,previewer);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			progressWindow.close();
			report.close();
		}
	}
	public static void updateTransactions()
	{
		ClarionString currentTab=Clarion.newString(80);
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString actionMessage=Clarion.newString(40).setEncoding(ClarionString.CSTRING);
		ClarionNumber recordChanged=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		QuickWindow_2 quickWindow=new QuickWindow_2();
		Toolbarclass toolbar=new Toolbarclass();
		Toolbarupdateclass toolbarForm=new Toolbarupdateclass();
		Thiswindow_5 thisWindow=new Thiswindow_5();
		ClarionNumber curCtrlFeq=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		Fieldcolorqueue_1 fieldColorQueue=new Fieldcolorqueue_1();
		thisWindow.__Init__(thisWindow,actionMessage,quickWindow,toolbar,toolbarForm);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			quickWindow.close();
		}
	}
	public static void browseCurrentTransactions()
	{
		ClarionString currentTab=Clarion.newString(80);
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionDecimal lOCTotalOpenTransactions=Clarion.newDecimal(7,2,0);
		ClarionDecimal lOCAvgTran=Clarion.newDecimal(7,2);
		ClarionDecimal lOCAvailableFunds=Clarion.newDecimal(9,2);
		ClarionView bRW1ViewBrowse=new BRW1ViewBrowse_1();
		QueueBrowse_1_1 queueBrowse_1=new QueueBrowse_1_1(lOCAvailableFunds);
		ClarionString displayDayString=Clarion.newString("Sunday   Monday   Tuesday  WednesdayThursday Friday   Saturday ");
		ClarionArray<ClarionString> displayDayText=Clarion.newString(9).dim(7).setOver(displayDayString);
		QuickWindow_3 quickWindow=new QuickWindow_3(queueBrowse_1,lOCTotalOpenTransactions,lOCAvgTran,lOCAvailableFunds);
		Toolbarclass toolbar=new Toolbarclass();
		Brw1_1 brw1=new Brw1_1(quickWindow,lOCTotalOpenTransactions,lOCAvgTran);
		Steplocatorclass bRW1Sort0Locator=new Steplocatorclass();
		Steplocatorclass bRW1Sort1Locator=new Steplocatorclass();
		Thiswindow_6 thisWindow=new Thiswindow_6();
		thisWindow.__Init__(quickWindow,displayDayText,toolbar,brw1,queueBrowse_1,bRW1ViewBrowse,bRW1Sort1Locator,lOCAvailableFunds,lOCAvgTran,lOCTotalOpenTransactions,bRW1Sort0Locator,thisWindow);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			quickWindow.close();
			bRW1Sort0Locator.destruct();
			bRW1Sort1Locator.destruct();
		}
	}
	public static void browseTransactionHistory()
	{
		ClarionString currentTab=Clarion.newString(80);
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionDecimal lOCTotalOpenTransactions=Clarion.newDecimal(7,2,0);
		ClarionDecimal lOCAvgTran=Clarion.newDecimal(7,2);
		ClarionDecimal lOCAvailableFunds=Clarion.newDecimal(7,2);
		ClarionView bRW1ViewBrowse=new BRW1ViewBrowse_2();
		QueueBrowse_1_2 queueBrowse_1=new QueueBrowse_1_2(lOCAvailableFunds);
		ClarionString displayDayString=Clarion.newString("Sunday   Monday   Tuesday  WednesdayThursday Friday   Saturday ");
		ClarionArray<ClarionString> displayDayText=Clarion.newString(9).dim(7).setOver(displayDayString);
		QuickWindow_4 quickWindow=new QuickWindow_4(queueBrowse_1,lOCAvailableFunds);
		Toolbarclass toolbar=new Toolbarclass();
		Brw1_2 brw1=new Brw1_2(quickWindow);
		Steplocatorclass bRW1Sort0Locator=new Steplocatorclass();
		Steplocatorclass bRW1Sort1Locator=new Steplocatorclass();
		Thiswindow_7 thisWindow=new Thiswindow_7(quickWindow,displayDayText,toolbar,brw1,queueBrowse_1,bRW1ViewBrowse,bRW1Sort1Locator,bRW1Sort0Locator,lOCTotalOpenTransactions,lOCAvailableFunds);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			quickWindow.close();
			bRW1Sort0Locator.destruct();
			bRW1Sort1Locator.destruct();
		}
	}
	public static void printAccountPurchases()
	{
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString lOCTransactionType=Clarion.newString(7);
		ClarionNumber progressThermometer=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionView processView=new ProcessView_1();
		ProgressWindow_1 progressWindow=new ProgressWindow_1(progressThermometer);
		Report_1 report=new Report_1();
		Thisreport_1 thisReport=new Thisreport_1(report);
		Steplongclass progressMgr=new Steplongclass();
		Printpreviewclass previewer=new Printpreviewclass();
		Thiswindow_8 thisWindow=new Thiswindow_8(progressWindow,progressMgr,thisReport,processView,progressThermometer,report,previewer);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			progressWindow.close();
			report.close();
		}
	}
	public static void pickaReport()
	{
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString lOCReportChoice=Clarion.newString(10);
		Window_2 window=new Window_2(lOCReportChoice);
		Toolbarclass toolbar=new Toolbarclass();
		Thiswindow_9 thisWindow=new Thiswindow_9(window,toolbar,lOCReportChoice);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			window.close();
		}
	}
}
