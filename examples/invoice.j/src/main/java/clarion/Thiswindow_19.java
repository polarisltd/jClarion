package clarion;

import clarion.Brw1_3;
import clarion.Cwutil;
import clarion.Filterlocatorclass;
import clarion.Incrementallocatorclass;
import clarion.Invoi002;
import clarion.Invoi003;
import clarion.Main;
import clarion.Queryformclass;
import clarion.Queryformvisual;
import clarion.QueueBrowse_1_4;
import clarion.QuickWindow_9;
import clarion.Resizer_10;
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

public class Thiswindow_19 extends Windowmanager
{
	Brw1_3 brw1;
	QuickWindow_9 quickWindow;
	Toolbarclass toolbar;
	QueueBrowse_1_4 queueBrowse_1;
	ClarionView bRW1ViewBrowse;
	Queryformclass qbe6;
	Queryformvisual qbv6;
	Stepstringclass bRW1Sort1StepClass;
	Incrementallocatorclass bRW1Sort1Locator;
	Stepstringclass bRW1Sort0StepClass;
	Filterlocatorclass bRW1Sort0Locator;
	Resizer_10 resizer;
	public Thiswindow_19(Brw1_3 brw1,QuickWindow_9 quickWindow,Toolbarclass toolbar,QueueBrowse_1_4 queueBrowse_1,ClarionView bRW1ViewBrowse,Queryformclass qbe6,Queryformvisual qbv6,Stepstringclass bRW1Sort1StepClass,Incrementallocatorclass bRW1Sort1Locator,Stepstringclass bRW1Sort0StepClass,Filterlocatorclass bRW1Sort0Locator,Resizer_10 resizer)
	{
		this.brw1=brw1;
		this.quickWindow=quickWindow;
		this.toolbar=toolbar;
		this.queueBrowse_1=queueBrowse_1;
		this.bRW1ViewBrowse=bRW1ViewBrowse;
		this.qbe6=qbe6;
		this.qbv6=qbv6;
		this.bRW1Sort1StepClass=bRW1Sort1StepClass;
		this.bRW1Sort1Locator=bRW1Sort1Locator;
		this.bRW1Sort0StepClass=bRW1Sort0StepClass;
		this.bRW1Sort0Locator=bRW1Sort0Locator;
		this.resizer=resizer;
	}

	public ClarionNumber init()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalErrors.setProcedureName(Clarion.newString("BrowseProducts"));
		brw1.askProcedure.setValue(1);
		this.request.setValue(Main.globalRequest);
		returnValue.setValue(super.init());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		this.firstField.setValue(quickWindow._string1);
		this.vCRRequest=Main.vCRRequest;
		this.errors=Main.globalErrors;
		Main.globalRequest.clear();
		Main.globalResponse.clear();
		this.addItem(toolbar);
		this.addItem(Clarion.newNumber(quickWindow._close),Clarion.newNumber(Constants.REQUESTCANCELLED));
		Main.relateProducts.get().open();
		this.filesOpened.setValue(Constants.TRUE);
		brw1.init(Clarion.newNumber(quickWindow._browse_1),queueBrowse_1.viewPosition,bRW1ViewBrowse,queueBrowse_1,Main.relateProducts.get(),this);
		quickWindow.open();
		this.opened.setValue(Constants.TRUE);
		Clarion.getControl(quickWindow._browse_1).setProperty(Prop.LINEHEIGHT,0);
		init_DefineListboxStyle();
		qbe6.init(qbv6,Main.iNIMgr,Clarion.newString("BrowseProducts"),Main.globalErrors);
		qbe6.qkSupport.setValue(Constants.TRUE);
		qbe6.qkMenuIcon.setValue("QkQBE.ico");
		qbe6.qkIcon.setValue("QkLoad.ico");
		brw1.q=queueBrowse_1;
		bRW1Sort1StepClass.init(Clarion.newNumber(Scrollsort.ALLOWALPHA),Clarion.newNumber(Scrollby.RUNTIME));
		brw1.addSortOrder(bRW1Sort1StepClass,Main.products.keyProductSKU);
		brw1.addLocator(bRW1Sort1Locator);
		bRW1Sort1Locator.init(Clarion.newNumber(quickWindow._pROProductSKU),Main.products.productSKU,Clarion.newNumber(1),brw1);
		bRW1Sort0StepClass.init(Clarion.newNumber(Scrollsort.ALLOWALPHA),Clarion.newNumber(Scrollby.RUNTIME));
		brw1.addSortOrder(bRW1Sort0StepClass,Main.products.keyDescription);
		brw1.addLocator(bRW1Sort0Locator);
		bRW1Sort0Locator.init(Clarion.newNumber(quickWindow._pRODescription),Main.products.description,Clarion.newNumber(1),brw1);
		brw1.addField(Main.products.description,brw1.q.pRODescription);
		brw1.addField(Main.products.productSKU,brw1.q.pROProductSKU);
		brw1.addField(Main.products.price,brw1.q.pROPrice);
		brw1.addField(Main.products.quantityInStock,brw1.q.pROQuantityInStock);
		brw1.addField(Main.products.pictureFile,brw1.q.pROPictureFile);
		brw1.addField(Main.products.productNumber,brw1.q.pROProductNumber);
		quickWindow.setProperty(Prop.MINWIDTH,403);
		quickWindow.setProperty(Prop.MINHEIGHT,180);
		resizer.init(Clarion.newNumber(Appstrategy.SPREAD));
		this.addItem(resizer);
		brw1.queryControl.setValue(quickWindow._query);
		brw1.updateQuery(qbe6,Clarion.newNumber(1));
		brw1.addToolbarTarget(toolbar);
		brw1.toolbarItem.helpButton.setValue(quickWindow._help);
		brw1.printProcedure.setValue(2);
		brw1.printControl.setValue(quickWindow._print);
		this.setAlerts();
		return returnValue.like();
	}
	public void init_DefineListboxStyle()
	{
		Invoi002.browseProducts_DefineListboxStyle();
	}
	public ClarionNumber kill()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(super.kill());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		if (this.filesOpened.boolValue()) {
			Main.relateProducts.get().close();
		}
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
		Clarion.getControl(quickWindow._image1).setClonedProperty(Prop.TEXT,Main.products.pictureFile);
		Cwutil.resizeImage(Clarion.newNumber(quickWindow._image1),Clarion.newNumber(267),Clarion.newNumber(19),Clarion.newNumber(123),Clarion.newNumber(134));
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
			{
				int execute_1=number.intValue();
				if (execute_1==1) {
					Invoi003.updateProducts();
				}
				if (execute_1==2) {
					Invoi002.printSelectedProduct();
				}
			}
			returnValue.setValue(Main.globalResponse);
		}
		return returnValue.like();
	}
}
