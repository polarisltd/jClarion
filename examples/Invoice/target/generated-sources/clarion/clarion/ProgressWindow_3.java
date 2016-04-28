package clarion;

import clarion.equates.Color;
import clarion.equates.Font;
import clarion.equates.Icon;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.ProgressControl;
import org.jclarion.clarion.control.StringControl;

public class ProgressWindow_3 extends ClarionWindow
{
	public int _progressThermometer=0;
	public int _progressUserString=0;
	public int _progressPctText=0;
	public int _progressCancel=0;
	public ProgressWindow_3(ClarionNumber progressThermometer)
	{
		this.setText("Report Progress...").setAt(null,null,142,59).setCenter().setTimer(1).setGray().setDouble();
		this.setId("printmailinglabels.progresswindow");
		ProgressControl _C1=new ProgressControl();
		_C1.setRange(0,100).setAt(15,15,111,12);
		this._progressThermometer=this.register(_C1.use(progressThermometer),"printmailinglabels.progresswindow.progress:thermometer");
		this.add(_C1);
		StringControl _C2=new StringControl();
		_C2.setText("").setAt(0,3,141,10).setCenter(null);
		this._progressUserString=this.register(_C2,"printmailinglabels.progresswindow.progress:userstring");
		this.add(_C2);
		StringControl _C3=new StringControl();
		_C3.setText("").setAt(0,30,141,10).setCenter(null);
		this._progressPctText=this.register(_C3,"printmailinglabels.progresswindow.progress:pcttext");
		this.add(_C3);
		ButtonControl _C4=new ButtonControl();
		_C4.setFlat().setIcon(Icon.NOPRINT).setText("Cancel").setAt(45,42,48,15).setLeft(null).setFont(null,null,Color.GREEN,Font.BOLD,null).setTip("Cancel Printing");
		this._progressCancel=this.register(_C4,"printmailinglabels.progresswindow.progress:cancel");
		this.add(_C4);
	}
}
