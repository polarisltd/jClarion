package clarion;

import clarion.Company;
import clarion.Invoi003;
import clarion.Main;
import clarion.QuickWindow_6;
import clarion.Resizer_7;
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
import clarion.equates.Msg;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CWin;

public class Thiswindow_12 extends Windowmanager
{
	ClarionString actionMessage;
	QuickWindow_6 quickWindow;
	Toolbarclass toolbar;
	Company historyCOMRecord;
	Resizer_7 resizer;
	Toolbarupdateclass toolbarForm;
	Thiswindow_12 thisWindow;
	public Thiswindow_12(ClarionString actionMessage,QuickWindow_6 quickWindow,Toolbarclass toolbar,Company historyCOMRecord,Resizer_7 resizer,Toolbarupdateclass toolbarForm,Thiswindow_12 thisWindow)
	{
		this.actionMessage=actionMessage;
		this.quickWindow=quickWindow;
		this.toolbar=toolbar;
		this.historyCOMRecord=historyCOMRecord;
		this.resizer=resizer;
		this.toolbarForm=toolbarForm;
		this.thisWindow=thisWindow;
	}
	public Thiswindow_12() {}
	public void __Init__(ClarionString actionMessage,QuickWindow_6 quickWindow,Toolbarclass toolbar,Company historyCOMRecord,Resizer_7 resizer,Toolbarupdateclass toolbarForm,Thiswindow_12 thisWindow)
	{
		this.actionMessage=actionMessage;
		this.quickWindow=quickWindow;
		this.toolbar=toolbar;
		this.historyCOMRecord=historyCOMRecord;
		this.resizer=resizer;
		this.toolbarForm=toolbarForm;
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
				actionMessage.setValue("Enter  your Company''s Information");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.CHANGERECORD)) {
				actionMessage.setValue("Change your Company''s Information");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.DELETERECORD)) {
				Main.globalErrors._throw(Clarion.newNumber(Msg.DELETEILLEGAL));
				return;
				// UNREACHABLE! :case_1_break=true;
			}
		}
		quickWindow.setClonedProperty(Prop.TEXT,actionMessage);
		super.ask();
	}
	public ClarionNumber init()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalErrors.setProcedureName(Clarion.newString("UpdateCompany"));
		this.request.setValue(Main.globalRequest);
		returnValue.setValue(super.init());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		this.firstField.setValue(quickWindow._cOMNamePrompt);
		this.vCRRequest=Main.vCRRequest;
		this.errors=Main.globalErrors;
		Main.globalRequest.clear();
		Main.globalResponse.clear();
		this.addItem(toolbar);
		this.historyKey.setValue(734);
		this.addHistoryFile(Main.company,historyCOMRecord);
		this.addHistoryField(Clarion.newNumber(quickWindow._cOMName),Clarion.newNumber(1));
		this.addHistoryField(Clarion.newNumber(quickWindow._cOMAddress),Clarion.newNumber(2));
		this.addHistoryField(Clarion.newNumber(quickWindow._cOMCity),Clarion.newNumber(3));
		this.addHistoryField(Clarion.newNumber(quickWindow._cOMState),Clarion.newNumber(4));
		this.addHistoryField(Clarion.newNumber(quickWindow._cOMZipcode),Clarion.newNumber(5));
		this.addHistoryField(Clarion.newNumber(quickWindow._cOMPhone),Clarion.newNumber(6));
		this.addUpdateFile(Main.accessCompany.get());
		this.addItem(Clarion.newNumber(quickWindow._cancel),Clarion.newNumber(Constants.REQUESTCANCELLED));
		Main.relateCompany.get().open();
		this.filesOpened.setValue(Constants.TRUE);
		this.primary=Main.relateCompany.get();
		if (this.request.equals(Constants.VIEWRECORD) && !this.batchProcessing.boolValue()) {
			this.insertAction.setValue(Insert.NONE);
			this.deleteAction.setValue(Delete.NONE);
			this.changeAction.setValue(Change.NONE);
			this.cancelAction.setValue(Cancel.CANCEL);
			this.okControl.setValue(0);
		}
		else {
			this.deleteAction.setValue(Delete.NONE);
			this.changeAction.setValue(Change.CALLER);
			this.okControl.setValue(quickWindow._ok);
			if (this.primeUpdate().boolValue()) {
				return Clarion.newNumber(Level.NOTIFY);
			}
		}
		quickWindow.open();
		this.opened.setValue(Constants.TRUE);
		init_DefineListboxStyle();
		quickWindow.setProperty(Prop.MINWIDTH,199);
		quickWindow.setProperty(Prop.MINHEIGHT,111);
		resizer.init(Clarion.newNumber(Appstrategy.SPREAD));
		this.addItem(resizer);
		toolbarForm.helpButton.setValue(quickWindow._help);
		this.addItem(toolbarForm);
		this.setAlerts();
		return returnValue.like();
	}
	public void init_DefineListboxStyle()
	{
		Invoi003.updateCompany_DefineListboxStyle();
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
				if (case_1==quickWindow._ok) {
					thisWindow.update();
					if (this.request.equals(Constants.VIEWRECORD) && !this.batchProcessing.boolValue()) {
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
