package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Pamat extends ClarionSQLFile
{
	public ClarionNumber u_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString nodala=Clarion.newString(2);
	public ClarionNumber obj_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber atb_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString atb_nos=Clarion.newString(25);
	public ClarionNumber izg_gad=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber expl_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString dok_senr=Clarion.newString(14);
	public ClarionString nos_p=Clarion.newString(35);
	public ClarionString nos_s=Clarion.newString(15);
	public ClarionString nos_a=Clarion.newString(5);
	public ClarionString bkk=Clarion.newString(5);
	public ClarionString bkkn=Clarion.newString(5);
	public ClarionString okk7=Clarion.newString(5);
	public ClarionDecimal iep_v=Clarion.newDecimal(11,2);
	public ClarionDecimal kap_v=Clarion.newDecimal(11,2);
	public ClarionDecimal nol_v=Clarion.newDecimal(11,2);
	public ClarionDecimal bil_v=Clarion.newDecimal(11,2);
	public ClarionDecimal skaits=Clarion.newDecimal(3,0);
	public ClarionDecimal lin_g_pr=Clarion.newDecimal(5,3);
	public ClarionNumber neraz=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionArray<ClarionString> kat=Clarion.newString(3).dim(40);
	public ClarionArray<ClarionNumber> gd_pr=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).dim(40);
	public ClarionArray<ClarionDecimal> gd_koef=Clarion.newDecimal(4,3).dim(40);
	public ClarionArray<ClarionDecimal> sak_v_gd=Clarion.newDecimal(11,2).dim(40);
	public ClarionArray<ClarionDecimal> nol_gd=Clarion.newDecimal(11,2).dim(40);
	public ClarionArray<ClarionNumber> lock_gd=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).dim(40);
	public ClarionNumber end_date=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey dat_key=new ClarionKey("DAT_KEY");
	public ClarionKey nr_key=new ClarionKey("NR_KEY");
	public ClarionKey nos_key=new ClarionKey("NOS_KEY");

	public Pamat()
	{
		setName(Main.pamatname);
		setPrefix("PAM");
		setCreate();
		this.addVariable("U_NR",this.u_nr);
		this.addVariable("NODALA",this.nodala);
		this.addVariable("OBJ_NR",this.obj_nr);
		this.addVariable("ATB_NR",this.atb_nr);
		this.addVariable("ATB_NOS",this.atb_nos);
		this.addVariable("IZG_GAD",this.izg_gad);
		this.addVariable("DATUMS",this.datums);
		this.addVariable("EXPL_DATUMS",this.expl_datums);
		this.addVariable("DOK_SENR",this.dok_senr);
		this.addVariable("NOS_P",this.nos_p);
		this.addVariable("NOS_S",this.nos_s);
		this.addVariable("NOS_A",this.nos_a);
		this.addVariable("BKK",this.bkk);
		this.addVariable("BKKN",this.bkkn);
		this.addVariable("OKK7",this.okk7);
		this.addVariable("IEP_V",this.iep_v);
		this.addVariable("KAP_V",this.kap_v);
		this.addVariable("NOL_V",this.nol_v);
		this.addVariable("BIL_V",this.bil_v);
		this.addVariable("SKAITS",this.skaits);
		this.addVariable("LIN_G_PR",this.lin_g_pr);
		this.addVariable("NERAZ",this.neraz);
		this.addVariable("KAT",this.kat);
		this.addVariable("GD_PR",this.gd_pr);
		this.addVariable("GD_KOEF",this.gd_koef);
		this.addVariable("SAK_V_GD",this.sak_v_gd);
		this.addVariable("NOL_GD",this.nol_gd);
		this.addVariable("LOCK_GD",this.lock_gd);
		this.addVariable("END_DATE",this.end_date);
		this.addVariable("BAITS",this.baits);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		dat_key.setNocase().setOptional().addDescendingField(datums).addDescendingField(u_nr);
		this.addKey(dat_key);
		nr_key.setNocase().addAscendingField(u_nr);
		this.addKey(nr_key);
		nos_key.setDuplicate().setNocase().setOptional().addAscendingField(nos_a);
		this.addKey(nos_key);
	}
}
