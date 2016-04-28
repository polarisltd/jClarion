package clarion.abfile;

import clarion.abfile.Abfile;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAsciiFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Dbtextlogfile extends ClarionAsciiFile
{
	public ClarionString strentry=Clarion.newString(1000);

	public Dbtextlogfile()
	{
		setName(Abfile.szdbtextlog);
		setCreate();
		this.addVariable("strEntry",this.strentry);
	}
}
