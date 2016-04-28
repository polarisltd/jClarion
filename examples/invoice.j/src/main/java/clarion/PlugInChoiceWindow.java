package clarion;

import clarion.equates.Charset;
import clarion.equates.Color;
import clarion.equates.Font;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.OptionControl;

public class PlugInChoiceWindow extends ClarionWindow
{
	public int _lPlugInChoice=0;
	public int _bOk=0;
	public int _bCancel=0;
	public PlugInChoiceWindow(ClarionNumber lPlugInChoice)
	{
		this.setText("Select an Output").setAt(null,null,103,30).setFont("Arial",8,Color.BLACK,Font.REGULAR,Charset.ANSI).setCenter().setImmediate().setSystem().setGray().setDouble().setMask();
		this.setId("reporttargetselectorclass.ask.pluginchoicewindow");
		OptionControl _C1=new OptionControl();
		_C1.setAt(0,0,16,12).setFont("Arial",8,Color.BLACK,Font.REGULAR,Charset.ANSI);
		this._lPlugInChoice=this.register(_C1.use(lPlugInChoice),"reporttargetselectorclass.ask.pluginchoicewindow.lpluginchoice");
		this.add(_C1);
		ButtonControl _C2=new ButtonControl();
		_C2.setIcon("WAOk.ico").setDefault().setText("&OK").setAt(1,14,47,14).setLeft(null).setFont("MS Sans Serif",8,null,Font.REGULAR,null);
		this._bOk=this.register(_C2,"reporttargetselectorclass.ask.pluginchoicewindow.bok");
		this.add(_C2);
		ButtonControl _C3=new ButtonControl();
		_C3.setIcon("WACancel.ico").setText("&Cancel").setAt(55,14,47,14).setLeft(null).setFont("MS Sans Serif",8,null,Font.REGULAR,null);
		this._bCancel=this.register(_C3,"reporttargetselectorclass.ask.pluginchoicewindow.bcancel");
		this.add(_C3);
	}
}
