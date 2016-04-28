package clarion.invoibc0;

import clarion.Main;
import clarion.abfile.Filemanager;
import clarion.equates.Level;
import clarion.equates.Msg;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CDate;

@SuppressWarnings("all")
public class HideAccessOrders extends Filemanager
{
	public HideAccessOrders()
	{
	}

	public void init()
	{
		this.init(Main.orders,Main.globalerrors);
		this.buffer=Main.orders;
		this.lockrecover.setValue(10);
		this.addkey(Main.orders.keycustordernumber,Clarion.newString("ORD:KeyCustOrderNumber"),Clarion.newNumber(2));
		this.addkey(Main.orders.invoicenumberkey,Clarion.newString("ORD:InvoiceNumberKey"),Clarion.newNumber(1));
		Main.accessOrders=this;
	}
	public void kill()
	{
		super.kill();
		Main.accessOrders=null;
	}
	public void primefields()
	{
		Main.orders.orderdate.setValue(CDate.today());
		Main.orders.shipstate.setValue("FL");
		super.primefields();
	}
	public ClarionNumber validatefieldserver(ClarionNumber id,ClarionNumber handleerrors)
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber saveCustomers1=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber saveStates11=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		returnvalue.setValue(super.validatefieldserver(id.like(),handleerrors.like()));
		{
			ClarionNumber case_1=id;
			boolean case_1_break=false;
			if (case_1.equals(1)) {
				Main.globalerrors.setfield(Clarion.newString("Customer's Identification Number"));
				saveCustomers1.setValue(Main.accessCustomers.savefile());
				Main.customers.custnumber.setValue(Main.orders.custnumber);
				returnvalue.setValue(Main.accessCustomers.tryfetch(Main.customers.keycustnumber));
				if (!returnvalue.equals(Level.BENIGN)) {
					if (handleerrors.boolValue()) {
						returnvalue.setValue(Main.globalerrors.throwmessage(Clarion.newNumber(Msg.FIELDNOTINFILE),Clarion.newString("Customers")));
					}
				}
				Main.accessCustomers.restorefile(saveCustomers1);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(11)) {
				Main.globalerrors.setfield(Clarion.newString("State to ship to"));
				saveStates11.setValue(Main.accessStates.savefile());
				Main.states.statecode.setValue(Main.orders.shipstate);
				returnvalue.setValue(Main.accessStates.tryfetch(Main.states.statecodekey));
				if (!returnvalue.equals(Level.BENIGN)) {
					if (handleerrors.boolValue()) {
						returnvalue.setValue(Main.globalerrors.throwmessage(Clarion.newNumber(Msg.FIELDNOTINFILE),Clarion.newString("States")));
					}
				}
				Main.accessStates.restorefile(saveStates11);
				case_1_break=true;
			}
		}
		return returnvalue.like();
	}
}
