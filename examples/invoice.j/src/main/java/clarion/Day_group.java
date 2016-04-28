package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionString;

public class Day_group extends ClarionGroup
{
	public ClarionString d1=Clarion.newString("Mon");
	public ClarionString d2=Clarion.newString("Tue");
	public ClarionString d3=Clarion.newString("Wed");
	public ClarionString d4=Clarion.newString("Thu");
	public ClarionString d5=Clarion.newString("Fri");
	public ClarionString d6=Clarion.newString("Sat");
	public ClarionString d7=Clarion.newString("Sun");

	public Day_group()
	{
		this.addVariable("d1",this.d1);
		this.addVariable("d2",this.d2);
		this.addVariable("d3",this.d3);
		this.addVariable("d4",this.d4);
		this.addVariable("d5",this.d5);
		this.addVariable("d6",this.d6);
		this.addVariable("d7",this.d7);
	}
}
