package clarion.abquery;

import clarion.abquery.equates.Mconstants;
import clarion.equates.Charset;
import clarion.equates.Font;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.SheetControl;
import org.jclarion.clarion.control.TabControl;

@SuppressWarnings("all")
public class W extends ClarionWindow
{
	public int _sheet1=0;
	public int _tab1=0;
	public int _tab2=0;
	public int _ok=0;
	public int _cancel=0;
	public int _clear=0;
	public W()
	{
		this.setText(Mconstants.DEFAULTWINDOWTEXT).setFont("MS Sans Serif",8,null,Font.REGULAR,Charset.ANSI).setCenter().setTiled().setSystem().setGray().setResize();
		this.setId("queryclass_3.ask.w");
		SheetControl _C1=new SheetControl();
		_C1.setAt(5,4,301,206);
		this._sheet1=this.register(_C1,"queryclass_3.ask.w.sheet1");
		this.add(_C1);
		TabControl _C2=new TabControl();
		_C2.setText(Mconstants.DEFAULTSAVETABNAME);
		this._tab1=this.register(_C2,"queryclass_3.ask.w.tab1");
		_C1.add(_C2);
		TabControl _C3=new TabControl();
		_C3.setText(Mconstants.DEFAULTSETTINGSNAME);
		this._tab2=this.register(_C3,"queryclass_3.ask.w.tab2");
		_C1.add(_C3);
		ButtonControl _C4=new ButtonControl();
		_C4.setDefault().setText(Mconstants.DEFAULTOKNAME).setAt(null,null,50,14);
		this._ok=this.register(_C4,"queryclass_3.ask.w.ok");
		this.add(_C4);
		ButtonControl _C5=new ButtonControl();
		_C5.setText(Mconstants.DEFAULTCANCELNAME).setAt(null,null,50,14);
		this._cancel=this.register(_C5,"queryclass_3.ask.w.cancel");
		this.add(_C5);
		ButtonControl _C6=new ButtonControl();
		_C6.setText(Mconstants.DEFAULTCLEARNAME).setAt(0,15,50,14);
		this._clear=this.register(_C6,"queryclass_3.ask.w.clear");
		this.add(_C6);
	}
}
