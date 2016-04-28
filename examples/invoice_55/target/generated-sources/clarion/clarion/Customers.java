package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Customers extends ClarionSQLFile
{
	public ClarionNumber custnumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString company=Clarion.newString(20);
	public ClarionString firstname=Clarion.newString(20);
	public ClarionString mi=Clarion.newString(1);
	public ClarionString lastname=Clarion.newString(25);
	public ClarionString address1=Clarion.newString(35);
	public ClarionString address2=Clarion.newString(35);
	public ClarionString city=Clarion.newString(25);
	public ClarionString state=Clarion.newString(2);
	public ClarionString zipcode=Clarion.newString(10);
	public ClarionString phonenumber=Clarion.newString(10);
	public ClarionString extension=Clarion.newString(4);
	public ClarionString phonetype=Clarion.newString(8);
	public ClarionKey keycustnumber=new ClarionKey("KeyCustNumber");
	public ClarionKey keyfullname=new ClarionKey("KeyFullName");
	public ClarionKey keycompany=new ClarionKey("KeyCompany");
	public ClarionKey keyzipcode=new ClarionKey("KeyZipCode");
	public ClarionKey statekey=new ClarionKey("StateKey");

	public Customers()
	{
		setPrefix("CUS");
		setCreate();
		setName(Clarion.newString("customers"));
		this.addVariable("CustNumber",this.custnumber);
		this.addVariable("Company",this.company);
		this.addVariable("FirstName",this.firstname);
		this.addVariable("MI",this.mi);
		this.addVariable("LastName",this.lastname);
		this.addVariable("Address1",this.address1);
		this.addVariable("Address2",this.address2);
		this.addVariable("City",this.city);
		this.addVariable("State",this.state);
		this.addVariable("ZipCode",this.zipcode);
		this.addVariable("PhoneNumber",this.phonenumber);
		this.addVariable("Extension",this.extension);
		this.addVariable("PhoneType",this.phonetype);
		keycustnumber.setNocase().setOptional().addAscendingField(custnumber);
		this.addKey(keycustnumber);
		keyfullname.setDuplicate().setNocase().setOptional().addAscendingField(lastname).addAscendingField(firstname).addAscendingField(mi);
		this.addKey(keyfullname);
		keycompany.setDuplicate().setNocase().addAscendingField(company);
		this.addKey(keycompany);
		keyzipcode.setDuplicate().setNocase().addAscendingField(zipcode);
		this.addKey(keyzipcode);
		statekey.setDuplicate().setNocase().setOptional().addAscendingField(state);
		this.addKey(statekey);
	}
}
