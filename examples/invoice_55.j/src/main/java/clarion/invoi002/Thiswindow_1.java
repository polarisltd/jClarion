package clarion.invoi002;

import clarion.Main;
import clarion.abbrowse.Filterlocatorclass;
import clarion.abbrowse.Incrementallocatorclass;
import clarion.abbrowse.Stepstringclass;
import clarion.abquery.Queryformclass_2;
import clarion.abquery.Queryformvisual_2;
import clarion.abtoolba.Toolbarclass;
import clarion.abwindow.Windowmanager;
import clarion.equates.Appstrategy;
import clarion.equates.Constants;
import clarion.equates.Prop;
import clarion.equates.Scrollby;
import clarion.equates.Scrollsort;
import clarion.invoi002.Brw1;
import clarion.invoi002.Invoi002;
import clarion.invoi002.QueueBrowse_1;
import clarion.invoi002.Quickwindow_1;
import clarion.invoi002.Resizer_1;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Thiswindow_1 extends Windowmanager
{
	Brw1 brw1;
	Quickwindow_1 quickwindow;
	Toolbarclass toolbar;
	QueueBrowse_1 queueBrowse_1;
	ClarionView brw1ViewBrowse;
	Queryformclass_2 qbe6;
	Queryformvisual_2 qbv6;
	Stepstringclass brw1Sort1Stepclass;
	Incrementallocatorclass brw1Sort1Locator;
	Stepstringclass brw1Sort0Stepclass;
	Filterlocatorclass brw1Sort0Locator;
	Resizer_1 resizer;
	public Thiswindow_1(Brw1 brw1,Quickwindow_1 quickwindow,Toolbarclass toolbar,QueueBrowse_1 queueBrowse_1,ClarionView brw1ViewBrowse,Queryformclass_2 qbe6,Queryformvisual_2 qbv6,Stepstringclass brw1Sort1Stepclass,Incrementallocatorclass brw1Sort1Locator,Stepstringclass brw1Sort0Stepclass,Filterlocatorclass brw1Sort0Locator,Resizer_1 resizer)
	{
		this.brw1=brw1;
		this.quickwindow=quickwindow;
		this.toolbar=toolbar;
		this.queueBrowse_1=queueBrowse_1;
		this.brw1ViewBrowse=brw1ViewBrowse;
		this.qbe6=qbe6;
		this.qbv6=qbv6;
		this.brw1Sort1Stepclass=brw1Sort1Stepclass;
		this.brw1Sort1Locator=brw1Sort1Locator;
		this.brw1Sort0Stepclass=brw1Sort0Stepclass;
		this.brw1Sort0Locator=brw1Sort0Locator;
		this.resizer=resizer;
	}

	public ClarionNumber init()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalerrors.setprocedurename(Clarion.newString("BrowseProducts"));
		brw1.askprocedure.setValue(1);
		this.request.setValue(Main.globalrequest);
		returnvalue.setValue(super.init());
		if (returnvalue.boolValue()) {
			return returnvalue.like();
		}
		this.firstfield.setValue(quickwindow._string1);
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
		qbe6.init(qbv6,Main.inimgr,Clarion.newString("BrowseProducts"),Main.globalerrors);
		qbe6.qksupport.setValue(Constants.TRUE);
		qbe6.qkmenuicon.setValue("QkQBE.ico");
		qbe6.qkicon.setValue("QkLoad.ico");
		brw1.q=queueBrowse_1;
		brw1Sort1Stepclass.init(Clarion.newNumber(Scrollsort.ALLOWALPHA),Clarion.newNumber(Scrollby.RUNTIME));
		brw1.addsortorder(brw1Sort1Stepclass,Main.products.keyproductsku);
		brw1.addlocator(brw1Sort1Locator);
		brw1Sort1Locator.init(Clarion.newNumber(quickwindow._proProductsku),Main.products.productsku,Clarion.newNumber(1),brw1);
		brw1Sort0Stepclass.init(Clarion.newNumber(Scrollsort.ALLOWALPHA),Clarion.newNumber(Scrollby.RUNTIME));
		brw1.addsortorder(brw1Sort0Stepclass,Main.products.keydescription);
		brw1.addlocator(brw1Sort0Locator);
		brw1Sort0Locator.init(Clarion.newNumber(quickwindow._proDescription),Main.products.description,Clarion.newNumber(1),brw1);
		brw1.addfield(Main.products.description,brw1.q.proDescription);
		brw1.addfield(Main.products.productsku,brw1.q.proProductsku);
		brw1.addfield(Main.products.price,brw1.q.proPrice);
		brw1.addfield(Main.products.quantityinstock,brw1.q.proQuantityinstock);
		brw1.addfield(Main.products.picturefile,brw1.q.proPicturefile);
		brw1.addfield(Main.products.productnumber,brw1.q.proProductnumber);
		quickwindow.setProperty(Prop.MINWIDTH,403);
		quickwindow.setProperty(Prop.MINHEIGHT,180);
		resizer.init(Clarion.newNumber(Appstrategy.SPREAD));
		this.additem(resizer);
		Main.inimgr.fetch(Clarion.newString("BrowseProducts"),quickwindow);
		resizer.resize();
		resizer.reset();
		brw1.querycontrol.setValue(quickwindow._query);
//		brw1.updatequery(qbe6,Clarion.newNumber(1));   %%%%%%%%%%%% comment it out as ABQUERY is not implemented anyways
		brw1.addtoolbartarget(toolbar);
		brw1.toolbaritem.helpbutton.setValue(quickwindow._help);
		brw1.printprocedure.setValue(2);
		brw1.printcontrol.setValue(quickwindow._print);
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
			Main.inimgr.update(Clarion.newString("BrowseProducts"),quickwindow);
		}
		Main.globalerrors.setprocedurename();
		return returnvalue.like();
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
		Clarion.getControl(quickwindow._image1).setClonedProperty(Prop.TEXT,Main.products.picturefile);
		super.reset(force.like());
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
					Invoi002.updateproducts();
				}
				if (execute_1==2) {
					Invoi002.printselectedproduct();
				}
			}
			returnvalue.setValue(Main.globalresponse);
		}
		return returnvalue.like();
	}
}
