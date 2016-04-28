package clarion.invoi002;

import clarion.Main;
import clarion.equates.Font;
import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.control.ImageControl;
import org.jclarion.clarion.control.ReportDetail;
import org.jclarion.clarion.control.ReportFooter;
import org.jclarion.clarion.control.ReportHeader;
import org.jclarion.clarion.control.StringControl;

@SuppressWarnings("all")
public class Report_4 extends ClarionReport
{
	public int _detail=0;
	public int _image1=0;
	public int _proProductsku=0;
	public int _proDescription=0;
	public int _string12=0;
	public int _proPrice=0;
	public int _string14=0;
	public int _proCost=0;
	public int _proReorderquantity=0;
	public int _proQuantityinstock=0;
	public int _pagecount=0;
	public ReportDetail detail=null;
	public Report_4()
	{
		this.setAt(1000,896,6500,9125).setFont("Arial",10,null,null,null).setThous();
		ReportHeader _C1=new ReportHeader();
		_C1.setAt(1000,458,6500,427);
		this.add(_C1);
		StringControl _C2=new StringControl();
		_C2.setText(" Product Information").setAt(21,10,6458,240).setCenter(null).setFont("MS Serif",14,null,Font.BOLD+Font.UNDERLINE,null);
		_C1.add(_C2);
		this.detail=new ReportDetail();
		this.detail.setAt(null,null,7500,1792);
		this._detail=this.register(this.detail);
		this.add(this.detail);
		StringControl _C3=new StringControl();
		_C3.setText("Product SKU:").setAt(219,10,896,188).setTransparent();
		this.detail.add(_C3);
		ImageControl _C4=new ImageControl();
		_C4.setAt(4417,10,1885,1771);
		this._image1=this.register(_C4);
		this.detail.add(_C4);
		StringControl _C5=new StringControl();
		_C5.setPicture("@s10").setAt(1542,10,896,167);
		this._proProductsku=this.register(_C5.use(Main.products.productsku));
		this.detail.add(_C5);
		StringControl _C6=new StringControl();
		_C6.setPicture("@s35").setAt(1542,313,2375,167);
		this._proDescription=this.register(_C6.use(Main.products.description));
		this.detail.add(_C6);
		StringControl _C7=new StringControl();
		_C7.setText("Quantity In Stock:").setAt(219,615,1135,188).setTransparent();
		this.detail.add(_C7);
		StringControl _C8=new StringControl();
		_C8.setText("Re-order Quantity:").setAt(219,917,1188,188).setTransparent();
		this._string12=this.register(_C8);
		this.detail.add(_C8);
		StringControl _C9=new StringControl();
		_C9.setText("Unit Price:").setAt(219,1219,698,188).setTransparent();
		this.detail.add(_C9);
		StringControl _C10=new StringControl();
		_C10.setPicture("@n$10.2B").setAt(1542,1208,771,208);
		this._proPrice=this.register(_C10.use(Main.products.price));
		this.detail.add(_C10);
		StringControl _C11=new StringControl();
		_C11.setText("Unit Cost:").setAt(219,1542,null,null).setTransparent();
		this._string14=this.register(_C11);
		this.detail.add(_C11);
		StringControl _C12=new StringControl();
		_C12.setPicture("@n$10.2B").setAt(1542,1542,null,null);
		this._proCost=this.register(_C12.use(Main.products.cost));
		this.detail.add(_C12);
		StringControl _C13=new StringControl();
		_C13.setText("Description:").setAt(219,313,802,188).setTransparent();
		this.detail.add(_C13);
		StringControl _C14=new StringControl();
		_C14.setPicture("@n6").setAt(1542,917,563,167).setRight(null);
		this._proReorderquantity=this.register(_C14.use(Main.products.reorderquantity));
		this.detail.add(_C14);
		StringControl _C15=new StringControl();
		_C15.setPicture("@n-7").setAt(1542,615,573,167).setRight(null);
		this._proQuantityinstock=this.register(_C15.use(Main.products.quantityinstock));
		this.detail.add(_C15);
		ReportFooter _C16=new ReportFooter();
		_C16.setAt(1000,10042,6500,240);
		this.add(_C16);
		StringControl _C17=new StringControl();
		_C17.setPageNo().setPicture("@pPage <<<#p").setAt(5542,10,865,208).setFont("Arial",10,null,null,null);
		this._pagecount=this.register(_C17);
		_C16.add(_C17);
	}
}
