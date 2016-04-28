package clarion;

import clarion.Filedropclass;
import clarion.QueueFiledrop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;

public class Fdb2 extends Filedropclass
{
	public QueueFiledrop q;
	public Fdb2()
	{
		q=null;
	}

	public ClarionNumber resetQueue()
	{
		return resetQueue(Clarion.newNumber(0));
	}
	public ClarionNumber resetQueue(ClarionNumber force)
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber greenBarIndex=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		returnValue.setValue(super.resetQueue(force.like()));
		return returnValue.like();
	}
}
