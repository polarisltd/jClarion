package clarion;

import clarion.QueueBrowse_1_1;
import clarion.equates.Font;
import clarion.equates.Std;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.ListControl;
import org.jclarion.clarion.control.SheetControl;
import org.jclarion.clarion.control.TabControl;

public class QuickWindow_2 extends ClarionWindow
{
	public int _browse_1=0;
	public int _select_2=0;
	public int _currentTab=0;
	public int _tab_2=0;
	public int _close=0;
	public int _help=0;
	public QuickWindow_2(QueueBrowse_1_1 queueBrowse_1)
	{
		this.setText("Select a States Record").setAt(null,null,158,198).setFont("MS Sans Serif",8,null,Font.REGULAR,null).setCenter().setImmediate().setHelp("SelectStates").setSystem().setGray().setResize().setMDI();
		this.setId("selectstates.quickwindow");
		ListControl _C1=new ListControl();
		_C1.setHVScroll().setFormat("24L(2)|M~State~L(2)@S2@80L(2)|M~State Name~L(2)@s30@").setFrom(queueBrowse_1).setAt(8,30,142,124).setImmediate().setMsg("Browsing the States file");
		this._browse_1=this.register(_C1,"selectstates.quickwindow.browse:1");
		this.add(_C1);
		ButtonControl _C2=new ButtonControl();
		_C2.setFlat().setIcon("WASELECT.ICO").setText("&Select").setAt(101,158,49,14).setLeft(null).setMsg("Select the Record").setTip("Select the Record");
		this._select_2=this.register(_C2,"selectstates.quickwindow.select:2");
		this.add(_C2);
		SheetControl _C3=new SheetControl();
		_C3.setAt(4,4,150,172);
		this._currentTab=this.register(_C3,"selectstates.quickwindow.currenttab");
		this.add(_C3);
		TabControl _C4=new TabControl();
		_C4.setText("&1) KeyState");
		this._tab_2=this.register(_C4,"selectstates.quickwindow.tab:2");
		_C3.add(_C4);
		ButtonControl _C5=new ButtonControl();
		_C5.setFlat().setIcon("WACLOSE.ICO").setText("&Close").setAt(52,180,49,14).setLeft(null).setMsg("Close Window").setTip("Close Window");
		this._close=this.register(_C5,"selectstates.quickwindow.close");
		this.add(_C5);
		ButtonControl _C6=new ButtonControl();
		_C6.setFlat().setIcon("WAHELP.ICO").setText("&Help").setAt(105,180,49,14).setLeft(null).setMsg("See Help Window").setTip("See Help Window").setStandard(Std.HELP);
		this._help=this.register(_C6,"selectstates.quickwindow.help");
		this.add(_C6);
	}
}
