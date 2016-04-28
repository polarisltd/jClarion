package clarion.winla043;

import clarion.equates.Charset;
import clarion.equates.Color;
import clarion.equates.Font;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.StringControl;

@SuppressWarnings("all")
public class Window extends ClarionWindow
{
	public int _zina1=0;
	public int _zina=0;
	public int _clakluda=0;
	public int _darit=0;
	public int _nedarit=0;
	public Window(ClarionString zina1,ClarionString zina,ClarionString clakluda)
	{
		this.setText("   K��da ").setAt(null,null,358,71).setFont("MS Sans Serif",9,null,Font.BOLD,Charset.BALTIC).setCenter().setImmediate().setIcon("CLARION.ICO").setSystem().setGray().setModal();
		this.setId("kluda.window");
		StringControl _C1=new StringControl();
		_C1.setPicture("@s85").setAt(2,11,351,10).setCenter(null).setFont(null,null,Color.BLUE,Font.BOLD,Charset.BALTIC);
		this._zina1=this.register(_C1.use(zina1),"kluda.window.zina1");
		this.add(_C1);
		StringControl _C2=new StringControl();
		_C2.setPicture("@s85").setAt(2,20,351,10).setCenter(null).setFont(null,null,Color.RED,Font.BOLD,Charset.BALTIC);
		this._zina=this.register(_C2.use(zina),"kluda.window.zina");
		this.add(_C2);
		StringControl _C3=new StringControl();
		_C3.setPicture("@s80").setAt(13,32,331,10).setCenter(null).setFont(null,null,Color.GRAY,null,Charset.ANSI);
		this._clakluda=this.register(_C3.use(clakluda),"kluda.window.clakluda");
		this.add(_C3);
		ButtonControl _C4=new ButtonControl();
		_C4.setDefault().setText("&dar�t").setAt(293,45,58,14);
		this._darit=this.register(_C4,"kluda.window.darit");
		this.add(_C4);
		ButtonControl _C5=new ButtonControl();
		_C5.setText("&nedar�t").setAt(240,45,49,14);
		this._nedarit=this.register(_C5,"kluda.window.nedarit");
		this.add(_C5);
	}
}
