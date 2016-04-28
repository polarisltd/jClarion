package clarion.invoi002;

import clarion.Main;
import clarion.equates.Font;
import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.control.ReportDetail;
import org.jclarion.clarion.control.StringControl;

@SuppressWarnings("all")
public class Report_3 extends ClarionReport
{
	public int _detail=0;
	public int _ordShiptoname=0;
	public int _glotShipaddress=0;
	public int _glotShipcsz=0;
	public ReportDetail detail=null;
	public Report_3()
	{
		this.setAt(250,448,8198,10500).setFont("MS Serif",10,null,Font.REGULAR,null).setThous();
		this.detail=new ReportDetail();
		this.detail.setAt(31,10,2656,979);
		this._detail=this.register(this.detail);
		this.add(this.detail);
		StringControl _C1=new StringControl();
		_C1.setPicture("@s45").setAt(115,156,2542,167);
		this._ordShiptoname=this.register(_C1.use(Main.orders.shiptoname));
		this.detail.add(_C1);
		StringControl _C2=new StringControl();
		_C2.setPicture("@s45").setAt(115,323,2521,167);
		this._glotShipaddress=this.register(_C2.use(Main.glotShipaddress));
		this.detail.add(_C2);
		StringControl _C3=new StringControl();
		_C3.setPicture("@s40").setAt(115,490,2531,167);
		this._glotShipcsz=this.register(_C3.use(Main.glotShipcsz));
		this.detail.add(_C3);
	}
}
