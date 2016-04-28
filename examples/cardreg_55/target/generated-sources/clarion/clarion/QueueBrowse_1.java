package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class QueueBrowse_1 extends ClarionQueue
{
	public ClarionString aCCCreditCardVendor;
	public ClarionString aCCAccountNumber;
	public ClarionString aCCVendorAddr1;
	public ClarionString aCCVendorAddr2;
	public ClarionString aCCVendorCity;
	public ClarionString aCCVendorState;
	public ClarionString aCCVendorZip;
	public ClarionDecimal aCCInterestRate;
	public ClarionNumber aCCBillingDay;
	public ClarionDecimal aCCAccountBalance;
	public ClarionDecimal aCCBalanceInfoPhone;
	public ClarionDecimal aCCLostCardPhone;
	public ClarionString lOCCityStateZip;
	public ClarionString lOCOrdinalExtension;
	public ClarionString lOCCardTypeDescription;
	public ClarionString gLOCardTypeDescription;
	public ClarionDecimal aCCCreditLimit;
	public ClarionNumber aCCExpirationDate;
	public ClarionNumber aCCSysID;
	public ClarionNumber mark;
	public ClarionString viewPosition;

	public QueueBrowse_1(ClarionString lOCCityStateZip,ClarionString lOCOrdinalExtension,ClarionString lOCCardTypeDescription)
	{
		this.aCCCreditCardVendor=Main.accounts.creditCardVendor.like();
		this.addVariable("ACC:CreditCardVendor",this.aCCCreditCardVendor);
		this.aCCAccountNumber=Main.accounts.accountNumber.like();
		this.addVariable("ACC:AccountNumber",this.aCCAccountNumber);
		this.aCCVendorAddr1=Main.accounts.vendorAddr1.like();
		this.addVariable("ACC:VendorAddr1",this.aCCVendorAddr1);
		this.aCCVendorAddr2=Main.accounts.vendorAddr2.like();
		this.addVariable("ACC:VendorAddr2",this.aCCVendorAddr2);
		this.aCCVendorCity=Main.accounts.vendorCity.like();
		this.addVariable("ACC:VendorCity",this.aCCVendorCity);
		this.aCCVendorState=Main.accounts.vendorState.like();
		this.addVariable("ACC:VendorState",this.aCCVendorState);
		this.aCCVendorZip=Main.accounts.vendorZip.like();
		this.addVariable("ACC:VendorZip",this.aCCVendorZip);
		this.aCCInterestRate=Main.accounts.interestRate.like();
		this.addVariable("ACC:InterestRate",this.aCCInterestRate);
		this.aCCBillingDay=Main.accounts.billingDay.like();
		this.addVariable("ACC:BillingDay",this.aCCBillingDay);
		this.aCCAccountBalance=Main.accounts.accountBalance.like();
		this.addVariable("ACC:AccountBalance",this.aCCAccountBalance);
		this.aCCBalanceInfoPhone=Main.accounts.balanceInfoPhone.like();
		this.addVariable("ACC:BalanceInfoPhone",this.aCCBalanceInfoPhone);
		this.aCCLostCardPhone=Main.accounts.lostCardPhone.like();
		this.addVariable("ACC:LostCardPhone",this.aCCLostCardPhone);
		this.lOCCityStateZip=lOCCityStateZip.like();
		this.addVariable("LOC:CityStateZip",this.lOCCityStateZip);
		this.lOCOrdinalExtension=lOCOrdinalExtension.like();
		this.addVariable("LOC:OrdinalExtension",this.lOCOrdinalExtension);
		this.lOCCardTypeDescription=lOCCardTypeDescription.like();
		this.addVariable("LOC:CardTypeDescription",this.lOCCardTypeDescription);
		this.gLOCardTypeDescription=Main.gLOCardTypeDescription.like();
		this.addVariable("GLO:CardTypeDescription",this.gLOCardTypeDescription);
		this.aCCCreditLimit=Main.accounts.creditLimit.like();
		this.addVariable("ACC:CreditLimit",this.aCCCreditLimit);
		this.aCCExpirationDate=Main.accounts.expirationDate.like();
		this.addVariable("ACC:ExpirationDate",this.aCCExpirationDate);
		this.aCCSysID=Main.accounts.sysID.like();
		this.addVariable("ACC:SysID",this.aCCSysID);
		this.mark=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.addVariable("Mark",this.mark);
		this.viewPosition=Clarion.newString(1024);
		this.addVariable("ViewPosition",this.viewPosition);
	}
}
