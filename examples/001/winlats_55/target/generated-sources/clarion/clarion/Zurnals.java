package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAsciiFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Zurnals extends ClarionAsciiFile
{
	public ClarionString line=Clarion.newString(132);

	public Zurnals()
	{
		setName(Main.dzname);
		setPrefix("ZUR");
		setCreate();
		this.addVariable("line",this.line);
	}
}
