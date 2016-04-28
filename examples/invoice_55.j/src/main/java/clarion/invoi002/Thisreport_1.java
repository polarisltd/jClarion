package clarion.invoi002;

import clarion.abreport.Processclass_1;
import clarion.invoi002.Report_1;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;

@SuppressWarnings("all")
public class Thisreport_1 extends Processclass_1
{
	Report_1 report;
	public Thisreport_1(Report_1 report)
	{
		this.report=report;
	}

	public ClarionNumber takerecord()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber skipdetails=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnvalue.setValue(super.takerecord());
		report.detail.print();
		return returnvalue.like();
	}
}
