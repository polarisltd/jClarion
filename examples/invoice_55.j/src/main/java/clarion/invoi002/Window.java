package clarion.invoi002;

import clarion.equates.Color;
import clarion.equates.Constants;
import clarion.equates.Font;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.GroupControl;
import org.jclarion.clarion.control.ImageControl;
import org.jclarion.clarion.control.StringControl;

@SuppressWarnings("all")
public class Window extends ClarionWindow
{
	public int _group1=0;
	public int _string7=0;
	public int _string1=0;
	public int _string2=0;
	public int _string3=0;
	public int _string6=0;
	public int _string4=0;
	public int _image1=0;
	public int _string8=0;
	public Window()
	{
		this.setAt(null,null,183,83).setFont("MS Sans Serif",12,null,Font.REGULAR,null).setColor(0xffff80,null,null).setCenter().setAlrt(Constants.MOUSELEFT).setAlrt(4).setAlrt(Constants.MOUSERIGHT).setTimer(1000).setGray().setDouble().setMDI();
		this.setId("aboutauthor.window");
		GroupControl _C1=new GroupControl();
		_C1.setAt(2,3,179,78).setBoxed().setTransparent().setBevel(-2,2,null);
		this._group1=this.register(_C1,"aboutauthor.window.group1");
		this.add(_C1);
		StringControl _C2=new StringControl();
		_C2.setText("Order Entry ").setAt(4,6,113,11).setTransparent().setCenter(null).setFont("Britannic Bold",16,Color.GREEN,Font.ITALIC,null);
		this._string7=this.register(_C2,"aboutauthor.window.string7");
		_C1.add(_C2);
		StringControl _C3=new StringControl();
		_C3.setText("Invoice System").setAt(4,25,113,10).setTransparent().setCenter(null).setFont("Britannic Bold",16,Color.GREEN,Font.BOLD+Font.ITALIC,null);
		this._string1=this.register(_C3,"aboutauthor.window.string1");
		_C1.add(_C3);
		StringControl _C4=new StringControl();
		_C4.setText("Created by:").setAt(4,40,113,8).setTransparent().setCenter(null).setFont("MS Sans Serif",10,null,null,null);
		this._string2=this.register(_C4,"aboutauthor.window.string2");
		_C1.add(_C4);
		StringControl _C5=new StringControl();
		_C5.setText("Doreen A. Williamson").setAt(4,51,113,11).setTransparent().setCenter(null).setFont("Britannic Bold",16,Color.GREEN,Font.BOLD+Font.ITALIC,null);
		this._string3=this.register(_C5,"aboutauthor.window.string3");
		_C1.add(_C5);
		StringControl _C6=new StringControl();
		_C6.setText("Programmer/Consultant").setAt(4,63,113,8).setCenter(null).setFont("MS Sans Serif",10,null,Font.ITALIC,null);
		this._string6=this.register(_C6,"aboutauthor.window.string6");
		_C1.add(_C6);
		StringControl _C7=new StringControl();
		_C7.setText("SoftVelocity, Inc").setAt(4,71,113,8).setTransparent().setCenter(null).setFont("MS Sans Serif",10,null,Font.ITALIC,null);
		this._string4=this.register(_C7,"aboutauthor.window.string4");
		_C1.add(_C7);
		ImageControl _C8=new ImageControl();
		_C8.setText("DAW.GIF").setAt(118,7,59,71);
		this._image1=this.register(_C8,"aboutauthor.window.image1");
		_C1.add(_C8);
		StringControl _C9=new StringControl();
		_C9.setText("&").setAt(4,16,113,10).setTransparent().setCenter(null).setFont("Britannic Bold",16,Color.GREEN,Font.BOLD+Font.ITALIC,null);
		this._string8=this.register(_C9,"aboutauthor.window.string8");
		_C1.add(_C9);
	}
}
