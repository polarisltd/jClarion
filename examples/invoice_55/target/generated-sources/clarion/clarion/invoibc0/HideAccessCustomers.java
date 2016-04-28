package clarion.invoibc0;

import clarion.Main;
import clarion.abfile.Filemanager;
import clarion.equates.Level;
import clarion.equates.Msg;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;

@SuppressWarnings("all")
public class HideAccessCustomers extends Filemanager
{
	public HideAccessCustomers()
	{
	}

	public void init()
	{
		this.init(Main.customers,Main.globalerrors);
		this.filenamevalue.setValue("Customers");
		this.buffer=Main.customers;
		this.lockrecover.setValue(10);
		this.addkey(Main.customers.keycustnumber,Clarion.newString("CUS:KeyCustNumber"),Clarion.newNumber(1));
		this.addkey(Main.customers.keyfullname,Clarion.newString("CUS:KeyFullName"),Clarion.newNumber(0));
		this.addkey(Main.customers.keycompany,Clarion.newString("CUS:KeyCompany"),Clarion.newNumber(0));
		this.addkey(Main.customers.keyzipcode,Clarion.newString("CUS:KeyZipCode"),Clarion.newNumber(0));
		this.addkey(Main.customers.statekey,Clarion.newString("CUS:StateKey"),Clarion.newNumber(0));
		Main.accessCustomers=this;
	}
	public void kill()
	{
		super.kill();
		Main.accessCustomers=null;
	}
	public void primefields()
	{
		Main.customers.state.setValue("FL");
		super.primefields();
	}
	public ClarionNumber validatefieldserver(ClarionNumber id,ClarionNumber handleerrors)
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber saveStates9=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		returnvalue.setValue(super.validatefieldserver(id.like(),handleerrors.like()));
		{
			ClarionNumber case_1=id;
			if (case_1.equals(9)) {
				Main.globalerrors.setfield(Clarion.newString("Customer's State"));
				saveStates9.setValue(Main.accessStates.savefile());
				Main.states.statecode.setValue(Main.customers.state);
				returnvalue.setValue(Main.accessStates.tryfetch(Main.states.statecodekey));
				if (!returnvalue.equals(Level.BENIGN)) {
					if (handleerrors.boolValue()) {
						returnvalue.setValue(Main.globalerrors.throwmessage(Clarion.newNumber(Msg.FIELDNOTINFILE),Clarion.newString("States")));
					}
				}
				Main.accessStates.restorefile(saveStates9);
			}
		}
		return returnvalue.like();
	}
}
