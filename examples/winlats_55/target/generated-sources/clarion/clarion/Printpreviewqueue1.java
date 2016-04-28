package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Printpreviewqueue1 extends ClarionQueue
{
	public ClarionString printpreviewimage1=Clarion.newString(80);

	public Printpreviewqueue1()
	{
		this.addVariable("PrintPreviewImage1",this.printpreviewimage1);
		this.setPrefix("");
	}
}
