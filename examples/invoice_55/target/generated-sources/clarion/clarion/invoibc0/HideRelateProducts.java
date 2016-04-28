package clarion.invoibc0;

import clarion.Main;
import clarion.abfile.Relationmanager;
import clarion.invoibc0.Invoibc0;
import org.jclarion.clarion.Clarion;

@SuppressWarnings("all")
public class HideRelateProducts extends Relationmanager
{
	public HideRelateProducts()
	{
	}

	public void init()
	{
		Invoibc0.hideAccessProducts.init();
		super.init(Main.accessProducts,Clarion.newNumber(1));
		init_addrelations_1();
	}
	public void init_addrelations_1()
	{
		this.addrelation(Main.relateDetail);
		this.addrelation(Main.relateInvhist);
	}
	public void kill()
	{
		Invoibc0.hideAccessProducts.kill();
		super.kill();
		Main.relateProducts=null;
	}
}
