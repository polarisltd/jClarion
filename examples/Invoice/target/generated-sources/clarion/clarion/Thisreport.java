package clarion;

import clarion.Main;
import clarion.Processclass;
import clarion.Report;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;

public class Thisreport extends Processclass
{
	Report report;
	public Thisreport(Report report)
	{
		this.report=report;
	}

	public ClarionNumber takeRecord()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber skipDetails=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.gLOTCustName.setValue(Main.customers.firstName.clip().concat("   ",Main.customers.lastName.clip()));
		returnValue.setValue(super.takeRecord());
		report.detail.print();
		return returnValue.like();
	}
}
