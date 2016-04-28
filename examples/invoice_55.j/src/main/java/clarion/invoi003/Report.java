package clarion.invoi003;

import clarion.Main;
import clarion.equates.Font;
import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.control.ReportDetail;
import org.jclarion.clarion.control.ReportFooter;
import org.jclarion.clarion.control.ReportHeader;
import org.jclarion.clarion.control.StringControl;

@SuppressWarnings("all")
public class Report extends ClarionReport
{
	public int _string16=0;
	public int _detail=0;
	public int _glotCustname=0;
	public int _cusExtension=0;
	public int _cusCompany=0;
	public int _string12=0;
	public int _locAddress=0;
	public int _string11=0;
	public int _locCsz=0;
	public int _cusPhonenumber=0;
	public int _string13=0;
	public int _pagecount=0;
	public ReportDetail detail=null;
	public Report(ClarionString locAddress,ClarionString locCsz)
	{
		this.setAt(1000,1167,6500,9104).setFont("MS Serif",8,null,Font.REGULAR,null).setThous();
		ReportHeader _C1=new ReportHeader();
		_C1.setAt(1000,500,6500,760);
		this.add(_C1);
		StringControl _C2=new StringControl();
		_C2.setText("Customer Information").setAt(21,10,6448,354).setCenter(null).setFont("MS Serif",18,null,Font.BOLD+Font.UNDERLINE,null);
		this._string16=this.register(_C2);
		_C1.add(_C2);
		this.detail=new ReportDetail();
		this.detail.setAt(10,null,6500,1500);
		this._detail=this.register(this.detail);
		this.add(this.detail);
		StringControl _C3=new StringControl();
		_C3.setText("Name:").setAt(1146,94,1844,167).setTransparent().setFont("MS Serif",10,null,Font.REGULAR,null);
		this.detail.add(_C3);
		StringControl _C4=new StringControl();
		_C4.setPicture("@s35").setAt(3083,94,2604,167);
		this._glotCustname=this.register(_C4.use(Main.glotCustname));
		this.detail.add(_C4);
		StringControl _C5=new StringControl();
		_C5.setText("Company:").setAt(1146,354,1844,167).setTransparent().setFont("MS Serif",10,null,Font.REGULAR,null);
		this.detail.add(_C5);
		StringControl _C6=new StringControl();
		_C6.setPicture("@P<<<#PB").setAt(3948,1135,333,167).setRight(null);
		this._cusExtension=this.register(_C6.use(Main.customers.extension));
		this.detail.add(_C6);
		StringControl _C7=new StringControl();
		_C7.setPicture("@s20").setAt(3083,354,1719,167);
		this._cusCompany=this.register(_C7.use(Main.customers.company));
		this.detail.add(_C7);
		StringControl _C8=new StringControl();
		_C8.setText("Address:").setAt(1146,615,1844,167).setTransparent();
		this._string12=this.register(_C8);
		this.detail.add(_C8);
		StringControl _C9=new StringControl();
		_C9.setPicture("@s45").setAt(3083,615,2667,167);
		this._locAddress=this.register(_C9.use(locAddress));
		this.detail.add(_C9);
		StringControl _C10=new StringControl();
		_C10.setText("City/State/Zip:").setAt(1146,875,1844,167).setTransparent().setFont("MS Serif",10,null,Font.REGULAR,null);
		this._string11=this.register(_C10);
		this.detail.add(_C10);
		StringControl _C11=new StringControl();
		_C11.setPicture("@s45").setAt(3083,875,2552,167);
		this._locCsz=this.register(_C11.use(locCsz));
		this.detail.add(_C11);
		StringControl _C12=new StringControl();
		_C12.setPicture("@P(###) ###-####PB").setAt(3083,1135,865,167);
		this._cusPhonenumber=this.register(_C12.use(Main.customers.phonenumber));
		this.detail.add(_C12);
		StringControl _C13=new StringControl();
		_C13.setText("Phone#/Extension:").setAt(1146,1135,1844,167).setTransparent().setFont("MS Serif",10,null,Font.REGULAR,null);
		this._string13=this.register(_C13);
		this.detail.add(_C13);
		ReportFooter _C14=new ReportFooter();
		_C14.setAt(1000,10260,6500,271);
		this.add(_C14);
		StringControl _C15=new StringControl();
		_C15.setPageNo().setPicture("@pPage <<<#p").setAt(5229,31,729,188).setFont("MS Serif",10,null,Font.REGULAR,null);
		this._pagecount=this.register(_C15);
		_C14.add(_C15);
	}
}
