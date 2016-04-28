package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Grupa2 extends ClarionSQLFile
{
	public ClarionString grupa1=Clarion.newString(3);
	public ClarionString grupa2=Clarion.newString(1);
	public ClarionString nosaukums=Clarion.newString(50);
	public ClarionDecimal proc=Clarion.newDecimal(3,0);
	public ClarionKey gr1_key=new ClarionKey("GR1_KEY");

	public Grupa2()
	{
		setName(Clarion.newString("GRUPA2"));
		setPrefix("GR2");
		setCreate();
		this.addVariable("GRUPA1",this.grupa1);
		this.addVariable("GRUPA2",this.grupa2);
		this.addVariable("NOSAUKUMS",this.nosaukums);
		this.addVariable("PROC",this.proc);
		gr1_key.setNocase().setOptional().addAscendingField(grupa1).addAscendingField(grupa2);
		this.addKey(gr1_key);
	}
}
