package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class QueueBrowse_1_2 extends ClarionQueue
{
	public ClarionNumber oRDOrderNumber;
	public ClarionNumber oRDOrderDate;
	public ClarionString lOCShipped;
	public ClarionString oRDOrderNote;
	public ClarionString gLOTShipName;
	public ClarionString oRDShipToName;
	public ClarionString oRDShipAddress1;
	public ClarionString oRDShipAddress2;
	public ClarionString oRDShipCity;
	public ClarionString oRDShipState;
	public ClarionString oRDShipZip;
	public ClarionString gLOTShipCSZ;
	public ClarionNumber oRDInvoiceNumber;
	public ClarionNumber oRDCustNumber;
	public ClarionNumber mark;
	public ClarionString viewPosition;

	public QueueBrowse_1_2(ClarionString lOCShipped)
	{
		this.oRDOrderNumber=Main.orders.orderNumber.like();
		this.addVariable("ORD:OrderNumber",this.oRDOrderNumber);
		this.oRDOrderDate=Main.orders.orderDate.like();
		this.addVariable("ORD:OrderDate",this.oRDOrderDate);
		this.lOCShipped=lOCShipped.like();
		this.addVariable("LOC:Shipped",this.lOCShipped);
		this.oRDOrderNote=Main.orders.orderNote.like();
		this.addVariable("ORD:OrderNote",this.oRDOrderNote);
		this.gLOTShipName=Main.gLOTShipName.like();
		this.addVariable("GLOT:ShipName",this.gLOTShipName);
		this.oRDShipToName=Main.orders.shipToName.like();
		this.addVariable("ORD:ShipToName",this.oRDShipToName);
		this.oRDShipAddress1=Main.orders.shipAddress1.like();
		this.addVariable("ORD:ShipAddress1",this.oRDShipAddress1);
		this.oRDShipAddress2=Main.orders.shipAddress2.like();
		this.addVariable("ORD:ShipAddress2",this.oRDShipAddress2);
		this.oRDShipCity=Main.orders.shipCity.like();
		this.addVariable("ORD:ShipCity",this.oRDShipCity);
		this.oRDShipState=Main.orders.shipState.like();
		this.addVariable("ORD:ShipState",this.oRDShipState);
		this.oRDShipZip=Main.orders.shipZip.like();
		this.addVariable("ORD:ShipZip",this.oRDShipZip);
		this.gLOTShipCSZ=Main.gLOTShipCSZ.like();
		this.addVariable("GLOT:ShipCSZ",this.gLOTShipCSZ);
		this.oRDInvoiceNumber=Main.orders.invoiceNumber.like();
		this.addVariable("ORD:InvoiceNumber",this.oRDInvoiceNumber);
		this.oRDCustNumber=Main.orders.custNumber.like();
		this.addVariable("ORD:CustNumber",this.oRDCustNumber);
		this.mark=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.addVariable("Mark",this.mark);
		this.viewPosition=Clarion.newString(1024);
		this.addVariable("ViewPosition",this.viewPosition);
	}
}
