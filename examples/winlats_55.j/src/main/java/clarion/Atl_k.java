package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Atl_k extends ClarionSQLFile
{
	public ClarionNumber u_nr=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber hidden=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString komentars=Clarion.newString(50);
	public ClarionString nos_a=Clarion.newString(7);
	public ClarionDecimal atl_proc_pa=Clarion.newDecimal(4,1);
	public ClarionString acc_kods=Clarion.newString(8);
	public ClarionNumber acc_datums=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");
	public ClarionKey nos_key=new ClarionKey("NOS_KEY");

	public Atl_k()
	{
		setName(Clarion.newString("ATL_K"));
		setPrefix("ATL");
		setCreate();
		this.addVariable("U_NR",this.u_nr);
		this.addVariable("HIDDEN",this.hidden);
		this.addVariable("KOMENTARS",this.komentars);
		this.addVariable("NOS_A",this.nos_a);
		this.addVariable("ATL_PROC_PA",this.atl_proc_pa);
		this.addVariable("ACC_KODS",this.acc_kods);
		this.addVariable("ACC_DATUMS",this.acc_datums);
		nr_key.setNocase().addAscendingField(u_nr);
		this.addKey(nr_key);
		nos_key.setDuplicate().setNocase().setOptional().addAscendingField(nos_a);
		this.addKey(nos_key);
	}
}
