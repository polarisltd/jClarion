package clarion.invoibc0;

import clarion.Main;
import clarion.abfile.Relationmanager;
import clarion.equates.Ri;
import clarion.invoibc0.Invoibc0;
import org.jclarion.clarion.Clarion;

@SuppressWarnings("all")
public class HideRelateInvhist extends Relationmanager
{
	public HideRelateInvhist()
	{
	}

	public void init()
	{
		Invoibc0.hideAccessInvhist.init();
		super.init(Main.accessInvhist,Clarion.newNumber(1));
		init_addrelations_1();
	}
	public void init_addrelations_1()
	{
		this.addrelation(Main.relateProducts,Clarion.newNumber(Ri.NONE),Clarion.newNumber(Ri.NONE),Main.products.keyproductnumber);
		this.addrelationlink(Main.invhist.productnumber,Main.products.productnumber);
	}
	public void kill()
	{
		Invoibc0.hideAccessInvhist.kill();
		super.kill();
		Main.relateInvhist=null;
	}
}
