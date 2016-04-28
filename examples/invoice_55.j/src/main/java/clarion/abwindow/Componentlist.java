package clarion.abwindow;

import clarion.Windowcomponent;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.runtime.ref.RefVariable;

@SuppressWarnings("all")
public class Componentlist extends ClarionQueue
{
	public RefVariable<Windowcomponent> wc=new RefVariable<Windowcomponent>(null);

	public Componentlist()
	{
		this.addVariable("WC",this.wc);
	}
}
