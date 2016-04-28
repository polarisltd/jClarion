package clarion;

import clarion.Detail;
import clarion.Fieldcolorqueue_1;
import clarion.Invoi001;
import clarion.Main;
import clarion.QuickWindow_3;
import clarion.Resizer_4;
import clarion.Toolbarclass;
import clarion.Toolbarupdateclass;
import clarion.Windowmanager;
import clarion.equates.Appstrategy;
import clarion.equates.Button;
import clarion.equates.Cancel;
import clarion.equates.Change;
import clarion.equates.Constants;
import clarion.equates.Delete;
import clarion.equates.Event;
import clarion.equates.Icon;
import clarion.equates.Insert;
import clarion.equates.Level;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CWin;

public class Thiswindow_4 extends Windowmanager
{
	ClarionString actionMessage;
	QuickWindow_3 quickWindow;
	Toolbarclass toolbar;
	ClarionDecimal sAVQuantity;
	ClarionNumber sAVBackOrder;
	ClarionNumber checkFlag;
	Detail historyDTLRecord;
	Thiswindow_4 thisWindow;
	ClarionString productDescription;
	Resizer_4 resizer;
	Toolbarupdateclass toolbarForm;
	ClarionDecimal lOCQuantityAvailable;
	Fieldcolorqueue_1 fieldColorQueue;
	ClarionDecimal nEWQuantity;
	ClarionDecimal lOCRegTotalPrice;
	ClarionDecimal lOCDiscTotalPrice;
	public Thiswindow_4(ClarionString actionMessage,QuickWindow_3 quickWindow,Toolbarclass toolbar,ClarionDecimal sAVQuantity,ClarionNumber sAVBackOrder,ClarionNumber checkFlag,Detail historyDTLRecord,Thiswindow_4 thisWindow,ClarionString productDescription,Resizer_4 resizer,Toolbarupdateclass toolbarForm,ClarionDecimal lOCQuantityAvailable,Fieldcolorqueue_1 fieldColorQueue,ClarionDecimal nEWQuantity,ClarionDecimal lOCRegTotalPrice,ClarionDecimal lOCDiscTotalPrice)
	{
		this.actionMessage=actionMessage;
		this.quickWindow=quickWindow;
		this.toolbar=toolbar;
		this.sAVQuantity=sAVQuantity;
		this.sAVBackOrder=sAVBackOrder;
		this.checkFlag=checkFlag;
		this.historyDTLRecord=historyDTLRecord;
		this.thisWindow=thisWindow;
		this.productDescription=productDescription;
		this.resizer=resizer;
		this.toolbarForm=toolbarForm;
		this.lOCQuantityAvailable=lOCQuantityAvailable;
		this.fieldColorQueue=fieldColorQueue;
		this.nEWQuantity=nEWQuantity;
		this.lOCRegTotalPrice=lOCRegTotalPrice;
		this.lOCDiscTotalPrice=lOCDiscTotalPrice;
	}
	public Thiswindow_4() {}
	public void __Init__(ClarionString actionMessage,QuickWindow_3 quickWindow,Toolbarclass toolbar,ClarionDecimal sAVQuantity,ClarionNumber sAVBackOrder,ClarionNumber checkFlag,Detail historyDTLRecord,Thiswindow_4 thisWindow,ClarionString productDescription,Resizer_4 resizer,Toolbarupdateclass toolbarForm,ClarionDecimal lOCQuantityAvailable,Fieldcolorqueue_1 fieldColorQueue,ClarionDecimal nEWQuantity,ClarionDecimal lOCRegTotalPrice,ClarionDecimal lOCDiscTotalPrice)
	{
		this.actionMessage=actionMessage;
		this.quickWindow=quickWindow;
		this.toolbar=toolbar;
		this.sAVQuantity=sAVQuantity;
		this.sAVBackOrder=sAVBackOrder;
		this.checkFlag=checkFlag;
		this.historyDTLRecord=historyDTLRecord;
		this.thisWindow=thisWindow;
		this.productDescription=productDescription;
		this.resizer=resizer;
		this.toolbarForm=toolbarForm;
		this.lOCQuantityAvailable=lOCQuantityAvailable;
		this.fieldColorQueue=fieldColorQueue;
		this.nEWQuantity=nEWQuantity;
		this.lOCRegTotalPrice=lOCRegTotalPrice;
		this.lOCDiscTotalPrice=lOCDiscTotalPrice;
	}

	public void ask()
	{
		{
			ClarionNumber case_1=this.request;
			boolean case_1_break=false;
			if (case_1.equals(Constants.VIEWRECORD)) {
				actionMessage.setValue("View Record");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.INSERTRECORD)) {
				actionMessage.setValue("Adding a Detail Record");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.CHANGERECORD)) {
				actionMessage.setValue("Changing a Detail Record");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.DELETERECORD)) {
				actionMessage.setValue("Deleting a Detail Record");
				case_1_break=true;
			}
		}
		quickWindow.setClonedProperty(Prop.TEXT,actionMessage);
		super.ask();
	}
	public ClarionNumber init()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalErrors.setProcedureName(Clarion.newString("UpdateDetail"));
		this.request.setValue(Main.globalRequest);
		returnValue.setValue(super.init());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		this.firstField.setValue(quickWindow._dTLProductNumberPrompt);
		this.vCRRequest=Main.vCRRequest;
		this.errors=Main.globalErrors;
		Main.globalRequest.clear();
		Main.globalResponse.clear();
		this.addItem(toolbar);
		sAVQuantity.setValue(Main.detail.quantityOrdered);
		sAVBackOrder.setValue(Main.detail.backOrdered);
		checkFlag.setValue(Constants.FALSE);
		this.historyKey.setValue(734);
		this.addHistoryFile(Main.detail,historyDTLRecord);
		this.addHistoryField(Clarion.newNumber(quickWindow._dTLProductNumber),Clarion.newNumber(4));
		this.addHistoryField(Clarion.newNumber(quickWindow._dTLLineNumber),Clarion.newNumber(3));
		this.addHistoryField(Clarion.newNumber(quickWindow._dTLQuantityOrdered),Clarion.newNumber(5));
		this.addHistoryField(Clarion.newNumber(quickWindow._dTLPrice),Clarion.newNumber(7));
		this.addHistoryField(Clarion.newNumber(quickWindow._dTLTaxRate),Clarion.newNumber(8));
		this.addHistoryField(Clarion.newNumber(quickWindow._dTLDiscountRate),Clarion.newNumber(10));
		this.addHistoryField(Clarion.newNumber(quickWindow._dTLBackOrdered),Clarion.newNumber(6));
		this.addUpdateFile(Main.accessDetail.get());
		this.addItem(Clarion.newNumber(quickWindow._cancel),Clarion.newNumber(Constants.REQUESTCANCELLED));
		Main.relateDetail.get().open();
		Main.relateInvHist.get().open();
		Main.relateProducts.get().open();
		this.filesOpened.setValue(Constants.TRUE);
		this.primary=Main.relateDetail.get();
		if (this.request.equals(Constants.VIEWRECORD) && !this.batchProcessing.boolValue()) {
			this.insertAction.setValue(Insert.NONE);
			this.deleteAction.setValue(Delete.NONE);
			this.changeAction.setValue(Change.NONE);
			this.cancelAction.setValue(Cancel.CANCEL);
			this.okControl.setValue(0);
		}
		else {
			this.insertAction.setValue(Insert.QUERY);
			this.deleteAction.setValue(Delete.FORM);
			this.changeAction.setValue(Change.CALLER);
			this.cancelAction.setValue(Cancel.CANCEL+Cancel.QUERY);
			this.okControl.setValue(quickWindow._ok);
			if (this.primeUpdate().boolValue()) {
				return Clarion.newNumber(Level.NOTIFY);
			}
		}
		quickWindow.open();
		this.opened.setValue(Constants.TRUE);
		if (thisWindow.request.equals(Constants.CHANGERECORD) || thisWindow.request.equals(Constants.DELETERECORD)) {
			Main.products.productNumber.setValue(Main.detail.productNumber);
			Main.accessProducts.get().tryFetch(Main.products.keyProductNumber);
			productDescription.setValue(Main.products.description);
		}
		init_DefineListboxStyle();
		quickWindow.setProperty(Prop.MINWIDTH,191);
		quickWindow.setProperty(Prop.MINHEIGHT,112);
		resizer.init(Clarion.newNumber(Appstrategy.SPREAD));
		this.addItem(resizer);
		toolbarForm.helpButton.setValue(quickWindow._help);
		this.addItem(toolbarForm);
		this.setAlerts();
		return returnValue.like();
	}
	public void init_DefineListboxStyle()
	{
		Invoi001.updateDetail_DefineListboxStyle();
	}
	public ClarionNumber kill()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(super.kill());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		if (this.filesOpened.boolValue()) {
			Main.relateDetail.get().close();
			Main.relateInvHist.get().close();
			Main.relateProducts.get().close();
		}
		Main.globalErrors.setProcedureName();
		return returnValue.like();
	}
	public ClarionNumber run()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(super.run());
		if (this.request.equals(Constants.VIEWRECORD)) {
			returnValue.setValue(Constants.REQUESTCANCELLED);
		}
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
			Invoi001.selectProducts();
			returnValue.setValue(Main.globalResponse);
		}
		if (Main.globalResponse.equals(Constants.REQUESTCOMPLETED)) {
			Main.detail.productNumber.setValue(Main.products.productNumber);
			productDescription.setValue(Main.products.description);
			Main.detail.price.setValue(Main.products.price);
			lOCQuantityAvailable.setValue(Main.products.quantityInStock);
			CWin.display();
			if (lOCQuantityAvailable.compareTo(0)<=0) {
				{
					int case_1=CWin.message(Clarion.newString("Yes for BACKORDER or No for CANCEL"),Clarion.newString("OUT OF STOCK: Select Order Options"),Icon.QUESTION,Button.YES+Button.NO,Button.YES,1);
					boolean case_1_break=false;
					if (case_1==Button.YES) {
						Main.detail.backOrdered.setValue(Constants.TRUE);
						CWin.display();
						CWin.select(quickWindow._dTLQuantityOrdered);
						case_1_break=true;
					}
					if (!case_1_break && case_1==Button.NO) {
						if (thisWindow.request.equals(Constants.INSERTRECORD)) {
							thisWindow.response.setValue(Constants.REQUESTCANCELLED);
							Main.accessDetail.get().cancelAutoInc();
							CWin.post(Event.CLOSEWINDOW);
						}
						case_1_break=true;
					}
				}
			}
			if (thisWindow.request.equals(Constants.CHANGERECORD)) {
				if (Main.detail.quantityOrdered.compareTo(lOCQuantityAvailable)<0) {
					Main.detail.backOrdered.setValue(Constants.FALSE);
					CWin.display();
				}
				else {
					Main.detail.backOrdered.setValue(Constants.TRUE);
					CWin.display();
				}
			}
			if (productDescription.equals("")) {
				Main.detail.price.clear();
				CWin.select(quickWindow._callLookup);
			}
			CWin.select(quickWindow._dTLQuantityOrdered);
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
				boolean case_1_break=false;
				if (case_1==quickWindow._dTLProductNumber) {
					if (Main.accessDetail.get().tryValidateField(Clarion.newNumber(4)).boolValue()) {
						CWin.select(quickWindow._dTLProductNumber);
						quickWindow.setProperty(Prop.ACCEPTALL,Constants.FALSE);
						continue;
					}
					else {
						fieldColorQueue.feq.setValue(quickWindow._dTLProductNumber);
						fieldColorQueue.get(fieldColorQueue.ORDER().ascend(fieldColorQueue.feq));
						if (!(CError.errorCode()!=0)) {
							Clarion.getControl(quickWindow._dTLProductNumber).setClonedProperty(Prop.FONTCOLOR,fieldColorQueue.oldColor);
							fieldColorQueue.delete();
						}
					}
					case_1_break=true;
				}
				if (!case_1_break && case_1==quickWindow._callLookup) {
					thisWindow.update();
					Main.products.productNumber.setValue(Main.detail.productNumber);
					if (this.run(Clarion.newNumber(1),Clarion.newNumber(Constants.SELECTRECORD)).equals(Constants.REQUESTCOMPLETED)) {
						Main.detail.productNumber.setValue(Main.products.productNumber);
					}
					thisWindow.reset(Clarion.newNumber(1));
					case_1_break=true;
				}
				if (!case_1_break && case_1==quickWindow._dTLQuantityOrdered) {
					if (Main.accessDetail.get().tryValidateField(Clarion.newNumber(5)).boolValue()) {
						CWin.select(quickWindow._dTLQuantityOrdered);
						quickWindow.setProperty(Prop.ACCEPTALL,Constants.FALSE);
						continue;
					}
					else {
						fieldColorQueue.feq.setValue(quickWindow._dTLQuantityOrdered);
						fieldColorQueue.get(fieldColorQueue.ORDER().ascend(fieldColorQueue.feq));
						if (!(CError.errorCode()!=0)) {
							Clarion.getControl(quickWindow._dTLQuantityOrdered).setClonedProperty(Prop.FONTCOLOR,fieldColorQueue.oldColor);
							fieldColorQueue.delete();
						}
					}
					nEWQuantity.setValue(Main.detail.quantityOrdered);
					if (checkFlag.equals(Constants.FALSE)) {
						if (lOCQuantityAvailable.compareTo(0)>0) {
							if (Main.detail.quantityOrdered.compareTo(lOCQuantityAvailable)>0) {
								{
									int case_2=CWin.message(Clarion.newString("Yes for BACKORDER or No for CANCEL"),Clarion.newString("LOW STOCK: Select Order Options"),Icon.QUESTION,Button.YES+Button.NO,Button.YES,1);
									boolean case_2_break=false;
									if (case_2==Button.YES) {
										Main.detail.backOrdered.setValue(Constants.TRUE);
										CWin.display();
										case_2_break=true;
									}
									if (!case_2_break && case_2==Button.NO) {
										if (thisWindow.request.equals(Constants.INSERTRECORD)) {
											thisWindow.response.setValue(Constants.REQUESTCANCELLED);
											Main.accessDetail.get().cancelAutoInc();
											CWin.post(Event.CLOSEWINDOW);
										}
										case_2_break=true;
									}
								}
							}
							else {
								Main.detail.backOrdered.setValue(Constants.FALSE);
								CWin.display();
							}
						}
						if (thisWindow.request.equals(Constants.CHANGERECORD)) {
							if (Main.detail.quantityOrdered.compareTo(lOCQuantityAvailable)<=0) {
								Main.detail.backOrdered.setValue(Constants.FALSE);
								CWin.display();
							}
							else {
								Main.detail.backOrdered.setValue(Constants.TRUE);
								CWin.display();
							}
						}
						checkFlag.setValue(Constants.TRUE);
					}
					case_1_break=true;
				}
				if (!case_1_break && case_1==quickWindow._ok) {
					thisWindow.update();
					takeAccepted_CalcValues(lOCRegTotalPrice,lOCDiscTotalPrice);
					if (this.request.equals(Constants.VIEWRECORD) && !this.batchProcessing.boolValue()) {
						CWin.post(Event.CLOSEWINDOW);
					}
					case_1_break=true;
				}
			}
			return returnValue.like();
		}
		// UNREACHABLE! :returnValue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnValue.like();
	}
	public void takeAccepted_CalcValues(ClarionDecimal lOCRegTotalPrice,ClarionDecimal lOCDiscTotalPrice)
	{
		Invoi001.updateDetail_CalcValues(lOCRegTotalPrice,lOCDiscTotalPrice);
	}
	public ClarionNumber takeCompleted()
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
			takeCompleted_UpdateOtherFiles(thisWindow,sAVBackOrder,sAVQuantity,nEWQuantity);
			returnValue.setValue(super.takeCompleted());
			return returnValue.like();
		}
		// UNREACHABLE! :returnValue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnValue.like();
	}
	public void takeCompleted_UpdateOtherFiles(Thiswindow_4 thisWindow,ClarionNumber sAVBackOrder,ClarionDecimal sAVQuantity,ClarionDecimal nEWQuantity)
	{
		Invoi001.updateDetail_UpdateOtherFiles(thisWindow,sAVBackOrder,sAVQuantity,nEWQuantity);
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
			returnValue.setValue(super.takeSelected());
			{
				int case_1=CWin.field();
				if (case_1==quickWindow._dTLProductNumber) {
					Main.products.productNumber.setValue(Main.detail.productNumber);
					if (Main.accessProducts.get().tryFetch(Main.products.keyProductNumber).boolValue()) {
						if (this.run(Clarion.newNumber(1),Clarion.newNumber(Constants.SELECTRECORD)).equals(Constants.REQUESTCOMPLETED)) {
							Main.detail.productNumber.setValue(Main.products.productNumber);
						}
					}
					thisWindow.reset();
				}
			}
			return returnValue.like();
		}
		// UNREACHABLE! :returnValue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnValue.like();
	}
}
