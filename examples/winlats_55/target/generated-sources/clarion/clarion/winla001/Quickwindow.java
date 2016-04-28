package clarion.winla001;

import clarion.Main;
import clarion.equates.Font;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.EntryControl;
import org.jclarion.clarion.control.PromptControl;
import org.jclarion.clarion.control.SheetControl;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.control.TabControl;

@SuppressWarnings("all")
public class Quickwindow extends ClarionWindow
{
	public int _currenttab=0;
	public int _tab_1=0;
	public int _nodU_nrPrompt=0;
	public int _nodU_nr=0;
	public int _string1=0;
	public int _nodKodsPrompt=0;
	public int _nodKods=0;
	public int _nodNos_pPrompt=0;
	public int _nodNos_p=0;
	public int _promptSvars=0;
	public int _nodSvars=0;
	public int _ok=0;
	public int _cancel=0;
	public Quickwindow()
	{
		this.setText("Update the NODALAS File").setAt(null,null,362,116).setFont("MS Sans Serif",9,null,Font.BOLD,null).setImmediate().setHelp("UpdateNodalas").setSystem().setGray().setResize();
		this.setId("updatenodalas.quickwindow");
		SheetControl _C1=new SheetControl();
		_C1.setAt(4,4,357,95);
		this._currenttab=this.register(_C1,"updatenodalas.quickwindow.currenttab");
		this.add(_C1);
		TabControl _C2=new TabControl();
		_C2.setText("Noda�a");
		this._tab_1=this.register(_C2,"updatenodalas.quickwindow.tab:1");
		_C1.add(_C2);
		PromptControl _C3=new PromptControl();
		_C3.setText("No&da�a:").setAt(7,31,null,null);
		this._nodU_nrPrompt=this.register(_C3,"updatenodalas.quickwindow.nod:u_nr:prompt");
		_C2.add(_C3);
		EntryControl _C4=new EntryControl();
		_C4.setRequired().setPicture("@S2").setAt(48,31,15,10).setLeft(null);
		this._nodU_nr=this.register(_C4.use(Main.nodalas.u_nr),"updatenodalas.quickwindow.nod:u_nr");
		_C2.add(_C4);
		StringControl _C5=new StringControl();
		_C5.setText("(aizpildiet abas z�mes; virsrakstiem-pirmo)").setAt(67,32,null,null);
		this._string1=this.register(_C5,"updatenodalas.quickwindow.string1");
		_C2.add(_C5);
		PromptControl _C6=new PromptControl();
		_C6.setText("Kods:").setAt(7,44,null,null);
		this._nodKodsPrompt=this.register(_C6,"updatenodalas.quickwindow.nod:kods:prompt");
		_C2.add(_C6);
		EntryControl _C7=new EntryControl();
		_C7.setPicture("@s6").setAt(48,44,35,10);
		this._nodKods=this.register(_C7.use(Main.nodalas.kods),"updatenodalas.quickwindow.nod:kods");
		_C2.add(_C7);
		PromptControl _C8=new PromptControl();
		_C8.setText("&Nosaukums:").setAt(7,57,43,10);
		this._nodNos_pPrompt=this.register(_C8,"updatenodalas.quickwindow.nod:nos_p:prompt");
		_C2.add(_C8);
		EntryControl _C9=new EntryControl();
		_C9.setPicture("@S90").setAt(48,57,311,10);
		this._nodNos_p=this.register(_C9.use(Main.nodalas.nos_p),"updatenodalas.quickwindow.nod:nos_p");
		_C2.add(_C9);
		PromptControl _C10=new PromptControl();
		_C10.setText("&Svars:").setAt(7,70,24,10);
		this._promptSvars=this.register(_C10,"updatenodalas.quickwindow.prompt:svars");
		_C2.add(_C10);
		EntryControl _C11=new EntryControl();
		_C11.setPicture("@N2").setAt(48,70,40,10).setRight(1);
		this._nodSvars=this.register(_C11.use(Main.nodalas.svars),"updatenodalas.quickwindow.nod:svars");
		_C2.add(_C11);
		ButtonControl _C12=new ButtonControl();
		_C12.setDefault().setText("&OK").setAt(266,101,45,14);
		this._ok=this.register(_C12,"updatenodalas.quickwindow.ok");
		this.add(_C12);
		ButtonControl _C13=new ButtonControl();
		_C13.setText("&Atlikt").setAt(315,101,45,14);
		this._cancel=this.register(_C13,"updatenodalas.quickwindow.cancel");
		this.add(_C13);
	}
}
