package clarion;

import clarion.Fieldcolorqueue;
import clarion.Main;
import clarion.QuickWindow;
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
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CWin;

public class Thiswindow_2 extends Windowmanager
{
	ClarionString actionMessage;
	QuickWindow quickWindow;
	Toolbarclass toolbar;
	Toolbarupdateclass toolbarForm;
	Fieldcolorqueue fieldColorQueue;
	Thiswindow_2 thisWindow;
	public Thiswindow_2(ClarionString actionMessage,QuickWindow quickWindow,Toolbarclass toolbar,Toolbarupdateclass toolbarForm,Fieldcolorqueue fieldColorQueue,Thiswindow_2 thisWindow)
	{
		this.actionMessage=actionMessage;
		this.quickWindow=quickWindow;
		this.toolbar=toolbar;
		this.toolbarForm=toolbarForm;
		this.fieldColorQueue=fieldColorQueue;
		this.thisWindow=thisWindow;
	}
	public Thiswindow_2() {}
	public void __Init__(ClarionString actionMessage,QuickWindow quickWindow,Toolbarclass toolbar,Toolbarupdateclass toolbarForm,Fieldcolorqueue fieldColorQueue,Thiswindow_2 thisWindow)
	{
		this.actionMessage=actionMessage;
		this.quickWindow=quickWindow;
		this.toolbar=toolbar;
		this.toolbarForm=toolbarForm;
		this.fieldColorQueue=fieldColorQueue;
		this.thisWindow=thisWindow;
	}

	public void ask()
	{
		{
			ClarionNumber case_1=this.request;
			boolean case_1_break=false;
			if (case_1.equals(Constants.VIEWRECORD)) {
				actionMessage.setValue("View Record");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.INSERTRECORD)) {
				actionMessage.setValue("Adding a Credit Card Account Record");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.CHANGERECORD)) {
				actionMessage.setValue("Changing a Credit Card Account Record");
				case_1_break=true;
			}
		}
		quickWindow.setClonedProperty(Prop.TEXT,actionMessage);
		super.ask();
	}
	public ClarionNumber init()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalErrors.setProcedureName(Clarion.newString("UpdateAccounts"));
		this.request.setValue(Main.globalRequest);
		returnValue.setValue(super.init());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		this.firstField.setValue(quickWindow._aCCCreditCardVendorPrompt);
		this.vCRRequest=Main.vCRRequest;
		this.errors=Main.globalErrors;
		this.addItem(toolbar);
		Main.globalRequest.clear();
		Main.globalResponse.clear();
		this.addUpdateFile(Main.accessAccounts);
		this.addItem(Clarion.newNumber(quickWindow._cancel),Clarion.newNumber(Constants.REQUESTCANCELLED));
		Main.relateAccounts.open();
		Main.accessTransactions.useFile();
		this.filesOpened.setValue(Constants.TRUE);
		this.primary=Main.relateAccounts;
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
		Main.iNIMgr.fetch(Clarion.newString("UpdateAccounts"),quickWindow);
		if (this.request.equals(Constants.CHANGERECORD)) {
			Clarion.getControl(quickWindow._aCCAccountBalance).setProperty(Prop.DISABLE,Constants.TRUE);
		}
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
			if (this.request.equals(Constants.INSERTRECORD)) {
				Main.transactions.sysID.setValue(Main.accounts.sysID);
				Main.transactions.dateofTransaction.setValue(CDate.today());
				Main.transactions.transactionDescription.setValue("Initial Account Balance");
				Main.transactions.transactionType.setValue("B");
				Main.transactions.transactionAmount.setValue(Main.accounts.accountBalance);
				Main.transactions.reconciledTransaction.setValue(0);
				Main.accessTransactions.insert();
			}
			Main.relateAccounts.close();
		}
		if (this.opened.boolValue()) {
			Main.iNIMgr.update(Clarion.newString("UpdateAccounts"),quickWindow);
		}
		Main.globalErrors.setProcedureName();
		return returnValue.like();
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
				boolean case_1_break=false;
				if (case_1==quickWindow._aCCBillingDay) {
					if (Main.accessAccounts.tryValidateField(Clarion.newNumber(15)).boolValue()) {
						CWin.select(quickWindow._aCCBillingDay);
						quickWindow.setProperty(Prop.ACCEPTALL,Constants.FALSE);
						continue;
					}
					else {
						fieldColorQueue.feq.setValue(quickWindow._aCCBillingDay);
						fieldColorQueue.get(fieldColorQueue.ORDER().ascend(fieldColorQueue.feq));
						if (!(CError.errorCode()!=0)) {
							Clarion.getControl(quickWindow._aCCBillingDay).setClonedProperty(Prop.FONTCOLOR,fieldColorQueue.oldColor);
							fieldColorQueue.delete();
						}
					}
					case_1_break=true;
				}
				if (!case_1_break && case_1==quickWindow._ok) {
					thisWindow.update();
					if (this.request.equals(Constants.VIEWRECORD)) {
						CWin.post(Event.CLOSEWINDOW);
					}
					case_1_break=true;
				}
			}
			return returnValue.like();
		}
		// UNREACHABLE! :returnValue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnValue.like();
	}
}
