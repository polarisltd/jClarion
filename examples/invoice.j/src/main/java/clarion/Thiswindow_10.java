package clarion;

import clarion.Invoi003;
import clarion.Main;
import clarion.Printpreviewclass;
import clarion.ProgressWindow_2;
import clarion.Report_2;
import clarion.Reportmanager;
import clarion.Steplongclass;
import clarion.Thisreport_2;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.equates.Propagate;
import clarion.equates.Scrollsort;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CExpression;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.view.ClarionView;

public class Thiswindow_10 extends Reportmanager
{
	public ClarionNumber paused;
	public ClarionNumber timer;
	public ClarionNumber cancelled;
	ProgressWindow_2 progressWindow;
	Steplongclass progressMgr;
	Thisreport_2 thisReport;
	ClarionView processView;
	ClarionNumber progressThermometer;
	Report_2 report;
	Printpreviewclass previewer;
	ClarionString locCcsz;
	Thiswindow_10 thisWindow;
	public Thiswindow_10(ProgressWindow_2 progressWindow,Steplongclass progressMgr,Thisreport_2 thisReport,ClarionView processView,ClarionNumber progressThermometer,Report_2 report,Printpreviewclass previewer,ClarionString locCcsz,Thiswindow_10 thisWindow)
	{
		this.progressWindow=progressWindow;
		this.progressMgr=progressMgr;
		this.thisReport=thisReport;
		this.processView=processView;
		this.progressThermometer=progressThermometer;
		this.report=report;
		this.previewer=previewer;
		this.locCcsz=locCcsz;
		this.thisWindow=thisWindow;
		paused=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		timer=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		cancelled=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	}
	public Thiswindow_10() {}
	public void __Init__(ProgressWindow_2 progressWindow,Steplongclass progressMgr,Thisreport_2 thisReport,ClarionView processView,ClarionNumber progressThermometer,Report_2 report,Printpreviewclass previewer,ClarionString locCcsz,Thiswindow_10 thisWindow)
	{
		this.progressWindow=progressWindow;
		this.progressMgr=progressMgr;
		this.thisReport=thisReport;
		this.processView=processView;
		this.progressThermometer=progressThermometer;
		this.report=report;
		this.previewer=previewer;
		this.locCcsz=locCcsz;
		this.thisWindow=thisWindow;
		paused=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		timer=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		cancelled=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	}

	public ClarionNumber init()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalErrors.setProcedureName(Clarion.newString("PrintInvoice"));
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
		CRun._assert(!this.deferWindow.boolValue());
		this.deferOpenReport.setValue(1);
		this.timer.setValue(CWin.getTarget().getProperty(Prop.TIMER));
		CWin.getTarget().setProperty(Prop.TIMER,0);
		Clarion.getControl(progressWindow._pause).setProperty(Prop.TEXT,"Go");
		this.paused.setValue(1);
		Clarion.getControl(progressWindow._progressCancel).setProperty(Prop.KEY,Constants.ESCKEY);
		this.setAlerts();
		return returnValue.like();
	}
	public void init_DefineListboxStyle()
	{
		Invoi003.printInvoice_DefineListboxStyle();
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
	public ClarionNumber takeAccepted()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber looped=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		while (true) {
			if (looped.boolValue()) {
				return Clarion.newNumber(Level.NOTIFY);
			}
			else {
				looped.setValue(1);
			}
			{
				int case_1=CWin.accepted();
				if (case_1==progressWindow._pause) {
					if (this.paused.boolValue()) {
						CWin.getTarget().setClonedProperty(Prop.TIMER,this.timer);
						Clarion.getControl(progressWindow._pause).setProperty(Prop.TEXT,"Pause");
					}
					else {
						this.timer.setValue(CWin.getTarget().getProperty(Prop.TIMER));
						CWin.getTarget().setProperty(Prop.TIMER,0);
						Clarion.getControl(progressWindow._pause).setProperty(Prop.TEXT,"Restart");
					}
					this.paused.setValue(Clarion.newNumber(1).subtract(this.paused));
				}
			}
			returnValue.setValue(super.takeAccepted());
			{
				int case_2=CWin.accepted();
				if (case_2==progressWindow._progressCancel) {
					thisWindow.update();
					this.cancelled.setValue(1);
				}
			}
			return returnValue.like();
		}
		// UNREACHABLE! :returnValue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnValue.like();
	}
	public ClarionNumber takeCloseEvent()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		report.detail1.print();
		returnValue.setValue(super.takeCloseEvent());
		return returnValue.like();
	}
	public ClarionNumber takeWindowEvent()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber looped=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		while (true) {
			if (looped.boolValue()) {
				return Clarion.newNumber(Level.NOTIFY);
			}
			else {
				looped.setValue(1);
			}
			{
				int case_1=CWin.event();
				boolean case_1_break=false;
				if (case_1==Event.CLOSEWINDOW) {
					this.keepVisible.setValue(1);
					case_1_break=true;
				}
				if (!case_1_break && case_1==Event.TIMER) {
					if (this.paused.boolValue()) {
						return Clarion.newNumber(Level.BENIGN);
					}
					case_1_break=true;
				}
			}
			returnValue.setValue(super.takeWindowEvent());
			{
				int case_2=CWin.event();
				if (case_2==Event.CLOSEWINDOW) {
					if (!this.cancelled.boolValue()) {
						progressThermometer.setValue(0);
						Clarion.getControl(progressWindow._progressPctText).setProperty(Prop.TEXT,"0% Completed");
						this.deferOpenReport.setValue(1);
						CWin.getTarget().setProperty(Prop.TIMER,0);
						Clarion.getControl(progressWindow._pause).setProperty(Prop.TEXT,"Go");
						this.paused.setValue(1);
						this.process.close();
						this.response.setValue(Constants.REQUESTCANCELLED);
						CWin.display();
						return Clarion.newNumber(Level.NOTIFY);
					}
				}
			}
			return returnValue.like();
		}
		// UNREACHABLE! :returnValue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnValue.like();
	}
	public void update()
	{
		super.update();
		Main.products.productNumber.setValue(Main.detail.productNumber);
		Main.accessProducts.get().fetch(Main.products.keyProductNumber);
	}
}
