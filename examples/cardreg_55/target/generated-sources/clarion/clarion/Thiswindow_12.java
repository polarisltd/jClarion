package clarion;

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
import org.jclarion.clarion.runtime.CExpression;
import org.jclarion.clarion.view.ClarionView;

public class Thiswindow_12 extends Reportmanager
{
	ProgressWindow_4 progressWindow;
	Steplongclass progressMgr;
	Thisreport_4 thisReport;
	ClarionView processView;
	ClarionNumber progressThermometer;
	Report_4 report;
	Printpreviewclass previewer;
	public Thiswindow_12(ProgressWindow_4 progressWindow,Steplongclass progressMgr,Thisreport_4 thisReport,ClarionView processView,ClarionNumber progressThermometer,Report_4 report,Printpreviewclass previewer)
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
		Main.globalErrors.setProcedureName(Clarion.newString("PrintPaymentHistory"));
		this.request.setValue(Main.globalRequest);
		returnValue.setValue(super.init());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		this.firstField.setValue(progressWindow._progressThermometer);
		this.vCRRequest=Main.vCRRequest;
		this.errors=Main.globalErrors;
		CExpression.bind("GLO:CurrentSysid",Main.gLOCurrentSysid);
		CExpression.bind("GLO:HighDate",Main.gLOHighDate);
		CExpression.bind("GLO:LowDate",Main.gLOLowDate);
		Main.globalRequest.clear();
		Main.globalResponse.clear();
		Main.relateTransactions.open();
		this.filesOpened.setValue(Constants.TRUE);
		progressWindow.open();
		this.opened.setValue(Constants.TRUE);
		Main.iNIMgr.fetch(Clarion.newString("PrintPaymentHistory"),progressWindow);
		progressMgr.init(Clarion.newNumber(Scrollsort.ALLOWNUMERIC));
		thisReport.init(processView,Main.relateTransactions,Clarion.newNumber(progressWindow._progressPctText),progressThermometer,Clarion.newNumber(25));
		thisReport.addSortOrder(Main.transactions.sysIDDateKey);
		thisReport.setFilter(Clarion.newString("TRA:TransactionType = 'P' AND TRA:SysID = GLO:CurrentSysID AND TRA:DateofTransaction  >= GLO:LowDate AND TRA:DateofTransaction <= GLO:HighDate"));
		this.addItem(Clarion.newNumber(progressWindow._progressCancel),Clarion.newNumber(Constants.REQUESTCANCELLED));
		this.init(thisReport,report,previewer);
		Clarion.getControl(progressWindow._progressUserString).setProperty(Prop.TEXT,"");
		Main.relateTransactions.setQuickScan(Clarion.newNumber(1),Clarion.newNumber(Propagate.ONEMANY));
		previewer.setINIManager(Main.iNIMgr);
		previewer.allowUserZoom.setValue(Constants.TRUE);
		this.setAlerts();
		return returnValue.like();
	}
	public ClarionNumber kill()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(super.kill());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		if (this.filesOpened.boolValue()) {
			Main.relateTransactions.close();
		}
		if (this.opened.boolValue()) {
			Main.iNIMgr.update(Clarion.newString("PrintPaymentHistory"),progressWindow);
		}
		Main.globalErrors.setProcedureName();
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
		Main.accounts.sysID.setValue(Main.transactions.sysID);
		Main.accessAccounts.fetch(Main.accounts.sysIDKey);
		super.reset(force.like());
	}
	public void update()
	{
		super.update();
		Main.accounts.sysID.setValue(Main.transactions.sysID);
		Main.accessAccounts.fetch(Main.accounts.sysIDKey);
	}
}
