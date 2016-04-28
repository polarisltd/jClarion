package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionQueue;

@SuppressWarnings("all")
public class Bufferedpairsqueue extends ClarionQueue
{
	public ClarionAny left=Clarion.newAny();
	public ClarionAny right=Clarion.newAny();
	public ClarionAny buffer=Clarion.newAny();

	public Bufferedpairsqueue()
	{
		this.addVariable("Left",this.left);
		this.addVariable("Right",this.right);
		this.addVariable("Buffer",this.buffer);
	}
}
