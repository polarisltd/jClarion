package clarion;

import clarion.Main;
import clarion.Printpreviewclass;
import clarion.ProcessView_2;
import clarion.ProcessView_3;
import clarion.ProcessView_4;
import clarion.ProgressWindow_2;
import clarion.ProgressWindow_3;
import clarion.ProgressWindow_4;
import clarion.Report_2;
import clarion.Report_3;
import clarion.Report_4;
import clarion.Steplongclass;
import clarion.Thisreport_2;
import clarion.Thisreport_3;
import clarion.Thisreport_4;
import clarion.Thiswindow_10;
import clarion.Thiswindow_11;
import clarion.Thiswindow_12;
import clarion.Thiswindow_13;
import clarion.Thiswindow_14;
import clarion.Toolbarclass;
import clarion.Window_4;
import clarion.Window_5;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.view.ClarionView;

public class Cardr002
{

	public static void printAccountTransactionHistory()
	{
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString lOCTransactionType=Clarion.newString(7);
		ClarionNumber progressThermometer=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionView processView=new ProcessView_2();
		ProgressWindow_2 progressWindow=new ProgressWindow_2(progressThermometer);
		Report_2 report=new Report_2();
		Thisreport_2 thisReport=new Thisreport_2(report);
		Steplongclass progressMgr=new Steplongclass();
		Printpreviewclass previewer=new Printpreviewclass();
		Thiswindow_10 thisWindow=new Thiswindow_10(progressWindow,progressMgr,thisReport,processView,progressThermometer,report,previewer);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			progressWindow.close();
			report.close();
		}
	}
	public static void printOpenTransactions()
	{
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString lOCTransactionType=Clarion.newString(7);
		ClarionString lOCPrntr=Clarion.newString(40);
		ClarionNumber progressThermometer=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionView processView=new ProcessView_3();
		ProgressWindow_3 progressWindow=new ProgressWindow_3(progressThermometer);
		Report_3 report=new Report_3();
		Thisreport_3 thisReport=new Thisreport_3(report);
		Steplongclass progressMgr=new Steplongclass();
		Printpreviewclass previewer=new Printpreviewclass();
		Thiswindow_11 thisWindow=new Thiswindow_11(progressWindow,progressMgr,thisReport,processView,progressThermometer,report,previewer);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			progressWindow.close();
			report.close();
		}
	}
	public static void printPaymentHistory()
	{
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString lOCTransactionType=Clarion.newString(7);
		ClarionNumber progressThermometer=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionView processView=new ProcessView_4();
		ProgressWindow_4 progressWindow=new ProgressWindow_4(progressThermometer);
		Report_4 report=new Report_4();
		Thisreport_4 thisReport=new Thisreport_4(report);
		Steplongclass progressMgr=new Steplongclass();
		Printpreviewclass previewer=new Printpreviewclass();
		Thiswindow_12 thisWindow=new Thiswindow_12(progressWindow,progressMgr,thisReport,processView,progressThermometer,report,previewer);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			progressWindow.close();
			report.close();
		}
	}
	public static void updateDates()
	{
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Window_4 window=new Window_4();
		Toolbarclass toolbar=new Toolbarclass();
		Thiswindow_13 thisWindow=new Thiswindow_13(window,toolbar);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			window.close();
		}
	}
	public static void splashScreen()
	{
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Window_5 window=new Window_5();
		Toolbarclass toolbar=new Toolbarclass();
		Thiswindow_14 thisWindow=new Thiswindow_14(window,toolbar);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			window.close();
		}
	}
}
