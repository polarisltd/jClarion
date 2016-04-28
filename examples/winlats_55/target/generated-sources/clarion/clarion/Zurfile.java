package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAsciiFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Zurfile extends ClarionAsciiFile
{
	public ClarionString line=Clarion.newString(132);

	public Zurfile()
	{
		setName(Main.dzfname);
		setPrefix("ZUF");
		setCreate();
		this.addVariable("line",this.line);
	}
}
