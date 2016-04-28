package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionQueue;

public class Fieldpairsqueue extends ClarionQueue
{
	public ClarionAny left=Clarion.newAny();
	public ClarionAny right=Clarion.newAny();

	public Fieldpairsqueue()
	{
		this.addVariable("Left",this.left);
		this.addVariable("Right",this.right);
	}
}
