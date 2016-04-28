package clarion;

import clarion.equates.Charset;
import clarion.equates.Font;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.TextControl;

public class TxtWindow extends ClarionWindow
{
	public int _text=0;
	public int _txtOk=0;
	public int _txtCancel=0;
	public TxtWindow()
	{
		this.setText("Caption").setAt(null,null,300,200).setFont("MS Sans Serif",8,null,Font.REGULAR,Charset.ANSI).setSystem().setGray().setDouble();
		this.setId("main.abeip.txtwindow");
		TextControl _C1=new TextControl();
		_C1.setVScroll().setAt(5,5,290,176).setFont("Courier New",8,null,Font.REGULAR,Charset.ANSI);
		this._text=this.register(_C1,"main.abeip.txtwindow.text");
		this.add(_C1);
		ButtonControl _C2=new ButtonControl();
		_C2.setDefault().setText("&Ok").setAt(203,184,45,14);
		this._txtOk=this.register(_C2,"main.abeip.txtwindow.txtok");
		this.add(_C2);
		ButtonControl _C3=new ButtonControl();
		_C3.setText("&Cancel").setAt(250,184,45,14);
		this._txtCancel=this.register(_C3,"main.abeip.txtwindow.txtcancel");
		this.add(_C3);
	}
}
