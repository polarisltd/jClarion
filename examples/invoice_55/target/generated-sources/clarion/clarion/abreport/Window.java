package clarion.abreport;

import clarion.abreport.Printpreviewclass_2;
import clarion.equates.Font;
import clarion.equates.Std;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.EntryControl;
import org.jclarion.clarion.control.PromptControl;

@SuppressWarnings("all")
public class Window extends ClarionWindow
{
	public int _prompt=0;
	public int _pagestoprint=0;
	public int _reset=0;
	public int _ok=0;
	public int _cancel=0;
	public Window(Printpreviewclass_2 self)
	{
		this.setText("Pages to Print").setAt(null,null,260,37).setFont("MS Sans Serif",8,null,Font.REGULAR,null).setCenter().setSystem().setGray().setResize();
		this.setId("printpreviewclass_2.askprintpages.window");
		PromptControl _C1=new PromptControl();
		_C1.setText("&Pages to Print:").setAt(4,8,null,null);
		this._prompt=this.register(_C1,"printpreviewclass_2.askprintpages.window.prompt");
		this.add(_C1);
		EntryControl _C2=new EntryControl();
		_C2.setPicture("@s255").setAt(56,4,200,11);
		this._pagestoprint=this.register(_C2.use(self.pagestoprint),"printpreviewclass_2.askprintpages.window.pagestoprint");
		this.add(_C2);
		ButtonControl _C3=new ButtonControl();
		_C3.setText("&Reset").setAt(116,20,45,14);
		this._reset=this.register(_C3,"printpreviewclass_2.askprintpages.window.reset");
		this.add(_C3);
		ButtonControl _C4=new ButtonControl();
		_C4.setDefault().setText("&Ok").setAt(164,20,45,14);
		this._ok=this.register(_C4,"printpreviewclass_2.askprintpages.window.ok");
		this.add(_C4);
		ButtonControl _C5=new ButtonControl();
		_C5.setText("&Cancel").setAt(212,20,45,14).setStandard(Std.CLOSE);
		this._cancel=this.register(_C5,"printpreviewclass_2.askprintpages.window.cancel");
		this.add(_C5);
	}
}
