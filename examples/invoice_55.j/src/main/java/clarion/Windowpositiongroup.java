package clarion;

import clarion.Positiongroup;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;

@SuppressWarnings("all")
public class Windowpositiongroup extends Positiongroup
{
	public ClarionNumber maximized=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber iconized=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);

	public Windowpositiongroup()
	{
		this.addVariable("Maximized",this.maximized);
		this.addVariable("Iconized",this.iconized);
	}
}
