package clarion;

import clarion.Fieldpairsclass;
import clarion.Locatorclass;
import clarion.Sortorder;
import clarion.Stepclass;
import org.jclarion.clarion.runtime.ref.RefVariable;

public class Browsesortorder extends Sortorder
{
	public RefVariable<Locatorclass> locator=new RefVariable<Locatorclass>(null);
	public RefVariable<Fieldpairsclass> resets=new RefVariable<Fieldpairsclass>(null);
	public RefVariable<Stepclass> thumb=new RefVariable<Stepclass>(null);

	public Browsesortorder()
	{
		this.addVariable("Locator",this.locator);
		this.addVariable("Resets",this.resets);
		this.addVariable("Thumb",this.thumb);
	}
}
