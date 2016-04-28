package clarion.invoi002;

import clarion.Main;
import clarion.abreport.Processclass_1;
import clarion.equates.Prop;
import clarion.invoi002.Report_4;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;

@SuppressWarnings("all")
public class Thisreport_4 extends Processclass_1
{
	Report_4 report;
	public Thisreport_4(Report_4 report)
	{
		this.report=report;
	}

	public ClarionNumber takerecord()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber skipdetails=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		report.getControl(report._image1).setClonedProperty(Prop.TEXT,Main.products.picturefile);
		returnvalue.setValue(super.takerecord());
		report.detail.print();
		return returnvalue.like();
	}
}
