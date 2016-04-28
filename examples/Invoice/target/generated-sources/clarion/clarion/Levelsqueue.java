package clarion;

import clarion.Resetfieldsqueue;
import clarion.Totalingfieldsqueue;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.runtime.ref.RefVariable;

public class Levelsqueue extends ClarionQueue
{
	public RefVariable<Resetfieldsqueue> fields=new RefVariable<Resetfieldsqueue>(null);
	public RefVariable<Totalingfieldsqueue> totals=new RefVariable<Totalingfieldsqueue>(null);
	public ClarionNumber records=Clarion.newNumber().setEncoding(ClarionNumber.LONG);

	public Levelsqueue()
	{
		this.addVariable("Fields",this.fields);
		this.addVariable("Totals",this.totals);
		this.addVariable("Records",this.records);
	}
}
