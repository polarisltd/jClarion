package clarion;

import clarion.Main;
import clarion.equates.Color;
import clarion.equates.Font;
import clarion.equates.Icon;
import clarion.equates.Std;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.CheckControl;
import org.jclarion.clarion.control.EntryControl;
import org.jclarion.clarion.control.PromptControl;
import org.jclarion.clarion.control.SheetControl;
import org.jclarion.clarion.control.SpinControl;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.control.TabControl;

public class QuickWindow_3 extends ClarionWindow
{
	public int _currentTab=0;
	public int _tab1=0;
	public int _dTLProductNumberPrompt=0;
	public int _dTLProductNumber=0;
	public int _productDescriptionPrompt=0;
	public int _productDescription=0;
	public int _dTLLineNumberPrompt=0;
	public int _dTLLineNumber=0;
	public int _callLookup=0;
	public int _dTLQuantityOrderedPrompt=0;
	public int _dTLQuantityOrdered=0;
	public int _dTLPricePrompt=0;
	public int _dTLPrice=0;
	public int _dTLTaxRatePrompt=0;
	public int _dTLTaxRate=0;
	public int _string3=0;
	public int _dTLDiscountRatePrompt=0;
	public int _dTLDiscountRate=0;
	public int _string4=0;
	public int _dTLBackOrdered=0;
	public int _ok=0;
	public int _help=0;
	public int _cancel=0;
	public QuickWindow_3(ClarionString productDescription)
	{
		this.setText("Update Detail").setAt(null,null,193,119).setFont("MS Sans Serif",8,Color.BLACK,null,null).setCenter().setImmediate().setIcon("NOTE14.ICO").setHelp("~UpdateDetail").setSystem().setGray().setResize().setMDI();
		this.setId("updatedetail.quickwindow");
		SheetControl _C1=new SheetControl();
		_C1.setWizard().setAt(3,2,187,116);
		this._currentTab=this.register(_C1,"updatedetail.quickwindow.currenttab");
		this.add(_C1);
		TabControl _C2=new TabControl();
		_C2.setText("Tab 1");
		this._tab1=this.register(_C2,"updatedetail.quickwindow.tab1");
		_C1.add(_C2);
		PromptControl _C3=new PromptControl();
		_C3.setText("Product Number:").setAt(7,21,null,null);
		this._dTLProductNumberPrompt=this.register(_C3,"updatedetail.quickwindow.dtl:productnumber:prompt");
		_C2.add(_C3);
		EntryControl _C4=new EntryControl();
		_C4.setPicture("@n07").setAt(66,21,33,10).setMsg("Product Identification Number");
		this._dTLProductNumber=this.register(_C4.use(Main.detail.productNumber),"updatedetail.quickwindow.dtl:productnumber");
		_C2.add(_C4);
		PromptControl _C5=new PromptControl();
		_C5.setText("Description:").setAt(7,35,null,null);
		this._productDescriptionPrompt=this.register(_C5,"updatedetail.quickwindow.productdescription:prompt");
		_C2.add(_C5);
		StringControl _C6=new StringControl();
		_C6.setPicture("@s35").setAt(66,35,119,10);
		this._productDescription=this.register(_C6.use(productDescription),"updatedetail.quickwindow.productdescription");
		_C2.add(_C6);
		PromptControl _C7=new PromptControl();
		_C7.setText("Line Number:").setAt(7,7,null,null);
		this._dTLLineNumberPrompt=this.register(_C7,"updatedetail.quickwindow.dtl:linenumber:prompt");
		this.add(_C7);
		StringControl _C8=new StringControl();
		_C8.setPicture("@n04").setAt(66,7,29,10);
		this._dTLLineNumber=this.register(_C8.use(Main.detail.lineNumber),"updatedetail.quickwindow.dtl:linenumber");
		this.add(_C8);
		ButtonControl _C9=new ButtonControl();
		_C9.setIcon(Icon.NONE).setText("Select Product").setAt(112,17,68,14).setImmediate().setFont("MS Serif",8,Color.NAVY,Font.BOLD,null);
		this._callLookup=this.register(_C9,"updatedetail.quickwindow.calllookup");
		this.add(_C9);
		PromptControl _C10=new PromptControl();
		_C10.setText("Quantity Ordered:").setAt(7,48,null,null);
		this._dTLQuantityOrderedPrompt=this.register(_C10,"updatedetail.quickwindow.dtl:quantityordered:prompt");
		this.add(_C10);
		SpinControl _C11=new SpinControl();
		_C11.setRange(1,99999).setPicture("@n9.2B").setAt(65,48,33,10).setMsg("Quantity of product ordered");
		this._dTLQuantityOrdered=this.register(_C11.use(Main.detail.quantityOrdered),"updatedetail.quickwindow.dtl:quantityordered");
		this.add(_C11);
		PromptControl _C12=new PromptControl();
		_C12.setText("Price:").setAt(117,48,19,10);
		this._dTLPricePrompt=this.register(_C12,"updatedetail.quickwindow.dtl:price:prompt");
		this.add(_C12);
		StringControl _C13=new StringControl();
		_C13.setPicture("@n$10.2B").setAt(136,48,41,10);
		this._dTLPrice=this.register(_C13.use(Main.detail.price),"updatedetail.quickwindow.dtl:price");
		this.add(_C13);
		PromptControl _C14=new PromptControl();
		_C14.setText("Tax Rate:").setAt(7,62,null,null);
		this._dTLTaxRatePrompt=this.register(_C14,"updatedetail.quickwindow.dtl:taxrate:prompt");
		this.add(_C14);
		EntryControl _C15=new EntryControl();
		_C15.setPicture("@n7.4B").setAt(65,62,33,10).setMsg("Enter Consumer's Tax rate");
		this._dTLTaxRate=this.register(_C15.use(Main.detail.taxRate),"updatedetail.quickwindow.dtl:taxrate");
		this.add(_C15);
		StringControl _C16=new StringControl();
		_C16.setText("%").setAt(99,61,13,10).setFont("MS Sans Serif",11,null,Font.BOLD,null);
		this._string3=this.register(_C16,"updatedetail.quickwindow.string3");
		this.add(_C16);
		PromptControl _C17=new PromptControl();
		_C17.setText("Discount Rate:").setAt(7,77,null,null);
		this._dTLDiscountRatePrompt=this.register(_C17,"updatedetail.quickwindow.dtl:discountrate:prompt");
		this.add(_C17);
		EntryControl _C18=new EntryControl();
		_C18.setPicture("@n7.4B").setAt(65,77,33,10).setMsg("Enter discount rate");
		this._dTLDiscountRate=this.register(_C18.use(Main.detail.discountRate),"updatedetail.quickwindow.dtl:discountrate");
		this.add(_C18);
		StringControl _C19=new StringControl();
		_C19.setText("%").setAt(99,77,13,10).setFont("MS Sans Serif",11,null,Font.BOLD,null);
		this._string4=this.register(_C19,"updatedetail.quickwindow.string4");
		this.add(_C19);
		CheckControl _C20=new CheckControl();
		_C20.setText("Back Ordered").setAt(117,62,null,null).setDisabled().setColor(Color.SILVER,null,null).setMsg("Product is on back order");
		this._dTLBackOrdered=this.register(_C20.use(Main.detail.backOrdered),"updatedetail.quickwindow.dtl:backordered");
		this.add(_C20);
		ButtonControl _C21=new ButtonControl();
		_C21.setFlat().setIcon("DISK12.ICO").setDefault().setAt(53,95,22,20).setTip("Save record and Exit");
		this._ok=this.register(_C21,"updatedetail.quickwindow.ok");
		this.add(_C21);
		ButtonControl _C22=new ButtonControl();
		_C22.setFlat().setIcon(Icon.HELP).setAt(86,100,13,12).setHidden().setTip("Get Help").setStandard(Std.HELP);
		this._help=this.register(_C22,"updatedetail.quickwindow.help");
		this.add(_C22);
		ButtonControl _C23=new ButtonControl();
		_C23.setFlat().setIcon(Icon.CROSS).setAt(110,95,22,20).setMsg("Cancel changes and Exit").setTip("Cancel changes and Exit");
		this._cancel=this.register(_C23,"updatedetail.quickwindow.cancel");
		this.add(_C23);
	}
}
