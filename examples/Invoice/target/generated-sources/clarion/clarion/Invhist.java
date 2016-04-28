package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

public class Invhist extends ClarionSQLFile
{
	public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber date=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString transType=Clarion.newString(7);
	public ClarionNumber productNumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionDecimal quantity=Clarion.newDecimal(7,2);
	public ClarionNumber vendorNumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionDecimal cost=Clarion.newDecimal(7,2);
	public ClarionString notes=Clarion.newString(50);
	public ClarionKey keyId=new ClarionKey("KeyId");
	public ClarionKey keyProductNumberDate=new ClarionKey("KeyProductNumberDate");
	public ClarionKey keyProdNumberDate=new ClarionKey("KeyProdNumberDate");
	public ClarionKey keyVendorNumberDate=new ClarionKey("KeyVendorNumberDate");

	public Invhist()
	{
		setName(Clarion.newString("InvHist"));
		setPrefix("INV");
		setCreate();
		this.addVariable("Id",this.id);
		this.addVariable("Date",this.date);
		this.addVariable("TransType",this.transType);
		this.addVariable("ProductNumber",this.productNumber);
		this.addVariable("Quantity",this.quantity);
		this.addVariable("VendorNumber",this.vendorNumber);
		this.addVariable("Cost",this.cost);
		this.addVariable("Notes",this.notes);
		keyId.setPrimary().addAscendingField(id);
		this.addKey(keyId);
		keyProductNumberDate.setDuplicate().setNocase().setOptional().addAscendingField(productNumber).addAscendingField(vendorNumber).addAscendingField(date);
		this.addKey(keyProductNumberDate);
		keyProdNumberDate.setDuplicate().setNocase().setOptional().addAscendingField(productNumber).addAscendingField(date);
		this.addKey(keyProdNumberDate);
		keyVendorNumberDate.setDuplicate().setNocase().setOptional().addAscendingField(vendorNumber).addAscendingField(date);
		this.addKey(keyVendorNumberDate);
	}
}
