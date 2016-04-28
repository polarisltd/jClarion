package clarion;

import clarion.Sortorder;
import clarion.abbrowse.Locatorclass;
import clarion.abbrowse.Stepclass;
import clarion.abutil.Fieldpairsclass;
import org.jclarion.clarion.runtime.ref.RefVariable;

@SuppressWarnings("all")
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
