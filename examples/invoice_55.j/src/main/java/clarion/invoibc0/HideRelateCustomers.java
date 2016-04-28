package clarion.invoibc0;

import clarion.Main;
import clarion.abfile.Relationmanager;
import clarion.equates.Ri;
import clarion.invoibc0.Invoibc0;
import org.jclarion.clarion.Clarion;

@SuppressWarnings("all")
public class HideRelateCustomers extends Relationmanager
{
	public HideRelateCustomers()
	{
	}

	public void init()
	{
		Invoibc0.hideAccessCustomers.init();
		super.init(Main.accessCustomers,Clarion.newNumber(1));
		init_addrelations_1();
	}
	public void init_addrelations_1()
	{
		this.addrelation(Main.relateOrders,Clarion.newNumber(Ri.NONE),Clarion.newNumber(Ri.RESTRICT),Main.orders.keycustordernumber);
		this.addrelationlink(Main.customers.custnumber,Main.orders.custnumber);
		this.addrelation(Main.relateStates,Clarion.newNumber(Ri.NONE),Clarion.newNumber(Ri.NONE),Main.states.statecodekey);
		this.addrelationlink(Main.customers.state,Main.states.statecode);
	}
	public void kill()
	{
		Invoibc0.hideAccessCustomers.kill();
		super.kill();
		Main.relateCustomers=null;
	}
}
