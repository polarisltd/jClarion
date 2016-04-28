package clarion.invoi001;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class QueueBrowse_1_3 extends ClarionQueue
{
	public ClarionString cusFirstname;
	public ClarionString cusMi;
	public ClarionString cusLastname;
	public ClarionString cusCompany;
	public ClarionString cusState;
	public ClarionString cusZipcode;
	public ClarionString cusAddress1;
	public ClarionString cusAddress2;
	public ClarionString cusCity;
	public ClarionString glotCuscsz;
	public ClarionString cusPhonenumber;
	public ClarionString locFilterstring;
	public ClarionString locCompanyletter;
	public ClarionString locZipnum;
	public ClarionString locState;
	public ClarionString locNameletter;
	public ClarionNumber mark;
	public ClarionString viewposition;

	public QueueBrowse_1_3(ClarionString locFilterstring,ClarionString locCompanyletter,ClarionString locZipnum,ClarionString locState,ClarionString locNameletter)
	{
		this.cusFirstname=Clarion.newString(20);
		this.addVariable("CUS:FirstName",this.cusFirstname);
		this.cusMi=Clarion.newString(1);
		this.addVariable("CUS:MI",this.cusMi);
		this.cusLastname=Clarion.newString(25);
		this.addVariable("CUS:LastName",this.cusLastname);
		this.cusCompany=Clarion.newString(20);
		this.addVariable("CUS:Company",this.cusCompany);
		this.cusState=Clarion.newString(2);
		this.addVariable("CUS:State",this.cusState);
		this.cusZipcode=Clarion.newString(10);
		this.addVariable("CUS:ZipCode",this.cusZipcode);
		this.cusAddress1=Clarion.newString(35);
		this.addVariable("CUS:Address1",this.cusAddress1);
		this.cusAddress2=Clarion.newString(35);
		this.addVariable("CUS:Address2",this.cusAddress2);
		this.cusCity=Clarion.newString(25);
		this.addVariable("CUS:City",this.cusCity);
		this.glotCuscsz=Clarion.newString(40);
		this.addVariable("GLOT:CusCSZ",this.glotCuscsz);
		this.cusPhonenumber=Clarion.newString(10);
		this.addVariable("CUS:PhoneNumber",this.cusPhonenumber);
		this.locFilterstring=Clarion.newString(255);
		this.addVariable("LOC:FilterString",this.locFilterstring);
		this.locCompanyletter=Clarion.newString(1);
		this.addVariable("LOC:CompanyLetter",this.locCompanyletter);
		this.locZipnum=Clarion.newString(2);
		this.addVariable("LOC:ZipNum",this.locZipnum);
		this.locState=Clarion.newString(2);
		this.addVariable("LOC:State",this.locState);
		this.locNameletter=Clarion.newString(1);
		this.addVariable("LOC:NameLetter",this.locNameletter);
		this.mark=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.addVariable("Mark",this.mark);
		this.viewposition=Clarion.newString(1024);
		this.addVariable("ViewPosition",this.viewposition);
	}
}
