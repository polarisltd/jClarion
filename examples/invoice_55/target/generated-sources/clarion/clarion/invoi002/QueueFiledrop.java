package clarion.invoi002;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class QueueFiledrop extends ClarionQueue
{
	public ClarionNumber ordInvoicenumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber ordOrderdate=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString ordShiptoname=Clarion.newString(45);
	public ClarionNumber mark=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString viewposition=Clarion.newString(1024);

	public QueueFiledrop()
	{
		this.addVariable("ORD:InvoiceNumber",this.ordInvoicenumber);
		this.addVariable("ORD:OrderDate",this.ordOrderdate);
		this.addVariable("ORD:ShipToName",this.ordShiptoname);
		this.addVariable("Mark",this.mark);
		this.addVariable("ViewPosition",this.viewposition);
	}
}
