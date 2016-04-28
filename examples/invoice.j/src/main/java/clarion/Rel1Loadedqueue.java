package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class Rel1Loadedqueue extends ClarionQueue
{
	public ClarionNumber rEL1LoadedLevel=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString rEL1LoadedPosition=Clarion.newString(1024);

	public Rel1Loadedqueue()
	{
		this.addVariable("REL1::LoadedLevel",this.rEL1LoadedLevel);
		this.addVariable("REL1::LoadedPosition",this.rEL1LoadedPosition);
	}
}
