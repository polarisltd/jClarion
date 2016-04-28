package clarion;

import clarion.Brw1;
import clarion.Incrementallocatorclass;
import clarion.Invoi001;
import clarion.Main;
import clarion.QueueBrowse_1;
import clarion.QuickWindow;
import clarion.Resizer;
import clarion.Stepstringclass;
import clarion.Toolbarclass;
import clarion.Windowmanager;
import clarion.equates.Appstrategy;
import clarion.equates.Constants;
import clarion.equates.Prop;
import clarion.equates.Scrollby;
import clarion.equates.Scrollsort;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.view.ClarionView;

public class Thiswindow extends Windowmanager
{
	QuickWindow quickWindow;
	Toolbarclass toolbar;
	Brw1 brw1;
	QueueBrowse_1 queueBrowse_1;
	ClarionView bRW1ViewBrowse;
	Stepstringclass bRW1Sort0StepClass;
	Incrementallocatorclass bRW1Sort0Locator;
	Resizer resizer;
	public Thiswindow(QuickWindow quickWindow,Toolbarclass toolbar,Brw1 brw1,QueueBrowse_1 queueBrowse_1,ClarionView bRW1ViewBrowse,Stepstringclass bRW1Sort0StepClass,Incrementallocatorclass bRW1Sort0Locator,Resizer resizer)
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
		this.firstField.setValue(quickWindow._sTAStateCode);
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
		Clarion.getControl(quickWindow._browse_1).setProperty(Prop.LINEHEIGHT,0);
		init_DefineListboxStyle();
		brw1.q=queueBrowse_1;
		bRW1Sort0StepClass.init(Clarion.newNumber(Scrollsort.ALLOWALPHA),Clarion.newNumber(Scrollby.RUNTIME));
		brw1.addSortOrder(bRW1Sort0StepClass,Main.states.stateCodeKey);
		brw1.addLocator(bRW1Sort0Locator);
		bRW1Sort0Locator.init(Clarion.newNumber(quickWindow._sTAStateCode),Main.states.stateCode,Clarion.newNumber(1),brw1);
		brw1.addField(Main.states.stateCode,brw1.q.sTAStateCode);
		brw1.addField(Main.states.name,brw1.q.sTAName);
		quickWindow.setProperty(Prop.MINWIDTH,173);
		quickWindow.setProperty(Prop.MINHEIGHT,203);
		resizer.init(Clarion.newNumber(Appstrategy.SPREAD));
		this.addItem(resizer);
		brw1.addToolbarTarget(toolbar);
		brw1.toolbarItem.helpButton.setValue(quickWindow._help);
		this.setAlerts();
		return returnValue.like();
	}
	public void init_DefineListboxStyle()
	{
		Invoi001.selectStates_DefineListboxStyle();
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
		Main.globalErrors.setProcedureName();
		return returnValue.like();
	}
}
