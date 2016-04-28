package clarion;

import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.ref.RefVariable;

public class Cstringlist extends ClarionQueue
{
	public RefVariable<ClarionString> item=new RefVariable<ClarionString>(null);

	public Cstringlist()
	{
		this.addVariable("Item",this.item);
	}
}
