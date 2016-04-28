package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Nolpas extends ClarionSQLFile
{
	public ClarionString rs=Clarion.newString(1);
	public ClarionNumber u_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber dok_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString nomenklat=Clarion.newString(21);
	public ClarionString nos_s=Clarion.newString(16);
	public ClarionString kataloga_nr=Clarion.newString(22);
	public ClarionNumber par_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber par_ke=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber nol_nr=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber san_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString san_nos=Clarion.newString(15);
	public ClarionNumber aut_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString komentars=Clarion.newString(25);
	public ClarionDecimal daudzums=Clarion.newDecimal(11,3);
	public ClarionDecimal t_daudzums=Clarion.newDecimal(11,3);
	public ClarionDecimal i_daudzums=Clarion.newDecimal(11,3);
	public ClarionDecimal summa=Clarion.newDecimal(11,2);
	public ClarionDecimal summav=Clarion.newDecimal(11,2);
	public ClarionString val=Clarion.newString(3);
	public ClarionDecimal ligumcena=Clarion.newDecimal(11,2);
	public ClarionNumber pvn_proc=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber keksis=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");
	public ClarionKey nom_key=new ClarionKey("NOM_KEY");
	public ClarionKey par_key=new ClarionKey("PAR_KEY");
	public ClarionKey parke_key=new ClarionKey("PARKE_KEY");
	public ClarionKey san_key=new ClarionKey("SAN_KEY");
	public ClarionKey aut_key=new ClarionKey("AUT_KEY");

	public Nolpas()
	{
		setName(Clarion.newString("NOLPAS"));
		setPrefix("NOS");
		setCreate();
		this.addVariable("RS",this.rs);
		this.addVariable("U_NR",this.u_nr);
		this.addVariable("DATUMS",this.datums);
		this.addVariable("DOK_NR",this.dok_nr);
		this.addVariable("NOMENKLAT",this.nomenklat);
		this.addVariable("NOS_S",this.nos_s);
		this.addVariable("KATALOGA_NR",this.kataloga_nr);
		this.addVariable("PAR_NR",this.par_nr);
		this.addVariable("PAR_KE",this.par_ke);
		this.addVariable("NOL_NR",this.nol_nr);
		this.addVariable("SAN_NR",this.san_nr);
		this.addVariable("SAN_NOS",this.san_nos);
		this.addVariable("AUT_NR",this.aut_nr);
		this.addVariable("KOMENTARS",this.komentars);
		this.addVariable("DAUDZUMS",this.daudzums);
		this.addVariable("T_DAUDZUMS",this.t_daudzums);
		this.addVariable("I_DAUDZUMS",this.i_daudzums);
		this.addVariable("SUMMA",this.summa);
		this.addVariable("SUMMAV",this.summav);
		this.addVariable("val",this.val);
		this.addVariable("LIGUMCENA",this.ligumcena);
		this.addVariable("PVN_PROC",this.pvn_proc);
		this.addVariable("KEKSIS",this.keksis);
		this.addVariable("BAITS",this.baits);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		nr_key.setDuplicate().setNocase().addAscendingField(u_nr).addAscendingField(nomenklat);
		this.addKey(nr_key);
		nom_key.setDuplicate().setNocase().setOptional().addAscendingField(nomenklat);
		this.addKey(nom_key);
		par_key.setDuplicate().setNocase().addAscendingField(par_nr).addAscendingField(dok_nr).addAscendingField(kataloga_nr);
		this.addKey(par_key);
		parke_key.setDuplicate().setNocase().setOptional().addAscendingField(par_ke).addAscendingField(dok_nr).addAscendingField(kataloga_nr);
		this.addKey(parke_key);
		san_key.setDuplicate().setNocase().setOptional().addAscendingField(san_nr).addAscendingField(datums);
		this.addKey(san_key);
		aut_key.setDuplicate().setNocase().setOptional().addAscendingField(aut_nr).addAscendingField(datums);
		this.addKey(aut_key);
	}
}
