package clarion;

import clarion.Filterqueue;
import clarion.abutil.Bufferedpairsclass;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.ref.RefVariable;

@SuppressWarnings("all")
public class Sortorder extends ClarionQueue
{
	public RefVariable<Filterqueue> filter=new RefVariable<Filterqueue>(null);
	public ClarionAny freeelement=Clarion.newAny();
	public ClarionNumber limittype=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public RefVariable<ClarionKey> mainkey=new RefVariable<ClarionKey>(null);
	public RefVariable<ClarionString> order=new RefVariable<ClarionString>(null);
	public RefVariable<Bufferedpairsclass> rangelist=new RefVariable<Bufferedpairsclass>(null);

	public Sortorder()
	{
		this.addVariable("Filter",this.filter);
		this.addVariable("FreeElement",this.freeelement);
		this.addVariable("LimitType",this.limittype);
		this.addVariable("MainKey",this.mainkey);
		this.addVariable("Order",this.order);
		this.addVariable("RangeList",this.rangelist);
	}
}
