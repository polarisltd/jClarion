package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class QueueBrowse_1 extends ClarionQueue
{
	public ClarionNumber cusCustnumber=Main.customer.custnumber.like();
	public ClarionString cusCompany=Main.customer.company.like();
	public ClarionString cusFirstname=Main.customer.firstname.like();
	public ClarionString cusLastname=Main.customer.lastname.like();
	public ClarionString cusAddress=Main.customer.address.like();
	public ClarionString cusCity=Main.customer.city.like();
	public ClarionString cusState=Main.customer.state.like();
	public ClarionNumber cusZipcode=Main.customer.zipcode.like();
	public ClarionNumber mark=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString viewPosition=Clarion.newString(1024);

	public QueueBrowse_1()
	{
		this.addVariable("CUS:CUSTNUMBER",this.cusCustnumber);
		this.addVariable("CUS:COMPANY",this.cusCompany);
		this.addVariable("CUS:FIRSTNAME",this.cusFirstname);
		this.addVariable("CUS:LASTNAME",this.cusLastname);
		this.addVariable("CUS:ADDRESS",this.cusAddress);
		this.addVariable("CUS:CITY",this.cusCity);
		this.addVariable("CUS:STATE",this.cusState);
		this.addVariable("CUS:ZIPCODE",this.cusZipcode);
		this.addVariable("Mark",this.mark);
		this.addVariable("ViewPosition",this.viewPosition);
	}
}
