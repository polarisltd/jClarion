package clarion.winla001;

import clarion.equates.Charset;
import clarion.equates.Color;
import clarion.equates.Font;
import clarion.winla001.QueueBrowse_1;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.ListControl;
import org.jclarion.clarion.control.SheetControl;
import org.jclarion.clarion.control.TabControl;

@SuppressWarnings("all")
public class Quickwindow_1 extends ClarionWindow
{
	public int _browse_1=0;
	public int _select_2=0;
	public int _currenttab=0;
	public int _tab_2=0;
	public int _insert_3=0;
	public int _change_3=0;
	public int _delete_3=0;
	public int _tab_3=0;
	public int _close=0;
	public Quickwindow_1(QueueBrowse_1 queueBrowse_1)
	{
		this.setText("NODALAS.tps").setAt(null,null,361,278).setFont("MS Sans Serif",9,null,Font.BOLD,null).setImmediate().setHelp("BrowseNodalas").setSystem().setGray().setResize();
		this.setId("browsenodalas.quickwindow");
		ListControl _C1=new ListControl();
		_C1.setVScroll().setFormat("15C|M*~Nr~@S2@300L(2)|M*~Kods, Nosaukums~L(5)@s97@12L(1)|M~Svars~L(2)@N3@").setFrom(queueBrowse_1).setAt(8,20,346,220).setImmediate().setMsg("Browsing Records");
		this._browse_1=this.register(_C1,"browsenodalas.quickwindow.browse:1");
		this.add(_C1);
		ButtonControl _C2=new ButtonControl();
		_C2.setText("Iz&v�l�ties").setAt(217,262,45,14).setFont(null,null,Color.NAVY,null,Charset.ANSI);
		this._select_2=this.register(_C2,"browsenodalas.quickwindow.select:2");
		this.add(_C2);
		SheetControl _C3=new SheetControl();
		_C3.setAt(4,4,353,256);
		this._currenttab=this.register(_C3,"browsenodalas.quickwindow.currenttab");
		this.add(_C3);
		TabControl _C4=new TabControl();
		_C4.setText("Numuru sec�ba");
		this._tab_2=this.register(_C4,"browsenodalas.quickwindow.tab:2");
		_C3.add(_C4);
		ButtonControl _C5=new ButtonControl();
		_C5.setText("&Ievad�t").setAt(210,243,45,14);
		this._insert_3=this.register(_C5,"browsenodalas.quickwindow.insert:3");
		_C4.add(_C5);
		ButtonControl _C6=new ButtonControl();
		_C6.setDefault().setText("&Main�t").setAt(259,243,45,14);
		this._change_3=this.register(_C6,"browsenodalas.quickwindow.change:3");
		_C4.add(_C6);
		ButtonControl _C7=new ButtonControl();
		_C7.setText("&Dz�st").setAt(308,243,45,14);
		this._delete_3=this.register(_C7,"browsenodalas.quickwindow.delete:3");
		_C4.add(_C7);
		TabControl _C8=new TabControl();
		_C8.setText("Kodu sec�ba");
		this._tab_3=this.register(_C8,"browsenodalas.quickwindow.tab:3");
		_C3.add(_C8);
		ButtonControl _C9=new ButtonControl();
		_C9.setText("&Beigt").setAt(314,263,45,14);
		this._close=this.register(_C9,"browsenodalas.quickwindow.close");
		this.add(_C9);
	}
}
