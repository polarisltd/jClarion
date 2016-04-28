package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class Fieldslist extends ClarionQueue
{
	public ClarionString tag=Clarion.newString().setEncoding(ClarionString.ASTRING);
	public ClarionAny fld=Clarion.newAny();
	public ClarionString fType=Clarion.newString().setEncoding(ClarionString.ASTRING);
	public ClarionString fPicture=Clarion.newString().setEncoding(ClarionString.ASTRING);

	public Fieldslist()
	{
		this.addVariable("Tag",this.tag);
		this.addVariable("Fld",this.fld);
		this.addVariable("fType",this.fType);
		this.addVariable("fPicture",this.fPicture);
	}
}
