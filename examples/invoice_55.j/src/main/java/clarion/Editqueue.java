package clarion;

import clarion.abeip.Editclass;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.runtime.ref.RefVariable;

@SuppressWarnings("all")
public class Editqueue extends ClarionQueue
{
	public ClarionNumber field=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
	public ClarionNumber freeup=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public RefVariable<Editclass> control=new RefVariable<Editclass>(null);

	public Editqueue()
	{
		this.addVariable("Field",this.field);
		this.addVariable("FreeUp",this.freeup);
		this.addVariable("Control",this.control);
	}
}
