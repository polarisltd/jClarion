package clarion;

import clarion.Brw1;
import clarion.Cardr001;
import clarion.Filterlocatorclass;
import clarion.Main;
import clarion.QueueBrowse_1;
import clarion.QuickWindow_1;
import clarion.Stepstringclass;
import clarion.Toolbarclass;
import clarion.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Prop;
import clarion.equates.Scrollby;
import clarion.equates.Scrollsort;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CExpression;
import org.jclarion.clarion.view.ClarionView;

public class Thiswindow_3 extends Windowmanager
{
	QuickWindow_1 quickWindow;
	Toolbarclass toolbar;
	Brw1 brw1;
	QueueBrowse_1 queueBrowse_1;
	ClarionView bRW1ViewBrowse;
	Stepstringclass bRW1Sort0StepClass;
	Filterlocatorclass bRW1Sort0Locator;
	ClarionString lOCCityStateZip;
	ClarionString lOCOrdinalExtension;
	ClarionString lOCCardTypeDescription;
	public Thiswindow_3(QuickWindow_1 quickWindow,Toolbarclass toolbar,Brw1 brw1,QueueBrowse_1 queueBrowse_1,ClarionView bRW1ViewBrowse,Stepstringclass bRW1Sort0StepClass,Filterlocatorclass bRW1Sort0Locator,ClarionString lOCCityStateZip,ClarionString lOCOrdinalExtension,ClarionString lOCCardTypeDescription)
	{
		this.quickWindow=quickWindow;
		this.toolbar=toolbar;
		this.brw1=brw1;
		this.queueBrowse_1=queueBrowse_1;
		this.bRW1ViewBrowse=bRW1ViewBrowse;
		this.bRW1Sort0StepClass=bRW1Sort0StepClass;
		this.bRW1Sort0Locator=bRW1Sort0Locator;
		this.lOCCityStateZip=lOCCityStateZip;
		this.lOCOrdinalExtension=lOCOrdinalExtension;
		this.lOCCardTypeDescription=lOCCardTypeDescription;
	}

	public ClarionNumber init()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalErrors.setProcedureName(Clarion.newString("BrowseAccounts"));
		this.request.setValue(Main.globalRequest);
		returnValue.setValue(super.init());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		this.firstField.setValue(quickWindow._browse_1);
		this.vCRRequest=Main.vCRRequest;
		this.errors=Main.globalErrors;
		this.addItem(toolbar);
		Main.globalRequest.clear();
		Main.globalResponse.clear();
		this.addItem(Clarion.newNumber(quickWindow._close),Clarion.newNumber(Constants.REQUESTCANCELLED));
		Main.relateAccounts.open();
		this.filesOpened.setValue(Constants.TRUE);
		Main.appWindowRef.getControl(Main.gLOButton1).setProperty(Prop.DISABLE,Constants.FALSE);
		Main.appWindowRef.getControl(Main.gLOButton2).setProperty(Prop.DISABLE,Constants.FALSE);
		Main.appWindowRef.getControl(Main.gLOButton3).setProperty(Prop.DISABLE,Constants.FALSE);
		brw1.init(Clarion.newNumber(quickWindow._browse_1),queueBrowse_1.viewPosition,bRW1ViewBrowse,queueBrowse_1,Main.relateAccounts,this);
		quickWindow.open();
		this.opened.setValue(Constants.TRUE);
		brw1.q=queueBrowse_1;
		bRW1Sort0StepClass.init(Clarion.newNumber(Scrollsort.ALLOWALPHA),Clarion.newNumber(Scrollby.RUNTIME));
		brw1.addSortOrder(bRW1Sort0StepClass,Main.accounts.creditCardVendorKey);
		brw1.addLocator(bRW1Sort0Locator);
		bRW1Sort0Locator.init(Clarion.newNumber(quickWindow._aCCCreditCardVendor),Main.accounts.creditCardVendor,Clarion.newNumber(1),brw1);
		CExpression.bind("LOC:CityStateZip",lOCCityStateZip);
		CExpression.bind("LOC:OrdinalExtension",lOCOrdinalExtension);
		CExpression.bind("LOC:CardTypeDescription",lOCCardTypeDescription);
		CExpression.bind("GLO:CardTypeDescription",Main.gLOCardTypeDescription);
		brw1.addField(Main.accounts.creditCardVendor,brw1.q.aCCCreditCardVendor);
		brw1.addField(Main.accounts.accountNumber,brw1.q.aCCAccountNumber);
		brw1.addField(Main.accounts.vendorAddr1,brw1.q.aCCVendorAddr1);
		brw1.addField(Main.accounts.vendorAddr2,brw1.q.aCCVendorAddr2);
		brw1.addField(Main.accounts.vendorCity,brw1.q.aCCVendorCity);
		brw1.addField(Main.accounts.vendorState,brw1.q.aCCVendorState);
		brw1.addField(Main.accounts.vendorZip,brw1.q.aCCVendorZip);
		brw1.addField(Main.accounts.interestRate,brw1.q.aCCInterestRate);
		brw1.addField(Main.accounts.billingDay,brw1.q.aCCBillingDay);
		brw1.addField(Main.accounts.accountBalance,brw1.q.aCCAccountBalance);
		brw1.addField(Main.accounts.balanceInfoPhone,brw1.q.aCCBalanceInfoPhone);
		brw1.addField(Main.accounts.lostCardPhone,brw1.q.aCCLostCardPhone);
		brw1.addField(lOCCityStateZip,brw1.q.lOCCityStateZip);
		brw1.addField(lOCOrdinalExtension,brw1.q.lOCOrdinalExtension);
		brw1.addField(lOCCardTypeDescription,brw1.q.lOCCardTypeDescription);
		brw1.addField(Main.gLOCardTypeDescription,brw1.q.gLOCardTypeDescription);
		brw1.addField(Main.accounts.creditLimit,brw1.q.aCCCreditLimit);
		brw1.addField(Main.accounts.expirationDate,brw1.q.aCCExpirationDate);
		brw1.addField(Main.accounts.sysID,brw1.q.aCCSysID);
		Main.iNIMgr.fetch(Clarion.newString("BrowseAccounts"),quickWindow);
		quickWindow.setProperty(Prop.TEXT,"Browse Credit Card Accounts");
		brw1.askProcedure.setValue(1);
		brw1.addToolbarTarget(toolbar);
		brw1.toolbarItem.helpButton.setValue(quickWindow._help);
		this.setAlerts();
		return returnValue.like();
	}
	public ClarionNumber kill()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(super.kill());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		if (this.filesOpened.boolValue()) {
			Main.relateAccounts.close();
		}
		if (this.opened.boolValue()) {
			Main.iNIMgr.update(Clarion.newString("BrowseAccounts"),quickWindow);
		}
		Main.appWindowRef.getControl(Main.gLOButton1).setProperty(Prop.DISABLE,Constants.TRUE);
		Main.appWindowRef.getControl(Main.gLOButton2).setProperty(Prop.DISABLE,Constants.TRUE);
		Main.appWindowRef.getControl(Main.gLOButton3).setProperty(Prop.DISABLE,Constants.TRUE);
		Main.globalErrors.setProcedureName();
		return returnValue.like();
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
		Main.gLOCurrentSysid.setValue(Main.accounts.sysID);
		super.reset(force.like());
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
			Cardr001.updateAccounts();
			returnValue.setValue(Main.globalResponse);
		}
		return returnValue.like();
	}
}
