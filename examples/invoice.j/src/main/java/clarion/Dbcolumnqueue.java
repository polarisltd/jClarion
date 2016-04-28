package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class Dbcolumnqueue extends ClarionQueue
{
	public ClarionString filename=Clarion.newString().setEncoding(ClarionString.ASTRING);
	public ClarionString fieldName=Clarion.newString().setEncoding(ClarionString.ASTRING);
	public ClarionString fieldHeader=Clarion.newString().setEncoding(ClarionString.ASTRING);
	public ClarionString fieldPicture=Clarion.newString().setEncoding(ClarionString.ASTRING);
	public ClarionNumber length=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionAny field=Clarion.newAny();

	public Dbcolumnqueue()
	{
		this.addVariable("FileName",this.filename);
		this.addVariable("FieldName",this.fieldName);
		this.addVariable("FieldHeader",this.fieldHeader);
		this.addVariable("FieldPicture",this.fieldPicture);
		this.addVariable("Length",this.length);
		this.addVariable("Field",this.field);
	}
}
