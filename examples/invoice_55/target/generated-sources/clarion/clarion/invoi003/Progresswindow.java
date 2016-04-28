package clarion.invoi003;

import clarion.equates.Color;
import clarion.equates.Font;
import clarion.equates.Icon;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.ProgressControl;
import org.jclarion.clarion.control.StringControl;

@SuppressWarnings("all")
public class Progresswindow extends ClarionWindow
{
	public int _progressThermometer=0;
	public int _progressUserstring=0;
	public int _progressPcttext=0;
	public int _progressCancel=0;
	public Progresswindow(ClarionNumber progressThermometer)
	{
		this.setText("Report Progress...").setAt(null,null,142,59).setCenter().setTimer(1).setGray().setDouble();
		this.setId("printselectedcustomer.progresswindow");
		ProgressControl _C1=new ProgressControl();
		_C1.setRange(0,100).setAt(15,15,111,12);
		this._progressThermometer=this.register(_C1.use(progressThermometer),"printselectedcustomer.progresswindow.progress:thermometer");
		this.add(_C1);
		StringControl _C2=new StringControl();
		_C2.setText("").setAt(0,3,141,10).setCenter(null);
		this._progressUserstring=this.register(_C2,"printselectedcustomer.progresswindow.progress:userstring");
		this.add(_C2);
		StringControl _C3=new StringControl();
		_C3.setText("").setAt(0,30,141,10).setCenter(null);
		this._progressPcttext=this.register(_C3,"printselectedcustomer.progresswindow.progress:pcttext");
		this.add(_C3);
		ButtonControl _C4=new ButtonControl();
		_C4.setFlat().setIcon(Icon.NOPRINT).setText("Cancel").setAt(45,42,46,15).setLeft(null).setFont(null,null,Color.GREEN,Font.BOLD,null).setTip("Cancel Printing");
		this._progressCancel=this.register(_C4,"printselectedcustomer.progresswindow.progress:cancel");
		this.add(_C4);
	}
}
