package clarion;

import clarion.Toolbartarget;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.runtime.ref.RefVariable;

public class Toolbartargetqueue extends ClarionQueue
{
	public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public RefVariable<Toolbartarget> item=new RefVariable<Toolbartarget>(null);

	public Toolbartargetqueue()
	{
		this.addVariable("Id",this.id);
		this.addVariable("Item",this.item);
	}
}
