package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Atl_s extends ClarionSQLFile
{
	public ClarionNumber u_nr=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionString nomenklat=Clarion.newString(21);
	public ClarionDecimal atl_proc=Clarion.newDecimal(4,1);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");

	public Atl_s()
	{
		setName(Clarion.newString("ATL_S"));
		setPrefix("ATS");
		setCreate();
		this.addVariable("U_NR",this.u_nr);
		this.addVariable("NOMENKLAT",this.nomenklat);
		this.addVariable("ATL_PROC",this.atl_proc);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		nr_key.setDuplicate().setNocase().setOptional().addAscendingField(u_nr).addAscendingField(nomenklat);
		this.addKey(nr_key);
	}
}
