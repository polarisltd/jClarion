package clarion;

import clarion.Format_1;
import org.jclarion.clarion.ClarionQueue;

public class Sliceformatqueue extends ClarionQueue
{
	public Format_1 format=new Format_1();

	public Sliceformatqueue()
	{
		this.addVariable("Format",this.format);
	}
}
