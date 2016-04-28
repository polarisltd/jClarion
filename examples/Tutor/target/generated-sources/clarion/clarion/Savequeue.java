package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class Savequeue extends ClarionQueue
{
	public ClarionNumber buffer=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber autoIncDone=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber state=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString pos=Clarion.newString(1024);

	public Savequeue()
	{
		this.addVariable("Buffer",this.buffer);
		this.addVariable("Id",this.id);
		this.addVariable("AutoIncDone",this.autoIncDone);
		this.addVariable("State",this.state);
		this.addVariable("Pos",this.pos);
	}
}
