package clarion;

import clarion.Main;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.view.*;

public class BRW1ViewBrowse_1 extends ClarionView
{

	public BRW1ViewBrowse_1()
	{
		setTable(Main.products);
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.products.description}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.products.productSKU}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.products.price}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.products.quantityInStock}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.products.productNumber}));
	}
}
