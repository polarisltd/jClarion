package clarion.winla002;

import clarion.Main;
import clarion.equates.Charset;
import clarion.equates.Color;
import clarion.equates.Constants;
import clarion.equates.Font;
import clarion.winla002.QueueBrowse_1;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.EntryControl;
import org.jclarion.clarion.control.ListControl;
import org.jclarion.clarion.control.SheetControl;
import org.jclarion.clarion.control.StringControl;
import org.jclarion.clarion.control.TabControl;

@SuppressWarnings("all")
public class Quickwindow_1 extends ClarionWindow
{
	public int _browse_1=0;
	public int _insert_2=0;
	public int _change=0;
	public int _delete_2=0;
	public int _kopet=0;
	public int _currenttab=0;
	public int _tab_3=0;
	public int _banKods=0;
	public int _string2=0;
	public int _tab_2=0;
	public int _banNos_a=0;
	public int _string1=0;
	public int _select=0;
	public int _close=0;
	public Quickwindow_1(QueueBrowse_1 queueBrowse_1)
	{
		this.setText("Browse the BANKAS_K File").setAt(null,null,268,238).setFont("MS Sans Serif",9,null,Font.BOLD,null).setImmediate().setVScroll().setHelp("BrowseBANKAS_K").setSystem().setGray().setResize();
		this.setId("browsebankas_k.quickwindow");
		ListControl _C1=new ListControl();
		_C1.setVScroll().setFormat(ClarionString.staticConcat("49L|M~Bankas kods~L(2)@s11@64L|M~Saīsinātais nosaukums~L(1)@s15@126L|M~Pilnais n","osaukums~L(2)@s31@")).setFrom(queueBrowse_1).setAt(5,20,257,178).setImmediate().setMsg("Browsing Records");
		this._browse_1=this.register(_C1,"browsebankas_k.quickwindow.browse:1");
		this.add(_C1);
		ButtonControl _C2=new ButtonControl();
		_C2.setText("&Ievadīt").setAt(110,201,45,14);
		this._insert_2=this.register(_C2,"browsebankas_k.quickwindow.insert:2");
		this.add(_C2);
		ButtonControl _C3=new ButtonControl();
		_C3.setDefault().setText("&Mainīt").setAt(158,201,45,14);
		this._change=this.register(_C3,"browsebankas_k.quickwindow.change");
		this.add(_C3);
		ButtonControl _C4=new ButtonControl();
		_C4.setText("&Dzēst").setAt(207,201,45,14);
		this._delete_2=this.register(_C4,"browsebankas_k.quickwindow.delete:2");
		this.add(_C4);
		ButtonControl _C5=new ButtonControl();
		_C5.setText("&C-Kopēt").setAt(111,222,45,14);
		this._kopet=this.register(_C5,"browsebankas_k.quickwindow.kopet");
		this.add(_C5);
		SheetControl _C6=new SheetControl();
		_C6.setAt(2,4,263,215);
		this._currenttab=this.register(_C6,"browsebankas_k.quickwindow.currenttab");
		this.add(_C6);
		TabControl _C7=new TabControl();
		_C7.setText("&Kodu secība");
		this._tab_3=this.register(_C7,"browsebankas_k.quickwindow.tab:3");
		_C6.add(_C7);
		EntryControl _C8=new EntryControl();
		_C8.setPicture("@s11").setAt(7,201,null,null).setMsg("Bankas kods");
		this._banKods=this.register(_C8.use(Main.bankas_k.kods),"browsebankas_k.quickwindow.ban:kods");
		_C7.add(_C8);
		StringControl _C9=new StringControl();
		_C9.setText("-pēc koda").setAt(63,202,null,null);
		this._string2=this.register(_C9,"browsebankas_k.quickwindow.string2");
		_C7.add(_C9);
		TabControl _C10=new TabControl();
		_C10.setText("&Nosaukumu sec�ba");
		this._tab_2=this.register(_C10,"browsebankas_k.quickwindow.tab:2");
		_C6.add(_C10);
		EntryControl _C11=new EntryControl();
		_C11.setPicture("@s4").setAt(7,202,null,null);
		this._banNos_a=this.register(_C11.use(Main.bankas_k.nos_a),"browsebankas_k.quickwindow.ban:nos_a");
		_C10.add(_C11);
		StringControl _C12=new StringControl();
		_C12.setText("-pēc nosaukuma").setAt(36,203,null,null);
		this._string1=this.register(_C12,"browsebankas_k.quickwindow.string1");
		_C10.add(_C12);
		ButtonControl _C13=new ButtonControl();
		_C13.setKey(Constants.ENTERKEY).setText("Iz&vēlēties").setAt(159,222,null,null).setFont(null,null,Color.NAVY,null,Charset.ANSI);
		this._select=this.register(_C13,"browsebankas_k.quickwindow.select");
		this.add(_C13);
		ButtonControl _C14=new ButtonControl();
		_C14.setText("&Beigt").setAt(219,222,45,14);
		this._close=this.register(_C14,"browsebankas_k.quickwindow.close");
		this.add(_C14);
	}
}
