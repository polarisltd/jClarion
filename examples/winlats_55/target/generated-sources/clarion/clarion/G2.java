package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class G2 extends ClarionSQLFile
{
	public ClarionDecimal nr=Clarion.newDecimal(7,0);
	public ClarionString dok_se=Clarion.newString(6);
	public ClarionString dok_nr=Clarion.newString(7);
	public ClarionDecimal imp_nr=Clarion.newDecimal(3,0);
	public ClarionNumber dokdat=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber dokdat1=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber datums1=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber refdat=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString reference=Clarion.newString(7);
	public ClarionString reference1=Clarion.newString(7);
	public ClarionString noka=Clarion.newString(15);
	public ClarionDecimal par_nr=Clarion.newDecimal(5,0);
	public ClarionDecimal rs=Clarion.newDecimal(1,0);
	public ClarionDecimal es=Clarion.newDecimal(1,0);
	public ClarionString saturs=Clarion.newString(45);
	public ClarionString saturs2=Clarion.newString(45);
	public ClarionString saturs3=Clarion.newString(45);
	public ClarionDecimal summa=Clarion.newDecimal(11,2);
	public ClarionString nos=Clarion.newString(3);
	public ClarionNumber i_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString operators=Clarion.newString(4);
	public ClarionNumber keksis=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");
	public ClarionKey dat_key=new ClarionKey("DAT_KEY");
	public ClarionKey dat1_key=new ClarionKey("DAT1_KEY");

	public G2()
	{
		setName(Main.filename1);
		setPrefix("G2");
		setCreate();
		this.addVariable("NR",this.nr);
		this.addVariable("DOK_SE",this.dok_se);
		this.addVariable("DOK_NR",this.dok_nr);
		this.addVariable("IMP_NR",this.imp_nr);
		this.addVariable("DOKDAT",this.dokdat);
		this.addVariable("DOKDAT1",this.dokdat1);
		this.addVariable("DATUMS",this.datums);
		this.addVariable("DATUMS1",this.datums1);
		this.addVariable("REFDAT",this.refdat);
		this.addVariable("REFERENCE",this.reference);
		this.addVariable("REFERENCE1",this.reference1);
		this.addVariable("NOKA",this.noka);
		this.addVariable("PAR_NR",this.par_nr);
		this.addVariable("RS",this.rs);
		this.addVariable("ES",this.es);
		this.addVariable("SATURS",this.saturs);
		this.addVariable("SATURS2",this.saturs2);
		this.addVariable("SATURS3",this.saturs3);
		this.addVariable("SUMMA",this.summa);
		this.addVariable("NOS",this.nos);
		this.addVariable("I_DATUMS",this.i_datums);
		this.addVariable("OPERATORS",this.operators);
		this.addVariable("KEKSIS",this.keksis);
		nr_key.setNocase().setOptional().addAscendingField(nr);
		this.addKey(nr_key);
		dat_key.setDuplicate().setNocase().addAscendingField(datums).addAscendingField(reference).addAscendingField(dokdat);
		this.addKey(dat_key);
		dat1_key.setDuplicate().setNocase().setOptional().addAscendingField(datums1).addAscendingField(reference1).addAscendingField(dokdat1);
		this.addKey(dat1_key);
	}
}
