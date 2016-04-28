package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class Logfilequeue extends ClarionQueue
{
	public ClarionString filename=Clarion.newString().setEncoding(ClarionString.ASTRING);
	public ClarionString logFileName=Clarion.newString().setEncoding(ClarionString.ASTRING);

	public Logfilequeue()
	{
		this.addVariable("FileName",this.filename);
		this.addVariable("LogFileName",this.logFileName);
	}
}
