package org.jclarion.clarion.test.simpleapp;

import org.jclarion.clarion.constants.Font;
import org.jclarion.clarion.constants.Std;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.EntryControl;
import org.jclarion.clarion.control.StringControl;

public class Window_56 extends ClarionWindow
{
	public int _string1=0;
	public int _accCode=0;
	public int _string2=0;
	public int _passwd=0;
	public int _login=0;
	public int _button2=0;
	public Window_56(ClarionString accCode,ClarionString passwd)
	{
		this.setText("Login").setAt(null,null,122,68).setFont("MS Sans Serif",8,null,Font.REGULAR,null).setCenter().setIcon("D:\\c8sys\\pgapak\\main\\images\\bike.ico").setTimer(100).setSystem().setGray().setDouble().setMDI().setModal().setImmediate();
		this.setId("login.window");
		StringControl _C1=new StringControl();
		_C1.setText("Login:").setAt(13,9,null,null);
		this._string1=this.register(_C1,"login.window.string1");
		this.add(_C1);
		EntryControl _C2=new EntryControl();
		_C2.setPicture("@s16").setAt(51,10,60,10);
		this._accCode=this.register(_C2.use(accCode),"login.window.acccode");
		this.add(_C2);
		StringControl _C3=new StringControl();
		_C3.setText("Password:").setAt(13,24,null,null);
		this._string2=this.register(_C3,"login.window.string2");
		this.add(_C3);
		EntryControl _C4=new EntryControl();
		_C4.setPassword().setPicture("@s20").setAt(51,24,60,10);
		this._passwd=this.register(_C4.use(passwd),"login.window.passwd");
		this.add(_C4);
		ButtonControl _C5=new ButtonControl();
		_C5.setDefault().setText("Login").setAt(9,48,45,14);
		this._login=this.register(_C5,"login.window.login");
		this.add(_C5);
		ButtonControl _C6=new ButtonControl();
		_C6.setText("Exit").setAt(71,48,45,14).setStandard(Std.CLOSE);
		this._button2=this.register(_C6,"login.window.button2");
		this.add(_C6);
	}
}
