package clarion;

import clarion.Main;
import clarion.equates.Color;
import clarion.equates.Icon;
import clarion.equates.Std;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.EntryControl;
import org.jclarion.clarion.control.ListControl;
import org.jclarion.clarion.control.PromptControl;
import org.jclarion.clarion.control.SheetControl;
import org.jclarion.clarion.control.TabControl;

public class QuickWindow_1 extends ClarionWindow
{
	public int _currentTab=0;
	public int _tab1=0;
	public int _cUSCompanyPrompt=0;
	public int _cUSCompany=0;
	public int _cUSFirstNamePrompt=0;
	public int _cUSFirstName=0;
	public int _cUSMIPrompt=0;
	public int _cusMi=0;
	public int _cUSLastNamePrompt=0;
	public int _cUSLastName=0;
	public int _cUSAddress1Prompt=0;
	public int _cUSAddress1=0;
	public int _cUSAddress2Prompt=0;
	public int _cUSAddress2=0;
	public int _cUSCityPrompt=0;
	public int _cUSCity=0;
	public int _cUSStatePrompt=0;
	public int _cUSState=0;
	public int _cUSZipCodePrompt=0;
	public int _cUSZipCode=0;
	public int _cUSPhoneNumberPrompt=0;
	public int _cUSPhoneNumber=0;
	public int _cUSExtensionPrompt=0;
	public int _cUSExtension=0;
	public int _cUSPhoneTypePrompt=0;
	public int _cUSPhoneType=0;
	public int _ok=0;
	public int _help=0;
	public int _cancel=0;
	public QuickWindow_1()
	{
		this.setText("Update Customers").setAt(null,null,214,191).setFont("MS Sans Serif",8,Color.BLACK,null,null).setCenter().setImmediate().setIcon("CUSTOMER.ICO").setHelp("~UpdateCustomers").setSystem().setGray().setResize().setMDI();
		this.setId("updatecustomers.quickwindow");
		SheetControl _C1=new SheetControl();
		_C1.setWizard().setAt(2,2,211,188);
		this._currentTab=this.register(_C1,"updatecustomers.quickwindow.currenttab");
		this.add(_C1);
		TabControl _C2=new TabControl();
		_C2.setText("Tab 1");
		this._tab1=this.register(_C2,"updatecustomers.quickwindow.tab1");
		_C1.add(_C2);
		PromptControl _C3=new PromptControl();
		_C3.setText("&Company:").setAt(8,9,null,null);
		this._cUSCompanyPrompt=this.register(_C3,"updatecustomers.quickwindow.cus:company:prompt");
		this.add(_C3);
		EntryControl _C4=new EntryControl();
		_C4.setCapitalise().setPicture("@s20").setAt(64,9,84,10).setMsg("Enter the customer's company");
		this._cUSCompany=this.register(_C4.use(Main.customers.company),"updatecustomers.quickwindow.cus:company");
		this.add(_C4);
		PromptControl _C5=new PromptControl();
		_C5.setText("&First Name:").setAt(8,23,null,null);
		this._cUSFirstNamePrompt=this.register(_C5,"updatecustomers.quickwindow.cus:firstname:prompt");
		this.add(_C5);
		EntryControl _C6=new EntryControl();
		_C6.setRequired().setCapitalise().setPicture("@s20").setAt(64,23,84,10).setMsg("Enter the first name of customer");
		this._cUSFirstName=this.register(_C6.use(Main.customers.firstName),"updatecustomers.quickwindow.cus:firstname");
		this.add(_C6);
		PromptControl _C7=new PromptControl();
		_C7.setText("MI:").setAt(8,37,23,10);
		this._cUSMIPrompt=this.register(_C7,"updatecustomers.quickwindow.cus:mi:prompt");
		this.add(_C7);
		EntryControl _C8=new EntryControl();
		_C8.setUpper().setPicture("@s1").setAt(64,37,21,10).setMsg("Enter the middle initial of customer");
		this._cusMi=this.register(_C8.use(Main.customers.mi),"updatecustomers.quickwindow.cus:mi");
		this.add(_C8);
		PromptControl _C9=new PromptControl();
		_C9.setText("&Last Name:").setAt(8,51,null,null);
		this._cUSLastNamePrompt=this.register(_C9,"updatecustomers.quickwindow.cus:lastname:prompt");
		this.add(_C9);
		EntryControl _C10=new EntryControl();
		_C10.setRequired().setCapitalise().setPicture("@s25").setAt(64,51,104,10).setMsg("Enter the last name of customer");
		this._cUSLastName=this.register(_C10.use(Main.customers.lastName),"updatecustomers.quickwindow.cus:lastname");
		this.add(_C10);
		PromptControl _C11=new PromptControl();
		_C11.setText("&Address1:").setAt(8,65,null,null);
		this._cUSAddress1Prompt=this.register(_C11,"updatecustomers.quickwindow.cus:address1:prompt");
		this.add(_C11);
		EntryControl _C12=new EntryControl();
		_C12.setCapitalise().setPicture("@s35").setAt(64,65,139,10).setMsg("Enter the first line address of customer");
		this._cUSAddress1=this.register(_C12.use(Main.customers.address1),"updatecustomers.quickwindow.cus:address1");
		this.add(_C12);
		PromptControl _C13=new PromptControl();
		_C13.setText("Address2:").setAt(8,79,null,null);
		this._cUSAddress2Prompt=this.register(_C13,"updatecustomers.quickwindow.cus:address2:prompt");
		this.add(_C13);
		EntryControl _C14=new EntryControl();
		_C14.setCapitalise().setPicture("@s35").setAt(64,79,139,10).setMsg("Enter the second line address of customer if any");
		this._cUSAddress2=this.register(_C14.use(Main.customers.address2),"updatecustomers.quickwindow.cus:address2");
		this.add(_C14);
		PromptControl _C15=new PromptControl();
		_C15.setText("&City:").setAt(8,93,null,null);
		this._cUSCityPrompt=this.register(_C15,"updatecustomers.quickwindow.cus:city:prompt");
		this.add(_C15);
		EntryControl _C16=new EntryControl();
		_C16.setCapitalise().setPicture("@s25").setAt(64,93,104,10).setMsg("Enter  city of customer");
		this._cUSCity=this.register(_C16.use(Main.customers.city),"updatecustomers.quickwindow.cus:city");
		this.add(_C16);
		PromptControl _C17=new PromptControl();
		_C17.setText("&State:").setAt(8,108,null,null);
		this._cUSStatePrompt=this.register(_C17,"updatecustomers.quickwindow.cus:state:prompt");
		this.add(_C17);
		EntryControl _C18=new EntryControl();
		_C18.setUpper().setPicture("@s2").setAt(64,108,22,10).setMsg("Enter state of customer");
		this._cUSState=this.register(_C18.use(Main.customers.state),"updatecustomers.quickwindow.cus:state");
		this.add(_C18);
		PromptControl _C19=new PromptControl();
		_C19.setText("&Zip Code:").setAt(8,122,null,null);
		this._cUSZipCodePrompt=this.register(_C19,"updatecustomers.quickwindow.cus:zipcode:prompt");
		this.add(_C19);
		EntryControl _C20=new EntryControl();
		_C20.setPicture("@K#####|-####KB").setAt(64,122,69,10).setMsg("Enter zipcode of customer").setTip("Enter zipcode of customer");
		this._cUSZipCode=this.register(_C20.use(Main.customers.zipCode),"updatecustomers.quickwindow.cus:zipcode");
		this.add(_C20);
		PromptControl _C21=new PromptControl();
		_C21.setText("Phone Number:").setAt(8,136,null,null);
		this._cUSPhoneNumberPrompt=this.register(_C21,"updatecustomers.quickwindow.cus:phonenumber:prompt");
		this.add(_C21);
		EntryControl _C22=new EntryControl();
		_C22.setPicture("@P(###) ###-####PB").setAt(64,136,68,10).setMsg("Customer's phone number");
		this._cUSPhoneNumber=this.register(_C22.use(Main.customers.phoneNumber),"updatecustomers.quickwindow.cus:phonenumber");
		this.add(_C22);
		PromptControl _C23=new PromptControl();
		_C23.setText("Extension:").setAt(8,150,null,null);
		this._cUSExtensionPrompt=this.register(_C23,"updatecustomers.quickwindow.cus:extension:prompt");
		this.add(_C23);
		EntryControl _C24=new EntryControl();
		_C24.setPicture("@P<<<#PB").setAt(64,150,24,10).setMsg("Enter customer's phone extension");
		this._cUSExtension=this.register(_C24.use(Main.customers.extension),"updatecustomers.quickwindow.cus:extension");
		this.add(_C24);
		PromptControl _C25=new PromptControl();
		_C25.setText("Phone Type:").setAt(109,150,43,10);
		this._cUSPhoneTypePrompt=this.register(_C25,"updatecustomers.quickwindow.cus:phonetype:prompt");
		this.add(_C25);
		ListControl _C26=new ListControl();
		_C26.setDrop(5).setFrom("Home|Work|Cellular|Pager|Fax|Other").setAt(158,150,44,10).setMsg("Enter customer's phone type");
		this._cUSPhoneType=this.register(_C26.use(Main.customers.phoneType),"updatecustomers.quickwindow.cus:phonetype");
		this.add(_C26);
		ButtonControl _C27=new ButtonControl();
		_C27.setFlat().setIcon("DISK12.ICO").setDefault().setAt(70,167,21,20).setMsg("Save recod and Exit").setTip("Save recod and Exit");
		this._ok=this.register(_C27,"updatecustomers.quickwindow.ok");
		this.add(_C27);
		ButtonControl _C28=new ButtonControl();
		_C28.setFlat().setIcon(Icon.HELP).setAt(103,171,13,12).setHidden().setTip("Get Help").setStandard(Std.HELP);
		this._help=this.register(_C28,"updatecustomers.quickwindow.help");
		this.add(_C28);
		ButtonControl _C29=new ButtonControl();
		_C29.setFlat().setIcon(Icon.CROSS).setAt(125,167,21,20).setMsg("Cancels change and Exit").setTip("Cancels change and Exit");
		this._cancel=this.register(_C29,"updatecustomers.quickwindow.cancel");
		this.add(_C29);
	}
}
