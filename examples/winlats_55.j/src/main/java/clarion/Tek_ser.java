package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Tek_ser extends ClarionSQLFile
{
	public ClarionNumber u_nr=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionString tek_a=Clarion.newString(7);
	public ClarionString teksts=Clarion.newString(110);
	public ClarionKey nos_key=new ClarionKey("NOS_KEY");
	public ClarionKey nr_key=new ClarionKey("NR_KEY");

	public Tek_ser()
	{
		setPrefix("TES");
		setCreate();
		setName(Clarion.newString("tek_ser"));
		this.addVariable("U_NR",this.u_nr);
		this.addVariable("TEK_A",this.tek_a);
		this.addVariable("TEKSTS",this.teksts);
		nos_key.setDuplicate().setNocase().setOptional().addAscendingField(tek_a);
		this.addKey(nos_key);
		nr_key.setNocase().setOptional().addAscendingField(u_nr);
		this.addKey(nr_key);
	}
}
