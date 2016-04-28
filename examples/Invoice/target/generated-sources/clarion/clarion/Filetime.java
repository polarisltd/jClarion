package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

public class Filetime extends ClarionGroup
{
	public ClarionNumber dwLowDateTime=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber dwHighDateTime=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);

	public Filetime()
	{
		this.addVariable("dwLowDateTime",this.dwLowDateTime);
		this.addVariable("dwHighDateTime",this.dwHighDateTime);
	}
}
