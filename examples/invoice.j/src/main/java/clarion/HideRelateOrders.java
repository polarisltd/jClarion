package clarion;

import clarion.Invoibc0;
import clarion.Main;
import clarion.Relationmanager;
import clarion.equates.Ri;
import org.jclarion.clarion.Clarion;

public class HideRelateOrders extends Relationmanager
{
	public HideRelateOrders()
	{
	}

	public void init()
	{
		Invoibc0._hideAccessOrders.get().init();
		this.init(Main.accessOrders.get(),Clarion.newNumber(1));
		init_AddRelations_1();
	}
	public void init_AddRelations_1()
	{
		this.addRelation(Main.relateCustomers.get());
		this.addRelation(Main.relateStates.get(),Clarion.newNumber(Ri.NONE),Clarion.newNumber(Ri.NONE),Main.states.stateCodeKey);
		this.addRelationLink(Main.orders.shipState,Main.states.stateCode);
		this.addRelation(Main.relateDetail.get(),Clarion.newNumber(Ri.NONE),Clarion.newNumber(Ri.CASCADE),Main.detail.keyDetails);
		this.addRelationLink(Main.orders.custNumber,Main.detail.custNumber);
		this.addRelationLink(Main.orders.orderNumber,Main.detail.orderNumber);
	}
	public void kill()
	{
		Invoibc0._hideAccessOrders.get().kill();
		super.kill();
		Main.relateOrders.set(null);
		Invoibc0._hideAccessOrders.get().destruct();
	}
}
