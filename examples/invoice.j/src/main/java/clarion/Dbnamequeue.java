package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class Dbnamequeue extends ClarionQueue
{
	public ClarionString filename=Clarion.newString().setEncoding(ClarionString.ASTRING);
	public ClarionString fieldName=Clarion.newString().setEncoding(ClarionString.ASTRING);
	public ClarionNumber ptr=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);

	public Dbnamequeue()
	{
		this.addVariable("FileName",this.filename);
		this.addVariable("FieldName",this.fieldName);
		this.addVariable("Ptr",this.ptr);
	}
}
