package clarion;

import clarion.QueueBrowse_1;
import clarion.equates.Font;
import clarion.equates.Std;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.ListControl;
import org.jclarion.clarion.control.SheetControl;
import org.jclarion.clarion.control.TabControl;

public class QuickWindow extends ClarionWindow
{
	public int _browse_1=0;
	public int _view_2=0;
	public int _insert_3=0;
	public int _change_3=0;
	public int _delete_3=0;
	public int _currentTab=0;
	public int _tab_2=0;
	public int _tab_3=0;
	public int _tab_4=0;
	public int _close=0;
	public int _help=0;
	public QuickWindow(QueueBrowse_1 queueBrowse_1)
	{
		this.setText("Browse the CUSTOMER file").setAt(null,null,358,198).setFont("MS Sans Serif",8,null,Font.REGULAR,null).setCenter().setImmediate().setHelp("BrowseCUSTOMER").setSystem().setGray().setResize().setMDI();
		this.setId("browsecustomer.quickwindow");
		ListControl _C1=new ListControl();
		_C1.setHVScroll().setFormat(ClarionString.staticConcat("64R(2)|M~CUSTNUMBER~C(0)@n-14@80L(2)|M~COMPANY~L(2)@s20@80L(2)|M~FIRSTNAME~L(2)@","s20@80L(2)|M~LASTNAME~L(2)@s20@80L(2)|M~ADDRESS~L(2)@s20@80L(2)|M~CITY~L(2)@s20@","24L(2)|M~STATE~L(2)@s2@32L(2)|M~ZIPCODE~L(2)@P#####P@")).setFrom(queueBrowse_1).setAt(8,30,342,124).setImmediate().setMsg("Browsing the CUSTOMER file");
		this._browse_1=this.register(_C1,"browsecustomer.quickwindow.browse:1");
		this.add(_C1);
		ButtonControl _C2=new ButtonControl();
		_C2.setFlat().setIcon("WAVIEW.ICO").setText("&View").setAt(142,158,49,14).setLeft(null).setMsg("View Record").setTip("View Record");
		this._view_2=this.register(_C2,"browsecustomer.quickwindow.view:2");
		this.add(_C2);
		ButtonControl _C3=new ButtonControl();
		_C3.setFlat().setIcon("WAINSERT.ICO").setText("&Insert").setAt(195,158,49,14).setLeft(null).setMsg("Insert a Record").setTip("Insert a Record");
		this._insert_3=this.register(_C3,"browsecustomer.quickwindow.insert:3");
		this.add(_C3);
		ButtonControl _C4=new ButtonControl();
		_C4.setFlat().setIcon("WACHANGE.ICO").setDefault().setText("&Change").setAt(248,158,49,14).setLeft(null).setMsg("Change the Record").setTip("Change the Record");
		this._change_3=this.register(_C4,"browsecustomer.quickwindow.change:3");
		this.add(_C4);
		ButtonControl _C5=new ButtonControl();
		_C5.setFlat().setIcon("WADELETE.ICO").setText("&Delete").setAt(301,158,49,14).setLeft(null).setMsg("Delete the Record").setTip("Delete the Record");
		this._delete_3=this.register(_C5,"browsecustomer.quickwindow.delete:3");
		this.add(_C5);
		SheetControl _C6=new SheetControl();
		_C6.setAt(4,4,350,172);
		this._currentTab=this.register(_C6,"browsecustomer.quickwindow.currenttab");
		this.add(_C6);
		TabControl _C7=new TabControl();
		_C7.setText("&1) KEYCUSTNUMBER");
		this._tab_2=this.register(_C7,"browsecustomer.quickwindow.tab:2");
		_C6.add(_C7);
		TabControl _C8=new TabControl();
		_C8.setText("&2) KEYCOMPANY");
		this._tab_3=this.register(_C8,"browsecustomer.quickwindow.tab:3");
		_C6.add(_C8);
		TabControl _C9=new TabControl();
		_C9.setText("&3) KEYZIPCODE");
		this._tab_4=this.register(_C9,"browsecustomer.quickwindow.tab:4");
		_C6.add(_C9);
		ButtonControl _C10=new ButtonControl();
		_C10.setFlat().setIcon("WACLOSE.ICO").setText("&Close").setAt(252,180,49,14).setLeft(null).setMsg("Close Window").setTip("Close Window");
		this._close=this.register(_C10,"browsecustomer.quickwindow.close");
		this.add(_C10);
		ButtonControl _C11=new ButtonControl();
		_C11.setFlat().setIcon("WAHELP.ICO").setText("&Help").setAt(305,180,49,14).setLeft(null).setMsg("See Help Window").setTip("See Help Window").setStandard(Std.HELP);
		this._help=this.register(_C11,"browsecustomer.quickwindow.help");
		this.add(_C11);
	}
}
