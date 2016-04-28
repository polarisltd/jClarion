package clarion.abutil;

import clarion.abutil.Abutil;
import clarion.abutil.equates.Mconstants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAsciiFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Extractfile extends ClarionAsciiFile
{
	public ClarionString line=Clarion.newString(Mconstants.MAXTLEN);

	public Extractfile()
	{
		setName(Abutil.kill_extractfilename);
		setCreate();
		this.addVariable("Line",this.line);
	}
}
