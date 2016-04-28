package clarion;

import clarion.Invoi003;
import clarion.Main;
import clarion.Printpreviewclass;
import clarion.ProgressWindow;
import clarion.Report;
import clarion.Reportmanager;
import clarion.Stepstringclass;
import clarion.Thisreport;
import clarion.equates.Constants;
import clarion.equates.Prop;
import clarion.equates.Propagate;
import clarion.equates.Scrollby;
import clarion.equates.Scrollsort;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.view.ClarionView;

public class Thiswindow_8 extends Reportmanager
{
	ProgressWindow progressWindow;
	Stepstringclass progressMgr;
	Thisreport thisReport;
	ClarionView processView;
	ClarionNumber progressThermometer;
	Report report;
	Printpreviewclass previewer;
	public Thiswindow_8(ProgressWindow progressWindow,Stepstringclass progressMgr,Thisreport thisReport,ClarionView processView,ClarionNumber progressThermometer,Report report,Printpreviewclass previewer)
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
		Main.globalErrors.setProcedureName(Clarion.newString("PrintCUS:StateKey"));
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
		thisReport.init(processView,Main.relateCustomers.get(),Clarion.newNumber(progressWindow._progressPctText),progressThermometer,progressMgr,Main.customers.state);
		thisReport.caseSensitiveValue.setValue(Constants.FALSE);
		thisReport.addSortOrder(Main.customers.stateKey);
		this.addItem(Clarion.newNumber(progressWindow._progressCancel),Clarion.newNumber(Constants.REQUESTCANCELLED));
		this.init(thisReport,report,previewer);
		Clarion.getControl(progressWindow._progressUserString).setProperty(Prop.TEXT,"");
		Main.relateCustomers.get().setQuickScan(Clarion.newNumber(1),Clarion.newNumber(Propagate.ONEMANY));
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
		Invoi003.printCUSStateKey_DefineListboxStyle();
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
