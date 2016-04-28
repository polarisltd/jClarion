package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class Logfilequeue extends ClarionQueue
{
	public ClarionString fileName=Clarion.newString().setEncoding(ClarionString.ASTRING);
	public ClarionString logFileName=Clarion.newString().setEncoding(ClarionString.ASTRING);

	public Logfilequeue()
	{
		this.addVariable("FileName",this.fileName);
		this.addVariable("LogFileName",this.logFileName);
	}
}
