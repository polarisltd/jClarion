package clarion;

import clarion.Invoibc0;
import clarion.Main;
import clarion.Relationmanager;
import org.jclarion.clarion.Clarion;

public class HideRelateProducts extends Relationmanager
{
	public HideRelateProducts()
	{
	}

	public void init()
	{
		Invoibc0._hideAccessProducts.get().init();
		this.init(Main.accessProducts.get(),Clarion.newNumber(1));
		init_AddRelations_1();
	}
	public void init_AddRelations_1()
	{
		this.addRelation(Main.relateDetail.get());
		this.addRelation(Main.relateInvHist.get());
	}
	public void kill()
	{
		Invoibc0._hideAccessProducts.get().kill();
		super.kill();
		Main.relateProducts.set(null);
		Invoibc0._hideAccessProducts.get().destruct();
	}
}
