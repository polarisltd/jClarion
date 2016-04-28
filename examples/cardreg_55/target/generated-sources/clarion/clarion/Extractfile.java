package clarion;

import clarion.Abutil;
import clarion.equates.Constants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAsciiFile;
import org.jclarion.clarion.ClarionString;

public class Extractfile extends ClarionAsciiFile
{
	public ClarionString line=Clarion.newString(Constants.MAXTLEN);

	public Extractfile()
	{
		setName(Abutil.kill_ExtractFilename);
		setCreate();
		this.addVariable("Line",this.line);
	}
}
