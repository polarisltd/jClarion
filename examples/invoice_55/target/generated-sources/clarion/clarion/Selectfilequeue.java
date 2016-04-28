package clarion;

import clarion.equates.File;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Selectfilequeue extends ClarionQueue
{
	public ClarionString name=Clarion.newString(File.MAXFILEPATH);
	public ClarionString shortname=Clarion.newString(File.MAXFILEPATH);

	public Selectfilequeue()
	{
		this.addVariable("Name",this.name);
		this.addVariable("ShortName",this.shortname);
	}
}
