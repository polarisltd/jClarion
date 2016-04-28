package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class QueueBrowse_2 extends ClarionQueue
{
	public ClarionNumber ordCustnumber=Main.orders.custnumber.like();
	public ClarionNumber ordOrdernumber=Main.orders.ordernumber.like();
	public ClarionDecimal ordInvoiceamount=Main.orders.invoiceamount.like();
	public ClarionNumber ordOrderdate=Main.orders.orderdate.like();
	public ClarionString ordOrdernote=Main.orders.ordernote.like();
	public ClarionNumber mark=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString viewPosition=Clarion.newString(1024);

	public QueueBrowse_2()
	{
		this.addVariable("ORD:CUSTNUMBER",this.ordCustnumber);
		this.addVariable("ORD:ORDERNUMBER",this.ordOrdernumber);
		this.addVariable("ORD:INVOICEAMOUNT",this.ordInvoiceamount);
		this.addVariable("ORD:ORDERDATE",this.ordOrderdate);
		this.addVariable("ORD:ORDERNOTE",this.ordOrdernote);
		this.addVariable("Mark",this.mark);
		this.addVariable("ViewPosition",this.viewPosition);
	}
}
