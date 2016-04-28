package clarion.invoi002;

import clarion.Main;
import clarion.abtoolba.Toolbarclass;
import clarion.abtoolba.Toolbarupdateclass;
import clarion.abwindow.Windowmanager;
import clarion.equates.Appstrategy;
import clarion.equates.Cancel;
import clarion.equates.Constants;
import clarion.equates.Delete;
import clarion.equates.Event;
import clarion.equates.Insert;
import clarion.equates.Level;
import clarion.equates.Msg;
import clarion.equates.Prop;
import clarion.invoi002.Invoi002;
import clarion.invoi002.Quickwindow_2;
import clarion.invoi002.Resizer_2;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Thiswindow_7 extends Windowmanager
{
	ClarionString actionmessage;
	Quickwindow_2 quickwindow;
	Toolbarclass toolbar;
	Resizer_2 resizer;
	Toolbarupdateclass toolbarform;
	Thiswindow_7 thiswindow;
	public Thiswindow_7(ClarionString actionmessage,Quickwindow_2 quickwindow,Toolbarclass toolbar,Resizer_2 resizer,Toolbarupdateclass toolbarform,Thiswindow_7 thiswindow)
	{
		this.actionmessage=actionmessage;
		this.quickwindow=quickwindow;
		this.toolbar=toolbar;
		this.resizer=resizer;
		this.toolbarform=toolbarform;
		this.thiswindow=thiswindow;
	}
	public Thiswindow_7() {}
	public void __Init__(ClarionString actionmessage,Quickwindow_2 quickwindow,Toolbarclass toolbar,Resizer_2 resizer,Toolbarupdateclass toolbarform,Thiswindow_7 thiswindow)
	{
		this.actionmessage=actionmessage;
		this.quickwindow=quickwindow;
		this.toolbar=toolbar;
		this.resizer=resizer;
		this.toolbarform=toolbarform;
		this.thiswindow=thiswindow;
	}

	public void ask()
	{
		{
			ClarionNumber case_1=this.request;
			boolean case_1_break=false;
			if (case_1.equals(Constants.VIEWRECORD)) {
				actionmessage.setValue("View Record");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.INSERTRECORD)) {
				actionmessage.setValue("Enter  your Company''s Information");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.CHANGERECORD)) {
				actionmessage.setValue("Change your Company''s Information");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.DELETERECORD)) {
				Main.globalerrors._throw(Clarion.newNumber(Msg.DELETEILLEGAL));
				return;
				// UNREACHABLE! :case_1_break=true;
			}
		}
		quickwindow.setClonedProperty(Prop.TEXT,actionmessage);
		super.ask();
	}
	public ClarionNumber init()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalerrors.setprocedurename(Clarion.newString("UpdateCompany"));
		this.request.setValue(Main.globalrequest);
		returnvalue.setValue(super.init());
		if (returnvalue.boolValue()) {
			return returnvalue.like();
		}
		this.firstfield.setValue(quickwindow._comNamePrompt);
		this.vcrrequest=Main.vcrrequest;
		this.errors=Main.globalerrors;
		this.additem(toolbar);
		Main.globalrequest.clear();
		Main.globalresponse.clear();
		this.historykey.setValue(734);
		this.addhistoryfile(Main.company,Invoi002.updatecompany_historyComRecord);
		this.addhistoryfield(Clarion.newNumber(quickwindow._comName),Clarion.newNumber(1));
		this.addhistoryfield(Clarion.newNumber(quickwindow._comAddress),Clarion.newNumber(2));
		this.addhistoryfield(Clarion.newNumber(quickwindow._comCity),Clarion.newNumber(3));
		this.addhistoryfield(Clarion.newNumber(quickwindow._comState),Clarion.newNumber(4));
		this.addhistoryfield(Clarion.newNumber(quickwindow._comZipcode),Clarion.newNumber(5));
		this.addhistoryfield(Clarion.newNumber(quickwindow._comPhone),Clarion.newNumber(6));
		this.addupdatefile(Main.accessCompany);
		this.additem(Clarion.newNumber(quickwindow._cancel),Clarion.newNumber(Constants.REQUESTCANCELLED));
		Main.relateCompany.open();
		this.filesopened.setValue(Constants.TRUE);
		this.primary=Main.relateCompany;
		if (this.request.equals(Constants.VIEWRECORD)) {
			this.insertaction.setValue(Insert.NONE);
			this.deleteaction.setValue(Delete.NONE);
			this.changeaction.setValue(0);
			this.cancelaction.setValue(Cancel.CANCEL);
			this.okcontrol.setValue(0);
		}
		else {
			this.deleteaction.setValue(Delete.NONE);
			this.okcontrol.setValue(quickwindow._ok);
			if (this.primeupdate().boolValue()) {
				return Clarion.newNumber(Level.NOTIFY);
			}
		}
		quickwindow.open();
		this.opened.setValue(Constants.TRUE);
		quickwindow.setProperty(Prop.MINWIDTH,199);
		quickwindow.setProperty(Prop.MINHEIGHT,111);
		resizer.init(Clarion.newNumber(Appstrategy.SPREAD));
		this.additem(resizer);
		Main.inimgr.fetch(Clarion.newString("UpdateCompany"),quickwindow);
		resizer.resize();
		resizer.reset();
		toolbarform.helpbutton.setValue(quickwindow._help);
		this.additem(toolbarform);
		this.setalerts();
		return returnvalue.like();
	}
	public ClarionNumber kill()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnvalue.setValue(super.kill());
		if (returnvalue.boolValue()) {
			return returnvalue.like();
		}
		if (this.filesopened.boolValue()) {
			Main.relateCompany.close();
		}
		if (this.opened.boolValue()) {
			Main.inimgr.update(Clarion.newString("UpdateCompany"),quickwindow);
		}
		Main.globalerrors.setprocedurename();
		return returnvalue.like();
	}
	public ClarionNumber run()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnvalue.setValue(super.run());
		if (this.request.equals(Constants.VIEWRECORD)) {
			returnvalue.setValue(Constants.REQUESTCANCELLED);
		}
		return returnvalue.like();
	}
	public ClarionNumber takeaccepted()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber looped=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		while (true) {
			if (looped.boolValue()) {
				return Clarion.newNumber(Level.NOTIFY);
			}
			else {
				looped.setValue(1);
			}
			returnvalue.setValue(super.takeaccepted());
			{
				int case_1=CWin.accepted();
				if (case_1==quickwindow._ok) {
					thiswindow.update();
					if (this.request.equals(Constants.VIEWRECORD)) {
						CWin.post(Event.CLOSEWINDOW);
					}
				}
			}
			return returnvalue.like();
		}
		// UNREACHABLE! :returnvalue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnvalue.like();
	}
}
