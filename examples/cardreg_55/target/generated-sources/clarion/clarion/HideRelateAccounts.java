package clarion;

import clarion.Cardrbc0;
import clarion.Main;
import clarion.Relationmanager;
import clarion.equates.Ri;
import org.jclarion.clarion.Clarion;

public class HideRelateAccounts extends Relationmanager
{
	public HideRelateAccounts()
	{
	}

	public void init()
	{
		Cardrbc0.hideAccessAccounts.init();
		super.init(Main.accessAccounts,Clarion.newNumber(1));
		init_AddRelations_1();
	}
	public void init_AddRelations_1()
	{
		this.addRelation(Main.relateTransactions,Clarion.newNumber(Ri.CASCADE),Clarion.newNumber(Ri.CASCADE),Main.transactions.sysIDKey);
		this.addRelationLink(Main.accounts.sysID,Main.transactions.sysID);
	}
	public void kill()
	{
		Cardrbc0.hideAccessAccounts.kill();
		super.kill();
		Main.relateAccounts=null;
	}
}
