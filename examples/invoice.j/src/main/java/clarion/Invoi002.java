package clarion;

import clarion.BRW1ViewBrowse_2;
import clarion.BRW1ViewBrowse_3;
import clarion.BRW1ViewBrowse_4;
import clarion.BRW5ViewBrowse;
import clarion.Browseeipmanager;
import clarion.Brw1_2;
import clarion.Brw1_3;
import clarion.Detailbrowse;
import clarion.Filterlocatorclass;
import clarion.Incrementallocatorclass;
import clarion.Main;
import clarion.Ordersbrowse;
import clarion.Printpreviewclass;
import clarion.ProcessView_4;
import clarion.ProcessView_5;
import clarion.ProcessView_6;
import clarion.ProgressWindow_4;
import clarion.ProgressWindow_5;
import clarion.ProgressWindow_6;
import clarion.Queryformclass;
import clarion.Queryformvisual;
import clarion.QueueBrowse;
import clarion.QueueBrowse_1_2;
import clarion.QueueBrowse_1_3;
import clarion.QueueBrowse_1_4;
import clarion.QuickWindow_7;
import clarion.QuickWindow_8;
import clarion.QuickWindow_9;
import clarion.Report_4;
import clarion.Report_5;
import clarion.Report_6;
import clarion.Resizer_10;
import clarion.Resizer_8;
import clarion.Resizer_9;
import clarion.Steplocatorclass;
import clarion.Steplongclass;
import clarion.Stepstringclass;
import clarion.Thisreport_4;
import clarion.Thisreport_5;
import clarion.Thisreport_6;
import clarion.Thiswindow_14;
import clarion.Thiswindow_15;
import clarion.Thiswindow_16;
import clarion.Thiswindow_17;
import clarion.Thiswindow_18;
import clarion.Thiswindow_19;
import clarion.Toolbarclass;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.view.ClarionView;

public class Invoi002
{

	public static void printInvoiceFromBrowse()
	{
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionDecimal extendPrice=Clarion.newDecimal(7,2);
		ClarionString locCcsz=Clarion.newString(35);
		ClarionNumber progressThermometer=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionView processView=new ProcessView_4();
		ProgressWindow_4 progressWindow=new ProgressWindow_4(progressThermometer);
		Report_4 report=new Report_4(locCcsz,extendPrice);
		Thisreport_4 thisReport=new Thisreport_4(extendPrice,report);
		Steplongclass progressMgr=new Steplongclass();
		Printpreviewclass previewer=new Printpreviewclass();
		Thiswindow_14 thisWindow=new Thiswindow_14(progressWindow,progressMgr,thisReport,processView,progressThermometer,report,previewer,locCcsz);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			progressWindow.close();
			report.close();
			thisReport.destruct();
		}
	}
	public static void printInvoiceFromBrowse_DefineListboxStyle()
	{
	}
	public static void browseOrders()
	{
		ClarionString currentTab=Clarion.newString(80);
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString lOCShipped=Clarion.newString(3);
		ClarionString lOCBackorder=Clarion.newString(3);
		ClarionString taxString=Clarion.newString(8);
		ClarionString discountString=Clarion.newString(8);
		ClarionDecimal totalTax=Clarion.newDecimal(7,2);
		ClarionDecimal totalDiscount=Clarion.newDecimal(7,2);
		ClarionDecimal totalCost=Clarion.newDecimal(7,2);
		ClarionView bRW1ViewBrowse=new BRW1ViewBrowse_2();
		QueueBrowse_1_2 queueBrowse_1=new QueueBrowse_1_2(lOCShipped);
		ClarionView bRW5ViewBrowse=new BRW5ViewBrowse();
		QueueBrowse queueBrowse=new QueueBrowse(lOCBackorder);
		QuickWindow_7 quickWindow=new QuickWindow_7(queueBrowse_1,queueBrowse,totalTax,totalDiscount,totalCost);
		Toolbarclass toolbar=new Toolbarclass();
		Detailbrowse detailBrowse=new Detailbrowse(quickWindow,totalTax,totalDiscount,totalCost,lOCBackorder);
		Steplocatorclass bRW1Sort0Locator=new Steplocatorclass();
		Steplongclass bRW1Sort0StepClass=new Steplongclass();
		Ordersbrowse ordersBrowse=new Ordersbrowse(quickWindow,detailBrowse,lOCShipped);
		Steplocatorclass bRW5Sort0Locator=new Steplocatorclass();
		Resizer_8 resizer=new Resizer_8();
		Thiswindow_15 thisWindow=new Thiswindow_15();
		thisWindow.__Init__(quickWindow,lOCShipped,lOCBackorder,toolbar,ordersBrowse,queueBrowse_1,bRW1ViewBrowse,detailBrowse,queueBrowse,bRW5ViewBrowse,bRW1Sort0StepClass,bRW1Sort0Locator,bRW5Sort0Locator,resizer,thisWindow);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			quickWindow.close();
			detailBrowse.destruct();
			bRW1Sort0Locator.destruct();
			ordersBrowse.destruct();
			bRW5Sort0Locator.destruct();
		}
	}
	public static void browseOrders_DefineListboxStyle()
	{
	}
	public static void browseCustomers()
	{
		ClarionString currentTab=Clarion.newString(80);
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString lOCNameLetter=Clarion.newString(1);
		ClarionString lOCCompanyLetter=Clarion.newString(1);
		ClarionString lOCZipNum=Clarion.newString(2);
		ClarionString lOCState=Clarion.newString(2);
		ClarionString lOCFilterString=Clarion.newString(255);
		ClarionView bRW1ViewBrowse=new BRW1ViewBrowse_3();
		QueueBrowse_1_3 queueBrowse_1=new QueueBrowse_1_3(lOCFilterString,lOCCompanyLetter,lOCZipNum,lOCState,lOCNameLetter);
		QuickWindow_8 quickWindow=new QuickWindow_8(queueBrowse_1);
		Toolbarclass toolbar=new Toolbarclass();
		Queryformclass qbe6=new Queryformclass();
		Queryformvisual qbv6=new Queryformvisual();
		Brw1_2 brw1=new Brw1_2(quickWindow);
		Filterlocatorclass bRW1Sort0Locator=new Filterlocatorclass();
		Filterlocatorclass bRW1Sort1Locator=new Filterlocatorclass();
		Filterlocatorclass bRW1Sort2Locator=new Filterlocatorclass();
		Filterlocatorclass bRW1Sort3Locator=new Filterlocatorclass();
		Stepstringclass bRW1Sort0StepClass=new Stepstringclass();
		Stepstringclass bRW1Sort1StepClass=new Stepstringclass();
		Stepstringclass bRW1Sort2StepClass=new Stepstringclass();
		Stepstringclass bRW1Sort3StepClass=new Stepstringclass();
		Resizer_9 resizer=new Resizer_9();
		Thiswindow_16 thisWindow=new Thiswindow_16();
		thisWindow.__Init__(quickWindow,lOCFilterString,lOCCompanyLetter,lOCZipNum,lOCState,lOCNameLetter,toolbar,brw1,queueBrowse_1,bRW1ViewBrowse,qbe6,qbv6,bRW1Sort1StepClass,bRW1Sort1Locator,bRW1Sort2StepClass,bRW1Sort2Locator,bRW1Sort3StepClass,bRW1Sort3Locator,bRW1Sort0StepClass,bRW1Sort0Locator,resizer,thisWindow);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			quickWindow.close();
			brw1.destruct();
			bRW1Sort0Locator.destruct();
			bRW1Sort1Locator.destruct();
			bRW1Sort2Locator.destruct();
			bRW1Sort3Locator.destruct();
		}
	}
	public static void browseCustomers_DefineListboxStyle()
	{
	}
	public static ClarionString cityStateZip(ClarionString p0,ClarionString p1)
	{
		return cityStateZip(p0,p1,(ClarionString)null);
	}
	public static ClarionString cityStateZip(ClarionString p0)
	{
		return cityStateZip(p0,(ClarionString)null);
	}
	public static ClarionString cityStateZip()
	{
		return cityStateZip((ClarionString)null);
	}
	public static ClarionString cityStateZip(ClarionString lOCCity,ClarionString lOCState,ClarionString lOCZip)
	{
		if (lOCCity==null || lOCCity.equals("")) {
			return Clarion.newString(lOCState.concat("  ",lOCZip));
		}
		else if (lOCState==null || lOCState.equals("")) {
			return Clarion.newString(lOCCity.clip().concat(",  ",lOCZip));
		}
		else if (lOCZip==null || lOCZip.equals("")) {
			return Clarion.newString(lOCCity.clip().concat(",  ",lOCState));
		}
		else {
			return Clarion.newString(lOCCity.clip().concat(", ",lOCState,"  ",lOCZip));
		}
	}
	public static void printSelectedCustomer()
	{
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber progressThermometer=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString locCsz=Clarion.newString(45);
		ClarionString lOCAddress=Clarion.newString(45);
		ClarionView processView=new ProcessView_5();
		ProgressWindow_5 progressWindow=new ProgressWindow_5(progressThermometer);
		Report_5 report=new Report_5(lOCAddress,locCsz);
		Thisreport_5 thisReport=new Thisreport_5(lOCAddress,locCsz,report);
		Stepstringclass progressMgr=new Stepstringclass();
		Printpreviewclass previewer=new Printpreviewclass();
		Thiswindow_17 thisWindow=new Thiswindow_17(progressWindow,progressMgr,thisReport,processView,progressThermometer,report,previewer);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			progressWindow.close();
			report.close();
			thisReport.destruct();
		}
	}
	public static void printSelectedCustomer_DefineListboxStyle()
	{
	}
	public static void printSelectedProduct()
	{
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber progressThermometer=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionView processView=new ProcessView_6();
		ProgressWindow_6 progressWindow=new ProgressWindow_6(progressThermometer);
		Report_6 report=new Report_6();
		Thisreport_6 thisReport=new Thisreport_6(report);
		Stepstringclass progressMgr=new Stepstringclass();
		Printpreviewclass previewer=new Printpreviewclass();
		Thiswindow_18 thisWindow=new Thiswindow_18(progressWindow,progressMgr,thisReport,processView,progressThermometer,report,previewer);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			progressWindow.close();
			report.close();
			thisReport.destruct();
		}
	}
	public static void printSelectedProduct_DefineListboxStyle()
	{
	}
	public static void browseProducts()
	{
		ClarionString currentTab=Clarion.newString(80);
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionView bRW1ViewBrowse=new BRW1ViewBrowse_4();
		QueueBrowse_1_4 queueBrowse_1=new QueueBrowse_1_4();
		QuickWindow_9 quickWindow=new QuickWindow_9(queueBrowse_1);
		Toolbarclass toolbar=new Toolbarclass();
		Queryformclass qbe6=new Queryformclass();
		Queryformvisual qbv6=new Queryformvisual();
		Filterlocatorclass bRW1Sort0Locator=new Filterlocatorclass();
		Browseeipmanager bRW1EIPManager=new Browseeipmanager();
		Incrementallocatorclass bRW1Sort1Locator=new Incrementallocatorclass();
		Stepstringclass bRW1Sort0StepClass=new Stepstringclass();
		Stepstringclass bRW1Sort1StepClass=new Stepstringclass();
		Resizer_10 resizer=new Resizer_10();
		Brw1_3 brw1=new Brw1_3();
		Thiswindow_19 thisWindow=new Thiswindow_19(brw1,quickWindow,toolbar,queueBrowse_1,bRW1ViewBrowse,qbe6,qbv6,bRW1Sort1StepClass,bRW1Sort1Locator,bRW1Sort0StepClass,bRW1Sort0Locator,resizer);
		brw1.__Init__(brw1,bRW1EIPManager,quickWindow);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			quickWindow.close();
			bRW1Sort0Locator.destruct();
			bRW1Sort1Locator.destruct();
			brw1.destruct();
		}
	}
	public static void browseProducts_DefineListboxStyle()
	{
	}
}
