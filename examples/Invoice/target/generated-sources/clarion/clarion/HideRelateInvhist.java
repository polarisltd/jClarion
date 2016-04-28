package clarion;

import clarion.Invoibc0;
import clarion.Main;
import clarion.Relationmanager;
import clarion.equates.Ri;
import org.jclarion.clarion.Clarion;

public class HideRelateInvhist extends Relationmanager
{
	public HideRelateInvhist()
	{
	}

	public void init()
	{
		Invoibc0._hideAccessInvHist.get().init();
		this.init(Main.accessInvHist.get(),Clarion.newNumber(1));
		init_AddRelations_1();
	}
	public void init_AddRelations_1()
	{
		this.addRelation(Main.relateProducts.get(),Clarion.newNumber(Ri.NONE),Clarion.newNumber(Ri.NONE),Main.products.keyProductNumber);
		this.addRelationLink(Main.invHist.productNumber,Main.products.productNumber);
	}
	public void kill()
	{
		Invoibc0._hideAccessInvHist.get().kill();
		super.kill();
		Main.relateInvHist.set(null);
		Invoibc0._hideAccessInvHist.get().destruct();
	}
}
