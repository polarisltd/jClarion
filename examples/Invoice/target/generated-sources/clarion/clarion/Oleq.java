package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class Oleq extends ClarionQueue
{
	public ClarionString name=Clarion.newString(64).setEncoding(ClarionString.CSTRING);
	public ClarionString clsid=Clarion.newString(64).setEncoding(ClarionString.CSTRING);
	public ClarionString progid=Clarion.newString(64).setEncoding(ClarionString.CSTRING);

	public Oleq()
	{
		this.addVariable("name",this.name);
		this.addVariable("clsid",this.clsid);
		this.addVariable("progid",this.progid);
	}
}
