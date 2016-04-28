package clarion;

import clarion.equates.Charset;
import clarion.equates.Font;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.ImageControl;
import org.jclarion.clarion.control.ListControl;

public class Window_1 extends ClarionWindow
{
	public int _image=0;
	public int _list=0;
	public int _button1=0;
	public int _button2=0;
	public int _button3=0;
	public int _button4=0;
	public int _button5=0;
	public int _button6=0;
	public int _button7=0;
	public int _button8=0;
	public Window_1()
	{
		this.setText("Error").setAt(null,null,320,96).setFont("MS Sans Serif",8,null,Font.REGULAR,Charset.ANSI).setCenter().setGray().setResize();
		this.setId("main.aberror.window");
		ImageControl _C1=new ImageControl();
		_C1.setAt(2,4,26,28);
		this._image=this.register(_C1,"main.aberror.window.image");
		this.add(_C1);
		ListControl _C2=new ListControl();
		_C2.setVScroll().setFormat("217L(2)|M~Message~S(255)@s255@42L(2)|M~Category~L(1)@s255@").setAt(32,4,286,71);
		this._list=this.register(_C2,"main.aberror.window.list");
		this.add(_C2);
		ButtonControl _C3=new ButtonControl();
		_C3.setText("Button 1").setAt(4,80,36,14).setHidden();
		this._button1=this.register(_C3,"main.aberror.window.button1");
		this.add(_C3);
		ButtonControl _C4=new ButtonControl();
		_C4.setText("Button 2").setAt(44,80,36,14).setHidden();
		this._button2=this.register(_C4,"main.aberror.window.button2");
		this.add(_C4);
		ButtonControl _C5=new ButtonControl();
		_C5.setText("Button 3").setAt(84,80,36,14).setHidden();
		this._button3=this.register(_C5,"main.aberror.window.button3");
		this.add(_C5);
		ButtonControl _C6=new ButtonControl();
		_C6.setText("Button 4").setAt(124,80,36,14).setHidden();
		this._button4=this.register(_C6,"main.aberror.window.button4");
		this.add(_C6);
		ButtonControl _C7=new ButtonControl();
		_C7.setText("Button 5").setAt(164,80,36,14).setHidden();
		this._button5=this.register(_C7,"main.aberror.window.button5");
		this.add(_C7);
		ButtonControl _C8=new ButtonControl();
		_C8.setText("Button 6").setAt(204,80,36,14).setHidden();
		this._button6=this.register(_C8,"main.aberror.window.button6");
		this.add(_C8);
		ButtonControl _C9=new ButtonControl();
		_C9.setText("Button 7").setAt(244,80,36,14).setHidden();
		this._button7=this.register(_C9,"main.aberror.window.button7");
		this.add(_C9);
		ButtonControl _C10=new ButtonControl();
		_C10.setText("Button 8").setAt(284,80,36,14).setHidden();
		this._button8=this.register(_C10,"main.aberror.window.button8");
		this.add(_C10);
	}
}
