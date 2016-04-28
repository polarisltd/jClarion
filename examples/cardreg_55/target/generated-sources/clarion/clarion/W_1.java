package clarion;

import clarion.equates.Charset;
import clarion.equates.Constants;
import clarion.equates.Font;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.SheetControl;
import org.jclarion.clarion.control.TabControl;

public class W_1 extends ClarionWindow
{
	public int _sheet1=0;
	public int _tab1=0;
	public int _tab2=0;
	public int _ok=0;
	public int _cancel=0;
	public int _clear=0;
	public W_1()
	{
		this.setText(Constants.DEFAULTWINDOWTEXT).setFont("MS Sans Serif",8,null,Font.REGULAR,Charset.ANSI).setCenter().setTiled().setSystem().setGray().setResize();
		this.setId("queryclass.ask.w");
		SheetControl _C1=new SheetControl();
		_C1.setAt(5,4,301,206);
		this._sheet1=this.register(_C1,"queryclass.ask.w.sheet1");
		this.add(_C1);
		TabControl _C2=new TabControl();
		_C2.setText(Constants.DEFAULTSAVETABNAME);
		this._tab1=this.register(_C2,"queryclass.ask.w.tab1");
		_C1.add(_C2);
		TabControl _C3=new TabControl();
		_C3.setText(Constants.DEFAULTSETTINGSNAME);
		this._tab2=this.register(_C3,"queryclass.ask.w.tab2");
		_C1.add(_C3);
		ButtonControl _C4=new ButtonControl();
		_C4.setDefault().setText(Constants.DEFAULTOKNAME).setAt(null,null,50,14);
		this._ok=this.register(_C4,"queryclass.ask.w.ok");
		this.add(_C4);
		ButtonControl _C5=new ButtonControl();
		_C5.setText(Constants.DEFAULTCANCELNAME).setAt(null,null,50,14);
		this._cancel=this.register(_C5,"queryclass.ask.w.cancel");
		this.add(_C5);
		ButtonControl _C6=new ButtonControl();
		_C6.setText(Constants.DEFAULTCLEARNAME).setAt(0,15,50,14);
		this._clear=this.register(_C6,"queryclass.ask.w.clear");
		this.add(_C6);
	}
}
