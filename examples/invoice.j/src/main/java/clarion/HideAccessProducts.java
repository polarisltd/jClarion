package clarion;

import clarion.Filemanager;
import clarion.Main;
import org.jclarion.clarion.Clarion;

public class HideAccessProducts extends Filemanager
{
	public HideAccessProducts()
	{
	}

	public void init()
	{
		this.init(Main.products,Main.globalErrors);
		this.fileNameValue.setValue("Products");
		this.buffer=Main.products;
		this.lockRecover.setValue(10);
		this.addKey(Main.products.keyProductNumber,Clarion.newString("PRO:KeyProductNumber"),Clarion.newNumber(1));
		this.addKey(Main.products.keyProductSKU,Clarion.newString("PRO:KeyProductSKU"),Clarion.newNumber(0));
		this.addKey(Main.products.keyDescription,Clarion.newString("PRO:KeyDescription"),Clarion.newNumber(0));
		Main.accessProducts.set(this);
	}
	public void kill()
	{
		super.kill();
		Main.accessProducts.set(null);
	}
}
