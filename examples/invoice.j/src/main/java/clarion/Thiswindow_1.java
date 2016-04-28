package clarion;

import clarion.Customers;
import clarion.Fieldcolorqueue;
import clarion.Invoi001;
import clarion.Main;
import clarion.QuickWindow_1;
import clarion.Resizer_1;
import clarion.Toolbarclass;
import clarion.Toolbarupdateclass;
import clarion.Windowmanager;
import clarion.equates.Appstrategy;
import clarion.equates.Cancel;
import clarion.equates.Change;
import clarion.equates.Constants;
import clarion.equates.Delete;
import clarion.equates.Event;
import clarion.equates.Insert;
import clarion.equates.Level;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CWin;

public class Thiswindow_1 extends Windowmanager
{
	ClarionString actionMessage;
	QuickWindow_1 quickWindow;
	Toolbarclass toolbar;
	Customers historyCUSRecord;
	Resizer_1 resizer;
	Toolbarupdateclass toolbarForm;
	Thiswindow_1 thisWindow;
	Fieldcolorqueue fieldColorQueue;
	public Thiswindow_1(ClarionString actionMessage,QuickWindow_1 quickWindow,Toolbarclass toolbar,Customers historyCUSRecord,Resizer_1 resizer,Toolbarupdateclass toolbarForm,Thiswindow_1 thisWindow,Fieldcolorqueue fieldColorQueue)
	{
		this.actionMessage=actionMessage;
		this.quickWindow=quickWindow;
		this.toolbar=toolbar;
		this.historyCUSRecord=historyCUSRecord;
		this.resizer=resizer;
		this.toolbarForm=toolbarForm;
		this.thisWindow=thisWindow;
		this.fieldColorQueue=fieldColorQueue;
	}
	public Thiswindow_1() {}
	public void __Init__(ClarionString actionMessage,QuickWindow_1 quickWindow,Toolbarclass toolbar,Customers historyCUSRecord,Resizer_1 resizer,Toolbarupdateclass toolbarForm,Thiswindow_1 thisWindow,Fieldcolorqueue fieldColorQueue)
	{
		this.actionMessage=actionMessage;
		this.quickWindow=quickWindow;
		this.toolbar=toolbar;
		this.historyCUSRecord=historyCUSRecord;
		this.resizer=resizer;
		this.toolbarForm=toolbarForm;
		this.thisWindow=thisWindow;
		this.fieldColorQueue=fieldColorQueue;
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
				actionMessage.setValue("Adding a Customers Record");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.CHANGERECORD)) {
				actionMessage.setValue("Changing a Customers Record");
				case_1_break=true;
			}
		}
		quickWindow.setClonedProperty(Prop.TEXT,actionMessage);
		super.ask();
	}
	public ClarionNumber init()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalErrors.setProcedureName(Clarion.newString("UpdateCustomers"));
		this.request.setValue(Main.globalRequest);
		returnValue.setValue(super.init());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		this.firstField.setValue(quickWindow._cUSCompanyPrompt);
		this.vCRRequest=Main.vCRRequest;
		this.errors=Main.globalErrors;
		Main.globalRequest.clear();
		Main.globalResponse.clear();
		this.addItem(toolbar);
		this.historyKey.setValue(734);
		this.addHistoryFile(Main.customers,historyCUSRecord);
		this.addHistoryField(Clarion.newNumber(quickWindow._cUSCompany),Clarion.newNumber(2));
		this.addHistoryField(Clarion.newNumber(quickWindow._cUSFirstName),Clarion.newNumber(3));
		this.addHistoryField(Clarion.newNumber(quickWindow._cusMi),Clarion.newNumber(4));
		this.addHistoryField(Clarion.newNumber(quickWindow._cUSLastName),Clarion.newNumber(5));
		this.addHistoryField(Clarion.newNumber(quickWindow._cUSAddress1),Clarion.newNumber(6));
		this.addHistoryField(Clarion.newNumber(quickWindow._cUSAddress2),Clarion.newNumber(7));
		this.addHistoryField(Clarion.newNumber(quickWindow._cUSCity),Clarion.newNumber(8));
		this.addHistoryField(Clarion.newNumber(quickWindow._cUSState),Clarion.newNumber(9));
		this.addHistoryField(Clarion.newNumber(quickWindow._cUSZipCode),Clarion.newNumber(10));
		this.addHistoryField(Clarion.newNumber(quickWindow._cUSPhoneNumber),Clarion.newNumber(11));
		this.addHistoryField(Clarion.newNumber(quickWindow._cUSExtension),Clarion.newNumber(12));
		this.addHistoryField(Clarion.newNumber(quickWindow._cUSPhoneType),Clarion.newNumber(13));
		this.addUpdateFile(Main.accessCustomers.get());
		this.addItem(Clarion.newNumber(quickWindow._cancel),Clarion.newNumber(Constants.REQUESTCANCELLED));
		Main.relateCustomers.get().open();
		Main.relateStates.get().open();
		this.filesOpened.setValue(Constants.TRUE);
		this.primary=Main.relateCustomers.get();
		if (this.request.equals(Constants.VIEWRECORD) && !this.batchProcessing.boolValue()) {
			this.insertAction.setValue(Insert.NONE);
			this.deleteAction.setValue(Delete.NONE);
			this.changeAction.setValue(Change.NONE);
			this.cancelAction.setValue(Cancel.CANCEL);
			this.okControl.setValue(0);
		}
		else {
			this.insertAction.setValue(Insert.QUERY);
			this.changeAction.setValue(Change.CALLER);
			this.okControl.setValue(quickWindow._ok);
			if (this.primeUpdate().boolValue()) {
				return Clarion.newNumber(Level.NOTIFY);
			}
		}
		quickWindow.open();
		this.opened.setValue(Constants.TRUE);
		init_DefineListboxStyle();
		quickWindow.setProperty(Prop.MINWIDTH,214);
		quickWindow.setProperty(Prop.MINHEIGHT,188);
		resizer.init(Clarion.newNumber(Appstrategy.SPREAD));
		this.addItem(resizer);
		toolbarForm.helpButton.setValue(quickWindow._help);
		this.addItem(toolbarForm);
		this.setAlerts();
		return returnValue.like();
	}
	public void init_DefineListboxStyle()
	{
		Invoi001.updateCustomers_DefineListboxStyle();
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
			Main.relateStates.get().close();
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
	public ClarionNumber run(ClarionNumber number,ClarionNumber request)
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(super.run(number.like(),request.like()));
		if (this.request.equals(Constants.VIEWRECORD)) {
			returnValue.setValue(Constants.REQUESTCANCELLED);
		}
		else {
			Main.globalRequest.setValue(request);
			Invoi001.selectStates();
			returnValue.setValue(Main.globalResponse);
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
				if (case_1==quickWindow._cUSState) {
					Main.states.stateCode.setValue(Main.customers.state);
					if (Main.accessStates.get().tryFetch(Main.states.stateCodeKey).boolValue()) {
						if (this.run(Clarion.newNumber(1),Clarion.newNumber(Constants.SELECTRECORD)).equals(Constants.REQUESTCOMPLETED)) {
							Main.customers.state.setValue(Main.states.stateCode);
						}
						else {
							CWin.select(quickWindow._cUSState);
							continue;
						}
					}
					thisWindow.reset(Clarion.newNumber(0));
					if (Main.accessCustomers.get().tryValidateField(Clarion.newNumber(9)).boolValue()) {
						CWin.select(quickWindow._cUSState);
						quickWindow.setProperty(Prop.ACCEPTALL,Constants.FALSE);
						continue;
					}
					else {
						fieldColorQueue.feq.setValue(quickWindow._cUSState);
						fieldColorQueue.get(fieldColorQueue.ORDER().ascend(fieldColorQueue.feq));
						if (!(CError.errorCode()!=0)) {
							Clarion.getControl(quickWindow._cUSState).setClonedProperty(Prop.FONTCOLOR,fieldColorQueue.oldColor);
							fieldColorQueue.delete();
						}
					}
					case_1_break=true;
				}
				if (!case_1_break && case_1==quickWindow._ok) {
					thisWindow.update();
					if (this.request.equals(Constants.VIEWRECORD) && !this.batchProcessing.boolValue()) {
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
