package clarion.winla_sf;

import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.PromptControl;
import org.jclarion.clarion.control.SpinControl;

@SuppressWarnings("all")
public class Jumpwindow extends ClarionWindow
{
	public int _jumpprompt=0;
	public int _jumppage=0;
	public int _okbutton=0;
	public int _cancelbutton=0;
	public Jumpwindow(ClarionNumber jumppage)
	{
		this.setText("Jump to a Report Page").setAt(null,null,181,26).setFont("MS Sans Serif",10,null,null,null).setCenter().setStatus().setGray();
		this.setId("preview:jumptopage.jumpwindow");
		PromptControl _C1=new PromptControl();
		_C1.setText("&Page:").setAt(5,8,null,null);
		this._jumpprompt=this.register(_C1,"preview:jumptopage.jumpwindow.jumpprompt");
		this.add(_C1);
		SpinControl _C2=new SpinControl();
		_C2.setStep(1).setPicture("@n5").setAt(30,7,50,12).setMsg("Select a page of the report");
		this._jumppage=this.register(_C2.use(jumppage),"preview:jumptopage.jumpwindow.jumppage");
		this.add(_C2);
		ButtonControl _C3=new ButtonControl();
		_C3.setDefault().setText("OK").setAt(89,7,40,12).setMsg("Jump to the selected page");
		this._okbutton=this.register(_C3,"preview:jumptopage.jumpwindow.okbutton");
		this.add(_C3);
		ButtonControl _C4=new ButtonControl();
		_C4.setText("Cancel").setAt(134,7,40,12).setMsg("Cancel this selection");
		this._cancelbutton=this.register(_C4,"preview:jumptopage.jumpwindow.cancelbutton");
		this.add(_C4);
	}
}
