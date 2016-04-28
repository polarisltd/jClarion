package clarion;

import clarion.abutil.Bufferedpairsclass;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.ref.RefVariable;

@SuppressWarnings("all")
public class Dbtriggerqueue extends ClarionQueue
{
	public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionString filename=Clarion.newString().setEncoding(ClarionString.ASTRING);
	public RefVariable<Bufferedpairsclass> bfp=new RefVariable<Bufferedpairsclass>(null);

	public Dbtriggerqueue()
	{
		this.addVariable("ID",this.id);
		this.addVariable("FileName",this.filename);
		this.addVariable("BFP",this.bfp);
	}
}
