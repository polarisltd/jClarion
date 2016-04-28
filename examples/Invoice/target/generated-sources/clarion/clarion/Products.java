package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

public class Products extends ClarionSQLFile
{
	public ClarionNumber productNumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString productSKU=Clarion.newString(10);
	public ClarionString description=Clarion.newString(35);
	public ClarionDecimal price=Clarion.newDecimal(7,2);
	public ClarionDecimal quantityInStock=Clarion.newDecimal(7,2);
	public ClarionDecimal reorderQuantity=Clarion.newDecimal(7,2);
	public ClarionDecimal cost=Clarion.newDecimal(7,2);
	public ClarionString pictureFile=Clarion.newString(64);
	public ClarionKey keyProductNumber=new ClarionKey("KeyProductNumber");
	public ClarionKey keyProductSKU=new ClarionKey("KeyProductSKU");
	public ClarionKey keyDescription=new ClarionKey("KeyDescription");

	public Products()
	{
		setName(Clarion.newString("Products"));
		setPrefix("PRO");
		setCreate();
		this.addVariable("ProductNumber",this.productNumber);
		this.addVariable("ProductSKU",this.productSKU);
		this.addVariable("Description",this.description);
		this.addVariable("Price",this.price);
		this.addVariable("QuantityInStock",this.quantityInStock);
		this.addVariable("ReorderQuantity",this.reorderQuantity);
		this.addVariable("Cost",this.cost);
		this.addVariable("PictureFile",this.pictureFile);
		keyProductNumber.setNocase().setOptional().setPrimary().addAscendingField(productNumber);
		this.addKey(keyProductNumber);
		keyProductSKU.setNocase().setOptional().addAscendingField(productSKU);
		this.addKey(keyProductSKU);
		keyDescription.setDuplicate().setNocase().setOptional().addAscendingField(description);
		this.addKey(keyDescription);
	}
}
