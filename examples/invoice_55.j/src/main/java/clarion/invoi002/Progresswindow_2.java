package clarion.invoi002;

import clarion.Main;
import clarion.equates.Color;
import clarion.equates.Font;
import clarion.equates.Icon;
import clarion.invoi002.QueueFiledrop;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.ListControl;
import org.jclarion.clarion.control.ProgressControl;
import org.jclarion.clarion.control.StringControl;

@SuppressWarnings("all")
public class Progresswindow_2 extends ClarionWindow
{
	public int _progressThermometer=0;
	public int _progressUserstring=0;
	public int _progressPcttext=0;
	public int _string3=0;
	public int _ordInvoicenumber_2=0;
	public int _progressCancel=0;
	public int _pause=0;
	public Progresswindow_2(ClarionNumber progressThermometer,QueueFiledrop queueFiledrop)
	{
		this.setText("Report Progress...").setAt(null,null,168,94).setCenter().setTimer(1).setGray().setDouble();
		this.setId("printinvoice.progresswindow");
		ProgressControl _C1=new ProgressControl();
		_C1.setRange(0,100).setAt(24,15,111,12);
		this._progressThermometer=this.register(_C1.use(progressThermometer),"printinvoice.progresswindow.progress:thermometer");
		this.add(_C1);
		StringControl _C2=new StringControl();
		_C2.setText("").setAt(3,3,162,10).setCenter(null);
		this._progressUserstring=this.register(_C2,"printinvoice.progresswindow.progress:userstring");
		this.add(_C2);
		StringControl _C3=new StringControl();
		_C3.setText("").setAt(3,30,162,10).setCenter(null);
		this._progressPcttext=this.register(_C3,"printinvoice.progresswindow.progress:pcttext");
		this.add(_C3);
		StringControl _C4=new StringControl();
		_C4.setText("Select An Invoice And Press Go To Preview").setAt(2,44,164,10).setCenter(null).setFont(null,null,Color.MAROON,Font.BOLD,null);
		this._string3=this.register(_C4,"printinvoice.progresswindow.string3");
		this.add(_C4);
		ListControl _C5=new ListControl();
		_C5.setVScroll().setFormat("33L(3)|~Invoice #~L(2)@n07@41L(3)|~Order Date~L(2)@d1@180L(2)|~Ship To~@s45@").setDrop(5).setFrom(queueFiledrop).setAt(9,60,150,12).setMsg("Invoice number for each order");
		this._ordInvoicenumber_2=this.register(_C5.use(Main.orders.invoicenumber),"printinvoice.progresswindow.ord:invoicenumber:2");
		this.add(_C5);
		ButtonControl _C6=new ButtonControl();
		_C6.setIcon(Icon.NOPRINT).setText("Exit").setAt(115,77,44,13).setLeft(null).setFont(null,null,Color.GREEN,Font.BOLD,null).setTip("Exit window or cancel printing");
		this._progressCancel=this.register(_C6,"printinvoice.progresswindow.progress:cancel");
		this.add(_C6);
		ButtonControl _C7=new ButtonControl();
		_C7.setIcon(Icon.PRINT1).setText("Pause").setAt(9,77,44,13).setLeft(null).setFont(null,null,Color.GREEN,Font.BOLD,null).setTip("Preview Invoice to Print");
		this._pause=this.register(_C7,"printinvoice.progresswindow.pause");
		this.add(_C7);
	}
}
