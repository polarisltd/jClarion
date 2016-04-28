package clarion;

import clarion.Levelmanagerclass;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.runtime.ref.RefVariable;

public class Breaksqueue extends ClarionQueue
{
	public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public RefVariable<Levelmanagerclass> thisBreak=new RefVariable<Levelmanagerclass>(null);

	public Breaksqueue()
	{
		this.addVariable("Id",this.id);
		this.addVariable("ThisBreak",this.thisBreak);
	}
}
