package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionBinaryFile;
import org.jclarion.clarion.ClarionString;

public class Outfile extends ClarionBinaryFile
{
	public ClarionString buffer=Clarion.newString(32768);

	public Outfile()
	{
		setCreate();
		this.addVariable("buffer",this.buffer);
	}
}
