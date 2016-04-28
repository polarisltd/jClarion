package clarion;

import clarion.Ireportgenerator;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.runtime.ref.RefVariable;

public class Reportgeneratorqueue extends ClarionQueue
{
	public RefVariable<Ireportgenerator> reportGenerator=new RefVariable<Ireportgenerator>(null);

	public Reportgeneratorqueue()
	{
		this.addVariable("ReportGenerator",this.reportGenerator);
	}
}
