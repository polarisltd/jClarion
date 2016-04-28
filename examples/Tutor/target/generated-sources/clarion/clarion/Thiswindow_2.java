package clarion;

import clarion.Brw2;
import clarion.Customer;
import clarion.Fieldcolorqueue;
import clarion.Main;
import clarion.QueueBrowse_2;
import clarion.QuickWindow_1;
import clarion.Resizer_1;
import clarion.Steplongclass;
import clarion.Toolbarclass;
import clarion.Tutor011;
import clarion.Tutor013;
import clarion.Tutor015;
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
import clarion.equates.Resize;
import clarion.equates.Scrollsort;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.view.ClarionView;

public class Thiswindow_2 extends Windowmanager
{
	ClarionString actionMessage;
	QuickWindow_1 quickWindow;
	Toolbarclass toolbar;
	Customer historyCUSRecord;
	Brw2 brw2;
	QueueBrowse_2 queueBrowse_2;
	ClarionView bRW2ViewBrowse;
	Steplongclass bRW2Sort0StepClass;
	Resizer_1 resizer;
	Thiswindow_2 thisWindow;
	Fieldcolorqueue fieldColorQueue;
	public Thiswindow_2(ClarionString actionMessage,QuickWindow_1 quickWindow,Toolbarclass toolbar,Customer historyCUSRecord,Brw2 brw2,QueueBrowse_2 queueBrowse_2,ClarionView bRW2ViewBrowse,Steplongclass bRW2Sort0StepClass,Resizer_1 resizer,Thiswindow_2 thisWindow,Fieldcolorqueue fieldColorQueue)
	{
		this.actionMessage=actionMessage;
		this.quickWindow=quickWindow;
		this.toolbar=toolbar;
		this.historyCUSRecord=historyCUSRecord;
		this.brw2=brw2;
		this.queueBrowse_2=queueBrowse_2;
		this.bRW2ViewBrowse=bRW2ViewBrowse;
		this.bRW2Sort0StepClass=bRW2Sort0StepClass;
		this.resizer=resizer;
		this.thisWindow=thisWindow;
		this.fieldColorQueue=fieldColorQueue;
	}
	public Thiswindow_2() {}
	public void __Init__(ClarionString actionMessage,QuickWindow_1 quickWindow,Toolbarclass toolbar,Customer historyCUSRecord,Brw2 brw2,QueueBrowse_2 queueBrowse_2,ClarionView bRW2ViewBrowse,Steplongclass bRW2Sort0StepClass,Resizer_1 resizer,Thiswindow_2 thisWindow,Fieldcolorqueue fieldColorQueue)
	{
		this.actionMessage=actionMessage;
		this.quickWindow=quickWindow;
		this.toolbar=toolbar;
		this.historyCUSRecord=historyCUSRecord;
		this.brw2=brw2;
		this.queueBrowse_2=queueBrowse_2;
		this.bRW2ViewBrowse=bRW2ViewBrowse;
		this.bRW2Sort0StepClass=bRW2Sort0StepClass;
		this.resizer=resizer;
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
				actionMessage.setValue("Adding a CUSTOMER Record");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.CHANGERECORD)) {
				actionMessage.setValue("Changing a CUSTOMER Record");
				case_1_break=true;
			}
		}
		quickWindow.setClonedProperty(Prop.TEXT,actionMessage);
		super.ask();
	}
	public ClarionNumber init()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalErrors.setProcedureName(Clarion.newString("UpdateCUSTOMER"));
		this.request.setValue(Main.globalRequest);
		returnValue.setValue(super.init());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		this.firstField.setValue(quickWindow._cUSCUSTNUMBERPrompt);
		this.vCRRequest=Main.vCRRequest;
		this.errors=Main.globalErrors;
		Main.globalRequest.clear();
		Main.globalResponse.clear();
		this.addItem(toolbar);
		this.historyKey.setValue(Constants.CTRLH);
		this.addHistoryFile(Main.customer,historyCUSRecord);
		this.addHistoryField(Clarion.newNumber(quickWindow._cusCustnumber),Clarion.newNumber(1));
		this.addHistoryField(Clarion.newNumber(quickWindow._cusCompany),Clarion.newNumber(2));
		this.addHistoryField(Clarion.newNumber(quickWindow._cusFirstname),Clarion.newNumber(3));
		this.addHistoryField(Clarion.newNumber(quickWindow._cusLastname),Clarion.newNumber(4));
		this.addHistoryField(Clarion.newNumber(quickWindow._cusAddress),Clarion.newNumber(5));
		this.addHistoryField(Clarion.newNumber(quickWindow._cusCity),Clarion.newNumber(6));
		this.addHistoryField(Clarion.newNumber(quickWindow._cusState),Clarion.newNumber(7));
		this.addHistoryField(Clarion.newNumber(quickWindow._cusZipcode),Clarion.newNumber(8));
		this.addUpdateFile(Main.accessCUSTOMER.get());
		this.addItem(Clarion.newNumber(quickWindow._cancel),Clarion.newNumber(Constants.REQUESTCANCELLED));
		Main.relateCUSTOMER.get().open();
		Main.relateStates.get().open();
		this.filesOpened.setValue(Constants.TRUE);
		this.primary=Main.relateCUSTOMER.get();
		if (this.request.equals(Constants.VIEWRECORD) && !this.batchProcessing.boolValue()) {
			this.insertAction.setValue(Insert.NONE);
			this.deleteAction.setValue(Delete.NONE);
			this.changeAction.setValue(Change.NONE);
			this.cancelAction.setValue(Cancel.CANCEL);
			this.okControl.setValue(0);
		}
		else {
			this.changeAction.setValue(Change.CALLER);
			this.cancelAction.setValue(Cancel.CANCEL+Cancel.QUERY);
			this.okControl.setValue(quickWindow._ok);
			if (this.primeUpdate().boolValue()) {
				return Clarion.newNumber(Level.NOTIFY);
			}
		}
		brw2.init(Clarion.newNumber(quickWindow._browse_2),queueBrowse_2.viewPosition,bRW2ViewBrowse,queueBrowse_2,Main.relateORDERS.get(),this);
		quickWindow.open();
		this.opened.setValue(Constants.TRUE);
		init_DefineListboxStyle();
		if (this.request.equals(Constants.VIEWRECORD)) {
			Clarion.getControl(quickWindow._cusCompany).setProperty(Prop.READONLY,Constants.TRUE);
			Clarion.getControl(quickWindow._cusFirstname).setProperty(Prop.READONLY,Constants.TRUE);
			Clarion.getControl(quickWindow._cusLastname).setProperty(Prop.READONLY,Constants.TRUE);
			Clarion.getControl(quickWindow._cusAddress).setProperty(Prop.READONLY,Constants.TRUE);
			Clarion.getControl(quickWindow._cusCity).setProperty(Prop.READONLY,Constants.TRUE);
			Clarion.getControl(quickWindow._cusState).setProperty(Prop.READONLY,Constants.TRUE);
			Clarion.getControl(quickWindow._cusZipcode).setProperty(Prop.READONLY,Constants.TRUE);
			CWin.disable(quickWindow._insert_3);
			CWin.disable(quickWindow._change_3);
			CWin.disable(quickWindow._delete_3);
		}
		brw2.q=queueBrowse_2;
		bRW2Sort0StepClass.init(Clarion.newNumber(Scrollsort.ALLOWALPHA));
		brw2.addSortOrder(bRW2Sort0StepClass,Main.orders.keycustnumber);
		brw2.addRange(Main.orders.custnumber,Main.relateORDERS.get(),Main.relateCUSTOMER.get());
		brw2.addField(Main.orders.custnumber,brw2.q.ordCustnumber);
		brw2.addField(Main.orders.ordernumber,brw2.q.ordOrdernumber);
		brw2.addField(Main.orders.invoiceamount,brw2.q.ordInvoiceamount);
		brw2.addField(Main.orders.orderdate,brw2.q.ordOrderdate);
		brw2.addField(Main.orders.ordernote,brw2.q.ordOrdernote);
		resizer.init(Clarion.newNumber(Appstrategy.SURFACE),Clarion.newNumber(Resize.SETMINSIZE));
		this.addItem(resizer);
		Main.iNIMgr.fetch(Clarion.newString("UpdateCUSTOMER"),quickWindow);
		resizer.resize();
		resizer.reset();
		brw2.askProcedure.setValue(2);
		this.setAlerts();
		return returnValue.like();
	}
	public void init_DefineListboxStyle()
	{
		Tutor011.updateCUSTOMER_DefineListboxStyle();
	}
	public ClarionNumber kill()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(super.kill());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		if (this.filesOpened.boolValue()) {
			Main.relateCUSTOMER.get().close();
			Main.relateStates.get().close();
		}
		if (this.opened.boolValue()) {
			Main.iNIMgr.update(Clarion.newString("UpdateCUSTOMER"),quickWindow);
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
			{
				int execute_1=number.intValue();
				if (execute_1==1) {
					Tutor015.selectStates();
				}
				if (execute_1==2) {
					Tutor013.updateORDERS();
				}
			}
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
				if (case_1==quickWindow._cusState) {
					Main.states.state.setValue(Main.customer.state);
					if (Main.accessStates.get().tryFetch(Main.states.keyState).boolValue()) {
						if (this.run(Clarion.newNumber(1),Clarion.newNumber(Constants.SELECTRECORD)).equals(Constants.REQUESTCOMPLETED)) {
							Main.customer.state.setValue(Main.states.state);
						}
						else {
							CWin.select(quickWindow._cusState);
							continue;
						}
					}
					thisWindow.reset(Clarion.newNumber(0));
					if (Main.accessCUSTOMER.get().tryValidateField(Clarion.newNumber(7)).boolValue()) {
						CWin.select(quickWindow._cusState);
						quickWindow.setProperty(Prop.ACCEPTALL,Constants.FALSE);
						continue;
					}
					else {
						fieldColorQueue.feq.setValue(quickWindow._cusState);
						fieldColorQueue.get(fieldColorQueue.ORDER().ascend(fieldColorQueue.feq));
						if (!(CError.errorCode()!=0)) {
							Clarion.getControl(quickWindow._cusState).setClonedProperty(Prop.FONTCOLOR,fieldColorQueue.oldColor);
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
