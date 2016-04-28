package clarion.invoibc0;

import clarion.Main;
import clarion.abfile.Relationmanager;
import clarion.invoibc0.Invoibc0;
import org.jclarion.clarion.Clarion;

@SuppressWarnings("all")
public class HideRelateStates extends Relationmanager
{
	public HideRelateStates()
	{
	}

	public void init()
	{
		Invoibc0.hideAccessStates.init();
		super.init(Main.accessStates,Clarion.newNumber(1));
		init_addrelations_1();
	}
	public void init_addrelations_1()
	{
		this.addrelation(Main.relateOrders);
		this.addrelation(Main.relateCustomers);
	}
	public void kill()
	{
		Invoibc0.hideAccessStates.kill();
		super.kill();
		Main.relateStates=null;
	}
}
