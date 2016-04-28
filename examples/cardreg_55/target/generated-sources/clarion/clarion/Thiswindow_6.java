package clarion;

import clarion.Brw1_1;
import clarion.Cardr001;
import clarion.Main;
import clarion.QueueBrowse_1_1;
import clarion.QuickWindow_3;
import clarion.Steplocatorclass;
import clarion.Toolbarclass;
import clarion.Windowmanager;
import clarion.equates.Button;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Icon;
import clarion.equates.Level;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CDate;
import org.jclarion.clarion.runtime.CExpression;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.view.ClarionView;

public class Thiswindow_6 extends Windowmanager
{
	QuickWindow_3 quickWindow;
	ClarionArray<ClarionString> displayDayText;
	Toolbarclass toolbar;
	Brw1_1 brw1;
	QueueBrowse_1_1 queueBrowse_1;
	ClarionView bRW1ViewBrowse;
	Steplocatorclass bRW1Sort1Locator;
	ClarionDecimal lOCAvailableFunds;
	ClarionDecimal lOCAvgTran;
	ClarionDecimal lOCTotalOpenTransactions;
	Steplocatorclass bRW1Sort0Locator;
	Thiswindow_6 thisWindow;
	public Thiswindow_6(QuickWindow_3 quickWindow,ClarionArray<ClarionString> displayDayText,Toolbarclass toolbar,Brw1_1 brw1,QueueBrowse_1_1 queueBrowse_1,ClarionView bRW1ViewBrowse,Steplocatorclass bRW1Sort1Locator,ClarionDecimal lOCAvailableFunds,ClarionDecimal lOCAvgTran,ClarionDecimal lOCTotalOpenTransactions,Steplocatorclass bRW1Sort0Locator,Thiswindow_6 thisWindow)
	{
		this.quickWindow=quickWindow;
		this.displayDayText=displayDayText;
		this.toolbar=toolbar;
		this.brw1=brw1;
		this.queueBrowse_1=queueBrowse_1;
		this.bRW1ViewBrowse=bRW1ViewBrowse;
		this.bRW1Sort1Locator=bRW1Sort1Locator;
		this.lOCAvailableFunds=lOCAvailableFunds;
		this.lOCAvgTran=lOCAvgTran;
		this.lOCTotalOpenTransactions=lOCTotalOpenTransactions;
		this.bRW1Sort0Locator=bRW1Sort0Locator;
		this.thisWindow=thisWindow;
	}
	public Thiswindow_6() {}
	public void __Init__(QuickWindow_3 quickWindow,ClarionArray<ClarionString> displayDayText,Toolbarclass toolbar,Brw1_1 brw1,QueueBrowse_1_1 queueBrowse_1,ClarionView bRW1ViewBrowse,Steplocatorclass bRW1Sort1Locator,ClarionDecimal lOCAvailableFunds,ClarionDecimal lOCAvgTran,ClarionDecimal lOCTotalOpenTransactions,Steplocatorclass bRW1Sort0Locator,Thiswindow_6 thisWindow)
	{
		this.quickWindow=quickWindow;
		this.displayDayText=displayDayText;
		this.toolbar=toolbar;
		this.brw1=brw1;
		this.queueBrowse_1=queueBrowse_1;
		this.bRW1ViewBrowse=bRW1ViewBrowse;
		this.bRW1Sort1Locator=bRW1Sort1Locator;
		this.lOCAvailableFunds=lOCAvailableFunds;
		this.lOCAvgTran=lOCAvgTran;
		this.lOCTotalOpenTransactions=lOCTotalOpenTransactions;
		this.bRW1Sort0Locator=bRW1Sort0Locator;
		this.thisWindow=thisWindow;
	}

	public void ask()
	{
		if (!CRun.inRange(quickWindow.getProperty(Prop.TIMER),Clarion.newNumber(1),Clarion.newNumber(100))) {
			quickWindow.setProperty(Prop.TIMER,100);
		}
		quickWindow.setProperty(Prop.STATUSTEXT,1,displayDayText.get(CDate.today()%7+1).clip().concat(", ",Clarion.newString(String.valueOf(CDate.today())).format("@D4")));
		quickWindow.setProperty(Prop.STATUSTEXT,2,Clarion.newString(String.valueOf(CDate.clock())).format("@T3"));
		super.ask();
	}
	public ClarionNumber init()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalErrors.setProcedureName(Clarion.newString("BrowseCurrentTransactions"));
		this.request.setValue(Main.globalRequest);
		returnValue.setValue(super.init());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		this.firstField.setValue(quickWindow._browse_1);
		this.vCRRequest=Main.vCRRequest;
		this.errors=Main.globalErrors;
		this.addItem(toolbar);
		Main.globalRequest.clear();
		Main.globalResponse.clear();
		this.addItem(Clarion.newNumber(quickWindow._close),Clarion.newNumber(Constants.REQUESTCANCELLED));
		Main.relateAccounts.open();
		this.filesOpened.setValue(Constants.TRUE);
		Main.appWindowRef.getControl(Main.gLOButton4).setProperty(Prop.DISABLE,Constants.FALSE);
		brw1.init(Clarion.newNumber(quickWindow._browse_1),queueBrowse_1.viewPosition,bRW1ViewBrowse,queueBrowse_1,Main.relateTransactions,this);
		quickWindow.open();
		this.opened.setValue(Constants.TRUE);
		brw1.q=queueBrowse_1;
		brw1.addSortOrder(null,Main.transactions.sysIDTypeKey);
		brw1.addRange(Main.transactions.sysID,Main.relateTransactions,Main.relateAccounts);
		brw1.addLocator(bRW1Sort1Locator);
		bRW1Sort1Locator.init(Clarion.newNumber(0),Main.transactions.transactionType,Clarion.newNumber(1),brw1);
		brw1.setFilter(Clarion.newString("(TRA:ReconciledTransaction = 0)"));
		brw1.addResetField(Main.accounts.accountBalance);
		brw1.addResetField(lOCAvailableFunds);
		brw1.addResetField(lOCAvgTran);
		brw1.addResetField(lOCTotalOpenTransactions);
		brw1.addSortOrder(null,Main.transactions.sysIDDateKey);
		brw1.addRange(Main.transactions.sysID,Main.relateTransactions,Main.relateAccounts);
		brw1.addLocator(bRW1Sort0Locator);
		bRW1Sort0Locator.init(Clarion.newNumber(0),Main.transactions.dateofTransaction,Clarion.newNumber(1),brw1);
		brw1.setFilter(Clarion.newString("(TRA:ReconciledTransaction = 0)"));
		brw1.addResetField(Main.accounts.accountBalance);
		brw1.addResetField(lOCAvailableFunds);
		brw1.addResetField(lOCTotalOpenTransactions);
		brw1.addResetField(Main.transactions.reconciledTransaction);
		CExpression.bind("GLO:TransactionTypeDescription",Main.gLOTransactionTypeDescription);
		CExpression.bind("LOC:AvailableFunds",lOCAvailableFunds);
		brw1.addField(Main.transactions.dateofTransaction,brw1.q.tRADateofTransaction);
		brw1.addField(Main.transactions.transactionDescription,brw1.q.tRATransactionDescription);
		brw1.addField(Main.gLOTransactionTypeDescription,brw1.q.gLOTransactionTypeDescription);
		brw1.addField(Main.transactions.transactionAmount,brw1.q.tRATransactionAmount);
		brw1.addField(Main.transactions.reconciledTransaction,brw1.q.tRAReconciledTransaction);
		brw1.addField(Main.accounts.creditLimit,brw1.q.aCCCreditLimit);
		brw1.addField(lOCAvailableFunds,brw1.q.lOCAvailableFunds);
		brw1.addField(Main.accounts.accountBalance,brw1.q.aCCAccountBalance);
		brw1.addField(Main.transactions.sysID,brw1.q.tRASysID);
		brw1.addField(Main.transactions.transactionType,brw1.q.tRATransactionType);
		Main.iNIMgr.fetch(Clarion.newString("BrowseCurrentTransactions"),quickWindow);
		Main.accounts.sysID.setValue(Main.gLOCurrentSysid);
		Main.accessAccounts.fetch(Main.accounts.sysIDKey);
		quickWindow.setProperty(Prop.TEXT,ClarionString.staticConcat("Current Transactions for ",Main.accounts.creditCardVendor.clip()," ( ",Main.gLOCardTypeDescription.clip()," )"));
		brw1.askProcedure.setValue(1);
		brw1.addToolbarTarget(toolbar);
		brw1.toolbarItem.helpButton.setValue(quickWindow._button6);
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
			Main.iNIMgr.update(Clarion.newString("BrowseCurrentTransactions"),quickWindow);
		}
		Main.appWindowRef.getControl(Main.gLOButton4).setProperty(Prop.DISABLE,Constants.TRUE);
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
		if (quickWindow.getProperty(Prop.ACCEPTALL).boolValue()) {
			return;
		}
		Main.accounts.sysID.setValue(Main.gLOCurrentSysid);
		Main.accessAccounts.fetch(Main.accounts.sysIDKey);
		quickWindow.setProperty(Prop.TEXT,ClarionString.staticConcat("Current Transactions for ",Main.accounts.creditCardVendor.clip()," ( ",Main.gLOCardTypeDescription.clip()," )"));
		lOCAvailableFunds.setValue(Main.accounts.creditLimit.subtract(Main.accounts.accountBalance));
		super.reset(force.like());
	}
	public ClarionNumber run(ClarionNumber number,ClarionNumber request)
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(super.run(number.like(),request.like()));
		Main.gLOHoldTransactionAmount.setValue(Main.transactions.transactionAmount);
		if (this.request.equals(Constants.VIEWRECORD)) {
			returnValue.setValue(Constants.REQUESTCANCELLED);
		}
		else {
			Main.globalRequest.setValue(request);
			Cardr001.updateTransactions();
			returnValue.setValue(Main.globalResponse);
		}
		if (Main.globalRequest.equals(Constants.DELETERECORD) && Main.globalResponse.equals(Constants.REQUESTCOMPLETED)) {
			Main.accounts.sysID.setValue(Main.gLOCurrentSysid);
			Main.accessAccounts.fetch(Main.accounts.sysIDKey);
			Main.accounts.accountBalance.setValue(Main.accounts.accountBalance.subtract(Main.gLOHoldTransactionAmount));
			Main.accessAccounts.update();
		}
		return returnValue.like();
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
			returnValue.setValue(super.takeAccepted());
			{
				int case_1=CWin.accepted();
				if (case_1==quickWindow._reconcileButton) {
					thisWindow.update();
					{
						int case_2=CWin.message(Clarion.newString("Do you want to reconcile this transaction?||Record will be moved to Transaction History"),Clarion.newString("Confirm Reconciliation"),Icon.QUESTION,Button.YES+Button.NO,Button.NO,1);
						if (case_2==Button.YES) {
							Main.transactions.reconciledTransaction.setValue(1);
							Main.accessTransactions.update();
							thisWindow.forcedReset.setValue(Constants.TRUE);
							thisWindow.reset();
						}
					}
				}
			}
			return returnValue.like();
		}
		// UNREACHABLE! :returnValue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnValue.like();
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
			returnValue.setValue(super.takeWindowEvent());
			{
				int case_1=CWin.event();
				boolean case_1_break=false;
				if (case_1==Event.LOSEFOCUS) {
					Main.appWindowRef.getControl(Main.gLOButton4).setProperty(Prop.DISABLE,Constants.TRUE);
					case_1_break=true;
				}
				if (!case_1_break && case_1==Event.GAINFOCUS) {
					Main.appWindowRef.getControl(Main.gLOButton4).setProperty(Prop.DISABLE,Constants.FALSE);
					case_1_break=true;
				}
				if (!case_1_break && case_1==Event.TIMER) {
					quickWindow.setProperty(Prop.STATUSTEXT,1,displayDayText.get(CDate.today()%7+1).clip().concat(", ",Clarion.newString(String.valueOf(CDate.today())).format("@D4")));
					quickWindow.setProperty(Prop.STATUSTEXT,2,Clarion.newString(String.valueOf(CDate.clock())).format("@T3"));
					case_1_break=true;
				}
			}
			return returnValue.like();
		}
		// UNREACHABLE! :returnValue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnValue.like();
	}
}
