package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class Colormap extends ClarionQueue
{
	public ClarionNumber color=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString text=Clarion.newString(25).setEncoding(ClarionString.CSTRING);
	public ClarionString textKey=Clarion.newString(25).setEncoding(ClarionString.PSTRING);

	public Colormap()
	{
		this.addVariable("Color",this.color);
		this.addVariable("Text",this.text);
		this.addVariable("TextKey",this.textKey);
	}
}
