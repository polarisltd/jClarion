package clarion;

import clarion.Filemanager;
import clarion.Main;
import clarion.equates.Constants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.runtime.CDate;

public class HideAccessTransactions extends Filemanager
{
	public HideAccessTransactions()
	{
	}

	public void init()
	{
		this.init(Main.transactions,Main.globalErrors);
		this.fileNameValue.setValue("Transactions");
		this.buffer=Main.transactions;
		this.lockRecover.setValue(10);
		this.addKey(Main.transactions.sysIDKey,Clarion.newString("TRA:SysIDKey"),Clarion.newNumber(0));
		this.addKey(Main.transactions.sysIDTypeKey,Clarion.newString("TRA:SysIDTypeKey"),Clarion.newNumber(0));
		this.addKey(Main.transactions.sysIDDateKey,Clarion.newString("TRA:SysIDDateKey"),Clarion.newNumber(0));
		this.addKey(Main.transactions.dateKey,Clarion.newString("TRA:DateKey"),Clarion.newNumber(0));
		this.addKey(Main.transactions.typeKey,Clarion.newString("TRA:TypeKey"),Clarion.newNumber(0));
		Main.accessTransactions=this;
	}
	public void kill()
	{
		super.kill();
		Main.accessTransactions=null;
	}
	public void primeFields()
	{
		Main.transactions.dateofTransaction.setValue(CDate.today());
		Main.transactions.transactionType.setValue("C");
		Main.transactions.transactionAmount.setValue(0);
		Main.transactions.reconciledTransaction.setValue(Constants.FALSE);
		super.primeFields();
	}
}
