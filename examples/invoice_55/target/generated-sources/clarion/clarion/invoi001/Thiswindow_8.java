package clarion.invoi001;

import clarion.Main;
import clarion.abbrowse.Steplocatorclass;
import clarion.abbrowse.Steplongclass;
import clarion.abtoolba.Toolbarclass;
import clarion.abwindow.Windowmanager;
import clarion.equates.Appstrategy;
import clarion.equates.Constants;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.equates.Scrollsort;
import clarion.invoi001.Detailbrowse;
import clarion.invoi001.Invoi001;
import clarion.invoi001.Ordersbrowse;
import clarion.invoi001.QueueBrowse;
import clarion.invoi001.QueueBrowse_1_2;
import clarion.invoi001.Quickwindow_5;
import clarion.invoi001.Resizer_6;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CExpression;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Thiswindow_8 extends Windowmanager
{
	Quickwindow_5 quickwindow;
	Toolbarclass toolbar;
	Ordersbrowse ordersbrowse;
	QueueBrowse_1_2 queueBrowse_1;
	ClarionView brw1ViewBrowse;
	Detailbrowse detailbrowse;
	QueueBrowse queueBrowse;
	ClarionView brw5ViewBrowse;
	Steplongclass brw1Sort0Stepclass;
	Steplocatorclass brw1Sort0Locator;
	ClarionString locShipped;
	Steplocatorclass brw5Sort0Locator;
	ClarionString locBackorder;
	Resizer_6 resizer;
	Thiswindow_8 thiswindow;
	public Thiswindow_8(Quickwindow_5 quickwindow,Toolbarclass toolbar,Ordersbrowse ordersbrowse,QueueBrowse_1_2 queueBrowse_1,ClarionView brw1ViewBrowse,Detailbrowse detailbrowse,QueueBrowse queueBrowse,ClarionView brw5ViewBrowse,Steplongclass brw1Sort0Stepclass,Steplocatorclass brw1Sort0Locator,ClarionString locShipped,Steplocatorclass brw5Sort0Locator,ClarionString locBackorder,Resizer_6 resizer,Thiswindow_8 thiswindow)
	{
		this.quickwindow=quickwindow;
		this.toolbar=toolbar;
		this.ordersbrowse=ordersbrowse;
		this.queueBrowse_1=queueBrowse_1;
		this.brw1ViewBrowse=brw1ViewBrowse;
		this.detailbrowse=detailbrowse;
		this.queueBrowse=queueBrowse;
		this.brw5ViewBrowse=brw5ViewBrowse;
		this.brw1Sort0Stepclass=brw1Sort0Stepclass;
		this.brw1Sort0Locator=brw1Sort0Locator;
		this.locShipped=locShipped;
		this.brw5Sort0Locator=brw5Sort0Locator;
		this.locBackorder=locBackorder;
		this.resizer=resizer;
		this.thiswindow=thiswindow;
	}
	public Thiswindow_8() {}
	public void __Init__(Quickwindow_5 quickwindow,Toolbarclass toolbar,Ordersbrowse ordersbrowse,QueueBrowse_1_2 queueBrowse_1,ClarionView brw1ViewBrowse,Detailbrowse detailbrowse,QueueBrowse queueBrowse,ClarionView brw5ViewBrowse,Steplongclass brw1Sort0Stepclass,Steplocatorclass brw1Sort0Locator,ClarionString locShipped,Steplocatorclass brw5Sort0Locator,ClarionString locBackorder,Resizer_6 resizer,Thiswindow_8 thiswindow)
	{
		this.quickwindow=quickwindow;
		this.toolbar=toolbar;
		this.ordersbrowse=ordersbrowse;
		this.queueBrowse_1=queueBrowse_1;
		this.brw1ViewBrowse=brw1ViewBrowse;
		this.detailbrowse=detailbrowse;
		this.queueBrowse=queueBrowse;
		this.brw5ViewBrowse=brw5ViewBrowse;
		this.brw1Sort0Stepclass=brw1Sort0Stepclass;
		this.brw1Sort0Locator=brw1Sort0Locator;
		this.locShipped=locShipped;
		this.brw5Sort0Locator=brw5Sort0Locator;
		this.locBackorder=locBackorder;
		this.resizer=resizer;
		this.thiswindow=thiswindow;
	}

	public ClarionNumber init()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalerrors.setprocedurename(Clarion.newString("BrowseOrders"));
		this.request.setValue(Main.globalrequest);
		returnvalue.setValue(super.init());
		if (returnvalue.boolValue()) {
			return returnvalue.like();
		}
		this.firstfield.setValue(quickwindow._browse_1);
		this.vcrrequest=Main.vcrrequest;
		this.errors=Main.globalerrors;
		this.additem(toolbar);
		Main.globalrequest.clear();
		Main.globalresponse.clear();
		Main.glotCustname.setValue(Main.customers.firstname.clip().concat("   ",Main.customers.lastname.clip()));
		this.additem(Clarion.newNumber(quickwindow._close),Clarion.newNumber(Constants.REQUESTCANCELLED));
		Main.relateCustomers.open();
		this.filesopened.setValue(Constants.TRUE);
		ordersbrowse.init(Clarion.newNumber(quickwindow._browse_1),queueBrowse_1.viewposition,brw1ViewBrowse,queueBrowse_1,Main.relateOrders,this);
		detailbrowse.init(Clarion.newNumber(quickwindow._list),queueBrowse.viewposition,brw5ViewBrowse,queueBrowse,Main.relateDetail,this);
		quickwindow.open();
		this.opened.setValue(Constants.TRUE);
		Clarion.getControl(quickwindow._list).setProperty(Prop.NOBAR,Constants.TRUE);
		ordersbrowse.q=queueBrowse_1;
		brw1Sort0Stepclass.init(Clarion.newNumber(Scrollsort.ALLOWALPHA));
		ordersbrowse.addsortorder(brw1Sort0Stepclass,Main.orders.keycustordernumber);
		ordersbrowse.addrange(Main.orders.custnumber,Main.relateOrders,Main.relateCustomers);
		ordersbrowse.addlocator(brw1Sort0Locator);
		brw1Sort0Locator.init(Clarion.newNumber(0),Main.orders.ordernumber,Clarion.newNumber(1),ordersbrowse);
		CExpression.bind("LOC:Shipped",locShipped);
		CExpression.bind("GLOT:ShipName",Main.glotShipname);
		CExpression.bind("GLOT:ShipCSZ",Main.glotShipcsz);
		ordersbrowse.addfield(Main.orders.ordernumber,ordersbrowse.q.ordOrdernumber);
		ordersbrowse.addfield(Main.orders.orderdate,ordersbrowse.q.ordOrderdate);
		ordersbrowse.addfield(locShipped,ordersbrowse.q.locShipped);
		ordersbrowse.addfield(Main.orders.ordernote,ordersbrowse.q.ordOrdernote);
		ordersbrowse.addfield(Main.glotShipname,ordersbrowse.q.glotShipname);
		ordersbrowse.addfield(Main.orders.shiptoname,ordersbrowse.q.ordShiptoname);
		ordersbrowse.addfield(Main.orders.shipaddress1,ordersbrowse.q.ordShipaddress1);
		ordersbrowse.addfield(Main.orders.shipaddress2,ordersbrowse.q.ordShipaddress2);
		ordersbrowse.addfield(Main.orders.shipcity,ordersbrowse.q.ordShipcity);
		ordersbrowse.addfield(Main.orders.shipstate,ordersbrowse.q.ordShipstate);
		ordersbrowse.addfield(Main.orders.shipzip,ordersbrowse.q.ordShipzip);
		ordersbrowse.addfield(Main.glotShipcsz,ordersbrowse.q.glotShipcsz);
		ordersbrowse.addfield(Main.orders.invoicenumber,ordersbrowse.q.ordInvoicenumber);
		ordersbrowse.addfield(Main.orders.custnumber,ordersbrowse.q.ordCustnumber);
		detailbrowse.q=queueBrowse;
		detailbrowse.addsortorder(null,Main.detail.keydetails);
		detailbrowse.addrange(Main.detail.ordernumber,Main.relateDetail,Main.relateOrders);
		detailbrowse.addlocator(brw5Sort0Locator);
		brw5Sort0Locator.init(Clarion.newNumber(0),Main.detail.linenumber,Clarion.newNumber(1),detailbrowse);
		CExpression.bind("LOC:Backorder",locBackorder);
		detailbrowse.addfield(Main.products.description,detailbrowse.q.proDescription);
		detailbrowse.addfield(Main.detail.quantityordered,detailbrowse.q.dtlQuantityordered);
		detailbrowse.addfield(Main.detail.price,detailbrowse.q.dtlPrice);
		detailbrowse.addfield(locBackorder,detailbrowse.q.locBackorder);
		detailbrowse.addfield(Main.detail.taxpaid,detailbrowse.q.dtlTaxpaid);
		detailbrowse.addfield(Main.detail.discount,detailbrowse.q.dtlDiscount);
		detailbrowse.addfield(Main.detail.totalcost,detailbrowse.q.dtlTotalcost);
		detailbrowse.addfield(Main.detail.taxrate,detailbrowse.q.dtlTaxrate);
		detailbrowse.addfield(Main.detail.discountrate,detailbrowse.q.dtlDiscountrate);
		detailbrowse.addfield(Main.detail.custnumber,detailbrowse.q.dtlCustnumber);
		detailbrowse.addfield(Main.detail.ordernumber,detailbrowse.q.dtlOrdernumber);
		detailbrowse.addfield(Main.detail.linenumber,detailbrowse.q.dtlLinenumber);
		detailbrowse.addfield(Main.products.productnumber,detailbrowse.q.proProductnumber);
		quickwindow.setProperty(Prop.MINWIDTH,375);
		quickwindow.setProperty(Prop.MINHEIGHT,193);
		resizer.init(Clarion.newNumber(Appstrategy.SPREAD));
		this.additem(resizer);
		Main.inimgr.fetch(Clarion.newString("BrowseOrders"),quickwindow);
		resizer.resize();
		resizer.reset();
		ordersbrowse.askprocedure.setValue(1);
		detailbrowse.askprocedure.setValue(2);
		ordersbrowse.addtoolbartarget(toolbar);
		ordersbrowse.toolbaritem.helpbutton.setValue(quickwindow._help);
		detailbrowse.addtoolbartarget(toolbar);
		detailbrowse.toolbaritem.helpbutton.setValue(quickwindow._help);
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
		}
		if (this.opened.boolValue()) {
			Main.inimgr.update(Clarion.newString("BrowseOrders"),quickwindow);
		}
		Main.globalerrors.setprocedurename();
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
			{
				int execute_1=number.intValue();
				if (execute_1==1) {
					Invoi001.updateorders();
				}
				if (execute_1==2) {
					Invoi001.updatedetail();
				}
			}
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
				if (case_1==quickwindow._pinvbutton) {
					thiswindow.update();
					Invoi001.printinvoicefrombrowse();
					thiswindow.reset();
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
			{
				int case_1=CWin.field();
				boolean case_1_break=false;
				if (case_1==quickwindow._browse_1) {
					toolbar.settarget(Clarion.newNumber(quickwindow._browse_1));
					case_1_break=true;
				}
				if (!case_1_break && case_1==quickwindow._list) {
					toolbar.settarget(Clarion.newNumber(quickwindow._list));
					case_1_break=true;
				}
			}
			returnvalue.setValue(super.takeselected());
			return returnvalue.like();
		}
		// UNREACHABLE! :returnvalue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnvalue.like();
	}
}
