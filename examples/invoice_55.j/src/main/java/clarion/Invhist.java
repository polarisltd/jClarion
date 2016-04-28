package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Invhist extends ClarionSQLFile
{
	public ClarionNumber date=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString transtype=Clarion.newString(7);
	public ClarionNumber productnumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionDecimal quantity=Clarion.newDecimal(7,2);
	public ClarionNumber vendornumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionDecimal cost=Clarion.newDecimal(7,2);
	public ClarionString notes=Clarion.newString(50);
	public ClarionKey keyproductnumberdate=new ClarionKey("KeyProductNumberDate");
	public ClarionKey keyprodnumberdate=new ClarionKey("KeyProdNumberDate");
	public ClarionKey keyvendornumberdate=new ClarionKey("KeyVendorNumberDate");

	public Invhist()
	{
		setPrefix("INV");
		setCreate();
		setName(Clarion.newString("invhist"));
		this.addVariable("Date",this.date);
		this.addVariable("TransType",this.transtype);
		this.addVariable("ProductNumber",this.productnumber);
		this.addVariable("Quantity",this.quantity);
		this.addVariable("VendorNumber",this.vendornumber);
		this.addVariable("Cost",this.cost);
		this.addVariable("Notes",this.notes);
		keyproductnumberdate.setDuplicate().setNocase().setOptional().addAscendingField(productnumber).addAscendingField(vendornumber).addAscendingField(date);
		this.addKey(keyproductnumberdate);
		keyprodnumberdate.setDuplicate().setNocase().setOptional().addAscendingField(productnumber).addAscendingField(date);
		this.addKey(keyprodnumberdate);
		keyvendornumberdate.setDuplicate().setNocase().setOptional().addAscendingField(vendornumber).addAscendingField(date);
		this.addKey(keyvendornumberdate);
	}
}
