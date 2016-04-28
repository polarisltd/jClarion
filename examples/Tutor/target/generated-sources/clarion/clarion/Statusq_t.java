package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class Statusq_t extends ClarionQueue
{
	public ClarionNumber thread=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString proc=Clarion.newString().setEncoding(ClarionString.ASTRING);
	public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber uStat=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber hold=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber scopeLevel=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber nestedOpen=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);

	public Statusq_t()
	{
		this.addVariable("Thread",this.thread);
		this.addVariable("Proc",this.proc);
		this.addVariable("ID",this.id);
		this.addVariable("UStat",this.uStat);
		this.addVariable("Hold",this.hold);
		this.addVariable("ScopeLevel",this.scopeLevel);
		this.addVariable("NestedOpen",this.nestedOpen);
	}
}
