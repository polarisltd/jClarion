package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class Valuelist extends ClarionQueue
{
	public ClarionString field=Clarion.newString(100).setEncoding(ClarionString.CSTRING);
	public ClarionString ops=Clarion.newString(10).setEncoding(ClarionString.CSTRING);
	public ClarionString value=Clarion.newString(100).setEncoding(ClarionString.CSTRING);

	public Valuelist()
	{
		this.addVariable("Field",this.field);
		this.addVariable("Ops",this.ops);
		this.addVariable("Value",this.value);
	}
}
