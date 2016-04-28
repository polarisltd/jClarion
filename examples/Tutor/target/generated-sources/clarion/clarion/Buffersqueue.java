package clarion;

import clarion.Filemanager;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.runtime.ref.RefVariable;

public class Buffersqueue extends ClarionQueue
{
	public ClarionNumber buff=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public RefVariable<Filemanager> fm=new RefVariable<Filemanager>(null);

	public Buffersqueue()
	{
		this.addVariable("Buff",this.buff);
		this.addVariable("Fm",this.fm);
	}
}
