package clarion.invoibc0;

import clarion.Main;
import clarion.abfile.Filemanager;
import org.jclarion.clarion.Clarion;

@SuppressWarnings("all")
public class HideAccessProducts extends Filemanager
{
	public HideAccessProducts()
	{
	}

	public void init()
	{
		this.init(Main.products,Main.globalerrors);
		this.filenamevalue.setValue("Products");
		this.buffer=Main.products;
		this.lockrecover.setValue(10);
		this.addkey(Main.products.keyproductnumber,Clarion.newString("PRO:KeyProductNumber"),Clarion.newNumber(1));
		this.addkey(Main.products.keyproductsku,Clarion.newString("PRO:KeyProductSKU"),Clarion.newNumber(0));
		this.addkey(Main.products.keydescription,Clarion.newString("PRO:KeyDescription"),Clarion.newNumber(0));
		Main.accessProducts=this;
	}
	public void kill()
	{
		super.kill();
		Main.accessProducts=null;
	}
}
