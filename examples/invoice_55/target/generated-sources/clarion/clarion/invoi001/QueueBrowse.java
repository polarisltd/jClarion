package clarion.invoi001;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class QueueBrowse extends ClarionQueue
{
	public ClarionString proDescription;
	public ClarionDecimal dtlQuantityordered;
	public ClarionDecimal dtlPrice;
	public ClarionString locBackorder;
	public ClarionDecimal dtlTaxpaid;
	public ClarionDecimal dtlDiscount;
	public ClarionDecimal dtlTotalcost;
	public ClarionDecimal dtlTaxrate;
	public ClarionDecimal dtlDiscountrate;
	public ClarionNumber dtlCustnumber;
	public ClarionNumber dtlOrdernumber;
	public ClarionNumber dtlLinenumber;
	public ClarionNumber proProductnumber;
	public ClarionNumber mark;
	public ClarionString viewposition;

	public QueueBrowse(ClarionString locBackorder)
	{
		this.proDescription=Clarion.newString(35);
		this.addVariable("PRO:Description",this.proDescription);
		this.dtlQuantityordered=Clarion.newDecimal(7,2);
		this.addVariable("DTL:QuantityOrdered",this.dtlQuantityordered);
		this.dtlPrice=Clarion.newDecimal(7,2);
		this.addVariable("DTL:Price",this.dtlPrice);
		this.locBackorder=Clarion.newString(3);
		this.addVariable("LOC:Backorder",this.locBackorder);
		this.dtlTaxpaid=Clarion.newDecimal(7,2);
		this.addVariable("DTL:TaxPaid",this.dtlTaxpaid);
		this.dtlDiscount=Clarion.newDecimal(7,2);
		this.addVariable("DTL:Discount",this.dtlDiscount);
		this.dtlTotalcost=Clarion.newDecimal(10,2);
		this.addVariable("DTL:TotalCost",this.dtlTotalcost);
		this.dtlTaxrate=Clarion.newDecimal(6,4);
		this.addVariable("DTL:TaxRate",this.dtlTaxrate);
		this.dtlDiscountrate=Clarion.newDecimal(6,4);
		this.addVariable("DTL:DiscountRate",this.dtlDiscountrate);
		this.dtlCustnumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		this.addVariable("DTL:CustNumber",this.dtlCustnumber);
		this.dtlOrdernumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		this.addVariable("DTL:OrderNumber",this.dtlOrdernumber);
		this.dtlLinenumber=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		this.addVariable("DTL:LineNumber",this.dtlLinenumber);
		this.proProductnumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		this.addVariable("PRO:ProductNumber",this.proProductnumber);
		this.mark=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.addVariable("Mark",this.mark);
		this.viewposition=Clarion.newString(1024);
		this.addVariable("ViewPosition",this.viewposition);
	}
}
