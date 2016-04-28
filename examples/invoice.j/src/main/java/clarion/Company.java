package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

public class Company extends ClarionSQLFile
{
	public ClarionNumber companyNumber=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString name=Clarion.newString(20);
	public ClarionString address=Clarion.newString(35);
	public ClarionString city=Clarion.newString(25);
	public ClarionString state=Clarion.newString(2);
	public ClarionString zipCode=Clarion.newString(10);
	public ClarionString phone=Clarion.newString(10);
	public ClarionKey keyId=new ClarionKey("KeyId");

	public Company()
	{
		setName(Clarion.newString("Company"));
		setPrefix("COM");
		setCreate();
		this.addVariable("CompanyNumber",this.companyNumber);
		this.addVariable("Name",this.name);
		this.addVariable("Address",this.address);
		this.addVariable("City",this.city);
		this.addVariable("State",this.state);
		this.addVariable("Zipcode",this.zipCode);
		this.addVariable("Phone",this.phone);
		keyId.setNocase().setPrimary().addAscendingField(companyNumber);
		this.addKey(keyId);
	}
}
