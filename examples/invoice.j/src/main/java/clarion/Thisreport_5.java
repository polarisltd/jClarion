package clarion;

import clarion.Invoi002;
import clarion.Main;
import clarion.Processclass;
import clarion.Report_5;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

public class Thisreport_5 extends Processclass
{
	ClarionString lOCAddress;
	ClarionString locCsz;
	Report_5 report;
	public Thisreport_5(ClarionString lOCAddress,ClarionString locCsz,Report_5 report)
	{
		this.lOCAddress=lOCAddress;
		this.locCsz=locCsz;
		this.report=report;
	}

	public ClarionNumber takeRecord()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber skipDetails=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.gLOTCustName.setValue(Main.customers.firstName.clip().concat("   ",Main.customers.lastName.clip()));
		if (Main.customers.address2.equals("")) {
			lOCAddress.setValue(Main.customers.address1);
		}
		else {
			lOCAddress.setValue(Main.customers.address1.clip().concat(",  ",Main.customers.address2));
		}
		locCsz.setValue(Invoi002.cityStateZip(Main.customers.city.like(),Main.customers.state.like(),Main.customers.zipCode.like()));
		returnValue.setValue(super.takeRecord());
		report.detail.print();
		return returnValue.like();
	}
}
