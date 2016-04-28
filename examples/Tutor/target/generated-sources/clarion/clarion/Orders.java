package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

public class Orders extends ClarionSQLFile
{
	public ClarionNumber custnumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber ordernumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionDecimal invoiceamount=Clarion.newDecimal(7,2);
	public ClarionNumber orderdate=Clarion.newNumber().setEncoding(ClarionNumber.DATE);
	public ClarionString ordernote=Clarion.newString(80);
	public ClarionKey keyordernumber=new ClarionKey("KEYORDERNUMBER");
	public ClarionKey keycustnumber=new ClarionKey("KEYCUSTNUMBER");

	public Orders()
	{
		setName(Clarion.newString("ORDERS"));
		setPrefix("ORD");
		setCreate();
		this.addVariable("CUSTNUMBER",this.custnumber);
		this.addVariable("ORDERNUMBER",this.ordernumber);
		this.addVariable("INVOICEAMOUNT",this.invoiceamount);
		this.addVariable("ORDERDATE",this.orderdate);
		this.addVariable("ORDERNOTE",this.ordernote);
		keyordernumber.setNocase().setOptional().setPrimary().addAscendingField(ordernumber);
		this.addKey(keyordernumber);
		keycustnumber.setDuplicate().setNocase().setOptional().addAscendingField(custnumber);
		this.addKey(keycustnumber);
	}
}
