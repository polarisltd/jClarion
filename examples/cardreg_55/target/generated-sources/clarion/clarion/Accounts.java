package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

public class Accounts extends ClarionSQLFile
{
	public ClarionNumber sysID=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString creditCardVendor=Clarion.newString(30);
	public ClarionString cardType=Clarion.newString(1);
	public ClarionString accountNumber=Clarion.newString(20);
	public ClarionNumber expirationDate=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString vendorAddr1=Clarion.newString(35);
	public ClarionString vendorAddr2=Clarion.newString(35);
	public ClarionString vendorCity=Clarion.newString(25);
	public ClarionString vendorState=Clarion.newString(2);
	public ClarionString vendorZip=Clarion.newString(10);
	public ClarionDecimal balanceInfoPhone=Clarion.newDecimal(10,0);
	public ClarionDecimal lostCardPhone=Clarion.newDecimal(10,0);
	public ClarionDecimal interestRate=Clarion.newDecimal(5,2);
	public ClarionDecimal creditLimit=Clarion.newDecimal(7,2);
	public ClarionNumber billingDay=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionDecimal accountBalance=Clarion.newDecimal(7,2);
	public ClarionKey sysIDKey=new ClarionKey("SysIDKey");
	public ClarionKey creditCardVendorKey=new ClarionKey("CreditCardVendorKey");
	public ClarionKey accountNumberKey=new ClarionKey("AccountNumberKey");

	public Accounts()
	{
		setName(Clarion.newString("Accounts"));
		setPrefix("ACC");
		setCreate();
		this.addVariable("SysID",this.sysID);
		this.addVariable("CreditCardVendor",this.creditCardVendor);
		this.addVariable("CardType",this.cardType);
		this.addVariable("AccountNumber",this.accountNumber);
		this.addVariable("ExpirationDate",this.expirationDate);
		this.addVariable("VendorAddr1",this.vendorAddr1);
		this.addVariable("VendorAddr2",this.vendorAddr2);
		this.addVariable("VendorCity",this.vendorCity);
		this.addVariable("VendorState",this.vendorState);
		this.addVariable("VendorZip",this.vendorZip);
		this.addVariable("BalanceInfoPhone",this.balanceInfoPhone);
		this.addVariable("LostCardPhone",this.lostCardPhone);
		this.addVariable("InterestRate",this.interestRate);
		this.addVariable("CreditLimit",this.creditLimit);
		this.addVariable("BillingDay",this.billingDay);
		this.addVariable("AccountBalance",this.accountBalance);
		sysIDKey.setNocase().setOptional().setPrimary().addAscendingField(sysID);
		this.addKey(sysIDKey);
		creditCardVendorKey.setDuplicate().setNocase().setOptional().addAscendingField(creditCardVendor);
		this.addKey(creditCardVendorKey);
		accountNumberKey.setDuplicate().setNocase().setOptional().addAscendingField(accountNumber);
		this.addKey(accountNumberKey);
	}
}
