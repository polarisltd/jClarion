package clarion;

import clarion.Main;
import clarion.Processclass;
import clarion.Report_3;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;

public class Thisreport_3 extends Processclass
{
	Report_3 report;
	public Thisreport_3(Report_3 report)
	{
		this.report=report;
	}

	public ClarionNumber takeRecord()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber skipDetails=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.gLOTShipAddress.setValue(Main.orders.shipAddress1.clip().concat("    ",Main.orders.shipAddress2.clip()));
		Main.gLOTShipCSZ.setValue(Main.orders.shipCity.clip().concat(",  ",Main.orders.shipState,"    ",Main.orders.shipZip.clip()));
		returnValue.setValue(super.takeRecord());
		report.detail.print();
		return returnValue.like();
	}
}
