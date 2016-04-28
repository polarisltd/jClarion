package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class G1 extends ClarionSQLFile
{
	public ClarionNumber u_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString rs=Clarion.newString(1);
	public ClarionDecimal es=Clarion.newDecimal(1,0);
	public ClarionDecimal imp_nr=Clarion.newDecimal(3,0);
	public ClarionNumber tips=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString dok_senr=Clarion.newString(14);
	public ClarionString att_dok=Clarion.newString(1);
	public ClarionNumber apmdat=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber dokdat=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString noka=Clarion.newString(15);
	public ClarionNumber par_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString saturs=Clarion.newString(47);
	public ClarionString saturs2=Clarion.newString(47);
	public ClarionString saturs3=Clarion.newString(47);
	public ClarionDecimal summa=Clarion.newDecimal(11,2);
	public ClarionString val=Clarion.newString(3);
	public ClarionDecimal atlaide=Clarion.newDecimal(3,1);
	public ClarionNumber keksis=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber baits=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber seciba=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");
	public ClarionKey dat_key=new ClarionKey("DAT_KEY");

	public G1()
	{
		setName(Main.filename1);
		setPrefix("G1");
		setCreate();
		this.addVariable("U_NR",this.u_nr);
		this.addVariable("RS",this.rs);
		this.addVariable("ES",this.es);
		this.addVariable("IMP_NR",this.imp_nr);
		this.addVariable("TIPS",this.tips);
		this.addVariable("DOK_SENR",this.dok_senr);
		this.addVariable("ATT_DOK",this.att_dok);
		this.addVariable("APMDAT",this.apmdat);
		this.addVariable("DOKDAT",this.dokdat);
		this.addVariable("DATUMS",this.datums);
		this.addVariable("NOKA",this.noka);
		this.addVariable("PAR_NR",this.par_nr);
		this.addVariable("SATURS",this.saturs);
		this.addVariable("SATURS2",this.saturs2);
		this.addVariable("SATURS3",this.saturs3);
		this.addVariable("SUMMA",this.summa);
		this.addVariable("VAL",this.val);
		this.addVariable("ATLAIDE",this.atlaide);
		this.addVariable("KEKSIS",this.keksis);
		this.addVariable("BAITS",this.baits);
		this.addVariable("SECIBA",this.seciba);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		nr_key.setNocase().setOptional().addAscendingField(u_nr);
		this.addKey(nr_key);
		dat_key.setDuplicate().setNocase().addDescendingField(datums).addDescendingField(seciba);
		this.addKey(dat_key);
	}
}
