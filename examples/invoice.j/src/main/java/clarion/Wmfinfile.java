package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionBinaryFile;
import org.jclarion.clarion.ClarionString;

public class Wmfinfile extends ClarionBinaryFile
{
	public ClarionString buffer=Clarion.newString(5000);

	public Wmfinfile()
	{
		setPrefix("WMFF");
		this.addVariable("Buffer",this.buffer);
	}
}
