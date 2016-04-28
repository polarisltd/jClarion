package clarion;

import clarion.Invoi003;
import clarion.Main;
import clarion.Printpreviewclass;
import clarion.ProgressWindow_1;
import clarion.Report_1;
import clarion.Reportmanager;
import clarion.Stepstringclass;
import clarion.Thisreport_1;
import clarion.equates.Constants;
import clarion.equates.Prop;
import clarion.equates.Propagate;
import clarion.equates.Scrollby;
import clarion.equates.Scrollsort;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.view.ClarionView;

public class Thiswindow_9 extends Reportmanager
{
	ProgressWindow_1 progressWindow;
	Stepstringclass progressMgr;
	Thisreport_1 thisReport;
	ClarionView processView;
	ClarionNumber progressThermometer;
	Report_1 report;
	Printpreviewclass previewer;
	public Thiswindow_9(ProgressWindow_1 progressWindow,Stepstringclass progressMgr,Thisreport_1 thisReport,ClarionView processView,ClarionNumber progressThermometer,Report_1 report,Printpreviewclass previewer)
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
		Main.globalErrors.setProcedureName(Clarion.newString("PrintPRO:KeyProductSKU"));
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
		this.setAlerts();
		return returnValue.like();
	}
	public void init_DefineListboxStyle()
	{
		Invoi003.printPROKeyProductSKU_DefineListboxStyle();
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
