package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Pava1 extends ClarionSQLFile
{
	public ClarionNumber u_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber gg_u_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber dokdat=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString nodala=Clarion.newString(2);
	public ClarionNumber obj_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString d_k=Clarion.newString(1);
	public ClarionString rs=Clarion.newString(1);
	public ClarionString dok_senr=Clarion.newString(14);
	public ClarionString dek_nr=Clarion.newString(12);
	public ClarionNumber kie_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString rek_nr=Clarion.newString(10);
	public ClarionNumber par_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString noka=Clarion.newString(15);
	public ClarionNumber par_adr_nr=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber mak_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber ved_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString pamat=Clarion.newString(28);
	public ClarionString pielik=Clarion.newString(21);
	public ClarionDecimal summa=Clarion.newDecimal(11,2);
	public ClarionDecimal summa_a=Clarion.newDecimal(9,2);
	public ClarionDecimal summa_b=Clarion.newDecimal(11,2);
	public ClarionString apm_v=Clarion.newString(1);
	public ClarionString apm_k=Clarion.newString(1);
	public ClarionNumber dar_v_kods=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber tr_v_kods=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString pieg_n_kods=Clarion.newString(3);
	public ClarionNumber c_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionDecimal c_summa=Clarion.newDecimal(11,2);
	public ClarionDecimal t_summa=Clarion.newDecimal(11,2);
	public ClarionNumber t_pvn=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString val=Clarion.newString(3);
	public ClarionDecimal muita=Clarion.newDecimal(9,2);
	public ClarionDecimal akcize=Clarion.newDecimal(9,2);
	public ClarionDecimal citas=Clarion.newDecimal(9,2);
	public ClarionNumber teksts_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber exp=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber keksis=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber baits1=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber baits2=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");
	public ClarionKey dat_key=new ClarionKey("DAT_KEY");
	public ClarionKey par_key=new ClarionKey("PAR_KEY");
	public ClarionKey senr_key=new ClarionKey("SENR_KEY");

	public Pava1()
	{
		setName(Main.filename1);
		setPrefix("PA1");
		setCreate();
		this.addVariable("U_NR",this.u_nr);
		this.addVariable("GG_U_NR",this.gg_u_nr);
		this.addVariable("DOKDAT",this.dokdat);
		this.addVariable("DATUMS",this.datums);
		this.addVariable("NODALA",this.nodala);
		this.addVariable("OBJ_NR",this.obj_nr);
		this.addVariable("D_K",this.d_k);
		this.addVariable("RS",this.rs);
		this.addVariable("DOK_SENR",this.dok_senr);
		this.addVariable("DEK_NR",this.dek_nr);
		this.addVariable("KIE_NR",this.kie_nr);
		this.addVariable("REK_NR",this.rek_nr);
		this.addVariable("PAR_NR",this.par_nr);
		this.addVariable("NOKA",this.noka);
		this.addVariable("PAR_ADR_NR",this.par_adr_nr);
		this.addVariable("MAK_NR",this.mak_nr);
		this.addVariable("VED_NR",this.ved_nr);
		this.addVariable("PAMAT",this.pamat);
		this.addVariable("PIELIK",this.pielik);
		this.addVariable("SUMMA",this.summa);
		this.addVariable("SUMMA_A",this.summa_a);
		this.addVariable("SUMMA_B",this.summa_b);
		this.addVariable("apm_v",this.apm_v);
		this.addVariable("apm_k",this.apm_k);
		this.addVariable("DAR_V_KODS",this.dar_v_kods);
		this.addVariable("TR_V_KODS",this.tr_v_kods);
		this.addVariable("PIEG_N_KODS",this.pieg_n_kods);
		this.addVariable("C_DATUMS",this.c_datums);
		this.addVariable("C_SUMMA",this.c_summa);
		this.addVariable("T_SUMMA",this.t_summa);
		this.addVariable("T_PVN",this.t_pvn);
		this.addVariable("val",this.val);
		this.addVariable("MUITA",this.muita);
		this.addVariable("AKCIZE",this.akcize);
		this.addVariable("CITAS",this.citas);
		this.addVariable("TEKSTS_NR",this.teksts_nr);
		this.addVariable("EXP",this.exp);
		this.addVariable("KEKSIS",this.keksis);
		this.addVariable("BAITS1",this.baits1);
		this.addVariable("BAITS2",this.baits2);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		nr_key.setNocase().setOptional().addAscendingField(u_nr);
		this.addKey(nr_key);
		dat_key.setDuplicate().setNocase().setOptional().addDescendingField(datums).addDescendingField(d_k).addDescendingField(dok_senr);
		this.addKey(dat_key);
		par_key.setDuplicate().setNocase().setOptional().addAscendingField(par_nr).addAscendingField(datums).addAscendingField(d_k);
		this.addKey(par_key);
		senr_key.setNocase().setOptional().addAscendingField(dok_senr);
		this.addKey(senr_key);
	}
}
