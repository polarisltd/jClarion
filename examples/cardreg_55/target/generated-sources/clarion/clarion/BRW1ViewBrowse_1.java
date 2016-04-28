package clarion;

import clarion.Main;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.view.*;

public class BRW1ViewBrowse_1 extends ClarionView
{

	public BRW1ViewBrowse_1()
	{
		setTable(Main.transactions);
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.transactions.dateofTransaction}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.transactions.transactionDescription}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.transactions.transactionAmount}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.transactions.reconciledTransaction}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.transactions.sysID}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.transactions.transactionType}));
	}
}
