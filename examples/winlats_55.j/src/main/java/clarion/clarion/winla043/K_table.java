package clarion.winla043;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class K_table extends ClarionQueue
{
	public ClarionString nos=Clarion.newString(3);
	public ClarionDecimal k2190=Clarion.newDecimal(12,2);
	public ClarionDecimal k2310=Clarion.newDecimal(12,2);
	public ClarionDecimal k5210=Clarion.newDecimal(12,2);
	public ClarionDecimal k5310=Clarion.newDecimal(12,2);
	public ClarionDecimal p2190=Clarion.newDecimal(12,2);
	public ClarionDecimal p2310=Clarion.newDecimal(12,2);
	public ClarionDecimal p5210=Clarion.newDecimal(12,2);
	public ClarionDecimal p5310=Clarion.newDecimal(12,2);

	public K_table()
	{
		this.addVariable("NOS",this.nos);
		this.addVariable("k2190",this.k2190);
		this.addVariable("k2310",this.k2310);
		this.addVariable("k5210",this.k5210);
		this.addVariable("k5310",this.k5310);
		this.addVariable("p2190",this.p2190);
		this.addVariable("p2310",this.p2310);
		this.addVariable("p5210",this.p5210);
		this.addVariable("p5310",this.p5310);
		this.setPrefix("K");
	}
}
