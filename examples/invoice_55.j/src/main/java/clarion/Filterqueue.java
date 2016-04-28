package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.ref.RefVariable;

@SuppressWarnings("all")
public class Filterqueue extends ClarionQueue
{
	public ClarionString id=Clarion.newString(30);
	public RefVariable<ClarionString> filter=new RefVariable<ClarionString>(null);

	public Filterqueue()
	{
		this.addVariable("ID",this.id);
		this.addVariable("Filter",this.filter);
	}
}
