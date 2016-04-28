package clarion;

import clarion.Format;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class Textformatqueue extends ClarionQueue
{
	public Format format=new Format();
	public ClarionString text=Clarion.newString(257).setEncoding(ClarionString.CSTRING);

	public Textformatqueue()
	{
		this.addVariable("Format",this.format);
		this.addVariable("Text",this.text);
	}
}
