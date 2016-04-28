package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.ref.RefVariable;

public class Bufferqueue extends ClarionQueue
{
	public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public RefVariable<ClarionString> buffer=new RefVariable<ClarionString>(null);

	public Bufferqueue()
	{
		this.addVariable("Id",this.id);
		this.addVariable("Buffer",this.buffer);
	}
}
