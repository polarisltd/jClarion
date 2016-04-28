package clarion;

import clarion.Filemanager;
import clarion.Main;
import clarion.equates.Level;
import clarion.equates.Msg;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;

public class HideAccessCustomers extends Filemanager
{
	public HideAccessCustomers()
	{
	}

	public void init()
	{
		this.init(Main.customers,Main.globalErrors);
		this.fileNameValue.setValue("Customers");
		this.buffer=Main.customers;
		this.lockRecover.setValue(10);
		this.addKey(Main.customers.keyCustNumber,Clarion.newString("CUS:KeyCustNumber"),Clarion.newNumber(1));
		this.addKey(Main.customers.keyFullName,Clarion.newString("CUS:KeyFullName"),Clarion.newNumber(0));
		this.addKey(Main.customers.keyCompany,Clarion.newString("CUS:KeyCompany"),Clarion.newNumber(0));
		this.addKey(Main.customers.keyZipCode,Clarion.newString("CUS:KeyZipCode"),Clarion.newNumber(0));
		this.addKey(Main.customers.stateKey,Clarion.newString("CUS:StateKey"),Clarion.newNumber(0));
		Main.accessCustomers.set(this);
	}
	public void kill()
	{
		super.kill();
		Main.accessCustomers.set(null);
	}
	public void primeFields()
	{
		Main.customers.state.setValue("FL");
		super.primeFields();
	}
	public ClarionNumber validateFieldServer(ClarionNumber id,ClarionNumber handleErrors)
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber saveStates9=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		returnValue.setValue(super.validateFieldServer(id.like(),handleErrors.like()));
		{
			ClarionNumber case_1=id;
			if (case_1.equals(9)) {
				Main.globalErrors.setField(Clarion.newString("Customer's State"));
				saveStates9.setValue(Main.accessStates.get().saveFile());
				Main.states.stateCode.setValue(Main.customers.state);
				returnValue.setValue(Main.accessStates.get().tryFetch(Main.states.stateCodeKey));
				if (!returnValue.equals(Level.BENIGN)) {
					if (handleErrors.boolValue()) {
						returnValue.setValue(Main.globalErrors.throwMessage(Clarion.newNumber(Msg.FIELDNOTINFILE),Clarion.newString("States")));
					}
				}
				Main.accessStates.get().restoreFile(saveStates9);
			}
		}
		return returnValue.like();
	}
}
