package clarion;

import clarion.Invoibc0;
import clarion.Main;
import clarion.Relationmanager;
import org.jclarion.clarion.Clarion;

public class HideRelateStates extends Relationmanager
{
	public HideRelateStates()
	{
	}

	public void init()
	{
		Invoibc0._hideAccessStates.get().init();
		this.init(Main.accessStates.get(),Clarion.newNumber(1));
		init_AddRelations_1();
	}
	public void init_AddRelations_1()
	{
		this.addRelation(Main.relateOrders.get());
		this.addRelation(Main.relateCustomers.get());
	}
	public void kill()
	{
		Invoibc0._hideAccessStates.get().kill();
		super.kill();
		Main.relateStates.set(null);
		Invoibc0._hideAccessStates.get().destruct();
	}
}
