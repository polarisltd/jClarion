package clarion;

import clarion.equates.Font;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ImageControl;
import org.jclarion.clarion.control.PanelControl;
import org.jclarion.clarion.control.StringControl;

public class Window_5 extends ClarionWindow
{
	public int _string3=0;
	public int _string3_2=0;
	public int _string2=0;
	public int _image1=0;
	public Window_5()
	{
		this.setAt(null,null,261,149).setFont("MS Sans Serif",8,null,Font.REGULAR,null).setCenter().setGray().setNoFrame().setMDI();
		this.setId("splashscreen.window");
		PanelControl _C1=new PanelControl();
		_C1.setAt(0,0,261,149).setBevel(6,null,null);
		this.add(_C1);
		PanelControl _C2=new PanelControl();
		_C2.setAt(7,7,246,135).setBevel(-2,1,null);
		this.add(_C2);
		StringControl _C3=new StringControl();
		_C3.setText("Plastic Money").setAt(22,11,217,26).setTransparent().setFont("Impact",30,null,Font.ITALIC,null);
		this._string3=this.register(_C3,"splashscreen.window.string3");
		this.add(_C3);
		StringControl _C4=new StringControl();
		_C4.setText("Manager").setAt(171,28,74,23).setTransparent().setFont("Impact",20,null,Font.ITALIC,null);
		this._string3_2=this.register(_C4,"splashscreen.window.string3:2");
		this.add(_C4);
		StringControl _C5=new StringControl();
		_C5.setText("A Credit Card Registry & Transaction Log").setAt(41,49,182,10).setTransparent().setCenter(null).setFont("Arial",9,null,Font.BOLD,null);
		this._string2=this.register(_C5,"splashscreen.window.string2");
		this.add(_C5);
		ImageControl _C6=new ImageControl();
		_C6.setCentered().setText("sv_small.jpg").setAt(69,62,126,75);
		this._image1=this.register(_C6,"splashscreen.window.image1");
		this.add(_C6);
	}
}
