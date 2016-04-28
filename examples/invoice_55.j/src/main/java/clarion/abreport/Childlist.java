package clarion.abreport;

import clarion.abfile.Viewmanager;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.runtime.ref.RefVariable;

@SuppressWarnings("all")
public class Childlist extends ClarionQueue
{
	public RefVariable<Viewmanager> vm=new RefVariable<Viewmanager>(null);

	public Childlist()
	{
		this.addVariable("VM",this.vm);
	}
}
