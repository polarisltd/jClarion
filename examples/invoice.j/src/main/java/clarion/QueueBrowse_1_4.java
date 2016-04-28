package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class QueueBrowse_1_4 extends ClarionQueue
{
	public ClarionString pRODescription=Main.products.description.like();
	public ClarionString pROProductSKU=Main.products.productSKU.like();
	public ClarionDecimal pROPrice=Main.products.price.like();
	public ClarionDecimal pROQuantityInStock=Main.products.quantityInStock.like();
	public ClarionString pROPictureFile=Main.products.pictureFile.like();
	public ClarionNumber pROProductNumber=Main.products.productNumber.like();
	public ClarionNumber mark=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString viewPosition=Clarion.newString(1024);

	public QueueBrowse_1_4()
	{
		this.addVariable("PRO:Description",this.pRODescription);
		this.addVariable("PRO:ProductSKU",this.pROProductSKU);
		this.addVariable("PRO:Price",this.pROPrice);
		this.addVariable("PRO:QuantityInStock",this.pROQuantityInStock);
		this.addVariable("PRO:PictureFile",this.pROPictureFile);
		this.addVariable("PRO:ProductNumber",this.pROProductNumber);
		this.addVariable("Mark",this.mark);
		this.addVariable("ViewPosition",this.viewPosition);
	}
}
