package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class B_pavad extends ClarionSQLFile
{
	public ClarionNumber datums=Clarion.newNumber().setEncoding(ClarionNumber.DATE);
	public ClarionString d_k=Clarion.newString(1);
	public ClarionString dok_senr=Clarion.newString(14);
	public ClarionString par_nr=Clarion.newString("@N_11");
	public ClarionString apm_v=Clarion.newString(1);
	public ClarionString apm_k=Clarion.newString(1);
	public ClarionNumber c_datums=Clarion.newNumber().setEncoding(ClarionNumber.DATE);
	public ClarionString c_summa=Clarion.newString("@N_12.2");
	public ClarionString t_summa=Clarion.newString("@N_11.2");
	public ClarionString t_pvn=Clarion.newString("@N2");
	public ClarionString val=Clarion.newString(3);
	public ClarionString nomenklat=Clarion.newString(21);
	public ClarionString kods=Clarion.newString("@N_13");
	public ClarionString artikuls=Clarion.newString(22);
	public ClarionString tips=Clarion.newString(1);
	public ClarionString nosaukums=Clarion.newString(50);
	public ClarionString nos_s=Clarion.newString(16);
	public ClarionString mervien=Clarion.newString(7);
	public ClarionString svars=Clarion.newString("@N_6.2");
	public ClarionString skaits_i=Clarion.newString("@N_8.2");
	public ClarionNumber der_term=Clarion.newNumber().setEncoding(ClarionNumber.DATE);
	public ClarionString daudzums=Clarion.newString("@n_12.3");
	public ClarionString summav=Clarion.newString("@n_10.2");
	public ClarionString atlaide_pr=Clarion.newString("@n_4.1");
	public ClarionString pvn_proc=Clarion.newString("@N2");
	public ClarionString arbyte=Clarion.newString("@N1");

	public B_pavad()
	{
		setName(Main.b_pavadname);
		setPrefix("BPA");
		setCreate();
		this.addVariable("DATUMS",this.datums);
		this.addVariable("D_K",this.d_k);
		this.addVariable("DOK_SENR",this.dok_senr);
		this.addVariable("PAR_NR",this.par_nr);
		this.addVariable("APM_V",this.apm_v);
		this.addVariable("APM_K",this.apm_k);
		this.addVariable("C_DATUMS",this.c_datums);
		this.addVariable("C_SUMMA",this.c_summa);
		this.addVariable("T_SUMMA",this.t_summa);
		this.addVariable("T_PVN",this.t_pvn);
		this.addVariable("VAL",this.val);
		this.addVariable("NOMENKLAT",this.nomenklat);
		this.addVariable("KODS",this.kods);
		this.addVariable("ARTIKULS",this.artikuls);
		this.addVariable("TIPS",this.tips);
		this.addVariable("NOSAUKUMS",this.nosaukums);
		this.addVariable("NOS_S",this.nos_s);
		this.addVariable("MERVIEN",this.mervien);
		this.addVariable("SVARS",this.svars);
		this.addVariable("SKAITS_I",this.skaits_i);
		this.addVariable("DER_TERM",this.der_term);
		this.addVariable("Daudzums",this.daudzums);
		this.addVariable("SUMMAV",this.summav);
		this.addVariable("ATLAIDE_PR",this.atlaide_pr);
		this.addVariable("PVN_PROC",this.pvn_proc);
		this.addVariable("ARBYTE",this.arbyte);
	}
}
