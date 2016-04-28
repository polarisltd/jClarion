package clarion.abfile;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Fieldslist extends ClarionQueue
{
	public ClarionString tag=Clarion.newString().setEncoding(ClarionString.ASTRING);
	public ClarionAny fld=Clarion.newAny();
	public ClarionString ftype=Clarion.newString().setEncoding(ClarionString.ASTRING);
	public ClarionString fpicture=Clarion.newString().setEncoding(ClarionString.ASTRING);

	public Fieldslist()
	{
		this.addVariable("Tag",this.tag);
		this.addVariable("Fld",this.fld);
		this.addVariable("fType",this.ftype);
		this.addVariable("fPicture",this.fpicture);
	}
}
