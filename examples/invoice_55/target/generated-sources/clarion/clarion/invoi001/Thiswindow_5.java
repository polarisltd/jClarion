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
import clarion.invoi001.Fieldcolorqueue_2;
import clarion.invoi001.Invoi001;
import clarion.invoi001.Quickwindow_4;
import clarion.invoi001.Resizer_5;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Thiswindow_5 extends Windowmanager
{
	ClarionString actionmessage;
	Quickwindow_4 quickwindow;
	Toolbarclass toolbar;
	Resizer_5 resizer;
	Toolbarupdateclass toolbarform;
	Thiswindow_5 thiswindow;
	Fieldcolorqueue_2 fieldcolorqueue;
	public Thiswindow_5(ClarionString actionmessage,Quickwindow_4 quickwindow,Toolbarclass toolbar,Resizer_5 resizer,Toolbarupdateclass toolbarform,Thiswindow_5 thiswindow,Fieldcolorqueue_2 fieldcolorqueue)
	{
		this.actionmessage=actionmessage;
		this.quickwindow=quickwindow;
		this.toolbar=toolbar;
		this.resizer=resizer;
		this.toolbarform=toolbarform;
		this.thiswindow=thiswindow;
		this.fieldcolorqueue=fieldcolorqueue;
	}
	public Thiswindow_5() {}
	public void __Init__(ClarionString actionmessage,Quickwindow_4 quickwindow,Toolbarclass toolbar,Resizer_5 resizer,Toolbarupdateclass toolbarform,Thiswindow_5 thiswindow,Fieldcolorqueue_2 fieldcolorqueue)
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
				actionmessage.setValue("Adding a Orders Record");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.CHANGERECORD)) {
				actionmessage.setValue("Changing a Orders Record");
				case_1_break=true;
			}
		}
		quickwindow.setClonedProperty(Prop.TEXT,actionmessage);
		super.ask();
	}
	public ClarionNumber init()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalerrors.setprocedurename(Clarion.newString("UpdateOrders"));
		this.request.setValue(Main.globalrequest);
		returnvalue.setValue(super.init());
		if (returnvalue.boolValue()) {
			return returnvalue.like();
		}
		this.firstfield.setValue(quickwindow._ordOrderdatePrompt);
		this.vcrrequest=Main.vcrrequest;
		this.errors=Main.globalerrors;
		this.additem(toolbar);
		Main.globalrequest.clear();
		Main.globalresponse.clear();
		this.historykey.setValue(734);
		this.addhistoryfile(Main.orders,Invoi001.updateorders_historyOrdRecord);
		this.addhistoryfield(Clarion.newNumber(quickwindow._ordOrderdate),Clarion.newNumber(4));
		this.addhistoryfield(Clarion.newNumber(quickwindow._ordInvoicenumber),Clarion.newNumber(3));
		this.addhistoryfield(Clarion.newNumber(quickwindow._ordSamename),Clarion.newNumber(5));
		this.addhistoryfield(Clarion.newNumber(quickwindow._ordShiptoname),Clarion.newNumber(6));
		this.addhistoryfield(Clarion.newNumber(quickwindow._ordSameadd),Clarion.newNumber(7));
		this.addhistoryfield(Clarion.newNumber(quickwindow._ordShipaddress1),Clarion.newNumber(8));
		this.addhistoryfield(Clarion.newNumber(quickwindow._ordShipaddress2),Clarion.newNumber(9));
		this.addhistoryfield(Clarion.newNumber(quickwindow._ordShipcity),Clarion.newNumber(10));
		this.addhistoryfield(Clarion.newNumber(quickwindow._ordShipstate),Clarion.newNumber(11));
		this.addhistoryfield(Clarion.newNumber(quickwindow._ordShipzip),Clarion.newNumber(12));
		this.addhistoryfield(Clarion.newNumber(quickwindow._ordOrdershipped),Clarion.newNumber(13));
		this.addhistoryfield(Clarion.newNumber(quickwindow._ordOrdernote),Clarion.newNumber(14));
		this.addupdatefile(Main.accessOrders);
		this.additem(Clarion.newNumber(quickwindow._cancel),Clarion.newNumber(Constants.REQUESTCANCELLED));
		Main.relateInvhist.open();
		Main.relateOrders.open();
		Main.relateStates.open();
		this.filesopened.setValue(Constants.TRUE);
		this.primary=Main.relateOrders;
		if (this.request.equals(Constants.VIEWRECORD)) {
			this.insertaction.setValue(Insert.NONE);
			this.deleteaction.setValue(Delete.NONE);
			this.changeaction.setValue(0);
			this.cancelaction.setValue(Cancel.CANCEL);
			this.okcontrol.setValue(0);
		}
		else {
			this.okcontrol.setValue(quickwindow._ok);
			if (this.primeupdate().boolValue()) {
				return Clarion.newNumber(Level.NOTIFY);
			}
		}
		quickwindow.open();
		this.opened.setValue(Constants.TRUE);
		quickwindow.setProperty(Prop.MINWIDTH,275);
		quickwindow.setProperty(Prop.MINHEIGHT,157);
		resizer.init(Clarion.newNumber(Appstrategy.SPREAD));
		this.additem(resizer);
		Main.inimgr.fetch(Clarion.newString("UpdateOrders"),quickwindow);
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
			Main.relateInvhist.close();
			Main.relateOrders.close();
			Main.relateStates.close();
		}
		if (this.opened.boolValue()) {
			Main.inimgr.update(Clarion.newString("UpdateOrders"),quickwindow);
		}
		Main.globalerrors.setprocedurename();
		return returnvalue.like();
	}
	public void primefields()
	{
		Main.orders.shiptoname.setValue(Main.customers.firstname.clip().concat(" ",Main.customers.lastname.clip()));
		Main.orders.shipaddress1.setValue(Main.customers.address1);
		Main.orders.shipaddress2.setValue(Main.customers.address2);
		Main.orders.shipcity.setValue(Main.customers.city);
		Main.orders.shipstate.setValue(Main.customers.state);
		Main.orders.shipzip.setValue(Main.customers.zipcode);
		super.primefields();
	}
	public void reset()
	{
		reset(Clarion.newNumber(0));
	}
	public void reset(ClarionNumber force)
	{
		this.forcedreset.increment(force);
		if (quickwindow.getProperty(Prop.ACCEPTALL).boolValue()) {
			return;
		}
		Main.customers.custnumber.setValue(Main.orders.custnumber);
		Main.accessCustomers.fetch(Main.customers.keycustnumber);
		Main.states.statecode.setValue(Main.orders.shipstate);
		Main.accessStates.fetch(Main.states.statecodekey);
		super.reset(force.like());
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
				if (case_1==quickwindow._ordSamename) {
					if (Main.orders.samename.equals(Constants.TRUE)) {
						Main.customers.custnumber.setValue(Main.orders.custnumber);
						Main.accessCustomers.fetch(Main.customers.keycustnumber);
						Main.orders.shiptoname.setValue(Main.customers.firstname.clip().concat(" ",Main.customers.lastname.clip()));
						CWin.display();
						CWin.disable(quickwindow._ordShiptoname);
						CWin.select(quickwindow._ordSameadd);
					}
					else {
						CWin.enable(quickwindow._ordShiptoname);
						CWin.select(quickwindow._ordShiptoname);
					}
					case_1_break=true;
				}
				if (!case_1_break && case_1==quickwindow._ordSameadd) {
					if (Main.orders.sameadd.equals(Constants.TRUE)) {
						CWin.disable(quickwindow._ordShipaddress1);
						CWin.disable(quickwindow._ordShipaddress2);
						CWin.disable(quickwindow._ordShipcity);
						CWin.disable(quickwindow._ordShipstate);
						CWin.disable(quickwindow._ordShipzip);
						CWin.select(quickwindow._ordOrdershipped);
					}
					else {
						CWin.enable(quickwindow._ordShipaddress1);
						CWin.enable(quickwindow._ordShipaddress2);
						CWin.enable(quickwindow._ordShipcity);
						CWin.enable(quickwindow._ordShipstate);
						CWin.enable(quickwindow._ordShipzip);
						CWin.select(quickwindow._ordShipaddress1);
					}
					case_1_break=true;
				}
				if (!case_1_break && case_1==quickwindow._ordShipstate) {
					Main.states.statecode.setValue(Main.orders.shipstate);
					if (Main.accessStates.tryfetch(Main.states.statecodekey).boolValue()) {
						if (this.run(Clarion.newNumber(1),Clarion.newNumber(Constants.SELECTRECORD)).equals(Constants.REQUESTCOMPLETED)) {
							Main.orders.shipstate.setValue(Main.states.statecode);
						}
						else {
							CWin.select(quickwindow._ordShipstate);
							continue;
						}
					}
					thiswindow.reset(Clarion.newNumber(0));
					if (Main.accessOrders.tryvalidatefield(Clarion.newNumber(11)).boolValue()) {
						CWin.select(quickwindow._ordShipstate);
						quickwindow.setProperty(Prop.ACCEPTALL,Constants.FALSE);
						continue;
					}
					else {
						fieldcolorqueue.feq.setValue(quickwindow._ordShipstate);
						fieldcolorqueue.get(fieldcolorqueue.ORDER().ascend(fieldcolorqueue.feq));
						if (!(CError.errorCode()!=0)) {
							Clarion.getControl(quickwindow._ordShipstate).setClonedProperty(Prop.FONTCOLOR,fieldcolorqueue.oldcolor);
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
	public ClarionNumber takeselected()
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
			returnvalue.setValue(super.takeselected());
			{
				int case_1=CWin.field();
				boolean case_1_break=false;
				if (case_1==quickwindow._ordSamename) {
					if (this.request.equals(Constants.CHANGERECORD)) {
						if (Main.orders.samename.equals(Constants.FALSE)) {
							CWin.disable(quickwindow._ordSamename);
							CWin.select(quickwindow._ordShiptoname);
						}
						else {
							CWin.enable(quickwindow._ordSamename);
							CWin.select(quickwindow._ordSamename);
						}
					}
					case_1_break=true;
				}
				if (!case_1_break && case_1==quickwindow._ordSameadd) {
					if (this.request.equals(Constants.CHANGERECORD)) {
						if (Main.orders.sameadd.equals(Constants.FALSE)) {
							CWin.disable(quickwindow._ordSameadd);
							CWin.select(quickwindow._ordShipaddress1);
						}
						else {
							CWin.enable(quickwindow._ordSameadd);
							CWin.select(quickwindow._ordSameadd);
						}
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
