package clarion;

import clarion.Main;
import clarion.Relationmanager;
import clarion.Tutorbc0;
import org.jclarion.clarion.Clarion;

public class HideRelateOrders extends Relationmanager
{
	public HideRelateOrders()
	{
	}

	public void init()
	{
		Tutorbc0._hideAccessORDERS.get().init();
		this.init(Main.accessORDERS.get(),Clarion.newNumber(1));
		init_AddRelations_1();
	}
	public void init_AddRelations_1()
	{
		this.addRelation(Main.relateCUSTOMER.get());
	}
	public void kill()
	{
		Tutorbc0._hideAccessORDERS.get().kill();
		super.kill();
		Main.relateORDERS.set(null);
		Tutorbc0._hideAccessORDERS.get().destruct();
	}
}
