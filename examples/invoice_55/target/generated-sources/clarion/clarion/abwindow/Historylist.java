package clarion.abwindow;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.runtime.ref.RefVariable;

@SuppressWarnings("all")
public class Historylist extends ClarionQueue
{
	public RefVariable<ClarionGroup> frecord=new RefVariable<ClarionGroup>(null);
	public RefVariable<ClarionGroup> srecord=new RefVariable<ClarionGroup>(null);
	public ClarionNumber control=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber fieldno=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);

	public Historylist()
	{
		this.addVariable("FRecord",this.frecord);
		this.addVariable("SRecord",this.srecord);
		this.addVariable("Control",this.control);
		this.addVariable("FieldNo",this.fieldno);
	}
}
