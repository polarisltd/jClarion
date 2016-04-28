package clarion;

import clarion.Main;
import clarion.Processclass;
import clarion.Report_6;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;

public class Thisreport_6 extends Processclass
{
	Report_6 report;
	public Thisreport_6(Report_6 report)
	{
		this.report=report;
	}

	public ClarionNumber takeRecord()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber skipDetails=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		report.getControl(report._image1).setClonedProperty(Prop.TEXT,Main.products.pictureFile);
		returnValue.setValue(super.takeRecord());
		report.detail.print();
		return returnValue.like();
	}
}
