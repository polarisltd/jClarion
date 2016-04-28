package clarion.abutil;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;

@SuppressWarnings("all")
public class Typemappingqueue extends ClarionQueue
{
	public ClarionNumber controltype=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber property=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);

	public Typemappingqueue()
	{
		this.addVariable("ControlType",this.controltype);
		this.addVariable("Property",this.property);
	}
}
