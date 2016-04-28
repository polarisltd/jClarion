package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAsciiFile;
import org.jclarion.clarion.ClarionString;

public class Stderrorfile extends ClarionAsciiFile
{
	public ClarionString txt=Clarion.newString(1024);

	public Stderrorfile()
	{
		setCreate();
		setName(Clarion.newString("ABCError.Log"));
		this.addVariable("Txt",this.txt);
	}
}
