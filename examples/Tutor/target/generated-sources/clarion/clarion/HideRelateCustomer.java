package clarion;

import clarion.Main;
import clarion.Relationmanager;
import clarion.Tutorbc0;
import clarion.equates.Ri;
import org.jclarion.clarion.Clarion;

public class HideRelateCustomer extends Relationmanager
{
	public HideRelateCustomer()
	{
	}

	public void init()
	{
		Tutorbc0._hideAccessCUSTOMER.get().init();
		this.init(Main.accessCUSTOMER.get(),Clarion.newNumber(1));
		init_AddRelations_1();
	}
	public void init_AddRelations_1()
	{
		this.addRelation(Main.relateStates.get(),Clarion.newNumber(Ri.NONE),Clarion.newNumber(Ri.NONE),Main.states.keyState);
		this.addRelationLink(Main.customer.state,Main.states.state);
		this.addRelation(Main.relateORDERS.get(),Clarion.newNumber(Ri.CASCADE),Clarion.newNumber(Ri.CASCADE),Main.orders.keycustnumber);
		this.addRelationLink(Main.customer.custnumber,Main.orders.custnumber);
	}
	public void kill()
	{
		Tutorbc0._hideAccessCUSTOMER.get().kill();
		super.kill();
		Main.relateCUSTOMER.set(null);
		Tutorbc0._hideAccessCUSTOMER.get().destruct();
	}
}
