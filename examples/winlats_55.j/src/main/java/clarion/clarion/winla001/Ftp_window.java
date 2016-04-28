package clarion.winla001;

import clarion.equates.Charset;
import clarion.equates.Color;
import clarion.equates.Font;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.control.ButtonControl;
import org.jclarion.clarion.control.StringControl;

@SuppressWarnings("all")
public class Ftp_window extends ClarionWindow
{
	public int _string1=0;
	public int _string10=0;
	public int _string2=0;
	public int _string4=0;
	public int _ftpdatums=0;
	public int _string5=0;
	public int _wldatums=0;
	public int _string11=0;
	public int _string6=0;
	public int _string7=0;
	public int _string12=0;
	public int _okbutton=0;
	public int _cancelbutton=0;
	public Ftp_window(ClarionNumber ftpdatums,ClarionNumber wldatums)
	{
		this.setText("Jaun�ko versiju lejupl�de").setAt(null,null,318,102).setFont("MS Sans Serif",9,null,Font.BOLD,Charset.BALTIC).setCenter().setGray();
		this.setId("main.ftp_window");
		StringControl _C1=new StringControl();
		_C1.setText("Labdien!").setAt(32,7,null,null).setFont(null,10,Color.NAVY,Font.BOLD,Charset.ANSI);
		this._string1=this.register(_C1,"main.ftp_window.string1");
		this.add(_C1);
		StringControl _C2=new StringControl();
		_C2.setText("Tikai garantijas vai p�cgarantijas noteikumu darb�bas laik�:").setAt(26,20,null,null);
		this._string10=this.register(_C2,"main.ftp_window.string10");
		this.add(_C2);
		StringControl _C3=new StringControl();
		_C3.setText("www.assako.lv").setAt(26,29,null,null).setFont(null,null,Color.NAVY,Font.UNDERLINE,Charset.ANSI);
		this._string2=this.register(_C3,"main.ftp_window.string2");
		this.add(_C3);
		StringControl _C4=new StringControl();
		_C4.setText(" ir pieejama WinLats versija 2.11 ar p�d�j�m izmai��m").setAt(69,29,null,null);
		this._string4=this.register(_C4,"main.ftp_window.string4");
		this.add(_C4);
		StringControl _C5=new StringControl();
		_C5.setPicture("@D06.B").setAt(246,29,null,null);
		this._ftpdatums=this.register(_C5.use(ftpdatums),"main.ftp_window.ftpdatums");
		this.add(_C5);
		StringControl _C6=new StringControl();
		_C6.setText("Lai sekm�gi veiktu lejupl�di un aizvietotu J�su winlats.exe  no").setAt(26,38,null,null);
		this._string5=this.register(_C6,"main.ftp_window.string5");
		this.add(_C6);
		StringControl _C7=new StringControl();
		_C7.setPicture("@D06.B").setAt(227,38,null,null).setCenter(null);
		this._wldatums=this.register(_C7.use(wldatums),"main.ftp_window.wldatums");
		this.add(_C7);
		StringControl _C8=new StringControl();
		_C8.setText(",").setAt(273,38,null,null);
		this._string11=this.register(_C8,"main.ftp_window.string11");
		this.add(_C8);
		StringControl _C9=new StringControl();
		_C9.setText("visiem p�r�jiem lietot�jiem nepiecie�ams uz br�di beigt darbu ar WinLatu.").setAt(26,48,null,null);
		this._string6=this.register(_C9,"main.ftp_window.string6");
		this.add(_C9);
		StringControl _C10=new StringControl();
		_C10.setText("Vecais exe fails tiks saglab�ts k� winlats_old.exe").setAt(26,58,null,null);
		this._string7=this.register(_C10,"main.ftp_window.string7");
		this.add(_C10);
		StringControl _C11=new StringControl();
		_C11.setText("P�c veiksm�gas atjauno�anas WinLats b�s j�palai� v�lreiz.").setAt(26,67,null,null);
		this._string12=this.register(_C11,"main.ftp_window.string12");
		this.add(_C11);
		ButtonControl _C12=new ButtonControl();
		_C12.setDefault().setText("Veikt lejupl�di").setAt(251,78,62,14);
		this._okbutton=this.register(_C12,"main.ftp_window.okbutton");
		this.add(_C12);
		ButtonControl _C13=new ButtonControl();
		_C13.setText("Citreiz").setAt(212,78,36,14);
		this._cancelbutton=this.register(_C13,"main.ftp_window.cancelbutton");
		this.add(_C13);
	}
}
