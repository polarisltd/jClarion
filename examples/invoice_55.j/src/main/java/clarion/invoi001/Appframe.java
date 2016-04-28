package clarion.invoi001;

import clarion.equates.Constants;
import clarion.equates.Icon;
import clarion.equates.Std;
import org.jclarion.clarion.ClarionApplication;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.ItemControl;
import org.jclarion.clarion.control.MenuControl;
import org.jclarion.clarion.control.MenubarControl;
import org.jclarion.clarion.control.SeparatorControl;
import org.jclarion.clarion.control.ToolbarControl;

@SuppressWarnings("all")
public class Appframe extends ClarionApplication
{
	public int _printsetup=0;
	public int _exit=0;
	public int _cut=0;
	public int _copy=0;
	public int _paste=0;
	public int _browsecustomers=0;
	public int _browseallorders=0;
	public int _browseproducts=0;
	public int _reportmenu=0;
	public int _reportsprintinvoice=0;
	public int _reportsprintmailinglabels=0;
	public int _printproKeyproductsku=0;
	public int _printcusStatekey=0;
	public int _maintenance=0;
	public int _updatecompanyfile=0;
	public int _tile=0;
	public int _cascade=0;
	public int _arrange=0;
	public int _helpindex=0;
	public int _helpsearch=0;
	public int _helponhelp=0;
	public int _helpabout=0;
	public int _exit_2=0;
	public int _ordbutton=0;
	public int _probutton=0;
	public int _cusbutton=0;
	public int _toolbarHelp=0;
	public int _c5rwbutton=0;
	public int _toolbarHistory=0;
	public int _toolbarDelete=0;
	public int _toolbarChange=0;
	public int _toolbarInsert=0;
	public int _toolbarSelect=0;
	public int _toolbarBottom=0;
	public int _toolbarPagedown=0;
	public int _toolbarDown=0;
	public int _toolbarLocate=0;
	public int _toolbarUp=0;
	public int _toolbarPageup=0;
	public int _toolbarTop=0;
	public Appframe()
	{
		this.setText("Order Entry & Invoice Manager").setAt(null,null,437,327).setFont("MS Sans Serif",8,null,null,null).setIcon("ORDER.ICO").setHelp("~MainToolBar").setAlrt(Constants.F3KEY).setAlrt(Constants.F4KEY).setAlrt(Constants.F5KEY).setStatus(-1,80,120,45).setTiled().setSystem().setMax().setMaximize().setResize().setImmediate();
		this.setId("main.appframe");
		MenubarControl _C1=new MenubarControl();
		this.add(_C1);
		MenuControl _C2=new MenuControl();
		_C2.setText("&File");
		_C1.add(_C2);
		ItemControl _C3=new ItemControl();
		_C3.setText("&Print Setup ...").setMsg("Setup printer").setStandard(Std.PRINTSETUP);
		this._printsetup=this.register(_C3,"main.appframe.printsetup");
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
		_C11.setText("Customer's Information").setMsg("Browse Customer's Information");
		this._browsecustomers=this.register(_C11,"main.appframe.browsecustomers");
		_C10.add(_C11);
		ItemControl _C12=new ItemControl();
		_C12.setText("All Customer's Orders").setMsg("Browse All Orders");
		this._browseallorders=this.register(_C12,"main.appframe.browseallorders");
		_C10.add(_C12);
		ItemControl _C13=new ItemControl();
		_C13.setText("Product's Information").setMsg("Browse Product's Information");
		this._browseproducts=this.register(_C13,"main.appframe.browseproducts");
		_C10.add(_C13);
		MenuControl _C14=new MenuControl();
		_C14.setText("&Reports").setMsg("Report data");
		this._reportmenu=this.register(_C14,"main.appframe.reportmenu");
		_C1.add(_C14);
		ItemControl _C15=new ItemControl();
		_C15.setText("Print Invoice").setMsg("Print Customer's Invoice");
		this._reportsprintinvoice=this.register(_C15,"main.appframe.reportsprintinvoice");
		_C14.add(_C15);
		ItemControl _C16=new ItemControl();
		_C16.setText("Print Mailing Labels").setMsg("Print mailing labels for customer's");
		this._reportsprintmailinglabels=this.register(_C16,"main.appframe.reportsprintmailinglabels");
		_C14.add(_C16);
		ItemControl _C17=new ItemControl();
		_C17.setText("Print Products Information").setMsg("Print ordered by the PRO:KeyProductSKU key");
		this._printproKeyproductsku=this.register(_C17,"main.appframe.printpro:keyproductsku");
		_C14.add(_C17);
		ItemControl _C18=new ItemControl();
		_C18.setText("Print Customer's Information").setMsg("Print ordered by the CUS:Statekey");
		this._printcusStatekey=this.register(_C18,"main.appframe.printcus:statekey");
		_C14.add(_C18);
		MenuControl _C19=new MenuControl();
		_C19.setText("&Maintenance");
		this._maintenance=this.register(_C19,"main.appframe.maintenance");
		_C1.add(_C19);
		ItemControl _C20=new ItemControl();
		_C20.setText("&Update Company File");
		this._updatecompanyfile=this.register(_C20,"main.appframe.updatecompanyfile");
		_C19.add(_C20);
		MenuControl _C21=new MenuControl();
		_C21.setText("&Window").setMsg("Create and Arrange windows").setStandard(Std.WINDOWLIST);
		_C1.add(_C21);
		ItemControl _C22=new ItemControl();
		_C22.setText("T&ile").setMsg("Make all open windows visible").setStandard(Std.TILEWINDOW);
		this._tile=this.register(_C22,"main.appframe.tile");
		_C21.add(_C22);
		ItemControl _C23=new ItemControl();
		_C23.setText("&Cascade").setMsg("Stack all open windows").setStandard(Std.CASCADEWINDOW);
		this._cascade=this.register(_C23,"main.appframe.cascade");
		_C21.add(_C23);
		ItemControl _C24=new ItemControl();
		_C24.setText("&Arrange Icons").setMsg("Align all window icons").setStandard(Std.ARRANGEICONS);
		this._arrange=this.register(_C24,"main.appframe.arrange");
		_C21.add(_C24);
		MenuControl _C25=new MenuControl();
		_C25.setText("&Help").setMsg("Windows Help");
		_C1.add(_C25);
		ItemControl _C26=new ItemControl();
		_C26.setText("&Contents").setMsg("View the contents of the help file").setStandard(Std.HELPINDEX);
		this._helpindex=this.register(_C26,"main.appframe.helpindex");
		_C25.add(_C26);
		ItemControl _C27=new ItemControl();
		_C27.setText("&Search for Help On...").setMsg("Search for help on a subject").setStandard(Std.HELPSEARCH);
		this._helpsearch=this.register(_C27,"main.appframe.helpsearch");
		_C25.add(_C27);
		ItemControl _C28=new ItemControl();
		_C28.setText("&How to Use Help").setMsg("How to use Windows Help").setStandard(Std.HELPONHELP);
		this._helponhelp=this.register(_C28,"main.appframe.helponhelp");
		_C25.add(_C28);
		SeparatorControl _C29=new SeparatorControl();
		_C25.add(_C29);
		ItemControl _C30=new ItemControl();
		_C30.setText("&About Order-Entry Invoice System...").setMsg("Information about the Author");
		this._helpabout=this.register(_C30,"main.appframe.helpabout");
		_C25.add(_C30);
		ToolbarControl _C31=new ToolbarControl();
		_C31.setAt(0,0,400,19);
		this.add(_C31);
		ButtonControl _C32=new ButtonControl();
		_C32.setIcon("EXITS.ICO").setFlat().setAt(294,2,16,14).setTip("Exit Application").setStandard(Std.CLOSE);
		this._exit_2=this.register(_C32,"main.appframe.exit:2");
		_C31.add(_C32);
		ButtonControl _C33=new ButtonControl();
		_C33.setIcon("BOOKS.ICO").setFlat().setAt(19,2,16,14).setTip("Browse All Customer's Orders");
		this._ordbutton=this.register(_C33,"main.appframe.ordbutton");
		_C31.add(_C33);
		ButtonControl _C34=new ButtonControl();
		_C34.setIcon("FLOW04.ICO").setFlat().setAt(35,2,16,14).setTip("Browse Products Information");
		this._probutton=this.register(_C34,"main.appframe.probutton");
		_C31.add(_C34);
		ButtonControl _C35=new ButtonControl();
		_C35.setIcon("CUSTOMER.ICO").setFlat().setAt(3,2,16,14).setMsg("Browse Customer Information").setTip("Browse Customer Information");
		this._cusbutton=this.register(_C35,"main.appframe.cusbutton");
		_C31.add(_C35);
		ButtonControl _C36=new ButtonControl();
		_C36.setIcon("HELP.ICO").setFlat().setAt(256,2,16,14).setDisabled().setTip("Get Help");
		this._toolbarHelp=this.register(_C36,"main.appframe.toolbar:help");
		_C31.add(_C36);
		ButtonControl _C37=new ButtonControl();
		_C37.setFlat().setIcon(Icon.PRINT1).setAt(276,2,16,14).setTip("Print C5RW report of All Invoices");
		this._c5rwbutton=this.register(_C37,"main.appframe.c5rwbutton");
		_C31.add(_C37);
		ButtonControl _C38=new ButtonControl();
		_C38.setIcon("DITTO.ICO").setFlat().setAt(240,2,16,14).setDisabled().setTip("Previous value");
		this._toolbarHistory=this.register(_C38,"main.appframe.toolbar:history");
		_C31.add(_C38);
		ButtonControl _C39=new ButtonControl();
		_C39.setIcon("DELETE.ICO").setFlat().setAt(220,2,16,14).setDisabled().setTip("Delete This Record");
		this._toolbarDelete=this.register(_C39,"main.appframe.toolbar:delete");
		_C31.add(_C39);
		ButtonControl _C40=new ButtonControl();
		_C40.setIcon("EDIT.ICO").setFlat().setAt(204,2,16,14).setDisabled().setTip("Edit This Record");
		this._toolbarChange=this.register(_C40,"main.appframe.toolbar:change");
		_C31.add(_C40);
		ButtonControl _C41=new ButtonControl();
		_C41.setIcon("INSERT.ICO").setFlat().setAt(188,2,16,14).setDisabled().setTip("Insert a New Record");
		this._toolbarInsert=this.register(_C41,"main.appframe.toolbar:insert");
		_C31.add(_C41);
		ButtonControl _C42=new ButtonControl();
		_C42.setIcon("MARK.ICO").setFlat().setAt(172,2,16,14).setDisabled().setTip("Select This Record");
		this._toolbarSelect=this.register(_C42,"main.appframe.toolbar:select");
		_C31.add(_C42);
		ButtonControl _C43=new ButtonControl();
		_C43.setIcon("VCRLAST.ICO").setFlat().setAt(152,2,16,14).setDisabled().setTip("Go to the Last Page");
		this._toolbarBottom=this.register(_C43,"main.appframe.toolbar:bottom");
		_C31.add(_C43);
		ButtonControl _C44=new ButtonControl();
		_C44.setIcon("VCRNEXT.ICO").setFlat().setAt(136,2,16,14).setDisabled().setTip("Go to the Next Page");
		this._toolbarPagedown=this.register(_C44,"main.appframe.toolbar:pagedown");
		_C31.add(_C44);
		ButtonControl _C45=new ButtonControl();
		_C45.setIcon("VCRDOWN.ICO").setFlat().setAt(120,2,16,14).setDisabled().setTip("Go to the Next Record");
		this._toolbarDown=this.register(_C45,"main.appframe.toolbar:down");
		_C31.add(_C45);
		ButtonControl _C46=new ButtonControl();
		_C46.setIcon("FIND.ICO").setFlat().setAt(104,2,16,14).setDisabled().setTip("Locate record");
		this._toolbarLocate=this.register(_C46,"main.appframe.toolbar:locate");
		_C31.add(_C46);
		ButtonControl _C47=new ButtonControl();
		_C47.setIcon("VCRUP.ICO").setFlat().setAt(88,2,16,14).setDisabled().setTip("Go to the Prior Record");
		this._toolbarUp=this.register(_C47,"main.appframe.toolbar:up");
		_C31.add(_C47);
		ButtonControl _C48=new ButtonControl();
		_C48.setIcon("VCRPRIOR.ICO").setFlat().setAt(72,2,16,14).setDisabled().setTip("Go to the Prior Page");
		this._toolbarPageup=this.register(_C48,"main.appframe.toolbar:pageup");
		_C31.add(_C48);
		ButtonControl _C49=new ButtonControl();
		_C49.setIcon("VCRFIRST.ICO").setFlat().setAt(56,2,16,14).setDisabled().setTip("Go to the First Page");
		this._toolbarTop=this.register(_C49,"main.appframe.toolbar:top");
		_C31.add(_C49);
	}
}