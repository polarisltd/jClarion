package clarion;

import clarion.Detailbrowse;
import clarion.Invoi001;
import clarion.Invoi002;
import clarion.Main;
import clarion.Ordersbrowse;
import clarion.QueueBrowse;
import clarion.QueueBrowse_1_2;
import clarion.QuickWindow_7;
import clarion.Resizer_8;
import clarion.Steplocatorclass;
import clarion.Steplongclass;
import clarion.Toolbarclass;
import clarion.Windowmanager;
import clarion.equates.Appstrategy;
import clarion.equates.Constants;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.equates.Scrollsort;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CExpression;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.view.ClarionView;

public class Thiswindow_15 extends Windowmanager
{
	QuickWindow_7 quickWindow;
	ClarionString lOCShipped;
	ClarionString lOCBackorder;
	Toolbarclass toolbar;
	Ordersbrowse ordersBrowse;
	QueueBrowse_1_2 queueBrowse_1;
	ClarionView bRW1ViewBrowse;
	Detailbrowse detailBrowse;
	QueueBrowse queueBrowse;
	ClarionView bRW5ViewBrowse;
	Steplongclass bRW1Sort0StepClass;
	Steplocatorclass bRW1Sort0Locator;
	Steplocatorclass bRW5Sort0Locator;
	Resizer_8 resizer;
	Thiswindow_15 thisWindow;
	public Thiswindow_15(QuickWindow_7 quickWindow,ClarionString lOCShipped,ClarionString lOCBackorder,Toolbarclass toolbar,Ordersbrowse ordersBrowse,QueueBrowse_1_2 queueBrowse_1,ClarionView bRW1ViewBrowse,Detailbrowse detailBrowse,QueueBrowse queueBrowse,ClarionView bRW5ViewBrowse,Steplongclass bRW1Sort0StepClass,Steplocatorclass bRW1Sort0Locator,Steplocatorclass bRW5Sort0Locator,Resizer_8 resizer,Thiswindow_15 thisWindow)
	{
		this.quickWindow=quickWindow;
		this.lOCShipped=lOCShipped;
		this.lOCBackorder=lOCBackorder;
		this.toolbar=toolbar;
		this.ordersBrowse=ordersBrowse;
		this.queueBrowse_1=queueBrowse_1;
		this.bRW1ViewBrowse=bRW1ViewBrowse;
		this.detailBrowse=detailBrowse;
		this.queueBrowse=queueBrowse;
		this.bRW5ViewBrowse=bRW5ViewBrowse;
		this.bRW1Sort0StepClass=bRW1Sort0StepClass;
		this.bRW1Sort0Locator=bRW1Sort0Locator;
		this.bRW5Sort0Locator=bRW5Sort0Locator;
		this.resizer=resizer;
		this.thisWindow=thisWindow;
	}
	public Thiswindow_15() {}
	public void __Init__(QuickWindow_7 quickWindow,ClarionString lOCShipped,ClarionString lOCBackorder,Toolbarclass toolbar,Ordersbrowse ordersBrowse,QueueBrowse_1_2 queueBrowse_1,ClarionView bRW1ViewBrowse,Detailbrowse detailBrowse,QueueBrowse queueBrowse,ClarionView bRW5ViewBrowse,Steplongclass bRW1Sort0StepClass,Steplocatorclass bRW1Sort0Locator,Steplocatorclass bRW5Sort0Locator,Resizer_8 resizer,Thiswindow_15 thisWindow)
	{
		this.quickWindow=quickWindow;
		this.lOCShipped=lOCShipped;
		this.lOCBackorder=lOCBackorder;
		this.toolbar=toolbar;
		this.ordersBrowse=ordersBrowse;
		this.queueBrowse_1=queueBrowse_1;
		this.bRW1ViewBrowse=bRW1ViewBrowse;
		this.detailBrowse=detailBrowse;
		this.queueBrowse=queueBrowse;
		this.bRW5ViewBrowse=bRW5ViewBrowse;
		this.bRW1Sort0StepClass=bRW1Sort0StepClass;
		this.bRW1Sort0Locator=bRW1Sort0Locator;
		this.bRW5Sort0Locator=bRW5Sort0Locator;
		this.resizer=resizer;
		this.thisWindow=thisWindow;
	}

	public ClarionNumber init()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalErrors.setProcedureName(Clarion.newString("BrowseOrders"));
		this.request.setValue(Main.globalRequest);
		returnValue.setValue(super.init());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		this.firstField.setValue(quickWindow._browse_1);
		this.vCRRequest=Main.vCRRequest;
		this.errors=Main.globalErrors;
		CExpression.bind("LOC:Shipped",lOCShipped);
		CExpression.bind("GLOT:ShipName",Main.gLOTShipName);
		CExpression.bind("GLOT:ShipCSZ",Main.gLOTShipCSZ);
		CExpression.bind("LOC:Backorder",lOCBackorder);
		Main.globalRequest.clear();
		Main.globalResponse.clear();
		this.addItem(toolbar);
		Main.gLOTCustName.setValue(Main.customers.firstName.clip().concat("   ",Main.customers.lastName.clip()));
		this.addItem(Clarion.newNumber(quickWindow._close),Clarion.newNumber(Constants.REQUESTCANCELLED));
		Main.relateCustomers.get().open();
		this.filesOpened.setValue(Constants.TRUE);
		ordersBrowse.init(Clarion.newNumber(quickWindow._browse_1),queueBrowse_1.viewPosition,bRW1ViewBrowse,queueBrowse_1,Main.relateOrders.get(),this);
		detailBrowse.init(Clarion.newNumber(quickWindow._list),queueBrowse.viewPosition,bRW5ViewBrowse,queueBrowse,Main.relateDetail.get(),this);
		quickWindow.open();
		this.opened.setValue(Constants.TRUE);
		Clarion.getControl(quickWindow._list).setProperty(Prop.NOBAR,Constants.TRUE);
		Clarion.getControl(quickWindow._browse_1).setProperty(Prop.LINEHEIGHT,0);
		Clarion.getControl(quickWindow._list).setProperty(Prop.LINEHEIGHT,0);
		init_DefineListboxStyle();
		ordersBrowse.q=queueBrowse_1;
		bRW1Sort0StepClass.init(Clarion.newNumber(Scrollsort.ALLOWALPHA));
		ordersBrowse.addSortOrder(bRW1Sort0StepClass,Main.orders.keyCustOrderNumber);
		ordersBrowse.addRange(Main.orders.custNumber,Main.relateOrders.get(),Main.relateCustomers.get());
		ordersBrowse.addLocator(bRW1Sort0Locator);
		bRW1Sort0Locator.init(Clarion.newNumber(0),Main.orders.orderNumber,Clarion.newNumber(1),ordersBrowse);
		ordersBrowse.addField(Main.orders.orderNumber,ordersBrowse.q.oRDOrderNumber);
		ordersBrowse.addField(Main.orders.orderDate,ordersBrowse.q.oRDOrderDate);
		ordersBrowse.addField(lOCShipped,ordersBrowse.q.lOCShipped);
		ordersBrowse.addField(Main.orders.orderNote,ordersBrowse.q.oRDOrderNote);
		ordersBrowse.addField(Main.gLOTShipName,ordersBrowse.q.gLOTShipName);
		ordersBrowse.addField(Main.orders.shipToName,ordersBrowse.q.oRDShipToName);
		ordersBrowse.addField(Main.orders.shipAddress1,ordersBrowse.q.oRDShipAddress1);
		ordersBrowse.addField(Main.orders.shipAddress2,ordersBrowse.q.oRDShipAddress2);
		ordersBrowse.addField(Main.orders.shipCity,ordersBrowse.q.oRDShipCity);
		ordersBrowse.addField(Main.orders.shipState,ordersBrowse.q.oRDShipState);
		ordersBrowse.addField(Main.orders.shipZip,ordersBrowse.q.oRDShipZip);
		ordersBrowse.addField(Main.gLOTShipCSZ,ordersBrowse.q.gLOTShipCSZ);
		ordersBrowse.addField(Main.orders.invoiceNumber,ordersBrowse.q.oRDInvoiceNumber);
		ordersBrowse.addField(Main.orders.custNumber,ordersBrowse.q.oRDCustNumber);
		detailBrowse.q=queueBrowse;
		detailBrowse.addSortOrder(null,Main.detail.keyDetails);
		detailBrowse.addRange(Main.detail.orderNumber,Main.relateDetail.get(),Main.relateOrders.get());
		detailBrowse.addLocator(bRW5Sort0Locator);
		bRW5Sort0Locator.init(Clarion.newNumber(0),Main.detail.lineNumber,Clarion.newNumber(1),detailBrowse);
		detailBrowse.addField(Main.products.description,detailBrowse.q.pRODescription);
		detailBrowse.addField(Main.detail.quantityOrdered,detailBrowse.q.dTLQuantityOrdered);
		detailBrowse.addField(Main.detail.price,detailBrowse.q.dTLPrice);
		detailBrowse.addField(lOCBackorder,detailBrowse.q.lOCBackorder);
		detailBrowse.addField(Main.detail.taxPaid,detailBrowse.q.dTLTaxPaid);
		detailBrowse.addField(Main.detail.discount,detailBrowse.q.dTLDiscount);
		detailBrowse.addField(Main.detail.totalCost,detailBrowse.q.dTLTotalCost);
		detailBrowse.addField(Main.detail.taxRate,detailBrowse.q.dTLTaxRate);
		detailBrowse.addField(Main.detail.discountRate,detailBrowse.q.dTLDiscountRate);
		detailBrowse.addField(Main.detail.custNumber,detailBrowse.q.dTLCustNumber);
		detailBrowse.addField(Main.detail.orderNumber,detailBrowse.q.dTLOrderNumber);
		detailBrowse.addField(Main.detail.lineNumber,detailBrowse.q.dTLLineNumber);
		detailBrowse.addField(Main.products.productNumber,detailBrowse.q.pROProductNumber);
		quickWindow.setProperty(Prop.MINWIDTH,375);
		quickWindow.setProperty(Prop.MINHEIGHT,193);
		resizer.init(Clarion.newNumber(Appstrategy.SPREAD));
		this.addItem(resizer);
		ordersBrowse.askProcedure.setValue(1);
		detailBrowse.askProcedure.setValue(2);
		ordersBrowse.addToolbarTarget(toolbar);
		ordersBrowse.toolbarItem.helpButton.setValue(quickWindow._help);
		detailBrowse.addToolbarTarget(toolbar);
		detailBrowse.toolbarItem.helpButton.setValue(quickWindow._help);
		this.setAlerts();
		return returnValue.like();
	}
	public void init_DefineListboxStyle()
	{
		Invoi002.browseOrders_DefineListboxStyle();
	}
	public ClarionNumber kill()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(super.kill());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		if (this.filesOpened.boolValue()) {
			Main.relateCustomers.get().close();
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
			{
				int execute_1=number.intValue();
				if (execute_1==1) {
					Invoi001.updateOrders();
				}
				if (execute_1==2) {
					Invoi001.updateDetail();
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
				if (case_1==quickWindow._pInvButton) {
					thisWindow.update();
					Invoi002.printInvoiceFromBrowse();
					thisWindow.reset();
				}
			}
			return returnValue.like();
		}
		// UNREACHABLE! :returnValue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnValue.like();
	}
	public ClarionNumber takeSelected()
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
			{
				int case_1=CWin.field();
				boolean case_1_break=false;
				if (case_1==quickWindow._browse_1) {
					toolbar.setTarget(Clarion.newNumber(quickWindow._browse_1));
					case_1_break=true;
				}
				if (!case_1_break && case_1==quickWindow._list) {
					toolbar.setTarget(Clarion.newNumber(quickWindow._browse_1));
					case_1_break=true;
				}
			}
			returnValue.setValue(super.takeSelected());
			return returnValue.like();
		}
		// UNREACHABLE! :returnValue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnValue.like();
	}
}
