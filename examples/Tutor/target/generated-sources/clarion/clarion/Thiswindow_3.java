package clarion;

import clarion.Brw1_1;
import clarion.Main;
import clarion.QueueBrowse_1_1;
import clarion.QuickWindow_2;
import clarion.Resizer_2;
import clarion.Steplocatorclass;
import clarion.Stepstringclass;
import clarion.Toolbarclass;
import clarion.Tutor015;
import clarion.Windowmanager;
import clarion.equates.Appstrategy;
import clarion.equates.Constants;
import clarion.equates.Resize;
import clarion.equates.Scrollby;
import clarion.equates.Scrollsort;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.view.ClarionView;

public class Thiswindow_3 extends Windowmanager
{
	QuickWindow_2 quickWindow;
	Toolbarclass toolbar;
	Brw1_1 brw1;
	QueueBrowse_1_1 queueBrowse_1;
	ClarionView bRW1ViewBrowse;
	Stepstringclass bRW1Sort0StepClass;
	Steplocatorclass bRW1Sort0Locator;
	Resizer_2 resizer;
	public Thiswindow_3(QuickWindow_2 quickWindow,Toolbarclass toolbar,Brw1_1 brw1,QueueBrowse_1_1 queueBrowse_1,ClarionView bRW1ViewBrowse,Stepstringclass bRW1Sort0StepClass,Steplocatorclass bRW1Sort0Locator,Resizer_2 resizer)
	{
		this.quickWindow=quickWindow;
		this.toolbar=toolbar;
		this.brw1=brw1;
		this.queueBrowse_1=queueBrowse_1;
		this.bRW1ViewBrowse=bRW1ViewBrowse;
		this.bRW1Sort0StepClass=bRW1Sort0StepClass;
		this.bRW1Sort0Locator=bRW1Sort0Locator;
		this.resizer=resizer;
	}

	public ClarionNumber init()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalErrors.setProcedureName(Clarion.newString("SelectStates"));
		this.request.setValue(Main.globalRequest);
		returnValue.setValue(super.init());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		this.firstField.setValue(quickWindow._browse_1);
		this.vCRRequest=Main.vCRRequest;
		this.errors=Main.globalErrors;
		Main.globalRequest.clear();
		Main.globalResponse.clear();
		this.addItem(toolbar);
		this.addItem(Clarion.newNumber(quickWindow._close),Clarion.newNumber(Constants.REQUESTCANCELLED));
		Main.relateStates.get().open();
		this.filesOpened.setValue(Constants.TRUE);
		brw1.init(Clarion.newNumber(quickWindow._browse_1),queueBrowse_1.viewPosition,bRW1ViewBrowse,queueBrowse_1,Main.relateStates.get(),this);
		quickWindow.open();
		this.opened.setValue(Constants.TRUE);
		init_DefineListboxStyle();
		brw1.q=queueBrowse_1;
		bRW1Sort0StepClass.init(Clarion.newNumber(Scrollsort.ALLOWALPHA),Clarion.newNumber(Scrollby.RUNTIME));
		brw1.addSortOrder(bRW1Sort0StepClass,Main.states.keyState);
		brw1.addLocator(bRW1Sort0Locator);
		bRW1Sort0Locator.init(Clarion.newNumber(0),Main.states.state,Clarion.newNumber(1),brw1);
		brw1.addField(Main.states.state,brw1.q.sTAState);
		brw1.addField(Main.states.stateName,brw1.q.sTAStateName);
		resizer.init(Clarion.newNumber(Appstrategy.SURFACE),Clarion.newNumber(Resize.SETMINSIZE));
		this.addItem(resizer);
		Main.iNIMgr.fetch(Clarion.newString("SelectStates"),quickWindow);
		resizer.resize();
		resizer.reset();
		this.setAlerts();
		return returnValue.like();
	}
	public void init_DefineListboxStyle()
	{
		Tutor015.selectStates_DefineListboxStyle();
	}
	public ClarionNumber kill()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(super.kill());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		if (this.filesOpened.boolValue()) {
			Main.relateStates.get().close();
		}
		if (this.opened.boolValue()) {
			Main.iNIMgr.update(Clarion.newString("SelectStates"),quickWindow);
		}
		Main.globalErrors.setProcedureName();
		return returnValue.like();
	}
}
