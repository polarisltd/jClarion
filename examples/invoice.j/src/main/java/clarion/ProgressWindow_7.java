package clarion;

import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ImageControl;
import org.jclarion.clarion.control.ProgressControl;
import org.jclarion.clarion.control.StringControl;

public class ProgressWindow_7 extends ClarionWindow
{
	public int _imageGenerator=0;
	public int _progressUserString=0;
	public int _progressThermometer=0;
	public int _progressPctText=0;
	public ProgressWindow_7(ClarionNumber progressThermometer)
	{
		this.setText("Progress...").setAt(null,null,160,47).setFont("Arial",8,null,null,null).setCenter().setTimer(1).setGray().setDouble();
		this.setId("wmfdocumentparser.generatereport.progresswindow");
		ImageControl _C1=new ImageControl();
		_C1.setAt(6,7,null,null);
		this._imageGenerator=this.register(_C1,"wmfdocumentparser.generatereport.progresswindow.imagegenerator");
		this.add(_C1);
		StringControl _C2=new StringControl();
		_C2.setText("Exporting to").setAt(33,8,114,10).setLeft(null);
		this._progressUserString=this.register(_C2,"wmfdocumentparser.generatereport.progresswindow.progress:userstring");
		this.add(_C2);
		ProgressControl _C3=new ProgressControl();
		_C3.setSmooth().setRange(0,100).setAt(4,31,152,7);
		this._progressThermometer=this.register(_C3.use(progressThermometer),"wmfdocumentparser.generatereport.progresswindow.progress:thermometer");
		this.add(_C3);
		StringControl _C4=new StringControl();
		_C4.setText("Page 0 of ").setAt(33,17,114,10).setTransparent().setLeft(null);
		this._progressPctText=this.register(_C4,"wmfdocumentparser.generatereport.progresswindow.progress:pcttext");
		this.add(_C4);
	}
}
