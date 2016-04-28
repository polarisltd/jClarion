package clarion;

import clarion.Invoi002;
import clarion.Main;
import clarion.Printpreviewclass;
import clarion.ProgressWindow_5;
import clarion.Report_5;
import clarion.Reportmanager;
import clarion.Stepstringclass;
import clarion.Thisreport_5;
import clarion.equates.Constants;
import clarion.equates.Prop;
import clarion.equates.Propagate;
import clarion.equates.Scrollby;
import clarion.equates.Scrollsort;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.view.ClarionView;

public class Thiswindow_17 extends Reportmanager
{
	ProgressWindow_5 progressWindow;
	Stepstringclass progressMgr;
	Thisreport_5 thisReport;
	ClarionView processView;
	ClarionNumber progressThermometer;
	Report_5 report;
	Printpreviewclass previewer;
	public Thiswindow_17(ProgressWindow_5 progressWindow,Stepstringclass progressMgr,Thisreport_5 thisReport,ClarionView processView,ClarionNumber progressThermometer,Report_5 report,Printpreviewclass previewer)
	{
		this.progressWindow=progressWindow;
		this.progressMgr=progressMgr;
		this.thisReport=thisReport;
		this.processView=processView;
		this.progressThermometer=progressThermometer;
		this.report=report;
		this.previewer=previewer;
	}

	public ClarionNumber init()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalErrors.setProcedureName(Clarion.newString("PrintSelectedCustomer"));
		this.request.setValue(Main.globalRequest);
		returnValue.setValue(super.init());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		this.firstField.setValue(progressWindow._progressThermometer);
		this.vCRRequest=Main.vCRRequest;
		this.errors=Main.globalErrors;
		Main.globalRequest.clear();
		Main.globalResponse.clear();
		Main.relateCustomers.get().open();
		this.filesOpened.setValue(Constants.TRUE);
		progressWindow.open();
		this.opened.setValue(Constants.TRUE);
		init_DefineListboxStyle();
		progressWindow.setProperty(Prop.TIMER,10);
		progressMgr.init(Clarion.newNumber(Scrollsort.ALLOWALPHA+Scrollsort.ALLOWNUMERIC),Clarion.newNumber(Scrollby.RUNTIME));
		thisReport.init(processView,Main.relateCustomers.get(),Clarion.newNumber(progressWindow._progressPctText),progressThermometer,progressMgr,Main.customers.lastName);
		thisReport.caseSensitiveValue.setValue(Constants.FALSE);
		thisReport.addSortOrder(Main.customers.keyFullName);
		this.addItem(Clarion.newNumber(progressWindow._progressCancel),Clarion.newNumber(Constants.REQUESTCANCELLED));
		this.init(thisReport,report,previewer);
		Clarion.getControl(progressWindow._progressUserString).setProperty(Prop.TEXT,"");
		Main.relateCustomers.get().setQuickScan(Clarion.newNumber(1),Clarion.newNumber(Propagate.ONEMANY));
		this.skipPreview.setValue(Constants.FALSE);
		this.zoom.setValue(Constants.PAGEWIDTH);
		previewer.setINIManager(Main.iNIMgr);
		previewer.allowUserZoom.setValue(Constants.TRUE);
		previewer.maximize.setValue(Constants.TRUE);
		this.deferWindow.setValue(0);
		this.waitCursor.setValue(1);
		if (this.originalRequest.equals(Constants.PROCESSRECORD)) {
			this.deferWindow.clear(1);
			thisReport.addRange(Main.customers.mi);
		}
		this.setAlerts();
		return returnValue.like();
	}
	public void init_DefineListboxStyle()
	{
		Invoi002.printSelectedCustomer_DefineListboxStyle();
	}
	public ClarionNumber kill()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(super.kill());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		if (this.filesOpened.boolValue()) {
			Main.relateCustomers.get().close();
		}
		progressMgr.kill();
		Main.globalErrors.setProcedureName();
		return returnValue.like();
	}
}
