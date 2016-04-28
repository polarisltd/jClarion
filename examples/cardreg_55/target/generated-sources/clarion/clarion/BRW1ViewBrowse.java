package clarion;

import clarion.Main;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.view.*;

public class BRW1ViewBrowse extends ClarionView
{

	public BRW1ViewBrowse()
	{
		setTable(Main.accounts);
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.accounts.creditCardVendor}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.accounts.accountNumber}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.accounts.vendorAddr1}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.accounts.vendorAddr2}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.accounts.vendorCity}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.accounts.vendorState}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.accounts.vendorZip}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.accounts.interestRate}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.accounts.billingDay}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.accounts.accountBalance}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.accounts.balanceInfoPhone}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.accounts.lostCardPhone}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.accounts.creditLimit}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.accounts.expirationDate}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.accounts.sysID}));
	}
}
