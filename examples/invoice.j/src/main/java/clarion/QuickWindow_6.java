package clarion;

import clarion.Main;
import clarion.equates.Color;
import clarion.equates.Icon;
import clarion.equates.Std;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.EntryControl;
import org.jclarion.clarion.control.PromptControl;
import org.jclarion.clarion.control.SheetControl;
import org.jclarion.clarion.control.TabControl;

public class QuickWindow_6 extends ClarionWindow
{
	public int _currentTab=0;
	public int _tab1=0;
	public int _cOMNamePrompt=0;
	public int _cOMName=0;
	public int _cOMAddressPrompt=0;
	public int _cOMAddress=0;
	public int _cOMCityPrompt=0;
	public int _cOMCity=0;
	public int _cOMStatePrompt=0;
	public int _cOMState=0;
	public int _cOMZipcodePrompt=0;
	public int _cOMZipcode=0;
	public int _cOMPhonePrompt=0;
	public int _cOMPhone=0;
	public int _ok=0;
	public int _help=0;
	public int _cancel=0;
	public QuickWindow_6()
	{
		this.setText("Update Company").setAt(null,null,199,121).setFont("MS Sans Serif",8,Color.BLACK,null,null).setCenter().setImmediate().setHelp("~UpdateCompany").setSystem().setGray().setResize();
		this.setId("updatecompany.quickwindow");
		SheetControl _C1=new SheetControl();
		_C1.setWizard().setAt(4,2,191,117);
		this._currentTab=this.register(_C1,"updatecompany.quickwindow.currenttab");
		this.add(_C1);
		TabControl _C2=new TabControl();
		_C2.setText("Tab 1");
		this._tab1=this.register(_C2,"updatecompany.quickwindow.tab1");
		_C1.add(_C2);
		PromptControl _C3=new PromptControl();
		_C3.setText("Name:").setAt(8,7,null,null);
		this._cOMNamePrompt=this.register(_C3,"updatecompany.quickwindow.com:name:prompt");
		this.add(_C3);
		EntryControl _C4=new EntryControl();
		_C4.setCapitalise().setPicture("@s20").setAt(49,7,84,10).setMsg("Company name");
		this._cOMName=this.register(_C4.use(Main.company.name),"updatecompany.quickwindow.com:name");
		this.add(_C4);
		PromptControl _C5=new PromptControl();
		_C5.setText("Address:").setAt(8,20,null,null);
		this._cOMAddressPrompt=this.register(_C5,"updatecompany.quickwindow.com:address:prompt");
		this.add(_C5);
		EntryControl _C6=new EntryControl();
		_C6.setCapitalise().setPicture("@s35").setAt(49,20,137,10).setMsg("First line of company's address");
		this._cOMAddress=this.register(_C6.use(Main.company.address),"updatecompany.quickwindow.com:address");
		this.add(_C6);
		PromptControl _C7=new PromptControl();
		_C7.setText("City:").setAt(8,34,17,10);
		this._cOMCityPrompt=this.register(_C7,"updatecompany.quickwindow.com:city:prompt");
		this.add(_C7);
		EntryControl _C8=new EntryControl();
		_C8.setCapitalise().setPicture("@s25").setAt(49,34,104,10).setMsg("Company's city");
		this._cOMCity=this.register(_C8.use(Main.company.city),"updatecompany.quickwindow.com:city");
		this.add(_C8);
		PromptControl _C9=new PromptControl();
		_C9.setText("State:").setAt(8,47,null,null);
		this._cOMStatePrompt=this.register(_C9,"updatecompany.quickwindow.com:state:prompt");
		this.add(_C9);
		EntryControl _C10=new EntryControl();
		_C10.setUpper().setPicture("@s2").setAt(49,47,25,10).setMsg("Company's state");
		this._cOMState=this.register(_C10.use(Main.company.state),"updatecompany.quickwindow.com:state");
		this.add(_C10);
		PromptControl _C11=new PromptControl();
		_C11.setText("Zipcode:").setAt(8,61,null,null);
		this._cOMZipcodePrompt=this.register(_C11,"updatecompany.quickwindow.com:zipcode:prompt");
		this.add(_C11);
		EntryControl _C12=new EntryControl();
		_C12.setPicture("@K#####|-####K").setAt(49,61,64,10).setMsg("Company's zipcode");
		this._cOMZipcode=this.register(_C12.use(Main.company.zipCode),"updatecompany.quickwindow.com:zipcode");
		this.add(_C12);
		PromptControl _C13=new PromptControl();
		_C13.setText("Phone:").setAt(8,74,null,null);
		this._cOMPhonePrompt=this.register(_C13,"updatecompany.quickwindow.com:phone:prompt");
		this.add(_C13);
		EntryControl _C14=new EntryControl();
		_C14.setPicture("@P(###) ###-####P").setAt(49,74,64,10).setMsg("Company's phone number");
		this._cOMPhone=this.register(_C14.use(Main.company.phone),"updatecompany.quickwindow.com:phone");
		this.add(_C14);
		ButtonControl _C15=new ButtonControl();
		_C15.setFlat().setIcon("DISK12.ICO").setDefault().setAt(52,92,21,18).setTip("Save changes and exit");
		this._ok=this.register(_C15,"updatecompany.quickwindow.ok");
		this.add(_C15);
		ButtonControl _C16=new ButtonControl();
		_C16.setFlat().setIcon(Icon.HELP).setAt(88,92,21,18).setTip("Get Help").setStandard(Std.HELP);
		this._help=this.register(_C16,"updatecompany.quickwindow.help");
		this.add(_C16);
		ButtonControl _C17=new ButtonControl();
		_C17.setFlat().setIcon(Icon.CROSS).setAt(124,92,21,18).setTip("Cancel changes and exit ");
		this._cancel=this.register(_C17,"updatecompany.quickwindow.cancel");
		this.add(_C17);
	}
}
