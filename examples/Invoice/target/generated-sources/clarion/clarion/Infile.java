package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionBinaryFile;
import org.jclarion.clarion.ClarionString;

public class Infile extends ClarionBinaryFile
{
	public ClarionString buffer=Clarion.newString(32768);

	public Infile()
	{
		this.addVariable("buffer",this.buffer);
	}
}
