package clarion.invoi002;

import clarion.Company;
import clarion.Main;
import clarion.Products;
import clarion.abbrowse.Browseeipmanager;
import clarion.abbrowse.Filterlocatorclass;
import clarion.abbrowse.Incrementallocatorclass;
import clarion.abbrowse.Steplongclass;
import clarion.abbrowse.Stepstringclass;
import clarion.abquery.Queryformclass_2;
import clarion.abquery.Queryformvisual_2;
import clarion.abreport.Printpreviewclass_1;
import clarion.abtoolba.Toolbarclass;
import clarion.abtoolba.Toolbarupdateclass;
import clarion.abutil.Selectfileclass;
import clarion.invoi002.Brw1;
import clarion.invoi002.Brw1ViewBrowse;
import clarion.invoi002.Fdb2ViewFiledrop;
import clarion.invoi002.Fieldcolorqueue;
import clarion.invoi002.Fieldcolorqueue_1;
import clarion.invoi002.ProcessView;
import clarion.invoi002.ProcessView_1;
import clarion.invoi002.ProcessView_2;
import clarion.invoi002.ProcessView_3;
import clarion.invoi002.ProcessView_4;
import clarion.invoi002.Progresswindow;
import clarion.invoi002.Progresswindow_1;
import clarion.invoi002.Progresswindow_2;
import clarion.invoi002.Progresswindow_3;
import clarion.invoi002.Progresswindow_4;
import clarion.invoi002.QueueBrowse_1;
import clarion.invoi002.QueueFiledrop;
import clarion.invoi002.Quickwindow;
import clarion.invoi002.Quickwindow_1;
import clarion.invoi002.Quickwindow_2;
import clarion.invoi002.Report;
import clarion.invoi002.Report_1;
import clarion.invoi002.Report_2;
import clarion.invoi002.Report_3;
import clarion.invoi002.Report_4;
import clarion.invoi002.Resizer;
import clarion.invoi002.Resizer_1;
import clarion.invoi002.Resizer_2;
import clarion.invoi002.Thisreport;
import clarion.invoi002.Thisreport_1;
import clarion.invoi002.Thisreport_2;
import clarion.invoi002.Thisreport_3;
import clarion.invoi002.Thisreport_4;
import clarion.invoi002.Thiswindow;
import clarion.invoi002.Thiswindow_1;
import clarion.invoi002.Thiswindow_2;
import clarion.invoi002.Thiswindow_3;
import clarion.invoi002.Thiswindow_4;
import clarion.invoi002.Thiswindow_5;
import clarion.invoi002.Thiswindow_6;
import clarion.invoi002.Thiswindow_7;
import clarion.invoi002.Thiswindow_8;
import clarion.invoi002.Thiswindow_9;
import clarion.invoi002.Window;
import clarion.invoi002.Window_1;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Invoi002
{
	public static Products updateproducts_historyProRecord;
	public static Company updatecompany_historyComRecord;
	static {
		Main.__register_init(new Runnable() { public void run() { __static_init(); } });
		__static_init();
	}

	public static void __static_init() {
		updateproducts_historyProRecord=new Products();
		updatecompany_historyComRecord=new Company();
	}


	public static void updatecompany()
	{
		ClarionString currenttab=Clarion.newString(80);
		ClarionNumber localrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesopened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString actionmessage=Clarion.newString(40).setEncoding(ClarionString.CSTRING);
		ClarionNumber recordchanged=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Quickwindow_2 quickwindow=new Quickwindow_2();
		Toolbarclass toolbar=new Toolbarclass();
		Toolbarupdateclass toolbarform=new Toolbarupdateclass();
		Resizer_2 resizer=new Resizer_2();
		Thiswindow_7 thiswindow=new Thiswindow_7();
		ClarionNumber curctrlfeq=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		Fieldcolorqueue_1 fieldcolorqueue=new Fieldcolorqueue_1();
		thiswindow.__Init__(actionmessage,quickwindow,toolbar,resizer,toolbarform,thiswindow);
		try {
			Main.globalresponse.setValue(thiswindow.run());
		} finally {
			quickwindow.close();
		}
	}
	public static void updateproducts()
	{
		ClarionString currenttab=Clarion.newString(80);
		ClarionNumber localrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesopened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString actionmessage=Clarion.newString(40).setEncoding(ClarionString.CSTRING);
		ClarionNumber recordchanged=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString dosdialogheader=Clarion.newString(40).setEncoding(ClarionString.CSTRING);
		ClarionString dosextparameter=Clarion.newString(250).setEncoding(ClarionString.CSTRING);
		ClarionString dostargetvariable=Clarion.newString(80).setEncoding(ClarionString.CSTRING);
		ClarionString locFilename=Clarion.newString(25);
		Quickwindow quickwindow=new Quickwindow();
		Toolbarclass toolbar=new Toolbarclass();
		Toolbarupdateclass toolbarform=new Toolbarupdateclass();
		Resizer resizer=new Resizer();
		Selectfileclass filelookup5=new Selectfileclass();
		Thiswindow thiswindow=new Thiswindow();
		ClarionNumber curctrlfeq=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		Fieldcolorqueue fieldcolorqueue=new Fieldcolorqueue();
		thiswindow.__Init__(actionmessage,quickwindow,toolbar,resizer,toolbarform,filelookup5,thiswindow,locFilename);
		try {
			Main.globalresponse.setValue(thiswindow.run());
		} finally {
			quickwindow.close();
		}
	}
	public static void browseproducts()
	{
		ClarionString currenttab=Clarion.newString(80);
		ClarionNumber localrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesopened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionView brw1ViewBrowse=new Brw1ViewBrowse();
		QueueBrowse_1 queueBrowse_1=new QueueBrowse_1();
		Quickwindow_1 quickwindow=new Quickwindow_1(queueBrowse_1);
		Toolbarclass toolbar=new Toolbarclass();
		Queryformclass_2 qbe6=new Queryformclass_2();
		Queryformvisual_2 qbv6=new Queryformvisual_2();
		Filterlocatorclass brw1Sort0Locator=new Filterlocatorclass();
		Browseeipmanager brw1Eipmanager=new Browseeipmanager();
		Incrementallocatorclass brw1Sort1Locator=new Incrementallocatorclass();
		Stepstringclass brw1Sort0Stepclass=new Stepstringclass();
		Stepstringclass brw1Sort1Stepclass=new Stepstringclass();
		Resizer_1 resizer=new Resizer_1();
		Brw1 brw1=new Brw1();
		Thiswindow_1 thiswindow=new Thiswindow_1(brw1,quickwindow,toolbar,queueBrowse_1,brw1ViewBrowse,qbe6,qbv6,brw1Sort1Stepclass,brw1Sort1Locator,brw1Sort0Stepclass,brw1Sort0Locator,resizer);
		brw1.__Init__(brw1,brw1Eipmanager,quickwindow);
		try {
			Main.globalresponse.setValue(thiswindow.run());
		} finally {
			quickwindow.close();
			brw1Sort0Locator.destruct();
			brw1Sort1Locator.destruct();
		}
	}
	public static void aboutauthor()
	{
		ClarionNumber localrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesopened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Window window=new Window();
		Toolbarclass toolbar=new Toolbarclass();
		Thiswindow_2 thiswindow=new Thiswindow_2(window,toolbar);
		try {
			Main.globalresponse.setValue(thiswindow.run());
		} finally {
			window.close();
		}
	}
	public static void printcusStatekey()
	{
		ClarionNumber localrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesopened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber progressThermometer=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionView processView=new ProcessView();
		Progresswindow progresswindow=new Progresswindow(progressThermometer);
		Report report=new Report();
		Thisreport thisreport=new Thisreport(report);
		Stepstringclass progressmgr=new Stepstringclass();
		Printpreviewclass_1 previewer=new Printpreviewclass_1();
		Thiswindow_3 thiswindow=new Thiswindow_3(progresswindow,progressmgr,thisreport,processView,progressThermometer,report,previewer);
		try {
			Main.globalresponse.setValue(thiswindow.run());
		} finally {
			progresswindow.close();
			report.close();
		}
	}
	public static void printproKeyproductsku()
	{
		ClarionNumber localrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesopened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber progressThermometer=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionView processView=new ProcessView_1();
		Progresswindow_1 progresswindow=new Progresswindow_1(progressThermometer);
		Report_1 report=new Report_1();
		Thisreport_1 thisreport=new Thisreport_1(report);
		Stepstringclass progressmgr=new Stepstringclass();
		Printpreviewclass_1 previewer=new Printpreviewclass_1();
		Thiswindow_4 thiswindow=new Thiswindow_4(progresswindow,progressmgr,thisreport,processView,progressThermometer,report,previewer);
		try {
			Main.globalresponse.setValue(thiswindow.run());
		} finally {
			progresswindow.close();
			report.close();
		}
	}
	public static void printinvoice()
	{
		ClarionNumber localrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesopened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionDecimal extendprice=Clarion.newDecimal(7,2);
		ClarionString locCcsz=Clarion.newString(35);
		ClarionNumber progressThermometer=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		QueueFiledrop queueFiledrop=new QueueFiledrop();
		ClarionView processView=new ProcessView_2();
		ClarionView fdb2ViewFiledrop=new Fdb2ViewFiledrop();
		Progresswindow_2 progresswindow=new Progresswindow_2(progressThermometer,queueFiledrop);
		Report_2 report=new Report_2(locCcsz,extendprice);
		Thisreport_2 thisreport=new Thisreport_2(extendprice,report);
		Steplongclass progressmgr=new Steplongclass();
		Printpreviewclass_1 previewer=new Printpreviewclass_1();
		Thiswindow_5 thiswindow=new Thiswindow_5();
		thiswindow.__Init__(progresswindow,progressmgr,thisreport,processView,progressThermometer,report,previewer,locCcsz,thiswindow);
		try {
			Main.globalresponse.setValue(thiswindow.run());
		} finally {
			progresswindow.close();
			report.close();
		}
	}
	public static void printmailinglabels()
	{
		ClarionNumber localrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesopened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber progressThermometer=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionView processView=new ProcessView_3();
		Progresswindow_3 progresswindow=new Progresswindow_3(progressThermometer);
		Report_3 report=new Report_3();
		Thisreport_3 thisreport=new Thisreport_3(report);
		Steplongclass progressmgr=new Steplongclass();
		Printpreviewclass_1 previewer=new Printpreviewclass_1();
		Thiswindow_6 thiswindow=new Thiswindow_6(progresswindow,progressmgr,thisreport,processView,progressThermometer,report,previewer);
		try {
			Main.globalresponse.setValue(thiswindow.run());
		} finally {
			progresswindow.close();
			report.close();
		}
	}
	public static void splashscreen()
	{
		ClarionNumber localrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesopened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Window_1 window=new Window_1();
		Toolbarclass toolbar=new Toolbarclass();
		Thiswindow_8 thiswindow=new Thiswindow_8(window,toolbar);
		try {
			Main.globalresponse.setValue(thiswindow.run());
		} finally {
			window.close();
		}
	}
	public static void printselectedproduct()
	{
		ClarionNumber localrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesopened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber progressThermometer=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionView processView=new ProcessView_4();
		Progresswindow_4 progresswindow=new Progresswindow_4(progressThermometer);
		Report_4 report=new Report_4();
		Thisreport_4 thisreport=new Thisreport_4(report);
		Stepstringclass progressmgr=new Stepstringclass();
		Printpreviewclass_1 previewer=new Printpreviewclass_1();
		Thiswindow_9 thiswindow=new Thiswindow_9(progresswindow,progressmgr,thisreport,processView,progressThermometer,report,previewer);
		try {
			Main.globalresponse.setValue(thiswindow.run());
		} finally {
			progresswindow.close();
			report.close();
		}
	}
}
