package clarion;

import clarion.Brw1_2;
import clarion.Cardr001;
import clarion.Main;
import clarion.QueueBrowse_1_2;
import clarion.QuickWindow_4;
import clarion.Steplocatorclass;
import clarion.Toolbarclass;
import clarion.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Event;
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

public class Thiswindow_7 extends Windowmanager
{
	QuickWindow_4 quickWindow;
	ClarionArray<ClarionString> displayDayText;
	Toolbarclass toolbar;
	Brw1_2 brw1;
	QueueBrowse_1_2 queueBrowse_1;
	ClarionView bRW1ViewBrowse;
	Steplocatorclass bRW1Sort1Locator;
	Steplocatorclass bRW1Sort0Locator;
	ClarionDecimal lOCTotalOpenTransactions;
	ClarionDecimal lOCAvailableFunds;
	public Thiswindow_7(QuickWindow_4 quickWindow,ClarionArray<ClarionString> displayDayText,Toolbarclass toolbar,Brw1_2 brw1,QueueBrowse_1_2 queueBrowse_1,ClarionView bRW1ViewBrowse,Steplocatorclass bRW1Sort1Locator,Steplocatorclass bRW1Sort0Locator,ClarionDecimal lOCTotalOpenTransactions,ClarionDecimal lOCAvailableFunds)
	{
		this.quickWindow=quickWindow;
		this.displayDayText=displayDayText;
		this.toolbar=toolbar;
		this.brw1=brw1;
		this.queueBrowse_1=queueBrowse_1;
		this.bRW1ViewBrowse=bRW1ViewBrowse;
		this.bRW1Sort1Locator=bRW1Sort1Locator;
		this.bRW1Sort0Locator=bRW1Sort0Locator;
		this.lOCTotalOpenTransactions=lOCTotalOpenTransactions;
		this.lOCAvailableFunds=lOCAvailableFunds;
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
		Main.globalErrors.setProcedureName(Clarion.newString("BrowseTransactionHistory"));
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
		brw1.init(Clarion.newNumber(quickWindow._browse_1),queueBrowse_1.viewPosition,bRW1ViewBrowse,queueBrowse_1,Main.relateTransactions,this);
		quickWindow.open();
		this.opened.setValue(Constants.TRUE);
		brw1.q=queueBrowse_1;
		brw1.addSortOrder(null,Main.transactions.sysIDTypeKey);
		brw1.addRange(Main.transactions.sysID,Main.relateTransactions,Main.relateAccounts);
		brw1.addLocator(bRW1Sort1Locator);
		bRW1Sort1Locator.init(Clarion.newNumber(0),Main.transactions.transactionType,Clarion.newNumber(1),brw1);
		brw1.setFilter(Clarion.newString("(TRA:ReconciledTransaction = 1)"));
		brw1.addSortOrder(null,Main.transactions.sysIDDateKey);
		brw1.addRange(Main.transactions.sysID,Main.relateTransactions,Main.relateAccounts);
		brw1.addLocator(bRW1Sort0Locator);
		bRW1Sort0Locator.init(Clarion.newNumber(0),Main.transactions.dateofTransaction,Clarion.newNumber(1),brw1);
		brw1.setFilter(Clarion.newString("(TRA:ReconciledTransaction = 1)"));
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
		Main.iNIMgr.fetch(Clarion.newString("BrowseTransactionHistory"),quickWindow);
		Main.accounts.sysID.setValue(Main.gLOCurrentSysid);
		Main.accessAccounts.fetch(Main.accounts.sysIDKey);
		quickWindow.setProperty(Prop.TEXT,ClarionString.staticConcat("Transaction History for ",Main.accounts.creditCardVendor.clip()," ( ",Main.gLOCardTypeDescription.clip()," )"));
		brw1.askProcedure.setValue(1);
		brw1.addToolbarTarget(toolbar);
		brw1.toolbarItem.helpButton.setValue(quickWindow._button5);
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
			Main.iNIMgr.update(Clarion.newString("BrowseTransactionHistory"),quickWindow);
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
		if (quickWindow.getProperty(Prop.ACCEPTALL).boolValue()) {
			return;
		}
		lOCAvailableFunds.setValue(Main.accounts.creditLimit.subtract(Main.accounts.accountBalance));
		Main.accounts.sysID.setValue(Main.gLOCurrentSysid);
		Main.accessAccounts.fetch(Main.accounts.sysIDKey);
		quickWindow.setProperty(Prop.TEXT,ClarionString.staticConcat("Transaction History for ",Main.accounts.creditCardVendor.clip()," ( ",Main.gLOCardTypeDescription.clip()," )"));
		super.reset(force.like());
	}
	public ClarionNumber run(ClarionNumber number,ClarionNumber request)
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.accounts.sysID.setValue(Main.gLOCurrentSysid);
		Main.accessAccounts.fetch(Main.accounts.sysIDKey);
		Main.accounts.accountBalance.setValue(Main.accounts.accountBalance.subtract(Main.gLOHoldTransactionAmount));
		Main.accessAccounts.update();
		Main.gLOHoldTransactionAmount.setValue(0);
		returnValue.setValue(super.run(number.like(),request.like()));
		Main.gLOHoldTransactionAmount.setValue(Main.transactions.transactionAmount);
		if (Main.globalRequest.equals(Constants.DELETERECORD) && Main.globalResponse.equals(Constants.REQUESTCOMPLETED)) {
			Main.accounts.sysID.setValue(Main.gLOCurrentSysid);
			Main.accessAccounts.fetch(Main.accounts.sysIDKey);
			Main.accounts.accountBalance.setValue(Main.accounts.accountBalance.subtract(Main.gLOHoldTransactionAmount));
			Main.accessAccounts.update();
		}
		if (this.request.equals(Constants.VIEWRECORD)) {
			returnValue.setValue(Constants.REQUESTCANCELLED);
		}
		else {
			Main.globalRequest.setValue(request);
			Cardr001.updateTransactions();
			returnValue.setValue(Main.globalResponse);
		}
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
			returnValue.setValue(super.takeWindowEvent());
			{
				int case_1=CWin.event();
				if (case_1==Event.TIMER) {
					quickWindow.setProperty(Prop.STATUSTEXT,1,displayDayText.get(CDate.today()%7+1).clip().concat(", ",Clarion.newString(String.valueOf(CDate.today())).format("@D4")));
					quickWindow.setProperty(Prop.STATUSTEXT,2,Clarion.newString(String.valueOf(CDate.clock())).format("@T3"));
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
		lOCAvailableFunds.setValue(Main.accounts.creditLimit.subtract(Main.accounts.accountBalance));
	}
}
