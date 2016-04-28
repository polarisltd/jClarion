package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Printpreviewqueue extends ClarionQueue
{
	public ClarionString printpreviewimage=Clarion.newString(80);

	public Printpreviewqueue()
	{
		this.addVariable("PrintPreviewImage",this.printpreviewimage);
		this.setPrefix("");
	}
}
