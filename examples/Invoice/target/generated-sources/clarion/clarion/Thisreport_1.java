package clarion;

import clarion.Processclass;
import clarion.Report_1;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;

public class Thisreport_1 extends Processclass
{
	Report_1 report;
	public Thisreport_1(Report_1 report)
	{
		this.report=report;
	}

	public ClarionNumber takeRecord()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber skipDetails=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(super.takeRecord());
		report.detail.print();
		return returnValue.like();
	}
}
