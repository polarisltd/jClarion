package clarion;

import clarion.Cwutil;
import clarion.Invoi003;
import clarion.Main;
import clarion.Products;
import clarion.QuickWindow_5;
import clarion.Resizer_6;
import clarion.Selectfileclass;
import clarion.Toolbarclass;
import clarion.Toolbarupdateclass;
import clarion.Windowmanager;
import clarion.equates.Appstrategy;
import clarion.equates.Cancel;
import clarion.equates.Change;
import clarion.equates.Constants;
import clarion.equates.Delete;
import clarion.equates.Event;
import clarion.equates.Insert;
import clarion.equates.Level;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CWin;

public class Thiswindow_7 extends Windowmanager
{
	ClarionString actionMessage;
	QuickWindow_5 quickWindow;
	Toolbarclass toolbar;
	Products historyPRORecord;
	Resizer_6 resizer;
	Toolbarupdateclass toolbarForm;
	Selectfileclass fileLookup5;
	Thiswindow_7 thisWindow;
	ClarionString lOCFileName;
	public Thiswindow_7(ClarionString actionMessage,QuickWindow_5 quickWindow,Toolbarclass toolbar,Products historyPRORecord,Resizer_6 resizer,Toolbarupdateclass toolbarForm,Selectfileclass fileLookup5,Thiswindow_7 thisWindow,ClarionString lOCFileName)
	{
		this.actionMessage=actionMessage;
		this.quickWindow=quickWindow;
		this.toolbar=toolbar;
		this.historyPRORecord=historyPRORecord;
		this.resizer=resizer;
		this.toolbarForm=toolbarForm;
		this.fileLookup5=fileLookup5;
		this.thisWindow=thisWindow;
		this.lOCFileName=lOCFileName;
	}
	public Thiswindow_7() {}
	public void __Init__(ClarionString actionMessage,QuickWindow_5 quickWindow,Toolbarclass toolbar,Products historyPRORecord,Resizer_6 resizer,Toolbarupdateclass toolbarForm,Selectfileclass fileLookup5,Thiswindow_7 thisWindow,ClarionString lOCFileName)
	{
		this.actionMessage=actionMessage;
		this.quickWindow=quickWindow;
		this.toolbar=toolbar;
		this.historyPRORecord=historyPRORecord;
		this.resizer=resizer;
		this.toolbarForm=toolbarForm;
		this.fileLookup5=fileLookup5;
		this.thisWindow=thisWindow;
		this.lOCFileName=lOCFileName;
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
				actionMessage.setValue("Record Will Be Added");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.CHANGERECORD)) {
				actionMessage.setValue("Record Will Be Changed");
				case_1_break=true;
			}
		}
		quickWindow.setClonedProperty(Prop.TEXT,actionMessage);
		{
			ClarionNumber case_2=this.request;
			boolean case_2_break=false;
			boolean case_2_match=false;
			case_2_match=false;
			if (case_2.equals(Constants.CHANGERECORD)) {
				case_2_match=true;
			}
			if (case_2_match || case_2.equals(Constants.DELETERECORD)) {
				quickWindow.setProperty(Prop.TEXT,quickWindow.getProperty(Prop.TEXT).concat("  (",Main.products.description.clip(),")"));
				case_2_break=true;
			}
			case_2_match=false;
			if (!case_2_break && case_2.equals(Constants.INSERTRECORD)) {
				quickWindow.setProperty(Prop.TEXT,quickWindow.getProperty(Prop.TEXT).concat("  (New)"));
				case_2_break=true;
			}
		}
		super.ask();
	}
	public ClarionNumber init()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalErrors.setProcedureName(Clarion.newString("UpdateProducts"));
		this.request.setValue(Main.globalRequest);
		returnValue.setValue(super.init());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		this.firstField.setValue(quickWindow._pROProductSKUPrompt);
		this.vCRRequest=Main.vCRRequest;
		this.errors=Main.globalErrors;
		Main.globalRequest.clear();
		Main.globalResponse.clear();
		this.addItem(toolbar);
		this.historyKey.setValue(734);
		this.addHistoryFile(Main.products,historyPRORecord);
		this.addHistoryField(Clarion.newNumber(quickWindow._pROProductSKU),Clarion.newNumber(2));
		this.addHistoryField(Clarion.newNumber(quickWindow._pRODescription),Clarion.newNumber(3));
		this.addHistoryField(Clarion.newNumber(quickWindow._pROPrice),Clarion.newNumber(4));
		this.addHistoryField(Clarion.newNumber(quickWindow._pROCost),Clarion.newNumber(7));
		this.addHistoryField(Clarion.newNumber(quickWindow._pROQuantityInStock),Clarion.newNumber(5));
		this.addHistoryField(Clarion.newNumber(quickWindow._pROReorderQuantity),Clarion.newNumber(6));
		this.addHistoryField(Clarion.newNumber(quickWindow._pROPictureFile),Clarion.newNumber(8));
		this.addUpdateFile(Main.accessProducts.get());
		this.addItem(Clarion.newNumber(quickWindow._cancel),Clarion.newNumber(Constants.REQUESTCANCELLED));
		Main.relateProducts.get().open();
		this.filesOpened.setValue(Constants.TRUE);
		this.primary=Main.relateProducts.get();
		if (this.request.equals(Constants.VIEWRECORD) && !this.batchProcessing.boolValue()) {
			this.insertAction.setValue(Insert.NONE);
			this.deleteAction.setValue(Delete.NONE);
			this.changeAction.setValue(Change.NONE);
			this.cancelAction.setValue(Cancel.CANCEL);
			this.okControl.setValue(0);
		}
		else {
			this.insertAction.setValue(Insert.QUERY);
			this.changeAction.setValue(Change.CALLER);
			this.okControl.setValue(quickWindow._ok);
			if (this.primeUpdate().boolValue()) {
				return Clarion.newNumber(Level.NOTIFY);
			}
		}
		quickWindow.open();
		this.opened.setValue(Constants.TRUE);
		init_DefineListboxStyle();
		quickWindow.setProperty(Prop.MINWIDTH,281);
		quickWindow.setProperty(Prop.MINHEIGHT,127);
		quickWindow.setProperty(Prop.MAXWIDTH,281);
		quickWindow.setProperty(Prop.MAXHEIGHT,127);
		resizer.init(Clarion.newNumber(Appstrategy.NORESIZE));
		this.addItem(resizer);
		if (this.request.equals(Constants.CHANGERECORD) || this.request.equals(Constants.DELETERECORD)) {
			Clarion.getControl(quickWindow._image1).setClonedProperty(Prop.TEXT,Main.products.pictureFile);
		}
		toolbarForm.helpButton.setValue(quickWindow._help);
		this.addItem(toolbarForm);
		fileLookup5.init();
		fileLookup5.setMask(Clarion.newString("JPEG Images"),Clarion.newString("*.JPG"));
		fileLookup5.addMask(Clarion.newString("BMP Images"),Clarion.newString("*.BMP"));
		fileLookup5.addMask(Clarion.newString("GIF Files"),Clarion.newString("*.GIF"));
		fileLookup5.windowTitle.setValue("Locate and Select Product Image File");
		this.setAlerts();
		return returnValue.like();
	}
	public void init_DefineListboxStyle()
	{
		Invoi003.updateProducts_DefineListboxStyle();
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
	public ClarionNumber run()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(super.run());
		if (this.request.equals(Constants.VIEWRECORD)) {
			returnValue.setValue(Constants.REQUESTCANCELLED);
		}
		return returnValue.like();
	}
	public ClarionNumber takeAccepted()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber looped=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber _lX_number=Clarion.newNumber();
		ClarionNumber _x_number=Clarion.newNumber();
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
				if (case_1==quickWindow._lookupFile) {
					thisWindow.update();
					lOCFileName.setValue(fileLookup5.ask(Clarion.newNumber(1)));
					CWin.display();
					if (lOCFileName.boolValue()) {
						Clarion.getControl(quickWindow._image1).setProperty(Prop.TEXT,lOCFileName.clip());
						Cwutil.resizeImage(Clarion.newNumber(quickWindow._image1),Clarion.newNumber(185),Clarion.newNumber(9),Clarion.newNumber(89),Clarion.newNumber(87));
						CWin.unhide(quickWindow._image1);
					}
					if (!lOCFileName.equals("")) {
						_lX_number.setValue(lOCFileName.clip().len());
						for (_x_number.setValue(_lX_number);_x_number.compareTo(1)>=0;_x_number.increment(-1)) {
							if (lOCFileName.stringAt(_x_number).equals("\\")) {
								break;
							}
						}
						if (lOCFileName.stringAt(1,_x_number.subtract(1)).equals("")) {
							Main.products.pictureFile.setValue(lOCFileName.stringAt(_x_number.add(1),_lX_number).upper());
							CWin.display();
						}
					}
					case_1_break=true;
				}
				if (!case_1_break && case_1==quickWindow._ok) {
					thisWindow.update();
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
}
