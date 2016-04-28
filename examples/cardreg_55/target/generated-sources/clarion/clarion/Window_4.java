package clarion;

import clarion.Main;
import clarion.equates.Font;
import clarion.equates.Icon;
import clarion.equates.Std;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.SpinControl;
import org.jclarion.clarion.control.StringControl;

public class Window_4 extends ClarionWindow
{
	public int _string1=0;
	public int _string2=0;
	public int _gLOLowDate=0;
	public int _string3=0;
	public int _gLOHighDate=0;
	public int _okButton=0;
	public int _cancelButton=0;
	public int _helpButton=0;
	public Window_4()
	{
		this.setText("Date Ranges for Report").setAt(null,null,171,83).setImmediate().setIcon("CREDCARD.ICO").setHelp("~DateRangesForm").setSystem().setGray();
		this.setId("updatedates.window");
		StringControl _C1=new StringControl();
		_C1.setText("Input Range of Dates for Report Selected...").setAt(19,13,null,null).setFont("Arial",9,null,Font.BOLD,null);
		this._string1=this.register(_C1,"updatedates.window.string1");
		this.add(_C1);
		StringControl _C2=new StringControl();
		_C2.setText("Start Date:").setAt(35,30,null,null).setFont("Arial",9,null,Font.BOLD,null);
		this._string2=this.register(_C2,"updatedates.window.string2");
		this.add(_C2);
		SpinControl _C3=new SpinControl();
		_C3.setRange(4,109211).setStep(1).setPicture("@d2").setAt(71,29,50,12).setCenter(null);
		this._gLOLowDate=this.register(_C3.use(Main.gLOLowDate),"updatedates.window.glo:lowdate");
		this.add(_C3);
		StringControl _C4=new StringControl();
		_C4.setText("End Date:").setAt(38,47,null,null).setFont("Arial",9,null,Font.BOLD,null);
		this._string3=this.register(_C4,"updatedates.window.string3");
		this.add(_C4);
		SpinControl _C5=new SpinControl();
		_C5.setRange(4,109211).setStep(1).setPicture("@d2").setAt(71,46,50,12);
		this._gLOHighDate=this.register(_C5.use(Main.gLOHighDate),"updatedates.window.glo:highdate");
		this.add(_C5);
		ButtonControl _C6=new ButtonControl();
		_C6.setDefault().setText("OK").setAt(46,63,30,15).setFont("Arial",10,null,Font.BOLD,null).setStandard(Std.CLOSE);
		this._okButton=this.register(_C6,"updatedates.window.okbutton");
		this.add(_C6);
		ButtonControl _C7=new ButtonControl();
		_C7.setText("Cancel").setAt(79,63,30,15).setFont("Arial",10,null,Font.BOLD,null).setStandard(Std.CLOSE);
		this._cancelButton=this.register(_C7,"updatedates.window.cancelbutton");
		this.add(_C7);
		ButtonControl _C8=new ButtonControl();
		_C8.setIcon(Icon.HELP).setAt(115,63,16,15).setStandard(Std.HELP);
		this._helpButton=this.register(_C8,"updatedates.window.helpbutton");
		this.add(_C8);
	}
}
