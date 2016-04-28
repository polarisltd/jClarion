package clarion;

import clarion.Invoibc0;
import clarion.Main;
import clarion.Relationmanager;
import clarion.equates.Ri;
import org.jclarion.clarion.Clarion;

public class HideRelateDetail extends Relationmanager
{
	public HideRelateDetail()
	{
	}

	public void init()
	{
		Invoibc0._hideAccessDetail.get().init();
		this.init(Main.accessDetail.get(),Clarion.newNumber(1));
		init_AddRelations_1();
	}
	public void init_AddRelations_1()
	{
		this.addRelation(Main.relateProducts.get(),Clarion.newNumber(Ri.NONE),Clarion.newNumber(Ri.NONE),Main.products.keyProductNumber);
		this.addRelationLink(Main.detail.productNumber,Main.products.productNumber);
		this.addRelation(Main.relateOrders.get());
	}
	public void kill()
	{
		Invoibc0._hideAccessDetail.get().kill();
		super.kill();
		Main.relateDetail.set(null);
		Invoibc0._hideAccessDetail.get().destruct();
	}
}
