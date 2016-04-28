package clarion.invoi001;

import clarion.Main;
import clarion.abreport.Processclass;
import clarion.invoi001.Report;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;

@SuppressWarnings("all")
public class Thisreport extends Processclass
{
	ClarionDecimal extendprice;
	Report report;
	public Thisreport(ClarionDecimal extendprice,Report report)
	{
		this.extendprice=extendprice;
		this.report=report;
	}

	public ClarionNumber takerecord()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber skipdetails=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		extendprice.setValue(Main.detail.price.multiply(Main.detail.quantityordered));
		Main.glotCustname.setValue(Main.customers.firstname.clip().concat("   ",Main.customers.lastname.clip()));
		Main.glotCustaddress.setValue(Main.customers.address1.clip().concat("    ",Main.customers.address2.clip()));
		Main.glotCuscsz.setValue(Main.customers.city.clip().concat(",  ",Main.customers.state,"     ",Main.customers.zipcode.clip()));
		Main.glotShipname.setValue(Main.orders.shiptoname.clip());
		Main.glotShipaddress.setValue(Main.orders.shipaddress1.clip().concat("    ",Main.orders.shipaddress2.clip()));
		Main.glotShipcsz.setValue(Main.orders.shipcity.clip().concat(",  ",Main.orders.shipstate,"    ",Main.orders.shipzip.clip()));
		returnvalue.setValue(super.takerecord());
		report.detail.print();
		return returnvalue.like();
	}
}
