package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Grupa1 extends ClarionSQLFile
{
	public ClarionString grupa1=Clarion.newString(3);
	public ClarionString nosaukums=Clarion.newString(50);
	public ClarionDecimal proc=Clarion.newDecimal(3,0);
	public ClarionKey gr1_key=new ClarionKey("GR1_KEY");

	public Grupa1()
	{
		setName(Clarion.newString("GRUPA1"));
		setPrefix("GR1");
		setCreate();
		this.addVariable("GRUPA1",this.grupa1);
		this.addVariable("NOSAUKUMS",this.nosaukums);
		this.addVariable("PROC",this.proc);
		gr1_key.setNocase().setOptional().setPrimary().addAscendingField(grupa1);
		this.addKey(gr1_key);
	}
}
