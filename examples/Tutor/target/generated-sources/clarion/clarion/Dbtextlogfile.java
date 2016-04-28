package clarion;

import clarion.Abfile;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAsciiFile;
import org.jclarion.clarion.ClarionString;

public class Dbtextlogfile extends ClarionAsciiFile
{
	public ClarionString strEntry=Clarion.newString(1000);

	public Dbtextlogfile()
	{
		setName(Abfile.szDbTextLog);
		setCreate();
		this.addVariable("strEntry",this.strEntry);
	}
}
