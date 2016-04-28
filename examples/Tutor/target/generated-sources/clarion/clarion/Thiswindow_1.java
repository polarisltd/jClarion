package clarion;

import clarion.Brw1;
import clarion.Main;
import clarion.QueueBrowse_1;
import clarion.QuickWindow;
import clarion.Resizer;
import clarion.Steplocatorclass;
import clarion.Steplongclass;
import clarion.Stepstringclass;
import clarion.Toolbarclass;
import clarion.Tutor002;
import clarion.Tutor011;
import clarion.Windowmanager;
import clarion.equates.Appstrategy;
import clarion.equates.Constants;
import clarion.equates.Resize;
import clarion.equates.Scrollby;
import clarion.equates.Scrollsort;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.view.ClarionView;

public class Thiswindow_1 extends Windowmanager
{
	QuickWindow quickWindow;
	Toolbarclass toolbar;
	Brw1 brw1;
	QueueBrowse_1 queueBrowse_1;
	ClarionView bRW1ViewBrowse;
	Stepstringclass bRW1Sort1StepClass;
	Steplocatorclass bRW1Sort1Locator;
	Steplongclass bRW1Sort2StepClass;
	Steplocatorclass bRW1Sort2Locator;
	Steplongclass bRW1Sort0StepClass;
	Steplocatorclass bRW1Sort0Locator;
	Resizer resizer;
	public Thiswindow_1(QuickWindow quickWindow,Toolbarclass toolbar,Brw1 brw1,QueueBrowse_1 queueBrowse_1,ClarionView bRW1ViewBrowse,Stepstringclass bRW1Sort1StepClass,Steplocatorclass bRW1Sort1Locator,Steplongclass bRW1Sort2StepClass,Steplocatorclass bRW1Sort2Locator,Steplongclass bRW1Sort0StepClass,Steplocatorclass bRW1Sort0Locator,Resizer resizer)
	{
		this.quickWindow=quickWindow;
		this.toolbar=toolbar;
		this.brw1=brw1;
		this.queueBrowse_1=queueBrowse_1;
		this.bRW1ViewBrowse=bRW1ViewBrowse;
		this.bRW1Sort1StepClass=bRW1Sort1StepClass;
		this.bRW1Sort1Locator=bRW1Sort1Locator;
		this.bRW1Sort2StepClass=bRW1Sort2StepClass;
		this.bRW1Sort2Locator=bRW1Sort2Locator;
		this.bRW1Sort0StepClass=bRW1Sort0StepClass;
		this.bRW1Sort0Locator=bRW1Sort0Locator;
		this.resizer=resizer;
	}

	public ClarionNumber init()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalErrors.setProcedureName(Clarion.newString("BrowseCUSTOMER"));
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
		Main.relateCUSTOMER.get().open();
		this.filesOpened.setValue(Constants.TRUE);
		brw1.init(Clarion.newNumber(quickWindow._browse_1),queueBrowse_1.viewPosition,bRW1ViewBrowse,queueBrowse_1,Main.relateCUSTOMER.get(),this);
		quickWindow.open();
		this.opened.setValue(Constants.TRUE);
		init_DefineListboxStyle();
		brw1.q=queueBrowse_1;
		bRW1Sort1StepClass.init(Clarion.newNumber(Scrollsort.ALLOWALPHA),Clarion.newNumber(Scrollby.RUNTIME));
		brw1.addSortOrder(bRW1Sort1StepClass,Main.customer.keycompany);
		brw1.addLocator(bRW1Sort1Locator);
		bRW1Sort1Locator.init(Clarion.newNumber(0),Main.customer.company,Clarion.newNumber(1),brw1);
		bRW1Sort2StepClass.init(Clarion.newNumber(Scrollsort.ALLOWALPHA));
		brw1.addSortOrder(bRW1Sort2StepClass,Main.customer.keyzipcode);
		brw1.addLocator(bRW1Sort2Locator);
		bRW1Sort2Locator.init(Clarion.newNumber(0),Main.customer.zipcode,Clarion.newNumber(1),brw1);
		bRW1Sort0StepClass.init(Clarion.newNumber(Scrollsort.ALLOWALPHA));
		brw1.addSortOrder(bRW1Sort0StepClass,Main.customer.keycustnumber);
		brw1.addLocator(bRW1Sort0Locator);
		bRW1Sort0Locator.init(Clarion.newNumber(0),Main.customer.custnumber,Clarion.newNumber(1),brw1);
		brw1.addField(Main.customer.custnumber,brw1.q.cusCustnumber);
		brw1.addField(Main.customer.company,brw1.q.cusCompany);
		brw1.addField(Main.customer.firstname,brw1.q.cusFirstname);
		brw1.addField(Main.customer.lastname,brw1.q.cusLastname);
		brw1.addField(Main.customer.address,brw1.q.cusAddress);
		brw1.addField(Main.customer.city,brw1.q.cusCity);
		brw1.addField(Main.customer.state,brw1.q.cusState);
		brw1.addField(Main.customer.zipcode,brw1.q.cusZipcode);
		resizer.init(Clarion.newNumber(Appstrategy.SURFACE),Clarion.newNumber(Resize.SETMINSIZE));
		this.addItem(resizer);
		Main.iNIMgr.fetch(Clarion.newString("BrowseCUSTOMER"),quickWindow);
		resizer.resize();
		resizer.reset();
		brw1.askProcedure.setValue(1);
		this.setAlerts();
		return returnValue.like();
	}
	public void init_DefineListboxStyle()
	{
		Tutor002.browseCUSTOMER_DefineListboxStyle();
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
		}
		if (this.opened.boolValue()) {
			Main.iNIMgr.update(Clarion.newString("BrowseCUSTOMER"),quickWindow);
		}
		Main.globalErrors.setProcedureName();
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
			Tutor011.updateCUSTOMER();
			returnValue.setValue(Main.globalResponse);
		}
		return returnValue.like();
	}
}
