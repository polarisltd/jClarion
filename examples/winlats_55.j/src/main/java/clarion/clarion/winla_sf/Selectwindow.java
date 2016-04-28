package clarion.winla_sf;

import clarion.equates.Constants;
import clarion.equates.Std;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.GroupControl;
import org.jclarion.clarion.control.SpinControl;

@SuppressWarnings("all")
public class Selectwindow extends ClarionWindow
{
	public int _group1=0;
	public int _inputPagesacross=0;
	public int _inputPagesdown=0;
	public int _ok=0;
	public Selectwindow(ClarionNumber inputPagesacross,ClarionNumber inputPagesdown)
	{
		this.setText("Change the Report Display").setAt(null,null,141,64).setFont("MS Sans Serif",10,null,null,null).setGray();
		this.setId("preview:selectdisplay.selectwindow");
		GroupControl _C1=new GroupControl();
		_C1.setText("Pages Displayed").setAt(3,2,135,43).setBoxed();
		this._group1=this.register(_C1,"preview:selectdisplay.selectwindow.group1");
		this.add(_C1);
		GroupControl _C2=new GroupControl();
		_C2.setText("Across").setAt(7,10,62,32).setBoxed();
		_C1.add(_C2);
		SpinControl _C3=new SpinControl();
		_C3.setHScroll().setRange(1,10).setStep(1).setPicture("@N2").setAt(13,22,50,12);
		this._inputPagesacross=this.register(_C3.use(inputPagesacross),"preview:selectdisplay.selectwindow.input:pagesacross");
		_C2.add(_C3);
		GroupControl _C4=new GroupControl();
		_C4.setText("Down").setAt(72,10,62,32).setBoxed();
		_C1.add(_C4);
		SpinControl _C5=new SpinControl();
		_C5.setHVScroll().setRange(1,10).setStep(1).setPicture("@N2").setAt(79,22,50,12);
		this._inputPagesdown=this.register(_C5.use(inputPagesdown),"preview:selectdisplay.selectwindow.input:pagesdown");
		_C4.add(_C5);
		ButtonControl _C6=new ButtonControl();
		_C6.setKey(Constants.ENTERKEY).setText("OK").setAt(98,47,40,14).setStandard(Std.CLOSE);
		this._ok=this.register(_C6,"preview:selectdisplay.selectwindow.ok");
		this.add(_C6);
	}
}
