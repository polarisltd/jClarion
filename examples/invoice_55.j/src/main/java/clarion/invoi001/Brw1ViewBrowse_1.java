package clarion.invoi001;

import clarion.Main;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.view.*;

@SuppressWarnings("all")
public class Brw1ViewBrowse_1 extends ClarionView
{

	public Brw1ViewBrowse_1()
	{
		setTable(Main.products);
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.products.description}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.products.productsku}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.products.price}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.products.quantityinstock}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.products.productnumber}));
	}
}
