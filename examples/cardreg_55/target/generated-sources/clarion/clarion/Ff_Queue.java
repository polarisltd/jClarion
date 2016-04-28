package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class Ff_Queue extends ClarionQueue
{
	public ClarionString name=Clarion.newString(13);
	public ClarionNumber date=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber time=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber size=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber attrib=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);

	public Ff_Queue()
	{
		this.addVariable("name",this.name);
		this.addVariable("date",this.date);
		this.addVariable("time",this.time);
		this.addVariable("size",this.size);
		this.addVariable("attrib",this.attrib);
	}
}
