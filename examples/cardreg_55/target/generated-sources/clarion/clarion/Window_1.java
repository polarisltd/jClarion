package clarion;

import clarion.equates.Font;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ImageControl;
import org.jclarion.clarion.control.PanelControl;
import org.jclarion.clarion.control.StringControl;

public class Window_1 extends ClarionWindow
{
	public int _panel1=0;
	public int _string1=0;
	public int _image1=0;
	public int _panel2=0;
	public int _string3=0;
	public int _string4=0;
	public int _string5=0;
	public int _string6=0;
	public int _string6_2=0;
	public Window_1()
	{
		this.setText("About the Author...").setAt(null,null,232,88).setCenter().setIcon("CREDCARD.ICO").setGray().setDouble().setMDI().setImmediate();
		this.setId("authorinformation.window");
		PanelControl _C1=new PanelControl();
		_C1.setAt(6,7,61,77).setBevel(-1,2,null);
		this._panel1=this.register(_C1,"authorinformation.window.panel1");
		this.add(_C1);
		StringControl _C2=new StringControl();
		_C2.setText("Barbara Klepeisz,").setAt(73,8,null,null).setTransparent();
		this._string1=this.register(_C2,"authorinformation.window.string1");
		this.add(_C2);
		ImageControl _C3=new ImageControl();
		_C3.setText("BARBARA.JPG").setAt(12,13,50,65);
		this._image1=this.register(_C3,"authorinformation.window.image1");
		this.add(_C3);
		PanelControl _C4=new PanelControl();
		_C4.setAt(73,28,150,56).setBevel(-1,2,null);
		this._panel2=this.register(_C4,"authorinformation.window.panel2");
		this.add(_C4);
		StringControl _C5=new StringControl();
		_C5.setText("Barbara has a life").setAt(122,34,null,null).setCenter(null).setFont("Arial",9,null,Font.BOLD+Font.ITALIC,null);
		this._string3=this.register(_C5,"authorinformation.window.string3");
		this.add(_C5);
		StringControl _C6=new StringControl();
		_C6.setText("which also runs at top speed.  She has two").setAt(88,43,null,null).setCenter(null).setFont("Arial",9,null,Font.BOLD+Font.ITALIC,null);
		this._string4=this.register(_C6,"authorinformation.window.string4");
		this.add(_C6);
		StringControl _C7=new StringControl();
		_C7.setText("daughters who have assisted her in testing this").setAt(81,52,null,null).setCenter(null).setFont("Arial",9,null,Font.BOLD+Font.ITALIC,null);
		this._string5=this.register(_C7,"authorinformation.window.string5");
		this.add(_C7);
		StringControl _C8=new StringControl();
		_C8.setText("application by encouraging frequent credit card ").setAt(80,61,null,null).setCenter(null).setFont("Arial",9,null,Font.BOLD+Font.ITALIC,null);
		this._string6=this.register(_C8,"authorinformation.window.string6");
		this.add(_C8);
		StringControl _C9=new StringControl();
		_C9.setText("purchases at the mall.").setAt(117,70,null,null).setCenter(null).setFont("Arial",9,null,Font.BOLD+Font.ITALIC,null);
		this._string6_2=this.register(_C9,"authorinformation.window.string6:2");
		this.add(_C9);
	}
}
