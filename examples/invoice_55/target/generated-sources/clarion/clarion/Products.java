package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Products extends ClarionSQLFile
{
	public ClarionNumber productnumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString productsku=Clarion.newString(10);
	public ClarionString description=Clarion.newString(35);
	public ClarionDecimal price=Clarion.newDecimal(7,2);
	public ClarionDecimal quantityinstock=Clarion.newDecimal(7,2);
	public ClarionDecimal reorderquantity=Clarion.newDecimal(7,2);
	public ClarionDecimal cost=Clarion.newDecimal(7,2);
	public ClarionString picturefile=Clarion.newString(64);
	public ClarionKey keyproductnumber=new ClarionKey("KeyProductNumber");
	public ClarionKey keyproductsku=new ClarionKey("KeyProductSKU");
	public ClarionKey keydescription=new ClarionKey("KeyDescription");

	public Products()
	{
		setPrefix("PRO");
		setCreate();
		setName(Clarion.newString("products"));
		this.addVariable("ProductNumber",this.productnumber);
		this.addVariable("ProductSKU",this.productsku);
		this.addVariable("Description",this.description);
		this.addVariable("Price",this.price);
		this.addVariable("QuantityInStock",this.quantityinstock);
		this.addVariable("ReorderQuantity",this.reorderquantity);
		this.addVariable("Cost",this.cost);
		this.addVariable("PictureFile",this.picturefile);
		keyproductnumber.setNocase().setOptional().setPrimary().addAscendingField(productnumber);
		this.addKey(keyproductnumber);
		keyproductsku.setNocase().setOptional().addAscendingField(productsku);
		this.addKey(keyproductsku);
		keydescription.setDuplicate().setNocase().setOptional().addAscendingField(description);
		this.addKey(keydescription);
	}
}
