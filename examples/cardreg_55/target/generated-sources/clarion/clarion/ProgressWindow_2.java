package clarion;

import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.ProgressControl;
import org.jclarion.clarion.control.StringControl;

public class ProgressWindow_2 extends ClarionWindow
{
	public int _progressThermometer=0;
	public int _progressUserString=0;
	public int _progressPctText=0;
	public int _progressCancel=0;
	public ProgressWindow_2(ClarionNumber progressThermometer)
	{
		this.setText("Report Progress...").setAt(null,null,142,59).setCenter().setTimer(1).setGray().setDouble();
		this.setId("printaccounttransactionhistory.progresswindow");
		ProgressControl _C1=new ProgressControl();
		_C1.setRange(0,100).setAt(15,15,111,12);
		this._progressThermometer=this.register(_C1.use(progressThermometer),"printaccounttransactionhistory.progresswindow.progress:thermometer");
		this.add(_C1);
		StringControl _C2=new StringControl();
		_C2.setText("").setAt(0,3,141,10).setCenter(null);
		this._progressUserString=this.register(_C2,"printaccounttransactionhistory.progresswindow.progress:userstring");
		this.add(_C2);
		StringControl _C3=new StringControl();
		_C3.setText("").setAt(0,30,141,10).setCenter(null);
		this._progressPctText=this.register(_C3,"printaccounttransactionhistory.progresswindow.progress:pcttext");
		this.add(_C3);
		ButtonControl _C4=new ButtonControl();
		_C4.setText("Cancel").setAt(45,42,50,15);
		this._progressCancel=this.register(_C4,"printaccounttransactionhistory.progresswindow.progress:cancel");
		this.add(_C4);
	}
}
