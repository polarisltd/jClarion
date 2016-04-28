package clarion.invoi001;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class QueueBrowse_1_1 extends ClarionQueue
{
	public ClarionString proDescription=Clarion.newString(35);
	public ClarionString proProductsku=Clarion.newString(10);
	public ClarionDecimal proPrice=Clarion.newDecimal(7,2);
	public ClarionDecimal proQuantityinstock=Clarion.newDecimal(7,2);
	public ClarionNumber proProductnumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber mark=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString viewposition=Clarion.newString(1024);

	public QueueBrowse_1_1()
	{
		this.addVariable("PRO:Description",this.proDescription);
		this.addVariable("PRO:ProductSKU",this.proProductsku);
		this.addVariable("PRO:Price",this.proPrice);
		this.addVariable("PRO:QuantityInStock",this.proQuantityinstock);
		this.addVariable("PRO:ProductNumber",this.proProductnumber);
		this.addVariable("Mark",this.mark);
		this.addVariable("ViewPosition",this.viewposition);
	}
}
