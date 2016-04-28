package clarion;

import clarion.Fieldcolorqueue_2;
import clarion.Invoi001;
import clarion.Main;
import clarion.Orders;
import clarion.QuickWindow_4;
import clarion.Resizer_5;
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

public class Thiswindow_5 extends Windowmanager
{
	ClarionString actionMessage;
	QuickWindow_4 quickWindow;
	Toolbarclass toolbar;
	Orders historyORDRecord;
	Resizer_5 resizer;
	Toolbarupdateclass toolbarForm;
	Thiswindow_5 thisWindow;
	Fieldcolorqueue_2 fieldColorQueue;
	public Thiswindow_5(ClarionString actionMessage,QuickWindow_4 quickWindow,Toolbarclass toolbar,Orders historyORDRecord,Resizer_5 resizer,Toolbarupdateclass toolbarForm,Thiswindow_5 thisWindow,Fieldcolorqueue_2 fieldColorQueue)
	{
		this.actionMessage=actionMessage;
		this.quickWindow=quickWindow;
		this.toolbar=toolbar;
		this.historyORDRecord=historyORDRecord;
		this.resizer=resizer;
		this.toolbarForm=toolbarForm;
		this.thisWindow=thisWindow;
		this.fieldColorQueue=fieldColorQueue;
	}
	public Thiswindow_5() {}
	public void __Init__(ClarionString actionMessage,QuickWindow_4 quickWindow,Toolbarclass toolbar,Orders historyORDRecord,Resizer_5 resizer,Toolbarupdateclass toolbarForm,Thiswindow_5 thisWindow,Fieldcolorqueue_2 fieldColorQueue)
	{
		this.actionMessage=actionMessage;
		this.quickWindow=quickWindow;
		this.toolbar=toolbar;
		this.historyORDRecord=historyORDRecord;
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
				actionMessage.setValue("Adding a Orders Record");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.CHANGERECORD)) {
				actionMessage.setValue("Changing a Orders Record");
				case_1_break=true;
			}
		}
		quickWindow.setClonedProperty(Prop.TEXT,actionMessage);
		super.ask();
	}
	public ClarionNumber init()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalErrors.setProcedureName(Clarion.newString("UpdateOrders"));
		this.request.setValue(Main.globalRequest);
		returnValue.setValue(super.init());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		this.firstField.setValue(quickWindow._oRDOrderDatePrompt);
		this.vCRRequest=Main.vCRRequest;
		this.errors=Main.globalErrors;
		Main.globalRequest.clear();
		Main.globalResponse.clear();
		this.addItem(toolbar);
		this.historyKey.setValue(734);
		this.addHistoryFile(Main.orders,historyORDRecord);
		this.addHistoryField(Clarion.newNumber(quickWindow._oRDOrderDate),Clarion.newNumber(4));
		this.addHistoryField(Clarion.newNumber(quickWindow._oRDInvoiceNumber),Clarion.newNumber(3));
		this.addHistoryField(Clarion.newNumber(quickWindow._oRDSameName),Clarion.newNumber(5));
		this.addHistoryField(Clarion.newNumber(quickWindow._oRDShipToName),Clarion.newNumber(6));
		this.addHistoryField(Clarion.newNumber(quickWindow._oRDSameAdd),Clarion.newNumber(7));
		this.addHistoryField(Clarion.newNumber(quickWindow._oRDShipAddress1),Clarion.newNumber(8));
		this.addHistoryField(Clarion.newNumber(quickWindow._oRDShipAddress2),Clarion.newNumber(9));
		this.addHistoryField(Clarion.newNumber(quickWindow._oRDShipCity),Clarion.newNumber(10));
		this.addHistoryField(Clarion.newNumber(quickWindow._oRDShipState),Clarion.newNumber(11));
		this.addHistoryField(Clarion.newNumber(quickWindow._oRDShipZip),Clarion.newNumber(12));
		this.addHistoryField(Clarion.newNumber(quickWindow._oRDOrderShipped),Clarion.newNumber(13));
		this.addHistoryField(Clarion.newNumber(quickWindow._oRDOrderNote),Clarion.newNumber(14));
		this.addUpdateFile(Main.accessOrders.get());
		this.addItem(Clarion.newNumber(quickWindow._cancel),Clarion.newNumber(Constants.REQUESTCANCELLED));
		Main.relateInvHist.get().open();
		Main.relateOrders.get().open();
		Main.relateStates.get().open();
		this.filesOpened.setValue(Constants.TRUE);
		this.primary=Main.relateOrders.get();
		if (this.request.equals(Constants.VIEWRECORD) && !this.batchProcessing.boolValue()) {
			this.insertAction.setValue(Insert.NONE);
			this.deleteAction.setValue(Delete.NONE);
			this.changeAction.setValue(Change.NONE);
			this.cancelAction.setValue(Cancel.CANCEL);
			this.okControl.setValue(0);
		}
		else {
			this.changeAction.setValue(Change.CALLER);
			this.okControl.setValue(quickWindow._ok);
			if (this.primeUpdate().boolValue()) {
				return Clarion.newNumber(Level.NOTIFY);
			}
		}
		quickWindow.open();
		this.opened.setValue(Constants.TRUE);
		init_DefineListboxStyle();
		quickWindow.setProperty(Prop.MINWIDTH,275);
		quickWindow.setProperty(Prop.MINHEIGHT,157);
		resizer.init(Clarion.newNumber(Appstrategy.SPREAD));
		this.addItem(resizer);
		toolbarForm.helpButton.setValue(quickWindow._help);
		this.addItem(toolbarForm);
		this.setAlerts();
		return returnValue.like();
	}
	public void init_DefineListboxStyle()
	{
		Invoi001.updateOrders_DefineListboxStyle();
	}
	public ClarionNumber kill()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(super.kill());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		if (this.filesOpened.boolValue()) {
			Main.relateInvHist.get().close();
			Main.relateOrders.get().close();
			Main.relateStates.get().close();
		}
		Main.globalErrors.setProcedureName();
		return returnValue.like();
	}
	public void primeFields()
	{
		Main.orders.shipToName.setValue(Main.customers.firstName.clip().concat(" ",Main.customers.lastName.clip()));
		Main.orders.shipAddress1.setValue(Main.customers.address1);
		Main.orders.shipAddress2.setValue(Main.customers.address2);
		Main.orders.shipCity.setValue(Main.customers.city);
		Main.orders.shipState.setValue(Main.customers.state);
		Main.orders.shipZip.setValue(Main.customers.zipCode);
		super.primeFields();
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
		Main.customers.custNumber.setValue(Main.orders.custNumber);
		Main.accessCustomers.get().fetch(Main.customers.keyCustNumber);
		Main.states.stateCode.setValue(Main.orders.shipState);
		Main.accessStates.get().fetch(Main.states.stateCodeKey);
		super.reset(force.like());
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
				if (case_1==quickWindow._oRDSameName) {
					if (Main.orders.sameName.equals(Constants.TRUE)) {
						Main.customers.custNumber.setValue(Main.orders.custNumber);
						Main.accessCustomers.get().fetch(Main.customers.keyCustNumber);
						Main.orders.shipToName.setValue(Main.customers.firstName.clip().concat(" ",Main.customers.lastName.clip()));
						CWin.display();
						CWin.disable(quickWindow._oRDShipToName);
						CWin.select(quickWindow._oRDSameAdd);
					}
					else {
						CWin.enable(quickWindow._oRDShipToName);
						CWin.select(quickWindow._oRDShipToName);
					}
					case_1_break=true;
				}
				if (!case_1_break && case_1==quickWindow._oRDSameAdd) {
					if (Main.orders.sameAdd.equals(Constants.TRUE)) {
						CWin.disable(quickWindow._oRDShipAddress1);
						CWin.disable(quickWindow._oRDShipAddress2);
						CWin.disable(quickWindow._oRDShipCity);
						CWin.disable(quickWindow._oRDShipState);
						CWin.disable(quickWindow._oRDShipZip);
						CWin.select(quickWindow._oRDOrderShipped);
					}
					else {
						CWin.enable(quickWindow._oRDShipAddress1);
						CWin.enable(quickWindow._oRDShipAddress2);
						CWin.enable(quickWindow._oRDShipCity);
						CWin.enable(quickWindow._oRDShipState);
						CWin.enable(quickWindow._oRDShipZip);
						CWin.select(quickWindow._oRDShipAddress1);
					}
					case_1_break=true;
				}
				if (!case_1_break && case_1==quickWindow._oRDShipState) {
					Main.states.stateCode.setValue(Main.orders.shipState);
					if (Main.accessStates.get().tryFetch(Main.states.stateCodeKey).boolValue()) {
						if (this.run(Clarion.newNumber(1),Clarion.newNumber(Constants.SELECTRECORD)).equals(Constants.REQUESTCOMPLETED)) {
							Main.orders.shipState.setValue(Main.states.stateCode);
						}
						else {
							CWin.select(quickWindow._oRDShipState);
							continue;
						}
					}
					thisWindow.reset(Clarion.newNumber(0));
					if (Main.accessOrders.get().tryValidateField(Clarion.newNumber(11)).boolValue()) {
						CWin.select(quickWindow._oRDShipState);
						quickWindow.setProperty(Prop.ACCEPTALL,Constants.FALSE);
						continue;
					}
					else {
						fieldColorQueue.feq.setValue(quickWindow._oRDShipState);
						fieldColorQueue.get(fieldColorQueue.ORDER().ascend(fieldColorQueue.feq));
						if (!(CError.errorCode()!=0)) {
							Clarion.getControl(quickWindow._oRDShipState).setClonedProperty(Prop.FONTCOLOR,fieldColorQueue.oldColor);
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
	public ClarionNumber takeSelected()
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
			returnValue.setValue(super.takeSelected());
			{
				int case_1=CWin.field();
				boolean case_1_break=false;
				if (case_1==quickWindow._oRDSameName) {
					if (this.request.equals(Constants.CHANGERECORD)) {
						if (Main.orders.sameName.equals(Constants.FALSE)) {
							CWin.disable(quickWindow._oRDSameName);
							CWin.select(quickWindow._oRDShipToName);
						}
						else {
							CWin.enable(quickWindow._oRDSameName);
							CWin.select(quickWindow._oRDSameName);
						}
					}
					case_1_break=true;
				}
				if (!case_1_break && case_1==quickWindow._oRDSameAdd) {
					if (this.request.equals(Constants.CHANGERECORD)) {
						if (Main.orders.sameAdd.equals(Constants.FALSE)) {
							CWin.disable(quickWindow._oRDSameAdd);
							CWin.select(quickWindow._oRDShipAddress1);
						}
						else {
							CWin.enable(quickWindow._oRDSameAdd);
							CWin.select(quickWindow._oRDSameAdd);
						}
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
