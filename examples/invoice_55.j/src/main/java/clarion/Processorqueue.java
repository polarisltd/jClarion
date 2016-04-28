package clarion;

import clarion.Recordprocessor;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.runtime.ref.RefVariable;

@SuppressWarnings("all")
public class Processorqueue extends ClarionQueue
{
	public RefVariable<Recordprocessor> p=new RefVariable<Recordprocessor>(null);

	public Processorqueue()
	{
		this.addVariable("P",this.p);
	}
}
