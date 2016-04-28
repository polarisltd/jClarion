package clarion.invoi001;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Previewqueue extends ClarionQueue
{
	public ClarionString filename=Clarion.newString(128);

	public Previewqueue()
	{
		this.addVariable("Filename",this.filename);
	}
}
