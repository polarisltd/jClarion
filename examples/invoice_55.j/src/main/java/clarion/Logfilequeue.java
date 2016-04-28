package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Logfilequeue extends ClarionQueue
{
	public ClarionString filename=Clarion.newString().setEncoding(ClarionString.ASTRING);
	public ClarionString logfilename=Clarion.newString().setEncoding(ClarionString.ASTRING);

	public Logfilequeue()
	{
		this.addVariable("FileName",this.filename);
		this.addVariable("LogFileName",this.logfilename);
	}
}
