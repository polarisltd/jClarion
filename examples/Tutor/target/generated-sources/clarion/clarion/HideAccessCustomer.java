package clarion;

import clarion.Filemanager;
import clarion.Main;
import clarion.equates.Level;
import clarion.equates.Msg;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;

public class HideAccessCustomer extends Filemanager
{
	public HideAccessCustomer()
	{
	}

	public void init()
	{
		this.init(Main.customer,Main.globalErrors);
		this.buffer=Main.customer;
		this.create.setValue(0);
		this.lockRecover.setValue(10);
		this.addKey(Main.customer.keycustnumber,Clarion.newString("CUS:KEYCUSTNUMBER"),Clarion.newNumber(1));
		this.addKey(Main.customer.keycompany,Clarion.newString("CUS:KEYCOMPANY"),Clarion.newNumber(0));
		this.addKey(Main.customer.keyzipcode,Clarion.newString("CUS:KEYZIPCODE"),Clarion.newNumber(0));
		Main.accessCUSTOMER.set(this);
	}
	public void kill()
	{
		super.kill();
		Main.accessCUSTOMER.set(null);
	}
	public ClarionNumber validateFieldServer(ClarionNumber id,ClarionNumber handleErrors)
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber saveStates7=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		returnValue.setValue(super.validateFieldServer(id.like(),handleErrors.like()));
		{
			ClarionNumber case_1=id;
			if (case_1.equals(7)) {
				Main.globalErrors.setField(Clarion.newString("CUS:STATE"));
				saveStates7.setValue(Main.accessStates.get().saveFile());
				Main.states.state.setValue(Main.customer.state);
				returnValue.setValue(Main.accessStates.get().tryFetch(Main.states.keyState));
				if (!returnValue.equals(Level.BENIGN)) {
					if (handleErrors.boolValue()) {
						returnValue.setValue(Main.globalErrors.throwMessage(Clarion.newNumber(Msg.FIELDNOTINFILE),Clarion.newString("States")));
					}
				}
				Main.accessStates.get().restoreFile(saveStates7);
			}
		}
		return returnValue.like();
	}
}
