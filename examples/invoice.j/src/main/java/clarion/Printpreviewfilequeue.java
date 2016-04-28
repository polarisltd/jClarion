package clarion;

import clarion.equates.File;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class Printpreviewfilequeue extends ClarionQueue
{
	public ClarionString filename=Clarion.newString(File.MAXFILENAME);
	public ClarionString printPreviewImage=Clarion.newString(File.MAXFILENAME).setOver(filename);

	public Printpreviewfilequeue()
	{
		this.addVariable("Filename",this.filename);
		this.addVariable("PrintPreviewImage",this.printPreviewImage);
	}
}
