package clarion;

import clarion.Main;
import clarion.QueueBrowse_1;
import clarion.equates.Color;
import clarion.equates.Font;
import clarion.equates.Icon;
import clarion.equates.Std;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.ListControl;
import org.jclarion.clarion.control.SheetControl;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.control.TabControl;

public class QuickWindow extends ClarionWindow
{
	public int _currentTab=0;
	public int _tab1=0;
	public int _sTAStateCode=0;
	public int _browse_1=0;
	public int _select_2=0;
	public int _insert_3=0;
	public int _change_3=0;
	public int _delete_3=0;
	public int _string1=0;
	public int _help=0;
	public int _close=0;
	public QuickWindow(QueueBrowse_1 queueBrowse_1)
	{
		this.setText("Select a State").setAt(null,null,173,203).setFont("MS Sans Serif",8,Color.BLACK,null,null).setCenter().setImmediate().setIcon("USA1.ICO").setHelp("~SelectaState").setSystem().setGray().setResize().setMDI();
		this.setId("selectstates.quickwindow");
		SheetControl _C1=new SheetControl();
		_C1.setWizard().setAt(4,1,165,199);
		this._currentTab=this.register(_C1,"selectstates.quickwindow.currenttab");
		this.add(_C1);
		TabControl _C2=new TabControl();
		_C2.setText("Tab 1");
		this._tab1=this.register(_C2,"selectstates.quickwindow.tab1");
		_C1.add(_C2);
		StringControl _C3=new StringControl();
		_C3.setPicture("@s2").setAt(69,185,18,10).setFont(null,null,Color.RED,Font.BOLD,null);
		this._sTAStateCode=this.register(_C3.use(Main.states.stateCode),"selectstates.quickwindow.sta:statecode");
		_C2.add(_C3);
		ListControl _C4=new ListControl();
		_C4.setVScroll().setFormat("39C|M~State Code~L(2)@s2@80L(1)|M~State Name~@s25@").setFrom(queueBrowse_1).setAt(10,7,151,171).setImmediate().setMsg("Browsing Records");
		this._browse_1=this.register(_C4,"selectstates.quickwindow.browse:1");
		this.add(_C4);
		ButtonControl _C5=new ButtonControl();
		_C5.setText("&Select").setAt(74,96,19,14).setHidden();
		this._select_2=this.register(_C5,"selectstates.quickwindow.select:2");
		this.add(_C5);
		ButtonControl _C6=new ButtonControl();
		_C6.setText("&Insert").setAt(57,130,19,14).setHidden();
		this._insert_3=this.register(_C6,"selectstates.quickwindow.insert:3");
		this.add(_C6);
		ButtonControl _C7=new ButtonControl();
		_C7.setDefault().setText("&Change").setAt(106,130,19,14).setHidden();
		this._change_3=this.register(_C7,"selectstates.quickwindow.change:3");
		this.add(_C7);
		ButtonControl _C8=new ButtonControl();
		_C8.setText("&Delete").setAt(42,90,19,14).setHidden();
		this._delete_3=this.register(_C8,"selectstates.quickwindow.delete:3");
		this.add(_C8);
		StringControl _C9=new StringControl();
		_C9.setText("Locator: Code").setAt(9,185,57,10).setFont("MS Sans Serif",8,null,Font.BOLD,null);
		this._string1=this.register(_C9,"selectstates.quickwindow.string1");
		this.add(_C9);
		ButtonControl _C10=new ButtonControl();
		_C10.setIcon(Icon.HELP).setAt(125,157,13,12).setHidden().setTip("Get Help").setStandard(Std.HELP);
		this._help=this.register(_C10,"selectstates.quickwindow.help");
		this.add(_C10);
		ButtonControl _C11=new ButtonControl();
		_C11.setFlat().setIcon("EXITS.ICO").setAt(145,181,19,16).setTip("Cancel selection and exit browse");
		this._close=this.register(_C11,"selectstates.quickwindow.close");
		this.add(_C11);
	}
}
