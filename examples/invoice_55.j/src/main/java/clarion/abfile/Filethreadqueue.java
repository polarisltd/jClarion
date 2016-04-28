package clarion.abfile;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;

@SuppressWarnings("all")
public class Filethreadqueue extends ClarionQueue
{
	public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber used=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber opened=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber ateof=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber autoincdone=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber lasterror=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);

	public Filethreadqueue()
	{
		this.addVariable("Id",this.id);
		this.addVariable("Used",this.used);
		this.addVariable("Opened",this.opened);
		this.addVariable("AtEOF",this.ateof);
		this.addVariable("AutoIncDone",this.autoincdone);
		this.addVariable("LastError",this.lasterror);
	}
}
