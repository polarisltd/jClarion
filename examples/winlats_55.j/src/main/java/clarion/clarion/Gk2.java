package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Gk2 extends ClarionSQLFile
{
	public ClarionDecimal nr=Clarion.newDecimal(7,0);
	public ClarionNumber datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionDecimal par_nr=Clarion.newDecimal(5,0);
	public ClarionDecimal ref_nr=Clarion.newDecimal(7,0);
	public ClarionNumber ref_avots=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionDecimal rs=Clarion.newDecimal(1,0);
	public ClarionString bkk=Clarion.newString(5);
	public ClarionString d_k=Clarion.newString(1);
	public ClarionDecimal summa=Clarion.newDecimal(11,2);
	public ClarionDecimal summav=Clarion.newDecimal(11,2);
	public ClarionString nos=Clarion.newString(3);
	public ClarionString p1=Clarion.newString(1);
	public ClarionNumber p2=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber p3=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString p4=Clarion.newString(1);
	public ClarionNumber kk=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");
	public ClarionKey dat_key=new ClarionKey("DAT_KEY");
	public ClarionKey bkk_dat=new ClarionKey("BKK_DAT");
	public ClarionKey par_key=new ClarionKey("PAR_KEY");

	public Gk2()
	{
		setName(Main.filename2);
		setPrefix("GK2");
		setCreate();
		this.addVariable("NR",this.nr);
		this.addVariable("DATUMS",this.datums);
		this.addVariable("PAR_NR",this.par_nr);
		this.addVariable("REF_NR",this.ref_nr);
		this.addVariable("REF_AVOTS",this.ref_avots);
		this.addVariable("RS",this.rs);
		this.addVariable("BKK",this.bkk);
		this.addVariable("D_K",this.d_k);
		this.addVariable("SUMMA",this.summa);
		this.addVariable("SUMMAV",this.summav);
		this.addVariable("NOS",this.nos);
		this.addVariable("P1",this.p1);
		this.addVariable("P2",this.p2);
		this.addVariable("P3",this.p3);
		this.addVariable("P4",this.p4);
		this.addVariable("KK",this.kk);
		nr_key.setDuplicate().setNocase().setOptional().addAscendingField(nr).addAscendingField(bkk);
		this.addKey(nr_key);
		dat_key.setDuplicate().setNocase().setOptional().addAscendingField(datums).addAscendingField(nr).addAscendingField(d_k);
		this.addKey(dat_key);
		bkk_dat.setDuplicate().setNocase().setOptional().addAscendingField(bkk).addAscendingField(datums).addAscendingField(nr);
		this.addKey(bkk_dat);
		par_key.setDuplicate().setNocase().setOptional().addAscendingField(par_nr).addAscendingField(datums).addAscendingField(nr);
		this.addKey(par_key);
	}
}
