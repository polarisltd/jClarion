package clarion.winla048;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Dosfiles extends ClarionQueue
{
	public ClarionString name=Clarion.newString(13);
	public ClarionNumber date=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber time=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber size=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber attrib=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);

	public Dosfiles()
	{
		this.addVariable("NAME",this.name);
		this.addVariable("DATE",this.date);
		this.addVariable("TIME",this.time);
		this.addVariable("SIZE",this.size);
		this.addVariable("ATTRIB",this.attrib);
		this.setPrefix("A");
	}
}
