package clarion.winla_sf;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionReal;

@SuppressWarnings("all")
public class _Anon_2 extends ClarionGroup
{
	public ClarionReal stepvalue=Clarion.newReal();
	public ClarionNumber currentstep=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionReal lowlimit=Clarion.newReal();
	public ClarionReal highlimit=Clarion.newReal();

	public _Anon_2()
	{
		this.addVariable("StepValue",this.stepvalue);
		this.addVariable("CurrentStep",this.currentstep);
		this.addVariable("LowLimit",this.lowlimit);
		this.addVariable("HighLimit",this.highlimit);
		this.setPrefix("CR:");
	}
}
