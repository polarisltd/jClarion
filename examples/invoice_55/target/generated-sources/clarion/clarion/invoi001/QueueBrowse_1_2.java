package clarion.invoi001;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class QueueBrowse_1_2 extends ClarionQueue
{
	public ClarionNumber ordOrdernumber;
	public ClarionNumber ordOrderdate;
	public ClarionString locShipped;
	public ClarionString ordOrdernote;
	public ClarionString glotShipname;
	public ClarionString ordShiptoname;
	public ClarionString ordShipaddress1;
	public ClarionString ordShipaddress2;
	public ClarionString ordShipcity;
	public ClarionString ordShipstate;
	public ClarionString ordShipzip;
	public ClarionString glotShipcsz;
	public ClarionNumber ordInvoicenumber;
	public ClarionNumber ordCustnumber;
	public ClarionNumber mark;
	public ClarionString viewposition;

	public QueueBrowse_1_2(ClarionString locShipped)
	{
		this.ordOrdernumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		this.addVariable("ORD:OrderNumber",this.ordOrdernumber);
		this.ordOrderdate=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		this.addVariable("ORD:OrderDate",this.ordOrderdate);
		this.locShipped=Clarion.newString(3);
		this.addVariable("LOC:Shipped",this.locShipped);
		this.ordOrdernote=Clarion.newString(80);
		this.addVariable("ORD:OrderNote",this.ordOrdernote);
		this.glotShipname=Clarion.newString(35);
		this.addVariable("GLOT:ShipName",this.glotShipname);
		this.ordShiptoname=Clarion.newString(45);
		this.addVariable("ORD:ShipToName",this.ordShiptoname);
		this.ordShipaddress1=Clarion.newString(35);
		this.addVariable("ORD:ShipAddress1",this.ordShipaddress1);
		this.ordShipaddress2=Clarion.newString(35);
		this.addVariable("ORD:ShipAddress2",this.ordShipaddress2);
		this.ordShipcity=Clarion.newString(25);
		this.addVariable("ORD:ShipCity",this.ordShipcity);
		this.ordShipstate=Clarion.newString(2);
		this.addVariable("ORD:ShipState",this.ordShipstate);
		this.ordShipzip=Clarion.newString(10);
		this.addVariable("ORD:ShipZip",this.ordShipzip);
		this.glotShipcsz=Clarion.newString(40);
		this.addVariable("GLOT:ShipCSZ",this.glotShipcsz);
		this.ordInvoicenumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		this.addVariable("ORD:InvoiceNumber",this.ordInvoicenumber);
		this.ordCustnumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		this.addVariable("ORD:CustNumber",this.ordCustnumber);
		this.mark=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.addVariable("Mark",this.mark);
		this.viewposition=Clarion.newString(1024);
		this.addVariable("ViewPosition",this.viewposition);
	}
}
