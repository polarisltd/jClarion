package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Orders extends ClarionSQLFile
{
	public ClarionNumber custnumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber ordernumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber invoicenumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber orderdate=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber samename=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString shiptoname=Clarion.newString(45);
	public ClarionNumber sameadd=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString shipaddress1=Clarion.newString(35);
	public ClarionString shipaddress2=Clarion.newString(35);
	public ClarionString shipcity=Clarion.newString(25);
	public ClarionString shipstate=Clarion.newString(2);
	public ClarionString shipzip=Clarion.newString(10);
	public ClarionNumber ordershipped=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString ordernote=Clarion.newString(80);
	public ClarionKey keycustordernumber=new ClarionKey("KeyCustOrderNumber");
	public ClarionKey invoicenumberkey=new ClarionKey("InvoiceNumberKey");

	public Orders()
	{
		setName(Clarion.newString("Orders.tps"));
		setPrefix("ORD");
		setCreate();
		setName(Clarion.newString("orders"));
		this.addVariable("CustNumber",this.custnumber);
		this.addVariable("OrderNumber",this.ordernumber);
		this.addVariable("InvoiceNumber",this.invoicenumber);
		this.addVariable("OrderDate",this.orderdate);
		this.addVariable("SameName",this.samename);
		this.addVariable("ShipToName",this.shiptoname);
		this.addVariable("SameAdd",this.sameadd);
		this.addVariable("ShipAddress1",this.shipaddress1);
		this.addVariable("ShipAddress2",this.shipaddress2);
		this.addVariable("ShipCity",this.shipcity);
		this.addVariable("ShipState",this.shipstate);
		this.addVariable("ShipZip",this.shipzip);
		this.addVariable("OrderShipped",this.ordershipped);
		this.addVariable("OrderNote",this.ordernote);
		keycustordernumber.setDuplicate().setNocase().setOptional().addAscendingField(custnumber).addAscendingField(ordernumber);
		this.addKey(keycustordernumber);
		invoicenumberkey.setNocase().setOptional().addAscendingField(invoicenumber);
		this.addKey(invoicenumberkey);
	}
}
