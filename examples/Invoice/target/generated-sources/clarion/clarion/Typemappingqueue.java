package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;

public class Typemappingqueue extends ClarionQueue
{
	public ClarionNumber controlType=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber property=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);

	public Typemappingqueue()
	{
		this.addVariable("ControlType",this.controlType);
		this.addVariable("Property",this.property);
	}
}
