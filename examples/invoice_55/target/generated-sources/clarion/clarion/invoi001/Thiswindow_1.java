package clarion.invoi001;

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
import clarion.equates.Prop;
import clarion.invoi001.Fieldcolorqueue;
import clarion.invoi001.Invoi001;
import clarion.invoi001.Quickwindow_1;
import clarion.invoi001.Resizer_1;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Thiswindow_1 extends Windowmanager
{
	ClarionString actionmessage;
	Quickwindow_1 quickwindow;
	Toolbarclass toolbar;
	Resizer_1 resizer;
	Toolbarupdateclass toolbarform;
	Thiswindow_1 thiswindow;
	Fieldcolorqueue fieldcolorqueue;
	public Thiswindow_1(ClarionString actionmessage,Quickwindow_1 quickwindow,Toolbarclass toolbar,Resizer_1 resizer,Toolbarupdateclass toolbarform,Thiswindow_1 thiswindow,Fieldcolorqueue fieldcolorqueue)
	{
		this.actionmessage=actionmessage;
		this.quickwindow=quickwindow;
		this.toolbar=toolbar;
		this.resizer=resizer;
		this.toolbarform=toolbarform;
		this.thiswindow=thiswindow;
		this.fieldcolorqueue=fieldcolorqueue;
	}
	public Thiswindow_1() {}
	public void __Init__(ClarionString actionmessage,Quickwindow_1 quickwindow,Toolbarclass toolbar,Resizer_1 resizer,Toolbarupdateclass toolbarform,Thiswindow_1 thiswindow,Fieldcolorqueue fieldcolorqueue)
	{
		this.actionmessage=actionmessage;
		this.quickwindow=quickwindow;
		this.toolbar=toolbar;
		this.resizer=resizer;
		this.toolbarform=toolbarform;
		this.thiswindow=thiswindow;
		this.fieldcolorqueue=fieldcolorqueue;
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
				actionmessage.setValue("Adding a Customers Record");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.CHANGERECORD)) {
				actionmessage.setValue("Changing a Customers Record");
				case_1_break=true;
			}
		}
		quickwindow.setClonedProperty(Prop.TEXT,actionmessage);
		super.ask();
	}
	public ClarionNumber init()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalerrors.setprocedurename(Clarion.newString("UpdateCustomers"));
		this.request.setValue(Main.globalrequest);
		returnvalue.setValue(super.init());
		if (returnvalue.boolValue()) {
			return returnvalue.like();
		}
		this.firstfield.setValue(quickwindow._cusCompanyPrompt);
		this.vcrrequest=Main.vcrrequest;
		this.errors=Main.globalerrors;
		this.additem(toolbar);
		Main.globalrequest.clear();
		Main.globalresponse.clear();
		this.historykey.setValue(734);
		this.addhistoryfile(Main.customers,Invoi001.updatecustomers_historyCusRecord);
		this.addhistoryfield(Clarion.newNumber(quickwindow._cusCompany),Clarion.newNumber(2));
		this.addhistoryfield(Clarion.newNumber(quickwindow._cusFirstname),Clarion.newNumber(3));
		this.addhistoryfield(Clarion.newNumber(quickwindow._cusMi),Clarion.newNumber(4));
		this.addhistoryfield(Clarion.newNumber(quickwindow._cusLastname),Clarion.newNumber(5));
		this.addhistoryfield(Clarion.newNumber(quickwindow._cusAddress1),Clarion.newNumber(6));
		this.addhistoryfield(Clarion.newNumber(quickwindow._cusAddress2),Clarion.newNumber(7));
		this.addhistoryfield(Clarion.newNumber(quickwindow._cusCity),Clarion.newNumber(8));
		this.addhistoryfield(Clarion.newNumber(quickwindow._cusState),Clarion.newNumber(9));
		this.addhistoryfield(Clarion.newNumber(quickwindow._cusZipcode),Clarion.newNumber(10));
		this.addhistoryfield(Clarion.newNumber(quickwindow._cusPhonenumber),Clarion.newNumber(11));
		this.addhistoryfield(Clarion.newNumber(quickwindow._cusExtension),Clarion.newNumber(12));
		this.addhistoryfield(Clarion.newNumber(quickwindow._cusPhonetype),Clarion.newNumber(13));
		this.addupdatefile(Main.accessCustomers);
		this.additem(Clarion.newNumber(quickwindow._cancel),Clarion.newNumber(Constants.REQUESTCANCELLED));
		Main.relateCustomers.open();
		Main.relateStates.open();
		this.filesopened.setValue(Constants.TRUE);
		this.primary=Main.relateCustomers;
		if (this.request.equals(Constants.VIEWRECORD)) {
			this.insertaction.setValue(Insert.NONE);
			this.deleteaction.setValue(Delete.NONE);
			this.changeaction.setValue(0);
			this.cancelaction.setValue(Cancel.CANCEL);
			this.okcontrol.setValue(0);
		}
		else {
			this.insertaction.setValue(Insert.QUERY);
			this.okcontrol.setValue(quickwindow._ok);
			if (this.primeupdate().boolValue()) {
				return Clarion.newNumber(Level.NOTIFY);
			}
		}
		quickwindow.open();
		this.opened.setValue(Constants.TRUE);
		quickwindow.setProperty(Prop.MINWIDTH,214);
		quickwindow.setProperty(Prop.MINHEIGHT,188);
		resizer.init(Clarion.newNumber(Appstrategy.SPREAD));
		this.additem(resizer);
		Main.inimgr.fetch(Clarion.newString("UpdateCustomers"),quickwindow);
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
			Main.relateCustomers.close();
			Main.relateStates.close();
		}
		if (this.opened.boolValue()) {
			Main.inimgr.update(Clarion.newString("UpdateCustomers"),quickwindow);
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
	public ClarionNumber run(ClarionNumber number,ClarionNumber request)
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnvalue.setValue(super.run(number.like(),request.like()));
		if (this.request.equals(Constants.VIEWRECORD)) {
			returnvalue.setValue(Constants.REQUESTCANCELLED);
		}
		else {
			Main.globalrequest.setValue(request);
			Invoi001.selectstates();
			returnvalue.setValue(Main.globalresponse);
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
				boolean case_1_break=false;
				if (case_1==quickwindow._cusState) {
					Main.states.statecode.setValue(Main.customers.state);
					if (Main.accessStates.tryfetch(Main.states.statecodekey).boolValue()) {
						if (this.run(Clarion.newNumber(1),Clarion.newNumber(Constants.SELECTRECORD)).equals(Constants.REQUESTCOMPLETED)) {
							Main.customers.state.setValue(Main.states.statecode);
						}
						else {
							CWin.select(quickwindow._cusState);
							continue;
						}
					}
					thiswindow.reset(Clarion.newNumber(0));
					if (Main.accessCustomers.tryvalidatefield(Clarion.newNumber(9)).boolValue()) {
						CWin.select(quickwindow._cusState);
						quickwindow.setProperty(Prop.ACCEPTALL,Constants.FALSE);
						continue;
					}
					else {
						fieldcolorqueue.feq.setValue(quickwindow._cusState);
						fieldcolorqueue.get(fieldcolorqueue.ORDER().ascend(fieldcolorqueue.feq));
						if (!(CError.errorCode()!=0)) {
							Clarion.getControl(quickwindow._cusState).setClonedProperty(Prop.FONTCOLOR,fieldcolorqueue.oldcolor);
							fieldcolorqueue.delete();
						}
					}
					case_1_break=true;
				}
				if (!case_1_break && case_1==quickwindow._ok) {
					thiswindow.update();
					if (this.request.equals(Constants.VIEWRECORD)) {
						CWin.post(Event.CLOSEWINDOW);
					}
					case_1_break=true;
				}
			}
			return returnvalue.like();
		}
		// UNREACHABLE! :returnvalue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnvalue.like();
	}
}
