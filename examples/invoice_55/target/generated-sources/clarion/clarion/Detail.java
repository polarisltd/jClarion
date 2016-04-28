package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;

@SuppressWarnings("all")
public class Detail extends ClarionSQLFile
{
	public ClarionNumber custnumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber ordernumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber linenumber=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber productnumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionDecimal quantityordered=Clarion.newDecimal(7,2);
	public ClarionNumber backordered=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionDecimal price=Clarion.newDecimal(7,2);
	public ClarionDecimal taxrate=Clarion.newDecimal(6,4);
	public ClarionDecimal taxpaid=Clarion.newDecimal(7,2);
	public ClarionDecimal discountrate=Clarion.newDecimal(6,4);
	public ClarionDecimal discount=Clarion.newDecimal(7,2);
	public ClarionDecimal savings=Clarion.newDecimal(7,2);
	public ClarionDecimal totalcost=Clarion.newDecimal(10,2);
	public ClarionKey keydetails=new ClarionKey("KeyDetails");

	public Detail()
	{
		setPrefix("DTL");
		setCreate();
		setName(Clarion.newString("detail"));
		this.addVariable("CustNumber",this.custnumber);
		this.addVariable("OrderNumber",this.ordernumber);
		this.addVariable("LineNumber",this.linenumber);
		this.addVariable("ProductNumber",this.productnumber);
		this.addVariable("QuantityOrdered",this.quantityordered);
		this.addVariable("BackOrdered",this.backordered);
		this.addVariable("Price",this.price);
		this.addVariable("TaxRate",this.taxrate);
		this.addVariable("TaxPaid",this.taxpaid);
		this.addVariable("DiscountRate",this.discountrate);
		this.addVariable("Discount",this.discount);
		this.addVariable("Savings",this.savings);
		this.addVariable("TotalCost",this.totalcost);
		keydetails.setNocase().setOptional().setPrimary().addAscendingField(custnumber).addAscendingField(ordernumber).addAscendingField(linenumber);
		this.addKey(keydetails);
	}
}
