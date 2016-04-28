package clarion;

import clarion.Invoi002;
import clarion.Main;
import clarion.Printpreviewclass;
import clarion.ProgressWindow_6;
import clarion.Report_6;
import clarion.Reportmanager;
import clarion.Stepstringclass;
import clarion.Thisreport_6;
import clarion.equates.Constants;
import clarion.equates.Prop;
import clarion.equates.Propagate;
import clarion.equates.Scrollby;
import clarion.equates.Scrollsort;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.view.ClarionView;

public class Thiswindow_18 extends Reportmanager
{
	ProgressWindow_6 progressWindow;
	Stepstringclass progressMgr;
	Thisreport_6 thisReport;
	ClarionView processView;
	ClarionNumber progressThermometer;
	Report_6 report;
	Printpreviewclass previewer;
	public Thiswindow_18(ProgressWindow_6 progressWindow,Stepstringclass progressMgr,Thisreport_6 thisReport,ClarionView processView,ClarionNumber progressThermometer,Report_6 report,Printpreviewclass previewer)
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
		Main.globalErrors.setProcedureName(Clarion.newString("PrintSelectedProduct"));
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
		Main.relateProducts.get().open();
		this.filesOpened.setValue(Constants.TRUE);
		progressWindow.open();
		this.opened.setValue(Constants.TRUE);
		init_DefineListboxStyle();
		progressWindow.setProperty(Prop.TIMER,10);
		progressMgr.init(Clarion.newNumber(Scrollsort.ALLOWALPHA+Scrollsort.ALLOWNUMERIC),Clarion.newNumber(Scrollby.RUNTIME));
		thisReport.init(processView,Main.relateProducts.get(),Clarion.newNumber(progressWindow._progressPctText),progressThermometer,progressMgr,Main.products.productSKU);
		thisReport.caseSensitiveValue.setValue(Constants.FALSE);
		thisReport.addSortOrder(Main.products.keyProductSKU);
		this.addItem(Clarion.newNumber(progressWindow._progressCancel),Clarion.newNumber(Constants.REQUESTCANCELLED));
		this.init(thisReport,report,previewer);
		Clarion.getControl(progressWindow._progressUserString).setProperty(Prop.TEXT,"");
		Main.relateProducts.get().setQuickScan(Clarion.newNumber(1),Clarion.newNumber(Propagate.ONEMANY));
		this.skipPreview.setValue(Constants.FALSE);
		this.zoom.setValue(Constants.PAGEWIDTH);
		previewer.setINIManager(Main.iNIMgr);
		previewer.allowUserZoom.setValue(Constants.TRUE);
		previewer.maximize.setValue(Constants.TRUE);
		this.deferWindow.setValue(0);
		this.waitCursor.setValue(1);
		if (this.originalRequest.equals(Constants.PROCESSRECORD)) {
			this.deferWindow.clear(1);
			thisReport.addRange(Main.products.productSKU);
		}
		this.setAlerts();
		return returnValue.like();
	}
	public void init_DefineListboxStyle()
	{
		Invoi002.printSelectedProduct_DefineListboxStyle();
	}
	public ClarionNumber kill()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(super.kill());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		if (this.filesOpened.boolValue()) {
			Main.relateProducts.get().close();
		}
		progressMgr.kill();
		Main.globalErrors.setProcedureName();
		return returnValue.like();
	}
}
