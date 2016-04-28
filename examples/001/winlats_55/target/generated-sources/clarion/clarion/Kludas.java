package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Kludas extends ClarionSQLFile
{
	public ClarionDecimal nr=Clarion.newDecimal(3,0);
	public ClarionDecimal darbiba=Clarion.newDecimal(1,0);
	public ClarionDecimal kartiba=Clarion.newDecimal(1,0);
	public ClarionString koment=Clarion.newString(70);
	public ClarionKey nr_key=new ClarionKey("NR_KEY");

	public Kludas()
	{
		setName(Clarion.newString("kludas"));
		setPrefix("KLU");
		setCreate();
		this.addVariable("NR",this.nr);
		this.addVariable("DARBIBA",this.darbiba);
		this.addVariable("KARTIBA",this.kartiba);
		this.addVariable("KOMENT",this.koment);
		nr_key.setNocase().addAscendingField(nr);
		this.addKey(nr_key);
	}
}
