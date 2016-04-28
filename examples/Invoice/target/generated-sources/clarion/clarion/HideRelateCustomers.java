package clarion;

import clarion.Invoibc0;
import clarion.Main;
import clarion.Relationmanager;
import clarion.equates.Ri;
import org.jclarion.clarion.Clarion;

public class HideRelateCustomers extends Relationmanager
{
	public HideRelateCustomers()
	{
	}

	public void init()
	{
		Invoibc0._hideAccessCustomers.get().init();
		this.init(Main.accessCustomers.get(),Clarion.newNumber(1));
		init_AddRelations_1();
	}
	public void init_AddRelations_1()
	{
		this.addRelation(Main.relateOrders.get(),Clarion.newNumber(Ri.NONE),Clarion.newNumber(Ri.RESTRICT),Main.orders.keyCustOrderNumber);
		this.addRelationLink(Main.customers.custNumber,Main.orders.custNumber);
		this.addRelation(Main.relateStates.get(),Clarion.newNumber(Ri.NONE),Clarion.newNumber(Ri.NONE),Main.states.stateCodeKey);
		this.addRelationLink(Main.customers.state,Main.states.stateCode);
	}
	public void kill()
	{
		Invoibc0._hideAccessCustomers.get().kill();
		super.kill();
		Main.relateCustomers.set(null);
		Invoibc0._hideAccessCustomers.get().destruct();
	}
}
