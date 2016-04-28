package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Nolik extends ClarionSQLFile
{
	public ClarionNumber u_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber obj_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString nomenklat=Clarion.newString(21);
	public ClarionString izc_v_kods=Clarion.newString(2);
	public ClarionNumber par_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString d_k=Clarion.newString(1);
	public ClarionString rs=Clarion.newString(1);
	public ClarionDecimal iepak_d=Clarion.newDecimal(7,2);
	public ClarionDecimal daudzums=Clarion.newDecimal(11,3);
	public ClarionDecimal summa=Clarion.newDecimal(11,2);
	public ClarionDecimal summav=Clarion.newDecimal(11,2);
	public ClarionString val=Clarion.newString(3);
	public ClarionDecimal atlaide_pr=Clarion.newDecimal(3,1);
	public ClarionNumber pvn_proc=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber arbyte=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionDecimal t_summa=Clarion.newDecimal(9,2);
	public ClarionDecimal muita=Clarion.newDecimal(9,2);
	public ClarionDecimal akcize=Clarion.newDecimal(9,2);
	public ClarionDecimal citas=Clarion.newDecimal(9,2);
	public ClarionNumber lock=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber baits1=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");
	public ClarionKey dat_key=new ClarionKey("DAT_KEY");
	public ClarionKey par_key=new ClarionKey("PAR_KEY");
	public ClarionKey nom_key=new ClarionKey("NOM_KEY");

	public Nolik()
	{
		setName(Main.nolikname);
		setPrefix("NOL");
		setCreate();
		this.addVariable("U_NR",this.u_nr);
		this.addVariable("OBJ_NR",this.obj_nr);
		this.addVariable("DATUMS",this.datums);
		this.addVariable("NOMENKLAT",this.nomenklat);
		this.addVariable("IZC_V_KODS",this.izc_v_kods);
		this.addVariable("PAR_NR",this.par_nr);
		this.addVariable("D_K",this.d_k);
		this.addVariable("RS",this.rs);
		this.addVariable("IEPAK_D",this.iepak_d);
		this.addVariable("DAUDZUMS",this.daudzums);
		this.addVariable("SUMMA",this.summa);
		this.addVariable("SUMMAV",this.summav);
		this.addVariable("val",this.val);
		this.addVariable("ATLAIDE_PR",this.atlaide_pr);
		this.addVariable("PVN_PROC",this.pvn_proc);
		this.addVariable("ARBYTE",this.arbyte);
		this.addVariable("T_SUMMA",this.t_summa);
		this.addVariable("MUITA",this.muita);
		this.addVariable("AKCIZE",this.akcize);
		this.addVariable("CITAS",this.citas);
		this.addVariable("LOCK",this.lock);
		this.addVariable("BAITS",this.baits);
		this.addVariable("BAITS1",this.baits1);
		nr_key.setDuplicate().setNocase().addAscendingField(u_nr).addAscendingField(nomenklat);
		this.addKey(nr_key);
		dat_key.setDuplicate().setNocase().addAscendingField(datums).addAscendingField(d_k);
		this.addKey(dat_key);
		par_key.setDuplicate().setNocase().addAscendingField(par_nr).addAscendingField(datums).addAscendingField(d_k);
		this.addKey(par_key);
		nom_key.setDuplicate().setNocase().addAscendingField(nomenklat).addAscendingField(datums).addAscendingField(d_k);
		this.addKey(nom_key);
	}
}
