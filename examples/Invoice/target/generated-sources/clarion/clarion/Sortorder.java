package clarion;

import clarion.Bufferedpairsclass;
import clarion.Filterqueue;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.ref.RefVariable;

public class Sortorder extends ClarionQueue
{
	public RefVariable<Filterqueue> filter=new RefVariable<Filterqueue>(null);
	public ClarionAny freeElement=Clarion.newAny();
	public ClarionNumber limitType=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public RefVariable<ClarionKey> mainKey=new RefVariable<ClarionKey>(null);
	public RefVariable<ClarionString> order=new RefVariable<ClarionString>(null);
	public RefVariable<Bufferedpairsclass> rangeList=new RefVariable<Bufferedpairsclass>(null);

	public Sortorder()
	{
		this.addVariable("Filter",this.filter);
		this.addVariable("FreeElement",this.freeElement);
		this.addVariable("LimitType",this.limitType);
		this.addVariable("MainKey",this.mainKey);
		this.addVariable("Order",this.order);
		this.addVariable("RangeList",this.rangeList);
	}
}
