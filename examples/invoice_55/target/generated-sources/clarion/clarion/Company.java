package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Company extends ClarionSQLFile
{
	public ClarionString name=Clarion.newString(20);
	public ClarionString address=Clarion.newString(35);
	public ClarionString city=Clarion.newString(25);
	public ClarionString state=Clarion.newString(2);
	public ClarionString zipcode=Clarion.newString(10);
	public ClarionString phone=Clarion.newString(10);

	public Company()
	{
		setPrefix("COM");
		setCreate();
		setName(Clarion.newString("company"));
		this.addVariable("Name",this.name);
		this.addVariable("Address",this.address);
		this.addVariable("City",this.city);
		this.addVariable("State",this.state);
		this.addVariable("Zipcode",this.zipcode);
		this.addVariable("Phone",this.phone);
	}
}
