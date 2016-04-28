package clarion;

import clarion.Main;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.view.*;

public class ProcessView_3 extends ClarionView
{

	public ProcessView_3()
	{
		setTable(Main.transactions);
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.transactions.dateofTransaction}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.transactions.reconciledTransaction}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.transactions.sysID}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.transactions.transactionAmount}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.transactions.transactionDescription}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.transactions.transactionType}));
		ViewJoin vj1=new ViewJoin();
		vj1.setKey(Main.accounts.sysIDKey);
		vj1.setFields(new ClarionObject[] {Main.transactions.sysID});
		vj1.add((new ViewProject()).setFields(new ClarionObject[] {Main.accounts.accountNumber}));
		vj1.add((new ViewProject()).setFields(new ClarionObject[] {Main.accounts.creditCardVendor}));
		vj1.add((new ViewProject()).setFields(new ClarionObject[] {Main.accounts.sysID}));
		this.add(vj1);
	}
}
