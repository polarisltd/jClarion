package clarion;

import clarion.Main;
import clarion.QueueBrowse_1_1;
import clarion.equates.Color;
import clarion.equates.Font;
import clarion.equates.Icon;
import clarion.equates.Std;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.ListControl;
import org.jclarion.clarion.control.SheetControl;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.control.TabControl;

public class QuickWindow_2 extends ClarionWindow
{
	public int _currentTab=0;
	public int _tab1=0;
	public int _pRODescription=0;
	public int _browse_1=0;
	public int _select_2=0;
	public int _string1=0;
	public int _help=0;
	public int _query=0;
	public int _close=0;
	public QuickWindow_2(QueueBrowse_1_1 queueBrowse_1)
	{
		this.setText("Select a Product").setAt(null,null,236,134).setFont("MS Sans Serif",8,null,null,null).setCenter().setImmediate().setIcon("ORCHID.ICO").setHelp("~SelectaProduct").setSystem().setGray().setResize().setMDI();
		this.setId("selectproducts.quickwindow");
		SheetControl _C1=new SheetControl();
		_C1.setWizard().setAt(2,0,231,132);
		this._currentTab=this.register(_C1,"selectproducts.quickwindow.currenttab");
		this.add(_C1);
		TabControl _C2=new TabControl();
		_C2.setText("Tab 1");
		this._tab1=this.register(_C2,"selectproducts.quickwindow.tab1");
		_C1.add(_C2);
		StringControl _C3=new StringControl();
		_C3.setPicture("@s35").setAt(46,116,76,10).setFont(null,null,Color.RED,Font.BOLD,null);
		this._pRODescription=this.register(_C3.use(Main.products.description),"selectproducts.quickwindow.pro:description");
		_C2.add(_C3);
		ListControl _C4=new ListControl();
		_C4.setHVScroll().setFormat(ClarionString.staticConcat("80L(1)|M~Description~@s35@48L(2)|M~Product SKU~L(0)@s10@32D(16)|M~Price~L(2)@n$1","0.2B@59D(20)|M~Quantity In Stock~L(2)@n-10.2B@")).setFrom(queueBrowse_1).setAt(6,6,221,102).setImmediate().setMsg("Browsing Records");
		this._browse_1=this.register(_C4,"selectproducts.quickwindow.browse:1");
		this.add(_C4);
		ButtonControl _C5=new ButtonControl();
		_C5.setText("&Select").setAt(41,19,25,13).setHidden().setFont("MS Serif",8,Color.BLACK,null,null).setMsg("Select a Product from list").setTip("Select a Product from list");
		this._select_2=this.register(_C5,"selectproducts.quickwindow.select:2");
		this.add(_C5);
		StringControl _C6=new StringControl();
		_C6.setText("Locator:").setAt(7,114,39,12).setTransparent().setFont("MS Serif",10,Color.BLACK,Font.BOLD,null);
		this._string1=this.register(_C6,"selectproducts.quickwindow.string1");
		this.add(_C6);
		ButtonControl _C7=new ButtonControl();
		_C7.setIcon(Icon.HELP).setAt(45,43,13,13).setHidden().setTip("Get Help").setStandard(Std.HELP);
		this._help=this.register(_C7,"selectproducts.quickwindow.help");
		this.add(_C7);
		ButtonControl _C8=new ButtonControl();
		_C8.setFlat().setText("&Query").setAt(149,111,38,18).setSkip().setFont(null,null,Color.NAVY,Font.BOLD,null).setTip("Query-By-Example");
		this._query=this.register(_C8,"selectproducts.quickwindow.query");
		this.add(_C8);
		ButtonControl _C9=new ButtonControl();
		_C9.setFlat().setIcon("EXITS.ICO").setAt(201,111,23,18).setSkip().setMsg("Exit Browse").setTip("Exit Browse and cancel selection");
		this._close=this.register(_C9,"selectproducts.quickwindow.close");
		this.add(_C9);
	}
}
