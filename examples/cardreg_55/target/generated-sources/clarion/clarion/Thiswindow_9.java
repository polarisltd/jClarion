package clarion;

import clarion.Cardr001;
import clarion.Cardr002;
import clarion.Main;
import clarion.Toolbarclass;
import clarion.Window_2;
import clarion.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Level;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CWin;

public class Thiswindow_9 extends Windowmanager
{
	Window_2 window;
	Toolbarclass toolbar;
	ClarionString lOCReportChoice;
	public Thiswindow_9(Window_2 window,Toolbarclass toolbar,ClarionString lOCReportChoice)
	{
		this.window=window;
		this.toolbar=toolbar;
		this.lOCReportChoice=lOCReportChoice;
	}

	public ClarionNumber init()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalErrors.setProcedureName(Clarion.newString("PickaReport"));
		this.request.setValue(Main.globalRequest);
		returnValue.setValue(super.init());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		this.firstField.setValue(window._okButton);
		this.vCRRequest=Main.vCRRequest;
		this.errors=Main.globalErrors;
		this.addItem(toolbar);
		Main.globalRequest.clear();
		Main.globalResponse.clear();
		Main.relateAccounts.open();
		this.filesOpened.setValue(Constants.TRUE);
		window.open();
		this.opened.setValue(Constants.TRUE);
		Main.iNIMgr.fetch(Clarion.newString("PickaReport"),window);
		Main.accounts.sysID.setValue(Main.gLOCurrentSysid);
		Main.accessAccounts.fetch(Main.accounts.sysIDKey);
		window.setProperty(Prop.TEXT,ClarionString.staticConcat("Report Transactions for ",Main.accounts.creditCardVendor.clip()," ( ",Main.gLOCardTypeDescription.clip()," )"));
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
			Main.relateAccounts.close();
		}
		if (this.opened.boolValue()) {
			Main.iNIMgr.update(Clarion.newString("PickaReport"),window);
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
		if (window.getProperty(Prop.ACCEPTALL).boolValue()) {
			return;
		}
		Main.accounts.sysID.setValue(Main.gLOCurrentSysid);
		Main.accessAccounts.fetch(Main.accounts.sysIDKey);
		window.setProperty(Prop.TEXT,ClarionString.staticConcat("Report Transactions for ",Main.accounts.creditCardVendor.clip()," ( ",Main.gLOCardTypeDescription.clip()," )"));
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
				if (case_1==window._okButton) {
					{
						ClarionString case_2=lOCReportChoice;
						boolean case_2_break=false;
						if (case_2.equals("Open")) {
							Cardr002.printOpenTransactions();
							case_2_break=true;
						}
						if (!case_2_break && case_2.equals("History")) {
							Cardr002.updateDates();
							Cardr002.printAccountTransactionHistory();
							case_2_break=true;
						}
						if (!case_2_break && case_2.equals("Purchases")) {
							Cardr002.updateDates();
							Cardr001.printAccountPurchases();
							case_2_break=true;
						}
						if (!case_2_break && case_2.equals("Payments")) {
							Cardr002.updateDates();
							Cardr002.printPaymentHistory();
							case_2_break=true;
						}
					}
				}
			}
			returnValue.setValue(super.takeAccepted());
			return returnValue.like();
		}
		// UNREACHABLE! :returnValue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnValue.like();
	}
}
