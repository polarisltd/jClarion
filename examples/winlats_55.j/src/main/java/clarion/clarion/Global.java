package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Global extends ClarionSQLFile
{
	public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString reg_nr=Clarion.newString(11);
	public ClarionString vid_nr=Clarion.newString(13);
	public ClarionString soc_nr=Clarion.newString(7);
	public ClarionString vid_nos=Clarion.newString(25);
	public ClarionString vid_lnr=Clarion.newString(6);
	public ClarionNumber nace=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionString adrese=Clarion.newString(60);
	public ClarionString fmi_tips=Clarion.newString(4);
	public ClarionNumber mau_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber kie_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber kiz_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber iesk_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber rek_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber pil_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber invoice_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber garant_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber rik_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber free_n=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionDecimal ean_nr=Clarion.newDecimal(13,0);
	public ClarionArray<ClarionString> bkods=Clarion.newString(15).dim(10);
	public ClarionArray<ClarionString> rek=Clarion.newString(34).dim(10);
	public ClarionArray<ClarionString> kor=Clarion.newString(11).dim(10);
	public ClarionArray<ClarionString> bkk=Clarion.newString(5).dim(10);
	public ClarionNumber d_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber d_laiks=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionDecimal db_gads=Clarion.newDecimal(4,0);
	public ClarionNumber db_s_dat=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber db_b_dat=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber client_u_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber vidpvn_u_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber free_u_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber baits1=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey pkglobal=new ClarionKey("PKGlobal");

	public Global()
	{
		setName(Clarion.newString("GLOBAL"));
		setPrefix("GL");
		setCreate();
		this.addVariable("ID",this.id);
		this.addVariable("REG_NR",this.reg_nr);
		this.addVariable("VID_NR",this.vid_nr);
		this.addVariable("SOC_NR",this.soc_nr);
		this.addVariable("VID_NOS",this.vid_nos);
		this.addVariable("VID_LNR",this.vid_lnr);
		this.addVariable("NACE",this.nace);
		this.addVariable("ADRESE",this.adrese);
		this.addVariable("FMI_TIPS",this.fmi_tips);
		this.addVariable("MAU_NR",this.mau_nr);
		this.addVariable("KIE_NR",this.kie_nr);
		this.addVariable("KIZ_NR",this.kiz_nr);
		this.addVariable("IESK_NR",this.iesk_nr);
		this.addVariable("REK_NR",this.rek_nr);
		this.addVariable("PIL_NR",this.pil_nr);
		this.addVariable("INVOICE_NR",this.invoice_nr);
		this.addVariable("GARANT_NR",this.garant_nr);
		this.addVariable("RIK_NR",this.rik_nr);
		this.addVariable("FREE_N",this.free_n);
		this.addVariable("EAN_NR",this.ean_nr);
		this.addVariable("BKODS",this.bkods);
		this.addVariable("REK",this.rek);
		this.addVariable("KOR",this.kor);
		this.addVariable("BKK",this.bkk);
		this.addVariable("D_DATUMS",this.d_datums);
		this.addVariable("D_LAIKS",this.d_laiks);
		this.addVariable("DB_GADS",this.db_gads);
		this.addVariable("DB_S_DAT",this.db_s_dat);
		this.addVariable("DB_B_DAT",this.db_b_dat);
		this.addVariable("CLIENT_U_NR",this.client_u_nr);
		this.addVariable("VIDPVN_U_NR",this.vidpvn_u_nr);
		this.addVariable("FREE_U_NR",this.free_u_nr);
		this.addVariable("BAITS",this.baits);
		this.addVariable("BAITS1",this.baits1);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		pkglobal.setName("PK_GLOBAL").setPrimary().addAscendingField(id);
		this.addKey(pkglobal);
	}
}
