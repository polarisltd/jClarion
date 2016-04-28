package clarion;

import clarion.Editclass;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.runtime.ref.RefVariable;

public class Editqueue extends ClarionQueue
{
	public ClarionNumber field=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
	public ClarionNumber freeUp=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public RefVariable<Editclass> control=new RefVariable<Editclass>(null);

	public Editqueue()
	{
		this.addVariable("Field",this.field);
		this.addVariable("FreeUp",this.freeUp);
		this.addVariable("Control",this.control);
	}
}
