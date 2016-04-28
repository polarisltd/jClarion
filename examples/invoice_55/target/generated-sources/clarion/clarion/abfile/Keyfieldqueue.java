package clarion.abfile;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.ref.RefVariable;

@SuppressWarnings("all")
public class Keyfieldqueue extends ClarionQueue
{
	public ClarionAny field=Clarion.newAny();
	public RefVariable<ClarionString> fieldname=new RefVariable<ClarionString>(null);
	public ClarionNumber ascend=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);

	public Keyfieldqueue()
	{
		this.addVariable("Field",this.field);
		this.addVariable("FieldName",this.fieldname);
		this.addVariable("Ascend",this.ascend);
	}
}
