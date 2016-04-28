package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class Previewqueue extends ClarionQueue
{
	public ClarionString fileName=Clarion.newString(128);

	public Previewqueue()
	{
		this.addVariable("Filename",this.fileName);
	}
}
