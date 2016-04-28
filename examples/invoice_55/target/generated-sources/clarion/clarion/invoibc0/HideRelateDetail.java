package clarion.invoibc0;

import clarion.Main;
import clarion.abfile.Relationmanager;
import clarion.equates.Ri;
import clarion.invoibc0.Invoibc0;
import org.jclarion.clarion.Clarion;

@SuppressWarnings("all")
public class HideRelateDetail extends Relationmanager
{
	public HideRelateDetail()
	{
	}

	public void init()
	{
		Invoibc0.hideAccessDetail.init();
		super.init(Main.accessDetail,Clarion.newNumber(1));
		init_addrelations_1();
	}
	public void init_addrelations_1()
	{
		this.addrelation(Main.relateProducts,Clarion.newNumber(Ri.NONE),Clarion.newNumber(Ri.NONE),Main.products.keyproductnumber);
		this.addrelationlink(Main.detail.productnumber,Main.products.productnumber);
		this.addrelation(Main.relateOrders);
	}
	public void kill()
	{
		Invoibc0.hideAccessDetail.kill();
		super.kill();
		Main.relateDetail=null;
	}
}
