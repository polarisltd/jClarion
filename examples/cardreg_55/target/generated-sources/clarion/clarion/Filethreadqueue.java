package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;

public class Filethreadqueue extends ClarionQueue
{
	public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber used=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber opened=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber atEOF=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber autoIncDone=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber lastError=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);

	public Filethreadqueue()
	{
		this.addVariable("Id",this.id);
		this.addVariable("Used",this.used);
		this.addVariable("Opened",this.opened);
		this.addVariable("AtEOF",this.atEOF);
		this.addVariable("AutoIncDone",this.autoIncDone);
		this.addVariable("LastError",this.lastError);
	}
}
