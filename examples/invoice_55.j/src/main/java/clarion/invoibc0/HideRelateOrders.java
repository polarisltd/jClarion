package clarion.invoibc0;

import clarion.Main;
import clarion.abfile.Relationmanager;
import clarion.equates.Ri;
import clarion.invoibc0.Invoibc0;
import org.jclarion.clarion.Clarion;

@SuppressWarnings("all")
public class HideRelateOrders extends Relationmanager
{
	public HideRelateOrders()
	{
	}

	public void init()
	{
		Invoibc0.hideAccessOrders.init();
		super.init(Main.accessOrders,Clarion.newNumber(1));
		init_addrelations_1();
	}
	public void init_addrelations_1()
	{
		this.addrelation(Main.relateCustomers);
		this.addrelation(Main.relateStates,Clarion.newNumber(Ri.NONE),Clarion.newNumber(Ri.NONE),Main.states.statecodekey);
		this.addrelationlink(Main.orders.shipstate,Main.states.statecode);
		this.addrelation(Main.relateDetail,Clarion.newNumber(Ri.NONE),Clarion.newNumber(Ri.CASCADE),Main.detail.keydetails);
		this.addrelationlink(Main.orders.custnumber,Main.detail.custnumber);
		this.addrelationlink(Main.orders.ordernumber,Main.detail.ordernumber);
	}
	public void kill()
	{
		Invoibc0.hideAccessOrders.kill();
		super.kill();
		Main.relateOrders=null;
	}
}
