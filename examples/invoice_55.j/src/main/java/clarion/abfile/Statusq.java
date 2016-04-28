package clarion.abfile;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Statusq extends ClarionQueue
{
	public ClarionNumber thread=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString proc=Clarion.newString().setEncoding(ClarionString.ASTRING);
	public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber ustat=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber hold=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber scopelevel=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber nestedopen=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);

	public Statusq()
	{
		this.addVariable("Thread",this.thread);
		this.addVariable("Proc",this.proc);
		this.addVariable("ID",this.id);
		this.addVariable("UStat",this.ustat);
		this.addVariable("Hold",this.hold);
		this.addVariable("ScopeLevel",this.scopelevel);
		this.addVariable("NestedOpen",this.nestedopen);
	}
}
