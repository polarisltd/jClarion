package clarion;

import clarion.Invoi002;
import clarion.Main;
import clarion.Printpreviewclass;
import clarion.ProgressWindow_4;
import clarion.Report_4;
import clarion.Reportmanager;
import clarion.Steplongclass;
import clarion.Thisreport_4;
import clarion.equates.Constants;
import clarion.equates.Prop;
import clarion.equates.Propagate;
import clarion.equates.Scrollsort;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CExpression;
import org.jclarion.clarion.view.ClarionView;

public class Thiswindow_14 extends Reportmanager
{
	ProgressWindow_4 progressWindow;
	Steplongclass progressMgr;
	Thisreport_4 thisReport;
	ClarionView processView;
	ClarionNumber progressThermometer;
	Report_4 report;
	Printpreviewclass previewer;
	ClarionString locCcsz;
	public Thiswindow_14(ProgressWindow_4 progressWindow,Steplongclass progressMgr,Thisreport_4 thisReport,ClarionView processView,ClarionNumber progressThermometer,Report_4 report,Printpreviewclass previewer,ClarionString locCcsz)
	{
		this.progressWindow=progressWindow;
		this.progressMgr=progressMgr;
		this.thisReport=thisReport;
		this.processView=processView;
		this.progressThermometer=progressThermometer;
		this.report=report;
		this.previewer=previewer;
		this.locCcsz=locCcsz;
	}

	public ClarionNumber init()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalErrors.setProcedureName(Clarion.newString("PrintInvoiceFromBrowse"));
		this.request.setValue(Main.globalRequest);
		returnValue.setValue(super.init());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		this.firstField.setValue(progressWindow._progressThermometer);
		this.vCRRequest=Main.vCRRequest;
		this.errors=Main.globalErrors;
		CExpression.bind("GLOT:CustName",Main.gLOTCustName);
		CExpression.bind("GLOT:CustAddress",Main.gLOTCustAddress);
		CExpression.bind("GLOT:CusCSZ",Main.gLOTCusCSZ);
		Main.globalRequest.clear();
		Main.globalResponse.clear();
		Main.relateCompany.get().open();
		Main.relateCustomers.get().open();
		Main.accessOrders.get().useFile();
		this.filesOpened.setValue(Constants.TRUE);
		progressWindow.open();
		this.opened.setValue(Constants.TRUE);
		init_DefineListboxStyle();
		progressWindow.setProperty(Prop.TIMER,10);
		progressMgr.init(Clarion.newNumber(Scrollsort.ALLOWNUMERIC));
		thisReport.init(processView,Main.relateDetail.get(),Clarion.newNumber(progressWindow._progressPctText),progressThermometer,progressMgr,Main.detail.custNumber);
		thisReport.addSortOrder(Main.detail.keyDetails);
		thisReport.setFilter(Clarion.newString("DTL:CustNumber=ORD:CustNumber AND DTL:OrderNumber=ORD:OrderNumber"));
		this.addItem(Clarion.newNumber(progressWindow._progressCancel),Clarion.newNumber(Constants.REQUESTCANCELLED));
		this.init(thisReport,report,previewer);
		Clarion.getControl(progressWindow._progressUserString).setProperty(Prop.TEXT,"");
		Main.relateDetail.get().setQuickScan(Clarion.newNumber(1),Clarion.newNumber(Propagate.ONEMANY));
		this.skipPreview.setValue(Constants.FALSE);
		this.zoom.setValue(Constants.PAGEWIDTH);
		previewer.setINIManager(Main.iNIMgr);
		previewer.allowUserZoom.setValue(Constants.TRUE);
		previewer.maximize.setValue(Constants.TRUE);
		this.setAlerts();
		return returnValue.like();
	}
	public void init_DefineListboxStyle()
	{
		Invoi002.printInvoiceFromBrowse_DefineListboxStyle();
	}
	public ClarionNumber kill()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(super.kill());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		if (this.filesOpened.boolValue()) {
			Main.relateCompany.get().close();
			Main.relateCustomers.get().close();
		}
		progressMgr.kill();
		Main.globalErrors.setProcedureName();
		return returnValue.like();
	}
	public ClarionNumber next()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.company.set();
		Main.accessCompany.get().next();
		locCcsz.setValue(Main.company.city.clip().concat(", ",Main.company.state,"  ",Main.company.zipCode.clip()));
		returnValue.setValue(super.next());
		return returnValue.like();
	}
	public void reset()
	{
		reset(Clarion.newNumber(0));
	}
	public void reset(ClarionNumber force)
	{
		this.forcedReset.increment(force);
		if (progressWindow.getProperty(Prop.ACCEPTALL).boolValue()) {
			return;
		}
		Main.products.productNumber.setValue(Main.detail.productNumber);
		Main.accessProducts.get().fetch(Main.products.keyProductNumber);
		super.reset(force.like());
	}
	public ClarionNumber takeCloseEvent()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		report.detail1.print();
		returnValue.setValue(super.takeCloseEvent());
		return returnValue.like();
	}
	public void update()
	{
		super.update();
		Main.products.productNumber.setValue(Main.detail.productNumber);
		Main.accessProducts.get().fetch(Main.products.keyProductNumber);
	}
}
