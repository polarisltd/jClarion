package clarion;

import clarion.Filemanager;
import clarion.Main;
import clarion.equates.Level;
import clarion.equates.Msg;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CRun;

public class HideAccessAccounts extends Filemanager
{
	public HideAccessAccounts()
	{
	}

	public void init()
	{
		this.init(Main.accounts,Main.globalErrors);
		this.fileNameValue.setValue("Accounts");
		this.buffer=Main.accounts;
		this.lockRecover.setValue(10);
		this.addKey(Main.accounts.sysIDKey,Clarion.newString("ACC:SysIDKey"),Clarion.newNumber(1));
		this.addKey(Main.accounts.creditCardVendorKey,Clarion.newString("ACC:CreditCardVendorKey"),Clarion.newNumber(0));
		this.addKey(Main.accounts.accountNumberKey,Clarion.newString("ACC:AccountNumberKey"),Clarion.newNumber(0));
		Main.accessAccounts=this;
	}
	public void kill()
	{
		super.kill();
		Main.accessAccounts=null;
	}
	public void primeFields()
	{
		Main.accounts.cardType.setValue("V");
		Main.accounts.billingDay.setValue(10);
		Main.accounts.accountBalance.setValue(0);
		super.primeFields();
	}
	public ClarionNumber validateFieldServer(ClarionNumber id,ClarionNumber handleErrors)
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(super.validateFieldServer(id.like(),handleErrors.like()));
		{
			ClarionNumber case_1=id;
			if (case_1.equals(15)) {
				Main.globalErrors.setField(Clarion.newString("ACC:BillingDay"));
				if (!CRun.inRange(Main.accounts.billingDay,Clarion.newNumber(1),Clarion.newNumber(28))) {
					returnValue.setValue(Level.NOTIFY);
				}
				if (!returnValue.equals(Level.BENIGN)) {
					if (handleErrors.boolValue()) {
						returnValue.setValue(Main.globalErrors.throwMessage(Clarion.newNumber(Msg.FIELDOUTOFRANGE),Clarion.newString("1 .. 28")));
					}
				}
			}
		}
		return returnValue.like();
	}
}
