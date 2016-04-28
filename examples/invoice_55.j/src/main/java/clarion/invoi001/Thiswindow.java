package clarion.invoi001;

import clarion.Main;
import clarion.abbrowse.Incrementallocatorclass;
import clarion.abbrowse.Stepstringclass;
import clarion.abtoolba.Toolbarclass;
import clarion.abwindow.Windowmanager;
import clarion.equates.Appstrategy;
import clarion.equates.Constants;
import clarion.equates.Prop;
import clarion.equates.Scrollby;
import clarion.equates.Scrollsort;
import clarion.invoi001.Brw1;
import clarion.invoi001.QueueBrowse_1;
import clarion.invoi001.Quickwindow;
import clarion.invoi001.Resizer;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Thiswindow extends Windowmanager
{
	Quickwindow quickwindow;
	Toolbarclass toolbar;
	Brw1 brw1;
	QueueBrowse_1 queueBrowse_1;
	ClarionView brw1ViewBrowse;
	Stepstringclass brw1Sort0Stepclass;
	Incrementallocatorclass brw1Sort0Locator;
	Resizer resizer;
	public Thiswindow(Quickwindow quickwindow,Toolbarclass toolbar,Brw1 brw1,QueueBrowse_1 queueBrowse_1,ClarionView brw1ViewBrowse,Stepstringclass brw1Sort0Stepclass,Incrementallocatorclass brw1Sort0Locator,Resizer resizer)
	{
		this.quickwindow=quickwindow;
		this.toolbar=toolbar;
		this.brw1=brw1;
		this.queueBrowse_1=queueBrowse_1;
		this.brw1ViewBrowse=brw1ViewBrowse;
		this.brw1Sort0Stepclass=brw1Sort0Stepclass;
		this.brw1Sort0Locator=brw1Sort0Locator;
		this.resizer=resizer;
	}

	public ClarionNumber init()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalerrors.setprocedurename(Clarion.newString("SelectStates"));
		this.request.setValue(Main.globalrequest);
		returnvalue.setValue(super.init());
		if (returnvalue.boolValue()) {
			return returnvalue.like();
		}
		this.firstfield.setValue(quickwindow._staStatecode);
		this.vcrrequest=Main.vcrrequest;
		this.errors=Main.globalerrors;
		this.additem(toolbar);
		Main.globalrequest.clear();
		Main.globalresponse.clear();
		this.additem(Clarion.newNumber(quickwindow._close),Clarion.newNumber(Constants.REQUESTCANCELLED));
		Main.relateStates.open();
		this.filesopened.setValue(Constants.TRUE);
		brw1.init(Clarion.newNumber(quickwindow._browse_1),queueBrowse_1.viewposition,brw1ViewBrowse,queueBrowse_1,Main.relateStates,this);
		quickwindow.open();
		this.opened.setValue(Constants.TRUE);
		brw1.q=queueBrowse_1;
		brw1Sort0Stepclass.init(Clarion.newNumber(Scrollsort.ALLOWALPHA),Clarion.newNumber(Scrollby.RUNTIME));
		brw1.addsortorder(brw1Sort0Stepclass,Main.states.statecodekey);
		brw1.addlocator(brw1Sort0Locator);
		brw1Sort0Locator.init(Clarion.newNumber(quickwindow._staStatecode),Main.states.statecode,Clarion.newNumber(1),brw1);
		brw1.addfield(Main.states.statecode,brw1.q.staStatecode);
		brw1.addfield(Main.states.name,brw1.q.staName);
		quickwindow.setProperty(Prop.MINWIDTH,173);
		quickwindow.setProperty(Prop.MINHEIGHT,203);
		resizer.init(Clarion.newNumber(Appstrategy.SPREAD));
		this.additem(resizer);
		Main.inimgr.fetch(Clarion.newString("SelectStates"),quickwindow);
		resizer.resize();
		resizer.reset();
		brw1.addtoolbartarget(toolbar);
		brw1.toolbaritem.helpbutton.setValue(quickwindow._help);
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
			Main.relateStates.close();
		}
		if (this.opened.boolValue()) {
			Main.inimgr.update(Clarion.newString("SelectStates"),quickwindow);
		}
		Main.globalerrors.setprocedurename();
		return returnvalue.like();
	}
}
