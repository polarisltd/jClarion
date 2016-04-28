package clarion.invoi001;

import clarion.Main;
import clarion.abbrowse.Incrementallocatorclass;
import clarion.abbrowse.Stepstringclass;
import clarion.abquery.Queryformclass_1;
import clarion.abquery.Queryformvisual_1;
import clarion.abtoolba.Toolbarclass;
import clarion.abwindow.Windowmanager;
import clarion.equates.Appstrategy;
import clarion.equates.Constants;
import clarion.equates.Prop;
import clarion.equates.Scrollby;
import clarion.equates.Scrollsort;
import clarion.invoi001.Brw1_1;
import clarion.invoi001.QueueBrowse_1_1;
import clarion.invoi001.Quickwindow_2;
import clarion.invoi001.Resizer_3;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Thiswindow_3 extends Windowmanager
{
	Quickwindow_2 quickwindow;
	Toolbarclass toolbar;
	Brw1_1 brw1;
	QueueBrowse_1_1 queueBrowse_1;
	ClarionView brw1ViewBrowse;
	Queryformclass_1 qbe5;
	Queryformvisual_1 qbv5;
	Stepstringclass brw1Sort0Stepclass;
	Incrementallocatorclass brw1Sort0Locator;
	Resizer_3 resizer;
	public Thiswindow_3(Quickwindow_2 quickwindow,Toolbarclass toolbar,Brw1_1 brw1,QueueBrowse_1_1 queueBrowse_1,ClarionView brw1ViewBrowse,Queryformclass_1 qbe5,Queryformvisual_1 qbv5,Stepstringclass brw1Sort0Stepclass,Incrementallocatorclass brw1Sort0Locator,Resizer_3 resizer)
	{
		this.quickwindow=quickwindow;
		this.toolbar=toolbar;
		this.brw1=brw1;
		this.queueBrowse_1=queueBrowse_1;
		this.brw1ViewBrowse=brw1ViewBrowse;
		this.qbe5=qbe5;
		this.qbv5=qbv5;
		this.brw1Sort0Stepclass=brw1Sort0Stepclass;
		this.brw1Sort0Locator=brw1Sort0Locator;
		this.resizer=resizer;
	}

	public ClarionNumber init()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalerrors.setprocedurename(Clarion.newString("SelectProducts"));
		this.request.setValue(Main.globalrequest);
		returnvalue.setValue(super.init());
		if (returnvalue.boolValue()) {
			return returnvalue.like();
		}
		this.firstfield.setValue(quickwindow._proDescription);
		this.vcrrequest=Main.vcrrequest;
		this.errors=Main.globalerrors;
		this.additem(toolbar);
		Main.globalrequest.clear();
		Main.globalresponse.clear();
		this.additem(Clarion.newNumber(quickwindow._close),Clarion.newNumber(Constants.REQUESTCANCELLED));
		Main.relateProducts.open();
		this.filesopened.setValue(Constants.TRUE);
		brw1.init(Clarion.newNumber(quickwindow._browse_1),queueBrowse_1.viewposition,brw1ViewBrowse,queueBrowse_1,Main.relateProducts,this);
		quickwindow.open();
		this.opened.setValue(Constants.TRUE);
		qbe5.init(qbv5,Main.inimgr,Clarion.newString("SelectProducts"),Main.globalerrors);
		qbe5.qksupport.setValue(Constants.TRUE);
		qbe5.qkmenuicon.setValue("QkQBE.ico");
		qbe5.qkicon.setValue("QkLoad.ico");
		brw1.q=queueBrowse_1;
		brw1Sort0Stepclass.init(Clarion.newNumber(Scrollsort.ALLOWALPHA),Clarion.newNumber(Scrollby.RUNTIME));
		brw1.addsortorder(brw1Sort0Stepclass,Main.products.keydescription);
		brw1.addlocator(brw1Sort0Locator);
		brw1Sort0Locator.init(Clarion.newNumber(quickwindow._proDescription),Main.products.description,Clarion.newNumber(1),brw1);
		brw1.addfield(Main.products.description,brw1.q.proDescription);
		brw1.addfield(Main.products.productsku,brw1.q.proProductsku);
		brw1.addfield(Main.products.price,brw1.q.proPrice);
		brw1.addfield(Main.products.quantityinstock,brw1.q.proQuantityinstock);
		brw1.addfield(Main.products.productnumber,brw1.q.proProductnumber);
		quickwindow.setProperty(Prop.MINWIDTH,236);
		quickwindow.setProperty(Prop.MINHEIGHT,139);
		resizer.init(Clarion.newNumber(Appstrategy.SPREAD));
		this.additem(resizer);
		Main.inimgr.fetch(Clarion.newString("SelectProducts"),quickwindow);
		resizer.resize();
		resizer.reset();
		brw1.querycontrol.setValue(quickwindow._query);
		brw1.query=qbe5;
		qbe5.additem(Clarion.newString("UPPER(PRO:Description)"),Clarion.newString("Product Description"),Clarion.newString("@s30"),Clarion.newNumber(1));
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
			Main.relateProducts.close();
		}
		if (this.opened.boolValue()) {
			Main.inimgr.update(Clarion.newString("SelectProducts"),quickwindow);
		}
		Main.globalerrors.setprocedurename();
		return returnvalue.like();
	}
}
