package clarion;

import clarion.Windowcomponent;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.runtime.ref.RefVariable;

public class Componentlist extends ClarionQueue
{
	public ClarionNumber type=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
	public RefVariable<Windowcomponent> wc=new RefVariable<Windowcomponent>(null);

	public Componentlist()
	{
		this.addVariable("Type",this.type);
		this.addVariable("WC",this.wc);
	}
}
