package clarion.invoi001;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Rel1Loadedqueue extends ClarionQueue
{
	public ClarionNumber rel1Loadedlevel=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString rel1Loadedposition=Clarion.newString(1024);

	public Rel1Loadedqueue()
	{
		this.addVariable("REL1::LoadedLevel",this.rel1Loadedlevel);
		this.addVariable("REL1::LoadedPosition",this.rel1Loadedposition);
		this.setPrefix("");
	}
}
