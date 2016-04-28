package clarion;

import clarion.Main;
import clarion.Processclass;
import clarion.Report_2;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;

public class Thisreport_2 extends Processclass
{
	ClarionDecimal extendPrice;
	Report_2 report;
	public Thisreport_2(ClarionDecimal extendPrice,Report_2 report)
	{
		this.extendPrice=extendPrice;
		this.report=report;
	}

	public ClarionNumber takeRecord()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber skipDetails=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.customers.custNumber.setValue(Main.orders.custNumber);
		Main.accessCustomers.get().fetch(Main.customers.keyCustNumber);
		extendPrice.setValue(Main.detail.price.multiply(Main.detail.quantityOrdered));
		Main.gLOTCustName.setValue(Main.customers.firstName.clip().concat("   ",Main.customers.lastName.clip()));
		Main.gLOTCustAddress.setValue(Main.customers.address1.clip().concat("    ",Main.customers.address2.clip()));
		Main.gLOTCusCSZ.setValue(Main.customers.city.clip().concat(",   ",Main.customers.state,"    ",Main.customers.zipCode.clip()));
		Main.gLOTShipName.setValue(Main.orders.shipToName.clip());
		Main.gLOTShipAddress.setValue(Main.orders.shipAddress1.clip().concat("   ",Main.orders.shipAddress2.clip()));
		Main.gLOTShipCSZ.setValue(Main.orders.shipCity.clip().concat(",  ",Main.orders.shipState,"    ",Main.orders.shipZip.clip()));
		returnValue.setValue(super.takeRecord());
		report.detail.print();
		return returnValue.like();
	}
}
