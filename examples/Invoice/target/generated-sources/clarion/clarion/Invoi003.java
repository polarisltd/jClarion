package clarion;

import clarion.Company;
import clarion.FDB2ViewFileDrop;
import clarion.Fdb2;
import clarion.Fieldcolorqueue_3;
import clarion.Fieldcolorqueue_4;
import clarion.Main;
import clarion.Printpreviewclass;
import clarion.ProcessView;
import clarion.ProcessView_1;
import clarion.ProcessView_2;
import clarion.ProcessView_3;
import clarion.Products;
import clarion.ProgressWindow;
import clarion.ProgressWindow_1;
import clarion.ProgressWindow_2;
import clarion.ProgressWindow_3;
import clarion.QueueFiledrop;
import clarion.QuickWindow_5;
import clarion.QuickWindow_6;
import clarion.Report;
import clarion.Report_1;
import clarion.Report_2;
import clarion.Report_3;
import clarion.Resizer_6;
import clarion.Resizer_7;
import clarion.Selectfileclass;
import clarion.Steplongclass;
import clarion.Stepstringclass;
import clarion.Thisreport;
import clarion.Thisreport_1;
import clarion.Thisreport_2;
import clarion.Thisreport_3;
import clarion.Thiswindow_10;
import clarion.Thiswindow_11;
import clarion.Thiswindow_12;
import clarion.Thiswindow_13;
import clarion.Thiswindow_7;
import clarion.Thiswindow_8;
import clarion.Thiswindow_9;
import clarion.Toolbarclass;
import clarion.Toolbarupdateclass;
import clarion.Window_3;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.view.ClarionView;

public class Invoi003
{

	public static void updateCompany()
	{
		ClarionString currentTab=Clarion.newString(80);
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString actionMessage=Clarion.newString(40).setEncoding(ClarionString.CSTRING);
		ClarionNumber recordChanged=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Company historyCOMRecord=(Company)(new Company()).getThread();
		QuickWindow_6 quickWindow=new QuickWindow_6();
		Toolbarclass toolbar=new Toolbarclass();
		Toolbarupdateclass toolbarForm=new Toolbarupdateclass();
		Resizer_7 resizer=new Resizer_7();
		Thiswindow_12 thisWindow=new Thiswindow_12();
		ClarionNumber curCtrlFeq=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		Fieldcolorqueue_4 fieldColorQueue=new Fieldcolorqueue_4();
		thisWindow.__Init__(actionMessage,quickWindow,toolbar,historyCOMRecord,resizer,toolbarForm,thisWindow);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			quickWindow.close();
		}
	}
	public static void updateCompany_DefineListboxStyle()
	{
	}
	public static void updateProducts()
	{
		ClarionString currentTab=Clarion.newString(80);
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString actionMessage=Clarion.newString(40).setEncoding(ClarionString.CSTRING);
		ClarionNumber recordChanged=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString dOSDialogHeader=Clarion.newString(40).setEncoding(ClarionString.CSTRING);
		ClarionString dOSExtParameter=Clarion.newString(250).setEncoding(ClarionString.CSTRING);
		ClarionString dOSTargetVariable=Clarion.newString(80).setEncoding(ClarionString.CSTRING);
		ClarionString lOCFileName=Clarion.newString(85);
		Products historyPRORecord=(Products)(new Products()).getThread();
		QuickWindow_5 quickWindow=new QuickWindow_5();
		Toolbarclass toolbar=new Toolbarclass();
		Toolbarupdateclass toolbarForm=new Toolbarupdateclass();
		Resizer_6 resizer=new Resizer_6();
		Selectfileclass fileLookup5=new Selectfileclass();
		Thiswindow_7 thisWindow=new Thiswindow_7();
		ClarionNumber curCtrlFeq=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		Fieldcolorqueue_3 fieldColorQueue=new Fieldcolorqueue_3();
		thisWindow.__Init__(actionMessage,quickWindow,toolbar,historyPRORecord,resizer,toolbarForm,fileLookup5,thisWindow,lOCFileName);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			quickWindow.close();
		}
	}
	public static void updateProducts_DefineListboxStyle()
	{
	}
	public static void printCUSStateKey()
	{
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber progressThermometer=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionView processView=new ProcessView();
		ProgressWindow progressWindow=new ProgressWindow(progressThermometer);
		Report report=new Report();
		Thisreport thisReport=new Thisreport(report);
		Stepstringclass progressMgr=new Stepstringclass();
		Printpreviewclass previewer=new Printpreviewclass();
		Thiswindow_8 thisWindow=new Thiswindow_8(progressWindow,progressMgr,thisReport,processView,progressThermometer,report,previewer);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			progressWindow.close();
			report.close();
			thisReport.destruct();
		}
	}
	public static void printCUSStateKey_DefineListboxStyle()
	{
	}
	public static void printPROKeyProductSKU()
	{
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber progressThermometer=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionView processView=new ProcessView_1();
		ProgressWindow_1 progressWindow=new ProgressWindow_1(progressThermometer);
		Report_1 report=new Report_1();
		Thisreport_1 thisReport=new Thisreport_1(report);
		Stepstringclass progressMgr=new Stepstringclass();
		Printpreviewclass previewer=new Printpreviewclass();
		Thiswindow_9 thisWindow=new Thiswindow_9(progressWindow,progressMgr,thisReport,processView,progressThermometer,report,previewer);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			progressWindow.close();
			report.close();
			thisReport.destruct();
		}
	}
	public static void printPROKeyProductSKU_DefineListboxStyle()
	{
	}
	public static void printInvoice()
	{
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionDecimal extendPrice=Clarion.newDecimal(7,2);
		ClarionString locCcsz=Clarion.newString(35);
		ClarionNumber progressThermometer=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		QueueFiledrop queueFileDrop=new QueueFiledrop();
		ClarionView processView=new ProcessView_2();
		ClarionView fDB2ViewFileDrop=new FDB2ViewFileDrop();
		ProgressWindow_2 progressWindow=new ProgressWindow_2(progressThermometer,queueFileDrop);
		Report_2 report=new Report_2(locCcsz,extendPrice);
		Thisreport_2 thisReport=new Thisreport_2(extendPrice,report);
		Steplongclass progressMgr=new Steplongclass();
		Printpreviewclass previewer=new Printpreviewclass();
		Thiswindow_10 thisWindow=new Thiswindow_10();
		Fdb2 fdb2=new Fdb2();
		thisWindow.__Init__(progressWindow,progressMgr,thisReport,processView,progressThermometer,report,previewer,locCcsz,thisWindow);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			progressWindow.close();
			report.close();
			thisReport.destruct();
			fdb2.destruct();
		}
	}
	public static void printInvoice_DefineListboxStyle()
	{
	}
	public static void printMailingLabels()
	{
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
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
			thisReport.destruct();
		}
	}
	public static void printMailingLabels_DefineListboxStyle()
	{
	}
	public static void splashScreen()
	{
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Window_3 window=new Window_3();
		Toolbarclass toolbar=new Toolbarclass();
		Thiswindow_13 thisWindow=new Thiswindow_13(window,toolbar);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			window.close();
		}
	}
	public static void splashScreen_DefineListboxStyle()
	{
	}
}
