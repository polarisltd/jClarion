package clarion;

import clarion.Filemanager;
import clarion.Main;
import clarion.equates.Level;
import clarion.equates.Msg;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CDate;

public class HideAccessOrders extends Filemanager
{
	public HideAccessOrders()
	{
	}

	public void init()
	{
		this.init(Main.orders,Main.globalErrors);
		this.buffer=Main.orders;
		this.lockRecover.setValue(10);
		this.addKey(Main.orders.keyCustOrderNumber,Clarion.newString("ORD:KeyCustOrderNumber"),Clarion.newNumber(2));
		this.addKey(Main.orders.invoiceNumberKey,Clarion.newString("ORD:InvoiceNumberKey"),Clarion.newNumber(1));
		Main.accessOrders.set(this);
	}
	public void kill()
	{
		super.kill();
		Main.accessOrders.set(null);
	}
	public void primeFields()
	{
		Main.orders.orderDate.setValue(CDate.today());
		Main.orders.shipState.setValue("FL");
		super.primeFields();
	}
	public ClarionNumber validateFieldServer(ClarionNumber id,ClarionNumber handleErrors)
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber saveCustomers1=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber saveStates11=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		returnValue.setValue(super.validateFieldServer(id.like(),handleErrors.like()));
		{
			ClarionNumber case_1=id;
			boolean case_1_break=false;
			if (case_1.equals(1)) {
				Main.globalErrors.setField(Clarion.newString("Customer's Identification Number"));
				saveCustomers1.setValue(Main.accessCustomers.get().saveFile());
				Main.customers.custNumber.setValue(Main.orders.custNumber);
				returnValue.setValue(Main.accessCustomers.get().tryFetch(Main.customers.keyCustNumber));
				if (!returnValue.equals(Level.BENIGN)) {
					if (handleErrors.boolValue()) {
						returnValue.setValue(Main.globalErrors.throwMessage(Clarion.newNumber(Msg.FIELDNOTINFILE),Clarion.newString("Customers")));
					}
				}
				Main.accessCustomers.get().restoreFile(saveCustomers1);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(11)) {
				Main.globalErrors.setField(Clarion.newString("State to ship to"));
				saveStates11.setValue(Main.accessStates.get().saveFile());
				Main.states.stateCode.setValue(Main.orders.shipState);
				returnValue.setValue(Main.accessStates.get().tryFetch(Main.states.stateCodeKey));
				if (!returnValue.equals(Level.BENIGN)) {
					if (handleErrors.boolValue()) {
						returnValue.setValue(Main.globalErrors.throwMessage(Clarion.newNumber(Msg.FIELDNOTINFILE),Clarion.newString("States")));
					}
				}
				Main.accessStates.get().restoreFile(saveStates11);
				case_1_break=true;
			}
		}
		return returnValue.like();
	}
}
