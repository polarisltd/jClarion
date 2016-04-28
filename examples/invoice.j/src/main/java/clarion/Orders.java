package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

public class Orders extends ClarionSQLFile
{
	public ClarionNumber custNumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber orderNumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber invoiceNumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber orderDate=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber sameName=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString shipToName=Clarion.newString(45);
	public ClarionNumber sameAdd=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString shipAddress1=Clarion.newString(35);
	public ClarionString shipAddress2=Clarion.newString(35);
	public ClarionString shipCity=Clarion.newString(25);
	public ClarionString shipState=Clarion.newString(2);
	public ClarionString shipZip=Clarion.newString(10);
	public ClarionNumber orderShipped=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString orderNote=Clarion.newString(80);
	public ClarionKey keyCustOrderNumber=new ClarionKey("KeyCustOrderNumber");
	public ClarionKey invoiceNumberKey=new ClarionKey("InvoiceNumberKey");
	public ClarionKey keyOrderNumber=new ClarionKey("KeyOrderNumber");

	public Orders()
	{
		setName(Clarion.newString("Orders"));
		setPrefix("ORD");
		setCreate();
		this.addVariable("CustNumber",this.custNumber);
		this.addVariable("OrderNumber",this.orderNumber);
		this.addVariable("InvoiceNumber",this.invoiceNumber);
		this.addVariable("OrderDate",this.orderDate);
		this.addVariable("SameName",this.sameName);
		this.addVariable("ShipToName",this.shipToName);
		this.addVariable("SameAdd",this.sameAdd);
		this.addVariable("ShipAddress1",this.shipAddress1);
		this.addVariable("ShipAddress2",this.shipAddress2);
		this.addVariable("ShipCity",this.shipCity);
		this.addVariable("ShipState",this.shipState);
		this.addVariable("ShipZip",this.shipZip);
		this.addVariable("OrderShipped",this.orderShipped);
		this.addVariable("OrderNote",this.orderNote);
		keyCustOrderNumber.setDuplicate().setNocase().setOptional().addAscendingField(custNumber).addAscendingField(orderNumber);
		this.addKey(keyCustOrderNumber);
		invoiceNumberKey.setNocase().setOptional().addAscendingField(invoiceNumber);
		this.addKey(invoiceNumberKey);
		keyOrderNumber.setPrimary().addAscendingField(orderNumber);
		this.addKey(keyOrderNumber);
	}
}
