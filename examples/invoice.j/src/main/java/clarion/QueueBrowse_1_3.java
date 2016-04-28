package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class QueueBrowse_1_3 extends ClarionQueue
{
	public ClarionString cUSFirstName;
	public ClarionString cusMi;
	public ClarionString cUSLastName;
	public ClarionString cUSCompany;
	public ClarionString cUSState;
	public ClarionString cUSZipCode;
	public ClarionString cUSAddress1;
	public ClarionString cUSAddress2;
	public ClarionString cUSCity;
	public ClarionString gLOTCusCSZ;
	public ClarionString cUSPhoneNumber;
	public ClarionString lOCFilterString;
	public ClarionString lOCCompanyLetter;
	public ClarionString lOCZipNum;
	public ClarionString lOCState;
	public ClarionString lOCNameLetter;
	public ClarionNumber mark;
	public ClarionString viewPosition;

	public QueueBrowse_1_3(ClarionString lOCFilterString,ClarionString lOCCompanyLetter,ClarionString lOCZipNum,ClarionString lOCState,ClarionString lOCNameLetter)
	{
		this.cUSFirstName=Main.customers.firstName.like();
		this.addVariable("CUS:FirstName",this.cUSFirstName);
		this.cusMi=Main.customers.mi.like();
		this.addVariable("CUS:MI",this.cusMi);
		this.cUSLastName=Main.customers.lastName.like();
		this.addVariable("CUS:LastName",this.cUSLastName);
		this.cUSCompany=Main.customers.company.like();
		this.addVariable("CUS:Company",this.cUSCompany);
		this.cUSState=Main.customers.state.like();
		this.addVariable("CUS:State",this.cUSState);
		this.cUSZipCode=Main.customers.zipCode.like();
		this.addVariable("CUS:ZipCode",this.cUSZipCode);
		this.cUSAddress1=Main.customers.address1.like();
		this.addVariable("CUS:Address1",this.cUSAddress1);
		this.cUSAddress2=Main.customers.address2.like();
		this.addVariable("CUS:Address2",this.cUSAddress2);
		this.cUSCity=Main.customers.city.like();
		this.addVariable("CUS:City",this.cUSCity);
		this.gLOTCusCSZ=Main.gLOTCusCSZ.like();
		this.addVariable("GLOT:CusCSZ",this.gLOTCusCSZ);
		this.cUSPhoneNumber=Main.customers.phoneNumber.like();
		this.addVariable("CUS:PhoneNumber",this.cUSPhoneNumber);
		this.lOCFilterString=lOCFilterString.like();
		this.addVariable("LOC:FilterString",this.lOCFilterString);
		this.lOCCompanyLetter=lOCCompanyLetter.like();
		this.addVariable("LOC:CompanyLetter",this.lOCCompanyLetter);
		this.lOCZipNum=lOCZipNum.like();
		this.addVariable("LOC:ZipNum",this.lOCZipNum);
		this.lOCState=lOCState.like();
		this.addVariable("LOC:State",this.lOCState);
		this.lOCNameLetter=lOCNameLetter.like();
		this.addVariable("LOC:NameLetter",this.lOCNameLetter);
		this.mark=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.addVariable("Mark",this.mark);
		this.viewPosition=Clarion.newString(1024);
		this.addVariable("ViewPosition",this.viewPosition);
	}
}
