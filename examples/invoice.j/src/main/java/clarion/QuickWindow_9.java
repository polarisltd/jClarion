package clarion;

import clarion.Main;
import clarion.QueueBrowse_1_4;
import clarion.equates.Color;
import clarion.equates.Font;
import clarion.equates.Icon;
import clarion.equates.Std;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.ImageControl;
import org.jclarion.clarion.control.ListControl;
import org.jclarion.clarion.control.SheetControl;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.control.TabControl;

public class QuickWindow_9 extends ClarionWindow
{
	public int _currentTab=0;
	public int _string1=0;
	public int _pRODescription=0;
	public int _string4=0;
	public int _pROProductSKU=0;
	public int _browse_1=0;
	public int _print=0;
	public int _query=0;
	public int _toolbox=0;
	public int _string3=0;
	public int _image1=0;
	public int _insert=0;
	public int _change=0;
	public int _delete=0;
	public int _help=0;
	public int _close=0;
	public QuickWindow_9(QueueBrowse_1_4 queueBrowse_1)
	{
		this.setText("Browse Products ").setAt(null,null,403,180).setFont("MS Sans Serif",8,null,null,null).setCenter().setImmediate().setHVScroll().setIcon("FLOW04.ICO").setHelp("~BrowseProducts").setSystem().setGray().setResize().setMDI();
		this.setId("browseproducts.quickwindow");
		SheetControl _C1=new SheetControl();
		_C1.setAt(4,0,395,177);
		this._currentTab=this.register(_C1,"browseproducts.quickwindow.currenttab");
		this.add(_C1);
		TabControl _C2=new TabControl();
		_C2.setText("Description");
		_C1.add(_C2);
		StringControl _C3=new StringControl();
		_C3.setText("Filter Locator: Description").setAt(9,15,103,11).setFont("MS Sans Serif",8,Color.BLACK,Font.BOLD,null);
		this._string1=this.register(_C3,"browseproducts.quickwindow.string1");
		_C2.add(_C3);
		StringControl _C4=new StringControl();
		_C4.setPicture("@s35").setAt(119,15,113,10).setTransparent().setFont(null,null,Color.MAROON,Font.BOLD,null);
		this._pRODescription=this.register(_C4.use(Main.products.description),"browseproducts.quickwindow.pro:description");
		_C2.add(_C4);
		TabControl _C5=new TabControl();
		_C5.setText("ProductSKU");
		_C1.add(_C5);
		StringControl _C6=new StringControl();
		_C6.setText("Incremental Locator: Product SKU").setAt(11,15,137,10).setFont(null,null,null,Font.BOLD,null);
		this._string4=this.register(_C6,"browseproducts.quickwindow.string4");
		_C5.add(_C6);
		StringControl _C7=new StringControl();
		_C7.setPicture("@s10").setAt(149,15,49,10).setFont(null,null,Color.MAROON,Font.BOLD,null);
		this._pROProductSKU=this.register(_C7.use(Main.products.productSKU),"browseproducts.quickwindow.pro:productsku");
		_C5.add(_C7);
		ListControl _C8=new ListControl();
		_C8.setVScroll().setFormat(ClarionString.staticConcat("93L(2)|M~Description~@s35@45L(3)|M~Product SKU~L(1)@s10@37D(16)|M~Price~L(2)@n$1","0.2B@58D(30)|M~Quantity In Stock~L(1)@n-10.2B@")).setFrom(queueBrowse_1).setAt(10,26,250,132).setImmediate().setMsg("Browsing Records");
		this._browse_1=this.register(_C8,"browseproducts.quickwindow.browse:1");
		this.add(_C8);
		ButtonControl _C9=new ButtonControl();
		_C9.setFlat().setText("&Print").setAt(9,161,39,12).setSkip().setFont(null,null,Color.NAVY,Font.BOLD,null).setTip("Print selected product information");
		this._print=this.register(_C9,"browseproducts.quickwindow.print");
		this.add(_C9);
		ButtonControl _C10=new ButtonControl();
		_C10.setFlat().setText("&Query").setAt(119,161,39,12).setSkip().setFont(null,null,Color.NAVY,Font.BOLD,null).setTip("Query by example");
		this._query=this.register(_C10,"browseproducts.quickwindow.query");
		this.add(_C10);
		ButtonControl _C11=new ButtonControl();
		_C11.setFlat().setText("&Toolbox").setAt(221,161,39,12).setSkip().setFont(null,null,Color.NAVY,Font.BOLD,null).setTip("Floating toolbox");
		this._toolbox=this.register(_C11,"browseproducts.quickwindow.toolbox");
		this.add(_C11);
		StringControl _C12=new StringControl();
		_C12.setText("Double-Click:- Edit-In-Place (Price & Quantity); Toolbar buttons:- Update form.").setAt(95,0,303,12).setCenter(null).setFont(null,null,Color.MAROON,Font.BOLD,null);
		this._string3=this.register(_C12,"browseproducts.quickwindow.string3");
		this.add(_C12);
		ImageControl _C13=new ImageControl();
		_C13.setAt(267,26,123,134);
		this._image1=this.register(_C13,"browseproducts.quickwindow.image1");
		this.add(_C13);
		ButtonControl _C14=new ButtonControl();
		_C14.setText("&Insert").setAt(145,125,28,12).setHidden();
		this._insert=this.register(_C14,"browseproducts.quickwindow.insert");
		this.add(_C14);
		ButtonControl _C15=new ButtonControl();
		_C15.setText("&Change").setAt(187,125,28,12).setHidden();
		this._change=this.register(_C15,"browseproducts.quickwindow.change");
		this.add(_C15);
		ButtonControl _C16=new ButtonControl();
		_C16.setText("&Delete").setAt(21,118,28,12).setHidden();
		this._delete=this.register(_C16,"browseproducts.quickwindow.delete");
		this.add(_C16);
		ButtonControl _C17=new ButtonControl();
		_C17.setIcon(Icon.HELP).setAt(229,124,13,12).setHidden().setTip("Get Help").setStandard(Std.HELP);
		this._help=this.register(_C17,"browseproducts.quickwindow.help");
		this.add(_C17);
		ButtonControl _C18=new ButtonControl();
		_C18.setFlat().setIcon("EXITS.ICO").setAt(371,161,20,12).setSkip().setMsg("Exit Browse").setTip("Exit Browse");
		this._close=this.register(_C18,"browseproducts.quickwindow.close");
		this.add(_C18);
	}
}