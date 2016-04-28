package clarion;

import clarion.equates.Font;
import clarion.equates.Icon;
import clarion.equates.Std;
import org.jclarion.clarion.ClarionApplication;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.ItemControl;
import org.jclarion.clarion.control.MenuControl;
import org.jclarion.clarion.control.MenubarControl;
import org.jclarion.clarion.control.SeparatorControl;
import org.jclarion.clarion.control.ToolbarControl;

public class AppFrame extends ClarionApplication
{
	public int _printSetup=0;
	public int _exit=0;
	public int _cut=0;
	public int _copy=0;
	public int _paste=0;
	public int _browseAccounts=0;
	public int _reportMenu=0;
	public int _printACCCreditCardVendorKey=0;
	public int _tile=0;
	public int _cascade=0;
	public int _arrange=0;
	public int _helpSearch=0;
	public int _helpOnHelp=0;
	public int _aboutAuthor=0;
	public int _button1=0;
	public int _toolbarTop=0;
	public int _toolbarPageUp=0;
	public int _toolbarUp=0;
	public int _toolbarLocate=0;
	public int _toolbarDown=0;
	public int _toolbarPageDown=0;
	public int _toolbarBottom=0;
	public int _toolbarSelect=0;
	public int _toolbarInsert=0;
	public int _toolbarChange=0;
	public int _toolbarDelete=0;
	public int _toolbarHistory=0;
	public int _toolbarHelp=0;
	public int _buttonPay=0;
	public int _buttonHistory=0;
	public int _buttonCurrent=0;
	public int _button17=0;
	public int _buttonPrint=0;
	public int _button16=0;
	public int _button2=0;
	public AppFrame()
	{
		this.setText("Credit Card Registry & Transaction Log").setAt(null,null,400,246).setFont("MS Sans Serif",8,null,null,null).setIcon("CREDCARD.ICO").setHelp("~CardRegMainWindow").setStatus(-1,80,120,45).setTiled().setSystem().setMax().setResize().setImmediate();
		this.setId("main.appframe");
		MenubarControl _C1=new MenubarControl();
		this.add(_C1);
		MenuControl _C2=new MenuControl();
		_C2.setText("&File");
		_C1.add(_C2);
		ItemControl _C3=new ItemControl();
		_C3.setText("&Print Setup ...").setMsg("Setup printer").setStandard(Std.PRINTSETUP);
		this._printSetup=this.register(_C3,"main.appframe.printsetup");
		_C2.add(_C3);
		SeparatorControl _C4=new SeparatorControl();
		_C2.add(_C4);
		ItemControl _C5=new ItemControl();
		_C5.setText("E&xit").setMsg("Exit this application").setStandard(Std.CLOSE);
		this._exit=this.register(_C5,"main.appframe.exit");
		_C2.add(_C5);
		MenuControl _C6=new MenuControl();
		_C6.setText("&Edit");
		_C1.add(_C6);
		ItemControl _C7=new ItemControl();
		_C7.setText("Cu&t").setMsg("Remove item to Windows Clipboard").setStandard(Std.CUT);
		this._cut=this.register(_C7,"main.appframe.cut");
		_C6.add(_C7);
		ItemControl _C8=new ItemControl();
		_C8.setText("&Copy").setMsg("Copy item to Windows Clipboard").setStandard(Std.COPY);
		this._copy=this.register(_C8,"main.appframe.copy");
		_C6.add(_C8);
		ItemControl _C9=new ItemControl();
		_C9.setText("&Paste").setMsg("Paste contents of Windows Clipboard").setStandard(Std.PASTE);
		this._paste=this.register(_C9,"main.appframe.paste");
		_C6.add(_C9);
		MenuControl _C10=new MenuControl();
		_C10.setText("&Browse");
		_C1.add(_C10);
		ItemControl _C11=new ItemControl();
		_C11.setText("Browse the &Accounts file").setMsg("Browse Accounts");
		this._browseAccounts=this.register(_C11,"main.appframe.browseaccounts");
		_C10.add(_C11);
		MenuControl _C12=new MenuControl();
		_C12.setText("&Reports").setMsg("Report data");
		this._reportMenu=this.register(_C12,"main.appframe.reportmenu");
		_C1.add(_C12);
		ItemControl _C13=new ItemControl();
		_C13.setText("Print All Credit Card Account &Information").setMsg("Print Credit Card Vendors and Information");
		this._printACCCreditCardVendorKey=this.register(_C13,"main.appframe.printacc:creditcardvendorkey");
		_C12.add(_C13);
		MenuControl _C14=new MenuControl();
		_C14.setText("&Window").setMsg("Create and Arrange windows").setStandard(Std.WINDOWLIST);
		_C1.add(_C14);
		ItemControl _C15=new ItemControl();
		_C15.setText("T&ile").setMsg("Make all open windows visible").setStandard(Std.TILEWINDOW);
		this._tile=this.register(_C15,"main.appframe.tile");
		_C14.add(_C15);
		ItemControl _C16=new ItemControl();
		_C16.setText("&Cascade").setMsg("Stack all open windows").setStandard(Std.CASCADEWINDOW);
		this._cascade=this.register(_C16,"main.appframe.cascade");
		_C14.add(_C16);
		ItemControl _C17=new ItemControl();
		_C17.setText("&Arrange Icons").setMsg("Align all window icons").setStandard(Std.ARRANGEICONS);
		this._arrange=this.register(_C17,"main.appframe.arrange");
		_C14.add(_C17);
		MenuControl _C18=new MenuControl();
		_C18.setText("&Help").setMsg("Windows Help");
		_C1.add(_C18);
		ItemControl _C19=new ItemControl();
		_C19.setText("&Search for Help On...").setMsg("Search for help on a subject").setStandard(Std.HELPSEARCH);
		this._helpSearch=this.register(_C19,"main.appframe.helpsearch");
		_C18.add(_C19);
		ItemControl _C20=new ItemControl();
		_C20.setText("&How to Use Help").setMsg("How to use Windows Help").setStandard(Std.HELPONHELP);
		this._helpOnHelp=this.register(_C20,"main.appframe.helponhelp");
		_C18.add(_C20);
		ItemControl _C21=new ItemControl();
		_C21.setText("&About Credit Card Registry...").setMsg("About the Author");
		this._aboutAuthor=this.register(_C21,"main.appframe.aboutauthor");
		_C18.add(_C21);
		ToolbarControl _C22=new ToolbarControl();
		_C22.setAt(0,0,399,18);
		this.add(_C22);
		ButtonControl _C23=new ButtonControl();
		_C23.setIcon("$.ICO").setFlat().setAt(28,2,16,14).setRight(null).setFont(null,null,null,Font.BOLD,null).setTip("Browse All Credit Card Accounts");
		this._button1=this.register(_C23,"main.appframe.button1");
		_C22.add(_C23);
		ButtonControl _C24=new ButtonControl();
		_C24.setIcon("VCRFIRST.ICO").setFlat().setAt(173,2,16,14).setDisabled().setTip("Go to the First Page");
		this._toolbarTop=this.register(_C24,"main.appframe.toolbar:top");
		_C22.add(_C24);
		ButtonControl _C25=new ButtonControl();
		_C25.setIcon("VCRPRIOR.ICO").setFlat().setAt(189,2,16,14).setDisabled().setTip("Go to the Prior Page");
		this._toolbarPageUp=this.register(_C25,"main.appframe.toolbar:pageup");
		_C22.add(_C25);
		ButtonControl _C26=new ButtonControl();
		_C26.setIcon("VCRUP.ICO").setFlat().setAt(205,2,16,14).setDisabled().setTip("Go to the Prior Record");
		this._toolbarUp=this.register(_C26,"main.appframe.toolbar:up");
		_C22.add(_C26);
		ButtonControl _C27=new ButtonControl();
		_C27.setIcon("FIND.ICO").setFlat().setAt(221,2,16,14).setDisabled().setTip("Locate record");
		this._toolbarLocate=this.register(_C27,"main.appframe.toolbar:locate");
		_C22.add(_C27);
		ButtonControl _C28=new ButtonControl();
		_C28.setIcon("VCRDOWN.ICO").setFlat().setAt(237,2,16,14).setDisabled().setTip("Go to the Next Record");
		this._toolbarDown=this.register(_C28,"main.appframe.toolbar:down");
		_C22.add(_C28);
		ButtonControl _C29=new ButtonControl();
		_C29.setIcon("VCRNEXT.ICO").setFlat().setAt(253,2,16,14).setDisabled().setTip("Go to the Next Page");
		this._toolbarPageDown=this.register(_C29,"main.appframe.toolbar:pagedown");
		_C22.add(_C29);
		ButtonControl _C30=new ButtonControl();
		_C30.setIcon("VCRLAST.ICO").setFlat().setAt(269,2,16,14).setDisabled().setTip("Go to the Last Page");
		this._toolbarBottom=this.register(_C30,"main.appframe.toolbar:bottom");
		_C22.add(_C30);
		ButtonControl _C31=new ButtonControl();
		_C31.setIcon("MARK.ICO").setFlat().setAt(289,2,16,14).setDisabled().setTip("Select This Record");
		this._toolbarSelect=this.register(_C31,"main.appframe.toolbar:select");
		_C22.add(_C31);
		ButtonControl _C32=new ButtonControl();
		_C32.setIcon("INSERT.ICO").setFlat().setAt(305,2,16,14).setDisabled().setTip("Insert a New Record");
		this._toolbarInsert=this.register(_C32,"main.appframe.toolbar:insert");
		_C22.add(_C32);
		ButtonControl _C33=new ButtonControl();
		_C33.setIcon("EDIT.ICO").setFlat().setAt(321,2,16,14).setDisabled().setTip("Edit This Record");
		this._toolbarChange=this.register(_C33,"main.appframe.toolbar:change");
		_C22.add(_C33);
		ButtonControl _C34=new ButtonControl();
		_C34.setIcon("DELETE.ICO").setFlat().setAt(337,2,16,14).setDisabled().setTip("Delete This Record");
		this._toolbarDelete=this.register(_C34,"main.appframe.toolbar:delete");
		_C22.add(_C34);
		ButtonControl _C35=new ButtonControl();
		_C35.setIcon("DITTO.ICO").setFlat().setAt(357,2,16,14).setDisabled().setTip("Previous value");
		this._toolbarHistory=this.register(_C35,"main.appframe.toolbar:history");
		_C22.add(_C35);
		ButtonControl _C36=new ButtonControl();
		_C36.setIcon("HELP.ICO").setFlat().setAt(383,2,16,14).setDisabled().setTip("Get Help");
		this._toolbarHelp=this.register(_C36,"main.appframe.toolbar:help");
		_C22.add(_C36);
		ButtonControl _C37=new ButtonControl();
		_C37.setIcon("PAYCHK2.ICO").setFlat().setAt(107,2,16,14).setTip("Record a Payment for Selected Account");
		this._buttonPay=this.register(_C37,"main.appframe.buttonpay");
		_C22.add(_C37);
		ButtonControl _C38=new ButtonControl();
		_C38.setIcon("HISTORY.ICO").setFlat().setAt(125,2,16,14).setTip("Browse/Update Transaction History for Selected Account");
		this._buttonHistory=this.register(_C38,"main.appframe.buttonhistory");
		_C22.add(_C38);
		ButtonControl _C39=new ButtonControl();
		_C39.setIcon("BOOKS.ICO").setFlat().setAt(90,2,16,14).setTip("Browse/Update Current Transactions for Selected Account");
		this._buttonCurrent=this.register(_C39,"main.appframe.buttoncurrent");
		_C22.add(_C39);
		ButtonControl _C40=new ButtonControl();
		_C40.setIcon("CALC.ICO").setFlat().setAt(146,2,16,14).setTip("Calculator");
		this._button17=this.register(_C40,"main.appframe.button17");
		_C22.add(_C40);
		ButtonControl _C41=new ButtonControl();
		_C41.setIcon(Icon.PRINT).setFlat().setAt(69,2,16,14).setTip("Select a Report to Print");
		this._buttonPrint=this.register(_C41,"main.appframe.buttonprint");
		_C22.add(_C41);
		ButtonControl _C42=new ButtonControl();
		_C42.setIcon("PAPR.ICO").setFlat().setAt(51,2,16,14).setTip("Print Listing of All Credit Card Accounts");
		this._button16=this.register(_C42,"main.appframe.button16");
		_C22.add(_C42);
		ButtonControl _C43=new ButtonControl();
		_C43.setIcon("EXITS.ICO").setFlat().setAt(4,2,16,14).setTip("Exit Credit Card Registry").setStandard(Std.CLOSE);
		this._button2=this.register(_C43,"main.appframe.button2");
		_C22.add(_C43);
	}
}