package clarion;

import clarion.Main;
import clarion.QuickWindow_2;
import clarion.Toolbarclass;
import clarion.Toolbarupdateclass;
import clarion.Windowmanager;
import clarion.equates.Cancel;
import clarion.equates.Constants;
import clarion.equates.Delete;
import clarion.equates.Event;
import clarion.equates.Insert;
import clarion.equates.Level;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CDate;
import org.jclarion.clarion.runtime.CWin;

public class Thiswindow_5 extends Windowmanager
{
	Thiswindow_5 thisWindow;
	ClarionString actionMessage;
	QuickWindow_2 quickWindow;
	Toolbarclass toolbar;
	Toolbarupdateclass toolbarForm;
	public Thiswindow_5(Thiswindow_5 thisWindow,ClarionString actionMessage,QuickWindow_2 quickWindow,Toolbarclass toolbar,Toolbarupdateclass toolbarForm)
	{
		this.thisWindow=thisWindow;
		this.actionMessage=actionMessage;
		this.quickWindow=quickWindow;
		this.toolbar=toolbar;
		this.toolbarForm=toolbarForm;
	}
	public Thiswindow_5() {}
	public void __Init__(Thiswindow_5 thisWindow,ClarionString actionMessage,QuickWindow_2 quickWindow,Toolbarclass toolbar,Toolbarupdateclass toolbarForm)
	{
		this.thisWindow=thisWindow;
		this.actionMessage=actionMessage;
		this.quickWindow=quickWindow;
		this.toolbar=toolbar;
		this.toolbarForm=toolbarForm;
	}

	public void ask()
	{
		if (Main.gLOMakePayment.equals(0)) {
			Main.gLOCurrentSysid.setValue(Main.accounts.sysID);
		}
		if (Main.gLOMakePayment.equals(1)) {
			Main.transactions.sysID.setValue(Main.gLOCurrentSysid);
			Main.transactions.dateofTransaction.setValue(CDate.today());
			Main.transactions.transactionType.setValue("P");
			Main.transactions.transactionDescription.setValue("Payment - Check number xxx");
			Main.transactions.transactionAmount.setValue(0);
			Main.transactions.reconciledTransaction.setValue(0);
			Main.gLOMakePayment.setValue(0);
		}
		Main.gLOHoldTransactionAmount.setValue(0);
		if (thisWindow.request.equals(Constants.CHANGERECORD)) {
			Main.gLOHoldTransactionAmount.setValue(Main.transactions.transactionAmount);
		}
		{
			ClarionNumber case_1=this.request;
			boolean case_1_break=false;
			if (case_1.equals(Constants.VIEWRECORD)) {
				actionMessage.setValue("View Record");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.INSERTRECORD)) {
				actionMessage.setValue("Adding a Transaction Record");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.CHANGERECORD)) {
				actionMessage.setValue("Changing a Transaction Record");
				case_1_break=true;
			}
		}
		quickWindow.setClonedProperty(Prop.TEXT,actionMessage);
		super.ask();
	}
	public ClarionNumber init()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalErrors.setProcedureName(Clarion.newString("UpdateTransactions"));
		this.request.setValue(Main.globalRequest);
		returnValue.setValue(super.init());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		this.firstField.setValue(quickWindow._panel1);
		this.vCRRequest=Main.vCRRequest;
		this.errors=Main.globalErrors;
		this.addItem(toolbar);
		Main.globalRequest.clear();
		Main.globalResponse.clear();
		this.addUpdateFile(Main.accessTransactions);
		this.addItem(Clarion.newNumber(quickWindow._cancel),Clarion.newNumber(Constants.REQUESTCANCELLED));
		Main.appWindowRef.getControl(Main.gLOButton4).setProperty(Prop.DISABLE,Constants.TRUE);
		Main.relateAccounts.open();
		this.filesOpened.setValue(Constants.TRUE);
		this.primary=Main.relateTransactions;
		if (this.request.equals(Constants.VIEWRECORD)) {
			this.insertAction.setValue(Insert.NONE);
			this.deleteAction.setValue(Delete.NONE);
			this.changeAction.setValue(0);
			this.cancelAction.setValue(Cancel.CANCEL);
			this.okControl.setValue(0);
		}
		else {
			this.okControl.setValue(quickWindow._ok);
			if (this.primeUpdate().boolValue()) {
				return Clarion.newNumber(Level.NOTIFY);
			}
		}
		quickWindow.open();
		this.opened.setValue(Constants.TRUE);
		Main.iNIMgr.fetch(Clarion.newString("UpdateTransactions"),quickWindow);
		toolbarForm.helpButton.setValue(quickWindow._help);
		this.addItem(toolbarForm);
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
			Main.iNIMgr.update(Clarion.newString("UpdateTransactions"),quickWindow);
		}
		Main.appWindowRef.getControl(Main.gLOButton4).setProperty(Prop.DISABLE,Constants.FALSE);
		Main.globalErrors.setProcedureName();
		return returnValue.like();
	}
	public void primeFields()
	{
		super.primeFields();
	}
	public ClarionNumber run()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(super.run());
		if (this.request.equals(Constants.VIEWRECORD)) {
			returnValue.setValue(Constants.REQUESTCANCELLED);
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
				if (case_1==quickWindow._ok) {
					thisWindow.update();
					Main.accounts.sysID.setValue(Main.gLOCurrentSysid);
					Main.accessAccounts.fetch(Main.accounts.sysIDKey);
					if (Main.transactions.transactionType.equals("P") && this.request.equals(Constants.INSERTRECORD)) {
						Main.transactions.transactionAmount.setValue(Main.transactions.transactionAmount.multiply(-1));
					}
					{
						ClarionNumber case_2=this.request;
						boolean case_2_break=false;
						if (case_2.equals(Constants.INSERTRECORD)) {
							Main.accounts.accountBalance.setValue(Main.accounts.accountBalance.add(Main.transactions.transactionAmount));
							case_2_break=true;
						}
						if (!case_2_break && case_2.equals(Constants.CHANGERECORD)) {
							Main.accounts.accountBalance.setValue(Main.accounts.accountBalance.subtract(Main.gLOHoldTransactionAmount).add(Main.transactions.transactionAmount));
							case_2_break=true;
						}
						if (!case_2_break && case_2.equals(Constants.DELETERECORD)) {
							Main.accounts.accountBalance.setValue(Main.accounts.accountBalance.subtract(Main.gLOHoldTransactionAmount));
							case_2_break=true;
						}
					}
					Main.accessAccounts.update();
					if (this.request.equals(Constants.VIEWRECORD)) {
						CWin.post(Event.CLOSEWINDOW);
					}
				}
			}
			return returnValue.like();
		}
		// UNREACHABLE! :returnValue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnValue.like();
	}
}
