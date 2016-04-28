package clarion.invoi002;

import clarion.equates.Font;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ImageControl;
import org.jclarion.clarion.control.PanelControl;
import org.jclarion.clarion.control.StringControl;

@SuppressWarnings("all")
public class Window_1 extends ClarionWindow
{
	public int _string2=0;
	public int _string4=0;
	public int _string3=0;
	public int _image1=0;
	public int _string1=0;
	public Window_1()
	{
		this.setAt(null,null,306,147).setFont("MS Sans Serif",8,null,Font.REGULAR,null).setColor(0x80ffff,null,null).setCenter().setGray().setNoFrame().setMDI();
		this.setId("splashscreen.window");
		PanelControl _C1=new PanelControl();
		_C1.setAt(0,0,306,147).setBevel(3,null,null);
		this.add(_C1);
		PanelControl _C2=new PanelControl();
		_C2.setAt(7,6,292,134).setBevel(-2,1,null);
		this.add(_C2);
		StringControl _C3=new StringControl();
		_C3.setText("ORDER ENTRY ").setAt(114,19,178,20).setTransparent().setCenter(null).setFont("Courier New",22,null,Font.BOLD,null);
		this._string2=this.register(_C3,"splashscreen.window.string2");
		this.add(_C3);
		StringControl _C4=new StringControl();
		_C4.setText("&").setAt(114,50,178,20).setTransparent().setCenter(null).setFont("Courier New",22,null,Font.BOLD,null);
		this._string4=this.register(_C4,"splashscreen.window.string4");
		this.add(_C4);
		StringControl _C5=new StringControl();
		_C5.setText("INVOICE SYSTEM").setAt(114,82,178,20).setTransparent().setCenter(null).setFont("Courier New",22,null,Font.BOLD,null);
		this._string3=this.register(_C5,"splashscreen.window.string3");
		this.add(_C5);
		ImageControl _C6=new ImageControl();
		_C6.setText("SSANTHUR.GIF").setAt(12,11,101,102);
		this._image1=this.register(_C6,"splashscreen.window.image1");
		this.add(_C6);
		PanelControl _C7=new PanelControl();
		_C7.setAt(17,111,273,10).setBevel(-1,1,0x9);
		this.add(_C7);
		StringControl _C8=new StringControl();
		_C8.setText("Revised using Clarion 5").setAt(11,124,284,12).setTransparent().setCenter(null).setFont("MS Sans Serif",10,null,null,null);
		this._string1=this.register(_C8,"splashscreen.window.string1");
		this.add(_C8);
	}
}
