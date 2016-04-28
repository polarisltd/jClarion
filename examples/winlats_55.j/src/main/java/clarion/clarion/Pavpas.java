package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Pavpas extends ClarionSQLFile
{
	public ClarionNumber u_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString koment=Clarion.newString(20);
	public ClarionString tips=Clarion.newString(1);
	public ClarionString rs=Clarion.newString(1);
	public ClarionNumber dok_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber par_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString noka=Clarion.newString(15);
	public ClarionDecimal summa=Clarion.newDecimal(11,2);
	public ClarionDecimal summav=Clarion.newDecimal(11,2);
	public ClarionString val=Clarion.newString(3);
	public ClarionNumber keksis=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");
	public ClarionKey dat_key=new ClarionKey("DAT_KEY");
	public ClarionKey par_key=new ClarionKey("PAR_KEY");

	public Pavpas()
	{
		setName(Clarion.newString("PAVPAS"));
		setPrefix("PAS");
		setCreate();
		this.addVariable("U_NR",this.u_nr);
		this.addVariable("DATUMS",this.datums);
		this.addVariable("KOMENT",this.koment);
		this.addVariable("TIPS",this.tips);
		this.addVariable("RS",this.rs);
		this.addVariable("DOK_NR",this.dok_nr);
		this.addVariable("PAR_NR",this.par_nr);
		this.addVariable("NOKA",this.noka);
		this.addVariable("SUMMA",this.summa);
		this.addVariable("SUMMAV",this.summav);
		this.addVariable("val",this.val);
		this.addVariable("KEKSIS",this.keksis);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		nr_key.setNocase().setOptional().addAscendingField(u_nr);
		this.addKey(nr_key);
		dat_key.setDuplicate().setNocase().setOptional().addDescendingField(datums).addDescendingField(dok_nr);
		this.addKey(dat_key);
		par_key.setDuplicate().setNocase().setOptional().addAscendingField(par_nr).addAscendingField(datums);
		this.addKey(par_key);
	}
}
