package clarion.invoi001;

import clarion.equates.Color;
import clarion.equates.Font;
import clarion.equates.Icon;
import clarion.equates.Std;
import clarion.invoi001.QueueReltree;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.ListControl;
import org.jclarion.clarion.control.StringControl;

@SuppressWarnings("all")
public class Window extends ClarionWindow
{
	public int _reltree=0;
	public int _insert=0;
	public int _change=0;
	public int _delete=0;
	public int _string1=0;
	public int _expand=0;
	public int _contract=0;
	public int _help=0;
	public int _close=0;
	public Window(QueueReltree queueReltree)
	{
		this.setText("Browse Customers Orders In Tree View").setAt(null,null,312,193).setFont("MS Sans Serif",8,null,Font.BOLD,null).setImmediate().setIcon("NOTE14.ICO").setHelp("~BrowseCustomersOrdersInTreeView").setSystem().setGray().setResize().setMDI();
		this.setId("browseallorders.window");
		ListControl _C1=new ListControl();
		_C1.setVScroll().setFormat("800L*ITS(70)@s200@").setFrom(queueReltree).setAt(3,17,305,156).setFont("Times New Roman",10,null,Font.BOLD,null).setColor(null,Color.WHITE,Color.BLUE).setMsg("Ctrl+-> Expand branch,  Ctrl+<- Contract branch");
		this._reltree=this.register(_C1,"browseallorders.window.reltree");
		this.add(_C1);
		ButtonControl _C2=new ButtonControl();
		_C2.setIcon("Insert.ico").setFlat().setText("Insert").setAt(4,177,48,15).setSkip().setLeft(null).setFont(null,null,Color.GREEN,Font.BOLD,null).setTip("Insert a record");
		this._insert=this.register(_C2,"browseallorders.window.insert");
		this.add(_C2);
		ButtonControl _C3=new ButtonControl();
		_C3.setIcon("Edit.ico").setFlat().setText("Change").setAt(55,177,48,15).setSkip().setLeft(null).setFont(null,8,Color.GREEN,Font.BOLD,null).setTip("Edit a record");
		this._change=this.register(_C3,"browseallorders.window.change");
		this.add(_C3);
		ButtonControl _C4=new ButtonControl();
		_C4.setIcon("Delete.ico").setFlat().setText("Delete").setAt(106,177,48,15).setSkip().setLeft(null).setFont(null,null,Color.GREEN,Font.BOLD,null).setTip("Delete a record");
		this._delete=this.register(_C4,"browseallorders.window.delete");
		this.add(_C4);
		StringControl _C5=new StringControl();
		_C5.setText("Backordered Item").setAt(104,2,89,12).setCenter(null).setFont("MS Sans Serif",10,Color.RED,Font.BOLD,null);
		this._string1=this.register(_C5,"browseallorders.window.string1");
		this.add(_C5);
		ButtonControl _C6=new ButtonControl();
		_C6.setIcon(Icon.NONE).setFlat().setText("&Expand All").setAt(161,177,55,15).setSkip().setFont(null,null,Color.NAVY,Font.BOLD,null).setTip("Expand All Branches");
		this._expand=this.register(_C6,"browseallorders.window.expand");
		this.add(_C6);
		ButtonControl _C7=new ButtonControl();
		_C7.setIcon(Icon.NONE).setFlat().setText("Co&ntract All").setAt(218,177,55,15).setSkip().setFont(null,null,Color.NAVY,Font.BOLD,null).setTip("Contract All Branches");
		this._contract=this.register(_C7,"browseallorders.window.contract");
		this.add(_C7);
		ButtonControl _C8=new ButtonControl();
		_C8.setIcon(Icon.HELP).setAt(274,143,11,12).setHidden().setTip("Get help").setStandard(Std.HELP);
		this._help=this.register(_C8,"browseallorders.window.help");
		this.add(_C8);
		ButtonControl _C9=new ButtonControl();
		_C9.setIcon("EXITS.ICO").setFlat().setAt(290,177,19,15).setSkip().setTip("Exits Browse");
		this._close=this.register(_C9,"browseallorders.window.close");
		this.add(_C9);
	}
}
