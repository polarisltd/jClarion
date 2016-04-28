package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Kadri extends ClarionSQLFile
{
	public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionString uzv=Clarion.newString(20);
	public ClarionString var=Clarion.newString(15);
	public ClarionString tev=Clarion.newString(15);
	public ClarionString ini=Clarion.newString(7);
	public ClarionString v_kods=Clarion.newString(2);
	public ClarionString dzim=Clarion.newString(1);
	public ClarionString izglitiba=Clarion.newString(1);
	public ClarionString v_val=Clarion.newString(40);
	public ClarionString perskod=Clarion.newString("@p######-#####p");
	public ClarionString dzv_pils=Clarion.newString(30);
	public ClarionString pase=Clarion.newString(60);
	public ClarionNumber pase_end=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString pieradr=Clarion.newString(60);
	public ClarionString rek_nr1=Clarion.newString(34);
	public ClarionString bkods1=Clarion.newString(15);
	public ClarionString rek_nr2=Clarion.newString(34);
	public ClarionString bkods2=Clarion.newString(15);
	public ClarionNumber terkod=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString kartnr=Clarion.newString(12);
	public ClarionString regnr=Clarion.newString(12);
	public ClarionNumber vid_u_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString statuss=Clarion.newString(1);
	public ClarionString amats=Clarion.newString(25);
	public ClarionString nodala=Clarion.newString(2);
	public ClarionNumber obj_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString dar_lig=Clarion.newString(8);
	public ClarionNumber dar_dat=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber darba_gr=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber z_kods=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString nedar_lig=Clarion.newString(8);
	public ClarionNumber nedar_dat=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber d_gr_end=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber z_kods_end=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString inv_p=Clarion.newString(1);
	public ClarionNumber apgad_sk=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString soc_v=Clarion.newString(1);
	public ClarionDecimal pr37=Clarion.newDecimal(5,2);
	public ClarionDecimal pr1=Clarion.newDecimal(5,2);
	public ClarionDecimal ppf_proc=Clarion.newDecimal(4,2);
	public ClarionDecimal dzivap_proc=Clarion.newDecimal(4,2);
	public ClarionDecimal avanss=Clarion.newDecimal(7,2);
	public ClarionArray<ClarionDecimal> piesklist=Clarion.newDecimal(3,0).dim(20);
	public ClarionString slodze=Clarion.newString(20);
	public ClarionArray<ClarionDecimal> ietlist=Clarion.newDecimal(3,0).dim(15);
	public ClarionNumber baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey ini_key=new ClarionKey("INI_Key");
	public ClarionKey nod_key=new ClarionKey("NOD_KEY");
	public ClarionKey id_key=new ClarionKey("ID_Key");

	public Kadri()
	{
		setName(Clarion.newString("KADRI"));
		setPrefix("KAD");
		setCreate();
		this.addVariable("ID",this.id);
		this.addVariable("UZV",this.uzv);
		this.addVariable("VAR",this.var);
		this.addVariable("TEV",this.tev);
		this.addVariable("INI",this.ini);
		this.addVariable("V_KODS",this.v_kods);
		this.addVariable("DZIM",this.dzim);
		this.addVariable("IZGLITIBA",this.izglitiba);
		this.addVariable("V_VAL",this.v_val);
		this.addVariable("PERSKOD",this.perskod);
		this.addVariable("DZV_PILS",this.dzv_pils);
		this.addVariable("PASE",this.pase);
		this.addVariable("PASE_END",this.pase_end);
		this.addVariable("PIERADR",this.pieradr);
		this.addVariable("REK_NR1",this.rek_nr1);
		this.addVariable("BKODS1",this.bkods1);
		this.addVariable("REK_NR2",this.rek_nr2);
		this.addVariable("BKODS2",this.bkods2);
		this.addVariable("TERKOD",this.terkod);
		this.addVariable("KARTNR",this.kartnr);
		this.addVariable("REGNR",this.regnr);
		this.addVariable("VID_U_Nr",this.vid_u_nr);
		this.addVariable("STATUSS",this.statuss);
		this.addVariable("AMATS",this.amats);
		this.addVariable("NODALA",this.nodala);
		this.addVariable("OBJ_NR",this.obj_nr);
		this.addVariable("DAR_LIG",this.dar_lig);
		this.addVariable("DAR_DAT",this.dar_dat);
		this.addVariable("DARBA_GR",this.darba_gr);
		this.addVariable("Z_KODS",this.z_kods);
		this.addVariable("NEDAR_LIG",this.nedar_lig);
		this.addVariable("NEDAR_DAT",this.nedar_dat);
		this.addVariable("D_GR_END",this.d_gr_end);
		this.addVariable("Z_KODS_END",this.z_kods_end);
		this.addVariable("INV_P",this.inv_p);
		this.addVariable("APGAD_SK",this.apgad_sk);
		this.addVariable("SOC_V",this.soc_v);
		this.addVariable("PR37",this.pr37);
		this.addVariable("PR1",this.pr1);
		this.addVariable("PPF_PROC",this.ppf_proc);
		this.addVariable("DZIVAP_PROC",this.dzivap_proc);
		this.addVariable("AVANSS",this.avanss);
		this.addVariable("PIESKLIST",this.piesklist);
		this.addVariable("SLODZE",this.slodze);
		this.addVariable("IETLIST",this.ietlist);
		this.addVariable("BAITS",this.baits);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		ini_key.setDuplicate().setNocase().addAscendingField(ini);
		this.addKey(ini_key);
		nod_key.setDuplicate().setNocase().setOptional().addAscendingField(nodala).addAscendingField(ini);
		this.addKey(nod_key);
		id_key.setNocase().addAscendingField(id);
		this.addKey(id_key);
	}
}