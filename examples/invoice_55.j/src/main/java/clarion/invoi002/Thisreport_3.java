package clarion.invoi002;

import clarion.Main;
import clarion.abreport.Processclass_1;
import clarion.invoi002.Report_3;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;

@SuppressWarnings("all")
public class Thisreport_3 extends Processclass_1
{
	Report_3 report;
	public Thisreport_3(Report_3 report)
	{
		this.report=report;
	}

	public ClarionNumber takerecord()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber skipdetails=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.glotShipaddress.setValue(Main.orders.shipaddress1.clip().concat("    ",Main.orders.shipaddress2.clip()));
		Main.glotShipcsz.setValue(Main.orders.shipcity.clip().concat(",  ",Main.orders.shipstate,"    ",Main.orders.shipzip.clip()));
		returnvalue.setValue(super.takerecord());
		report.detail.print();
		return returnvalue.like();
	}
}
