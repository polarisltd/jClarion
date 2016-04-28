package clarion;

import clarion.Main;
import clarion.Relationmanager;
import clarion.Tutorbc0;
import org.jclarion.clarion.Clarion;

public class HideRelateStates extends Relationmanager
{
	public HideRelateStates()
	{
	}

	public void init()
	{
		Tutorbc0._hideAccessStates.get().init();
		this.init(Main.accessStates.get(),Clarion.newNumber(1));
		init_AddRelations_1();
	}
	public void init_AddRelations_1()
	{
		this.addRelation(Main.relateCUSTOMER.get());
	}
	public void kill()
	{
		Tutorbc0._hideAccessStates.get().kill();
		super.kill();
		Main.relateStates.set(null);
		Tutorbc0._hideAccessStates.get().destruct();
	}
}
