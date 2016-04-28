package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

public class Customer extends ClarionSQLFile
{
	public ClarionNumber custnumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString company=Clarion.newString(20);
	public ClarionString firstname=Clarion.newString(20);
	public ClarionString lastname=Clarion.newString(20);
	public ClarionString address=Clarion.newString(20);
	public ClarionString city=Clarion.newString(20);
	public ClarionString state=Clarion.newString(2);
	public ClarionNumber zipcode=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionKey keycustnumber=new ClarionKey("KEYCUSTNUMBER");
	public ClarionKey keycompany=new ClarionKey("KEYCOMPANY");
	public ClarionKey keyzipcode=new ClarionKey("KEYZIPCODE");

	public Customer()
	{
		setName(Clarion.newString("CUSTOMER"));
		setPrefix("CUS");
		setCreate();
		this.addVariable("CUSTNUMBER",this.custnumber);
		this.addVariable("COMPANY",this.company);
		this.addVariable("FIRSTNAME",this.firstname);
		this.addVariable("LASTNAME",this.lastname);
		this.addVariable("ADDRESS",this.address);
		this.addVariable("CITY",this.city);
		this.addVariable("STATE",this.state);
		this.addVariable("ZIPCODE",this.zipcode);
		keycustnumber.setNocase().setOptional().addAscendingField(custnumber);
		this.addKey(keycustnumber);
		keycompany.setDuplicate().setNocase().addAscendingField(company);
		this.addKey(keycompany);
		keyzipcode.setDuplicate().setNocase().addAscendingField(zipcode);
		this.addKey(keyzipcode);
	}
}
