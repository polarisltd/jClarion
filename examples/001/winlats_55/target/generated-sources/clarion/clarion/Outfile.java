package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAsciiFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Outfile extends ClarionAsciiFile
{
	public ClarionString line=Clarion.newString(500);

	public Outfile()
	{
		setName(Main.asciifilename);
		setPrefix("OUT");
		setCreate();
		this.addVariable("LINE",this.line);
	}
}
