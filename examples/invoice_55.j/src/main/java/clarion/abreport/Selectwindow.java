package clarion.abreport;

import clarion.abreport.Printpreviewclass_2;
import clarion.equates.Constants;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.GroupControl;
import org.jclarion.clarion.control.SpinControl;

@SuppressWarnings("all")
public class Selectwindow extends ClarionWindow
{
	public int _group1=0;
	public int _pagesacross=0;
	public int _pagesdown=0;
	public int _ok=0;
	public Selectwindow(Printpreviewclass_2 self)
	{
		this.setText("Change the Report Display").setAt(null,null,141,64).setFont("MS Sans Serif",10,null,null,null).setGray().setDouble();
		this.setId("printpreviewclass_2.askthumbnails.selectwindow");
		GroupControl _C1=new GroupControl();
		_C1.setText("Pages Displayed").setAt(3,2,135,43).setBoxed();
		this._group1=this.register(_C1,"printpreviewclass_2.askthumbnails.selectwindow.group1");
		this.add(_C1);
		GroupControl _C2=new GroupControl();
		_C2.setText("Across").setAt(7,10,62,32).setBoxed();
		_C1.add(_C2);
		SpinControl _C3=new SpinControl();
		_C3.setHScroll().setRange(1,10).setStep(1).setPicture("@N2").setAt(13,22,50,12);
		this._pagesacross=this.register(_C3.use(self.pagesacross),"printpreviewclass_2.askthumbnails.selectwindow.pagesacross");
		_C2.add(_C3);
		GroupControl _C4=new GroupControl();
		_C4.setText("Down").setAt(72,10,62,32).setBoxed();
		_C1.add(_C4);
		SpinControl _C5=new SpinControl();
		_C5.setHVScroll().setRange(1,10).setStep(1).setPicture("@N2").setAt(79,22,50,12);
		this._pagesdown=this.register(_C5.use(self.pagesdown),"printpreviewclass_2.askthumbnails.selectwindow.pagesdown");
		_C4.add(_C5);
		ButtonControl _C6=new ButtonControl();
		_C6.setKey(Constants.ENTERKEY).setText("OK").setAt(98,47,40,14);
		this._ok=this.register(_C6,"printpreviewclass_2.askthumbnails.selectwindow.ok");
		this.add(_C6);
	}
}
