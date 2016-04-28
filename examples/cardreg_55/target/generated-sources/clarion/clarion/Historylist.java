package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.runtime.ref.RefVariable;

public class Historylist extends ClarionQueue
{
	public RefVariable<ClarionGroup> fRecord=new RefVariable<ClarionGroup>(null);
	public RefVariable<ClarionGroup> sRecord=new RefVariable<ClarionGroup>(null);
	public ClarionNumber control=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber fieldNo=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);

	public Historylist()
	{
		this.addVariable("FRecord",this.fRecord);
		this.addVariable("SRecord",this.sRecord);
		this.addVariable("Control",this.control);
		this.addVariable("FieldNo",this.fieldNo);
	}
}
