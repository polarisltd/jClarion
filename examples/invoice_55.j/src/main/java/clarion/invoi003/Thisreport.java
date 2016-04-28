package clarion.invoi003;

import clarion.Main;
import clarion.abreport.Processclass_3;
import clarion.invoi003.Invoi003;
import clarion.invoi003.Report;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Thisreport extends Processclass_3
{
	ClarionString locAddress;
	ClarionString locCsz;
	Report report;
	public Thisreport(ClarionString locAddress,ClarionString locCsz,Report report)
	{
		this.locAddress=locAddress;
		this.locCsz=locCsz;
		this.report=report;
	}

	public ClarionNumber takerecord()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber skipdetails=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.glotCustname.setValue(Main.customers.firstname.clip().concat("   ",Main.customers.lastname.clip()));
		if (Main.customers.address2.equals("")) {
			locAddress.setValue(Main.customers.address1);
		}
		else {
			locAddress.setValue(Main.customers.address1.clip().concat(",  ",Main.customers.address2));
		}
		locCsz.setValue(Invoi003.citystatezip(Main.customers.city.like(),Main.customers.state.like(),Main.customers.zipcode.like()));
		returnvalue.setValue(super.takerecord());
		report.detail.print();
		return returnvalue.like();
	}
}
