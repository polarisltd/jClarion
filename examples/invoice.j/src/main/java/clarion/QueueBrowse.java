package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class QueueBrowse extends ClarionQueue
{
	public ClarionString pRODescription;
	public ClarionDecimal dTLQuantityOrdered;
	public ClarionDecimal dTLPrice;
	public ClarionString lOCBackorder;
	public ClarionDecimal dTLTaxPaid;
	public ClarionDecimal dTLDiscount;
	public ClarionDecimal dTLTotalCost;
	public ClarionDecimal dTLTaxRate;
	public ClarionDecimal dTLDiscountRate;
	public ClarionNumber dTLCustNumber;
	public ClarionNumber dTLOrderNumber;
	public ClarionNumber dTLLineNumber;
	public ClarionNumber pROProductNumber;
	public ClarionNumber mark;
	public ClarionString viewPosition;

	public QueueBrowse(ClarionString lOCBackorder)
	{
		this.pRODescription=Main.products.description.like();
		this.addVariable("PRO:Description",this.pRODescription);
		this.dTLQuantityOrdered=Main.detail.quantityOrdered.like();
		this.addVariable("DTL:QuantityOrdered",this.dTLQuantityOrdered);
		this.dTLPrice=Main.detail.price.like();
		this.addVariable("DTL:Price",this.dTLPrice);
		this.lOCBackorder=lOCBackorder.like();
		this.addVariable("LOC:Backorder",this.lOCBackorder);
		this.dTLTaxPaid=Main.detail.taxPaid.like();
		this.addVariable("DTL:TaxPaid",this.dTLTaxPaid);
		this.dTLDiscount=Main.detail.discount.like();
		this.addVariable("DTL:Discount",this.dTLDiscount);
		this.dTLTotalCost=Main.detail.totalCost.like();
		this.addVariable("DTL:TotalCost",this.dTLTotalCost);
		this.dTLTaxRate=Main.detail.taxRate.like();
		this.addVariable("DTL:TaxRate",this.dTLTaxRate);
		this.dTLDiscountRate=Main.detail.discountRate.like();
		this.addVariable("DTL:DiscountRate",this.dTLDiscountRate);
		this.dTLCustNumber=Main.detail.custNumber.like();
		this.addVariable("DTL:CustNumber",this.dTLCustNumber);
		this.dTLOrderNumber=Main.detail.orderNumber.like();
		this.addVariable("DTL:OrderNumber",this.dTLOrderNumber);
		this.dTLLineNumber=Main.detail.lineNumber.like();
		this.addVariable("DTL:LineNumber",this.dTLLineNumber);
		this.pROProductNumber=Main.products.productNumber.like();
		this.addVariable("PRO:ProductNumber",this.pROProductNumber);
		this.mark=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.addVariable("Mark",this.mark);
		this.viewPosition=Clarion.newString(1024);
		this.addVariable("ViewPosition",this.viewPosition);
	}
}
