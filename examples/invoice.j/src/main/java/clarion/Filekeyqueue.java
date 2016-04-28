package clarion;

import clarion.Keyfieldqueue;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.ref.RefVariable;

public class Filekeyqueue extends ClarionQueue
{
	public RefVariable<ClarionKey> key=new RefVariable<ClarionKey>(null);
	public ClarionString description=Clarion.newString(80);
	public RefVariable<Keyfieldqueue> fields=new RefVariable<Keyfieldqueue>(null);
	public ClarionNumber autoInc=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber dups=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber noCase=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);

	public Filekeyqueue()
	{
		this.addVariable("Key",this.key);
		this.addVariable("Description",this.description);
		this.addVariable("Fields",this.fields);
		this.addVariable("AutoInc",this.autoInc);
		this.addVariable("Dups",this.dups);
		this.addVariable("NoCase",this.noCase);
	}
}
