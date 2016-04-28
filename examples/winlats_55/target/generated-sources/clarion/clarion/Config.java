package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Config extends ClarionSQLFile
{
	public ClarionNumber nr=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString nosaukums=Clarion.newString(30);
	public ClarionString taka=Clarion.newString(50);
	public ClarionNumber par_end_u_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber aut_end_u_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber statuss=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");

	public Config()
	{
		setName(Clarion.newString("CONFIG"));
		setPrefix("CON");
		setCreate();
		this.addVariable("NR",this.nr);
		this.addVariable("Nosaukums",this.nosaukums);
		this.addVariable("TAKA",this.taka);
		this.addVariable("PAR_END_U_NR",this.par_end_u_nr);
		this.addVariable("AUT_END_U_NR",this.aut_end_u_nr);
		this.addVariable("STATUSS",this.statuss);
		nr_key.setNocase().setOptional().addAscendingField(nr);
		this.addKey(nr_key);
	}
}
