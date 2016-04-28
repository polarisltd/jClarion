package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAsciiFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Outfileansi extends ClarionAsciiFile
{
	public ClarionString line=Clarion.newString(500);

	public Outfileansi()
	{
		setName(Main.ansifilename);
		setPrefix("OUTA");
		setCreate();
		this.addVariable("LINE",this.line);
	}
}
