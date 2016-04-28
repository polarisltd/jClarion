package clarion.invoi001;

import clarion.Main;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.view.*;

@SuppressWarnings("all")
public class Brw5ViewBrowse extends ClarionView
{

	public Brw5ViewBrowse()
	{
		setTable(Main.detail);
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.detail.quantityordered}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.detail.price}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.detail.taxpaid}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.detail.discount}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.detail.totalcost}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.detail.taxrate}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.detail.discountrate}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.detail.custnumber}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.detail.ordernumber}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.detail.linenumber}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.detail.productnumber}));
		ViewJoin vj1=new ViewJoin();
		vj1.setKey(Main.products.keyproductnumber);
		vj1.setFields(new ClarionObject[] {Main.detail.productnumber});
		vj1.add((new ViewProject()).setFields(new ClarionObject[] {Main.products.description}));
		vj1.add((new ViewProject()).setFields(new ClarionObject[] {Main.products.productnumber}));
		this.add(vj1);
	}
}
