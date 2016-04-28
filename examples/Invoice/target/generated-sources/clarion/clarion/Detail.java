package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;

public class Detail extends ClarionSQLFile
{
	public ClarionNumber custNumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber orderNumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber lineNumber=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber productNumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionDecimal quantityOrdered=Clarion.newDecimal(7,2);
	public ClarionNumber backOrdered=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionDecimal price=Clarion.newDecimal(7,2);
	public ClarionDecimal taxRate=Clarion.newDecimal(6,4);
	public ClarionDecimal taxPaid=Clarion.newDecimal(7,2);
	public ClarionDecimal discountRate=Clarion.newDecimal(6,4);
	public ClarionDecimal discount=Clarion.newDecimal(7,2);
	public ClarionDecimal savings=Clarion.newDecimal(7,2);
	public ClarionDecimal totalCost=Clarion.newDecimal(10,2);
	public ClarionKey keyDetails=new ClarionKey("KeyDetails");

	public Detail()
	{
		setName(Clarion.newString("Detail"));
		setPrefix("DTL");
		setCreate();
		this.addVariable("CustNumber",this.custNumber);
		this.addVariable("OrderNumber",this.orderNumber);
		this.addVariable("LineNumber",this.lineNumber);
		this.addVariable("ProductNumber",this.productNumber);
		this.addVariable("QuantityOrdered",this.quantityOrdered);
		this.addVariable("BackOrdered",this.backOrdered);
		this.addVariable("Price",this.price);
		this.addVariable("TaxRate",this.taxRate);
		this.addVariable("TaxPaid",this.taxPaid);
		this.addVariable("DiscountRate",this.discountRate);
		this.addVariable("Discount",this.discount);
		this.addVariable("Savings",this.savings);
		this.addVariable("TotalCost",this.totalCost);
		keyDetails.setNocase().setOptional().setPrimary().addAscendingField(custNumber).addAscendingField(orderNumber).addAscendingField(lineNumber);
		this.addKey(keyDetails);
	}
}
