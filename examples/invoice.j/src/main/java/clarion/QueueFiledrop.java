package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class QueueFiledrop extends ClarionQueue
{
	public ClarionNumber oRDInvoiceNumber=Main.orders.invoiceNumber.like();
	public ClarionNumber oRDOrderDate=Main.orders.orderDate.like();
	public ClarionString oRDShipToName=Main.orders.shipToName.like();
	public ClarionNumber mark=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString viewPosition=Clarion.newString(1024);

	public QueueFiledrop()
	{
		this.addVariable("ORD:InvoiceNumber",this.oRDInvoiceNumber);
		this.addVariable("ORD:OrderDate",this.oRDOrderDate);
		this.addVariable("ORD:ShipToName",this.oRDShipToName);
		this.addVariable("Mark",this.mark);
		this.addVariable("ViewPosition",this.viewPosition);
	}
}
