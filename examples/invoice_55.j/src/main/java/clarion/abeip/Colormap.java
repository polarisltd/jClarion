package clarion.abeip;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Colormap extends ClarionQueue
{
	public ClarionNumber color=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString text=Clarion.newString(25).setEncoding(ClarionString.CSTRING);
	public ClarionString textkey=Clarion.newString(25).setEncoding(ClarionString.PSTRING);

	public Colormap()
	{
		this.addVariable("Color",this.color);
		this.addVariable("Text",this.text);
		this.addVariable("TextKey",this.textkey);
	}
}
