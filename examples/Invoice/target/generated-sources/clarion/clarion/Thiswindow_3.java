package clarion;

import clarion.Brw1_1;
import clarion.Incrementallocatorclass;
import clarion.Invoi001;
import clarion.Main;
import clarion.Queryformclass;
import clarion.Queryformvisual;
import clarion.QueueBrowse_1_1;
import clarion.QuickWindow_2;
import clarion.Resizer_3;
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

public class Thiswindow_3 extends Windowmanager
{
	QuickWindow_2 quickWindow;
	Toolbarclass toolbar;
	Brw1_1 brw1;
	QueueBrowse_1_1 queueBrowse_1;
	ClarionView bRW1ViewBrowse;
	Queryformclass qbe5;
	Queryformvisual qbv5;
	Stepstringclass bRW1Sort0StepClass;
	Incrementallocatorclass bRW1Sort0Locator;
	Resizer_3 resizer;
	public Thiswindow_3(QuickWindow_2 quickWindow,Toolbarclass toolbar,Brw1_1 brw1,QueueBrowse_1_1 queueBrowse_1,ClarionView bRW1ViewBrowse,Queryformclass qbe5,Queryformvisual qbv5,Stepstringclass bRW1Sort0StepClass,Incrementallocatorclass bRW1Sort0Locator,Resizer_3 resizer)
	{
		this.quickWindow=quickWindow;
		this.toolbar=toolbar;
		this.brw1=brw1;
		this.queueBrowse_1=queueBrowse_1;
		this.bRW1ViewBrowse=bRW1ViewBrowse;
		this.qbe5=qbe5;
		this.qbv5=qbv5;
		this.bRW1Sort0StepClass=bRW1Sort0StepClass;
		this.bRW1Sort0Locator=bRW1Sort0Locator;
		this.resizer=resizer;
	}

	public ClarionNumber init()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalErrors.setProcedureName(Clarion.newString("SelectProducts"));
		this.request.setValue(Main.globalRequest);
		returnValue.setValue(super.init());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		this.firstField.setValue(quickWindow._pRODescription);
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
		qbe5.init(qbv5,Main.iNIMgr,Clarion.newString("SelectProducts"),Main.globalErrors);
		qbe5.qkSupport.setValue(Constants.TRUE);
		qbe5.qkMenuIcon.setValue("QkQBE.ico");
		qbe5.qkIcon.setValue("QkLoad.ico");
		brw1.q=queueBrowse_1;
		bRW1Sort0StepClass.init(Clarion.newNumber(Scrollsort.ALLOWALPHA),Clarion.newNumber(Scrollby.RUNTIME));
		brw1.addSortOrder(bRW1Sort0StepClass,Main.products.keyDescription);
		brw1.addLocator(bRW1Sort0Locator);
		bRW1Sort0Locator.init(Clarion.newNumber(quickWindow._pRODescription),Main.products.description,Clarion.newNumber(1),brw1);
		brw1.addField(Main.products.description,brw1.q.pRODescription);
		brw1.addField(Main.products.productSKU,brw1.q.pROProductSKU);
		brw1.addField(Main.products.price,brw1.q.pROPrice);
		brw1.addField(Main.products.quantityInStock,brw1.q.pROQuantityInStock);
		brw1.addField(Main.products.productNumber,brw1.q.pROProductNumber);
		quickWindow.setProperty(Prop.MINWIDTH,236);
		quickWindow.setProperty(Prop.MINHEIGHT,139);
		resizer.init(Clarion.newNumber(Appstrategy.SPREAD));
		this.addItem(resizer);
		brw1.queryControl.setValue(quickWindow._query);
		brw1.query=qbe5;
		qbe5.addItem(Clarion.newString("UPPER(PRO:Description)"),Clarion.newString("Product Description"),Clarion.newString("@s30"),Clarion.newNumber(1));
		brw1.addToolbarTarget(toolbar);
		brw1.toolbarItem.helpButton.setValue(quickWindow._help);
		this.setAlerts();
		return returnValue.like();
	}
	public void init_DefineListboxStyle()
	{
		Invoi001.selectProducts_DefineListboxStyle();
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
}
