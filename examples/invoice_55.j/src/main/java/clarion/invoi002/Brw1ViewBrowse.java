package clarion.invoi002;

import clarion.Main;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.view.*;

@SuppressWarnings("all")
public class Brw1ViewBrowse extends ClarionView
{

	public Brw1ViewBrowse()
	{
		setTable(Main.products);
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.products.description}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.products.productsku}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.products.price}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.products.quantityinstock}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.products.picturefile}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.products.productnumber}));
	}
}
