package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Gk1 extends ClarionSQLFile
{
	public ClarionNumber u_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString rs=Clarion.newString(1);
	public ClarionNumber datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber par_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString reference=Clarion.newString(14);
	public ClarionString bkk=Clarion.newString(5);
	public ClarionString d_k=Clarion.newString(1);
	public ClarionDecimal summa=Clarion.newDecimal(11,2);
	public ClarionDecimal summav=Clarion.newDecimal(11,2);
	public ClarionString val=Clarion.newString(3);
	public ClarionNumber pvn_proc=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString pvn_tips=Clarion.newString(1);
	public ClarionNumber baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber kk=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString nodala=Clarion.newString(2);
	public ClarionNumber obj_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");
	public ClarionKey dat_key=new ClarionKey("DAT_KEY");
	public ClarionKey bkk_dat=new ClarionKey("BKK_DAT");
	public ClarionKey par_key=new ClarionKey("PAR_KEY");
	public ClarionKey pardat_key=new ClarionKey("PARDAT_KEY");

	public Gk1()
	{
		setName(Main.filename2);
		setPrefix("GK1");
		setCreate();
		this.addVariable("U_NR",this.u_nr);
		this.addVariable("RS",this.rs);
		this.addVariable("DATUMS",this.datums);
		this.addVariable("PAR_NR",this.par_nr);
		this.addVariable("REFERENCE",this.reference);
		this.addVariable("BKK",this.bkk);
		this.addVariable("D_K",this.d_k);
		this.addVariable("SUMMA",this.summa);
		this.addVariable("SUMMAV",this.summav);
		this.addVariable("VAL",this.val);
		this.addVariable("PVN_PROC",this.pvn_proc);
		this.addVariable("PVN_TIPS",this.pvn_tips);
		this.addVariable("BAITS",this.baits);
		this.addVariable("KK",this.kk);
		this.addVariable("NODALA",this.nodala);
		this.addVariable("Obj_nr",this.obj_nr);
		nr_key.setDuplicate().setNocase().setOptional().addAscendingField(u_nr).addAscendingField(bkk);
		this.addKey(nr_key);
		dat_key.setDuplicate().setNocase().setOptional().addAscendingField(datums).addAscendingField(u_nr).addAscendingField(d_k);
		this.addKey(dat_key);
		bkk_dat.setDuplicate().setNocase().setOptional().addAscendingField(bkk).addAscendingField(datums).addAscendingField(u_nr);
		this.addKey(bkk_dat);
		par_key.setDuplicate().setNocase().setOptional().addAscendingField(par_nr).addAscendingField(datums).addAscendingField(u_nr);
		this.addKey(par_key);
		pardat_key.setDuplicate().setNocase().setOptional().addAscendingField(par_nr).addDescendingField(datums).addDescendingField(u_nr);
		this.addKey(pardat_key);
	}
}
