package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

public class Customers extends ClarionSQLFile
{
	public ClarionNumber custNumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString company=Clarion.newString(20);
	public ClarionString firstName=Clarion.newString(20);
	public ClarionString mi=Clarion.newString(1);
	public ClarionString lastName=Clarion.newString(25);
	public ClarionString address1=Clarion.newString(35);
	public ClarionString address2=Clarion.newString(35);
	public ClarionString city=Clarion.newString(25);
	public ClarionString state=Clarion.newString(2);
	public ClarionString zipCode=Clarion.newString(10);
	public ClarionString phoneNumber=Clarion.newString(10);
	public ClarionString extension=Clarion.newString(4);
	public ClarionString phoneType=Clarion.newString(8);
	public ClarionKey keyCustNumber=new ClarionKey("KeyCustNumber");
	public ClarionKey keyFullName=new ClarionKey("KeyFullName");
	public ClarionKey keyCompany=new ClarionKey("KeyCompany");
	public ClarionKey keyZipCode=new ClarionKey("KeyZipCode");
	public ClarionKey stateKey=new ClarionKey("StateKey");

	public Customers()
	{
		setName(Clarion.newString("Customers"));
		setPrefix("CUS");
		setCreate();
		this.addVariable("CustNumber",this.custNumber);
		this.addVariable("Company",this.company);
		this.addVariable("FirstName",this.firstName);
		this.addVariable("MI",this.mi);
		this.addVariable("LastName",this.lastName);
		this.addVariable("Address1",this.address1);
		this.addVariable("Address2",this.address2);
		this.addVariable("City",this.city);
		this.addVariable("State",this.state);
		this.addVariable("ZipCode",this.zipCode);
		this.addVariable("PhoneNumber",this.phoneNumber);
		this.addVariable("Extension",this.extension);
		this.addVariable("PhoneType",this.phoneType);
		keyCustNumber.setPrimary().addAscendingField(custNumber);
		this.addKey(keyCustNumber);
		keyFullName.setDuplicate().setNocase().setOptional().addAscendingField(lastName).addAscendingField(firstName).addAscendingField(mi);
		this.addKey(keyFullName);
		keyCompany.setDuplicate().setNocase().addAscendingField(company);
		this.addKey(keyCompany);
		keyZipCode.setDuplicate().setNocase().addAscendingField(zipCode);
		this.addKey(keyZipCode);
		stateKey.setDuplicate().setNocase().setOptional().addAscendingField(state);
		this.addKey(stateKey);
	}
}
