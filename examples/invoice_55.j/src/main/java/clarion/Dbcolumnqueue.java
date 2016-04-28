package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Dbcolumnqueue extends ClarionQueue
{
	public ClarionString filename=Clarion.newString().setEncoding(ClarionString.ASTRING);
	public ClarionString fieldname=Clarion.newString().setEncoding(ClarionString.ASTRING);
	public ClarionString fieldheader=Clarion.newString().setEncoding(ClarionString.ASTRING);
	public ClarionString fieldpicture=Clarion.newString().setEncoding(ClarionString.ASTRING);
	public ClarionNumber length=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionAny field=Clarion.newAny();

	public Dbcolumnqueue()
	{
		this.addVariable("FileName",this.filename);
		this.addVariable("FieldName",this.fieldname);
		this.addVariable("FieldHeader",this.fieldheader);
		this.addVariable("FieldPicture",this.fieldpicture);
		this.addVariable("Length",this.length);
		this.addVariable("Field",this.field);
	}
}
