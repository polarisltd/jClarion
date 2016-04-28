package clarion;

import clarion.Cardrbc0;
import clarion.Main;
import clarion.Relationmanager;
import org.jclarion.clarion.Clarion;

public class HideRelateTransactions extends Relationmanager
{
	public HideRelateTransactions()
	{
	}

	public void init()
	{
		Cardrbc0.hideAccessTransactions.init();
		super.init(Main.accessTransactions,Clarion.newNumber(1));
		init_AddRelations_1();
	}
	public void init_AddRelations_1()
	{
		this.addRelation(Main.relateAccounts);
	}
	public void kill()
	{
		Cardrbc0.hideAccessTransactions.kill();
		super.kill();
		Main.relateTransactions=null;
	}
}
