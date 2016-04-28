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
public class Autoapk1 extends ClarionSQLFile
{
	public ClarionNumber pav_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber par_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber aut_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber pien_dat=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber plkst=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionDecimal nobraukums=Clarion.newDecimal(7,0);
	public ClarionNumber ctrl_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString teksts=Clarion.newString(50);
	public ClarionDecimal savirze_p=Clarion.newDecimal(4,2);
	public ClarionDecimal savirze_a=Clarion.newDecimal(4,2);
	public ClarionArray<ClarionDecimal> amort_p=Clarion.newDecimal(3,0).dim(2);
	public ClarionArray<ClarionDecimal> amort_a=Clarion.newDecimal(3,0).dim(2);
	public ClarionArray<ClarionDecimal> bremzes_p=Clarion.newDecimal(3,1).dim(2);
	public ClarionArray<ClarionDecimal> bremzes_a=Clarion.newDecimal(3,1).dim(2);
	public ClarionArray<ClarionString> karogi=Clarion.newString(1).dim(80);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString diag_tex=Clarion.newString(50);
	public ClarionKey pav_key=new ClarionKey("PAV_KEY");
	public ClarionKey dat_key=new ClarionKey("DAT_KEY");
	public ClarionKey par_key=new ClarionKey("PAR_KEY");
	public ClarionKey aut_key=new ClarionKey("AUT_KEY");

	public Autoapk1()
	{
		setName(Main.filename1);
		setPrefix("APK1");
		setCreate();
		this.addVariable("PAV_NR",this.pav_nr);
		this.addVariable("PAR_NR",this.par_nr);
		this.addVariable("AUT_NR",this.aut_nr);
		this.addVariable("DATUMS",this.datums);
		this.addVariable("PIEN_DAT",this.pien_dat);
		this.addVariable("PLKST",this.plkst);
		this.addVariable("Nobraukums",this.nobraukums);
		this.addVariable("CTRL_DATUMS",this.ctrl_datums);
		this.addVariable("TEKSTS",this.teksts);
		this.addVariable("SAVIRZE_P",this.savirze_p);
		this.addVariable("SAVIRZE_A",this.savirze_a);
		this.addVariable("AMORT_P",this.amort_p);
		this.addVariable("AMORT_A",this.amort_a);
		this.addVariable("BREMZES_P",this.bremzes_p);
		this.addVariable("BREMZES_A",this.bremzes_a);
		this.addVariable("KAROGI",this.karogi);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		this.addVariable("Diag_TEX",this.diag_tex);
		pav_key.setDuplicate().setNocase().setOptional().addAscendingField(pav_nr);
		this.addKey(pav_key);
		dat_key.setDuplicate().setNocase().setOptional().addDescendingField(datums);
		this.addKey(dat_key);
		par_key.setDuplicate().setNocase().setOptional().addAscendingField(par_nr);
		this.addKey(par_key);
		aut_key.setDuplicate().setNocase().setOptional().addAscendingField(aut_nr).addDescendingField(datums);
		this.addKey(aut_key);
	}
}
