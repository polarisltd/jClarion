package clarion;

import clarion.equates.Constants;
import clarion.equates.Font;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.GroupControl;
import org.jclarion.clarion.control.ListControl;
import org.jclarion.clarion.control.PanelControl;

public class MultiWindow extends ClarionWindow
{
	public int _panel1=0;
	public int _group2=0;
	public int _available=0;
	public int _group3=0;
	public int _selected=0;
	public int _selectSome=0;
	public int _selectAll=0;
	public int _deselectSome=0;
	public int _deselectAll=0;
	public int _moveUp=0;
	public int _moveDown=0;
	public int _ok=0;
	public int _cancel=0;
	public MultiWindow()
	{
		this.setText("Choose items and order").setAt(null,null,300,200).setFont("MS Sans Serif",8,null,Font.REGULAR,null).setCenter().setImmediate().setSystem().setGray().setDouble();
		this.setId("main.abeip.multiwindow");
		PanelControl _C1=new PanelControl();
		_C1.setAt(5,5,290,176);
		this._panel1=this.register(_C1,"main.abeip.multiwindow.panel1");
		this.add(_C1);
		GroupControl _C2=new GroupControl();
		_C2.setText("&Available items").setAt(10,10,125,166).setBoxed();
		this._group2=this.register(_C2,"main.abeip.multiwindow.group2");
		this.add(_C2);
		ListControl _C3=new ListControl();
		_C3.setHVScroll().setAt(15,20,115,151).setAlrt(Constants.MOUSELEFT2);
		this._available=this.register(_C3,"main.abeip.multiwindow.available");
		_C2.add(_C3);
		GroupControl _C4=new GroupControl();
		_C4.setText("&Selected items").setAt(165,10,125,166).setBoxed();
		this._group3=this.register(_C4,"main.abeip.multiwindow.group3");
		this.add(_C4);
		ListControl _C5=new ListControl();
		_C5.setHVScroll().setAt(170,20,115,151).setAlrt(Constants.MOUSELEFT2);
		this._selected=this.register(_C5,"main.abeip.multiwindow.selected");
		_C4.add(_C5);
		ButtonControl _C6=new ButtonControl();
		_C6.setText(">").setAt(141,41,18,14);
		this._selectSome=this.register(_C6,"main.abeip.multiwindow.selectsome");
		this.add(_C6);
		ButtonControl _C7=new ButtonControl();
		_C7.setText(">>").setAt(141,55,18,14);
		this._selectAll=this.register(_C7,"main.abeip.multiwindow.selectall");
		this.add(_C7);
		ButtonControl _C8=new ButtonControl();
		_C8.setText("<").setAt(141,79,18,14);
		this._deselectSome=this.register(_C8,"main.abeip.multiwindow.deselectsome");
		this.add(_C8);
		ButtonControl _C9=new ButtonControl();
		_C9.setText("<<").setAt(141,93,18,14);
		this._deselectAll=this.register(_C9,"main.abeip.multiwindow.deselectall");
		this.add(_C9);
		ButtonControl _C10=new ButtonControl();
		_C10.setIcon("ABUPROW.ICO").setAt(141,117,18,14).setDisabled();
		this._moveUp=this.register(_C10,"main.abeip.multiwindow.moveup");
		this.add(_C10);
		ButtonControl _C11=new ButtonControl();
		_C11.setIcon("ABDNROW.ICO").setAt(141,131,18,14).setDisabled();
		this._moveDown=this.register(_C11,"main.abeip.multiwindow.movedown");
		this.add(_C11);
		ButtonControl _C12=new ButtonControl();
		_C12.setDefault().setText("&Ok").setAt(203,184,45,14);
		this._ok=this.register(_C12,"main.abeip.multiwindow.ok");
		this.add(_C12);
		ButtonControl _C13=new ButtonControl();
		_C13.setText("&Cancel").setAt(250,184,45,14);
		this._cancel=this.register(_C13,"main.abeip.multiwindow.cancel");
		this.add(_C13);
	}
}
