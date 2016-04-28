package clarion.invoi002;

import clarion.Main;
import clarion.abreport.Processclass_1;
import clarion.invoi002.Report;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;

@SuppressWarnings("all")
public class Thisreport extends Processclass_1
{
	Report report;
	public Thisreport(Report report)
	{
		this.report=report;
	}

	public ClarionNumber takerecord()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber skipdetails=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.glotCustname.setValue(Main.customers.firstname.clip().concat("   ",Main.customers.lastname.clip()));
		returnvalue.setValue(super.takerecord());
		report.detail.print();
		return returnvalue.like();
	}
}
