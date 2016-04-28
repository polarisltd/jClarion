package clarion;

import clarion.Main;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class QueueBrowse_1_1 extends ClarionQueue
{
	public ClarionNumber tRADateofTransaction;
	public ClarionString tRATransactionDescription;
	public ClarionString gLOTransactionTypeDescription;
	public ClarionDecimal tRATransactionAmount;
	public ClarionNumber tRATransactionAmount_NormalFG;
	public ClarionNumber tRATransactionAmount_NormalBG;
	public ClarionNumber tRATransactionAmount_SelectedFG;
	public ClarionNumber tRATransactionAmount_SelectedBG;
	public ClarionNumber tRAReconciledTransaction;
	public ClarionDecimal aCCCreditLimit;
	public ClarionDecimal lOCAvailableFunds;
	public ClarionDecimal aCCAccountBalance;
	public ClarionNumber tRASysID;
	public ClarionString tRATransactionType;
	public ClarionNumber mark;
	public ClarionString viewPosition;

	public QueueBrowse_1_1(ClarionDecimal lOCAvailableFunds)
	{
		this.tRADateofTransaction=Main.transactions.dateofTransaction.like();
		this.addVariable("TRA:DateofTransaction",this.tRADateofTransaction);
		this.tRATransactionDescription=Main.transactions.transactionDescription.like();
		this.addVariable("TRA:TransactionDescription",this.tRATransactionDescription);
		this.gLOTransactionTypeDescription=Main.gLOTransactionTypeDescription.like();
		this.addVariable("GLO:TransactionTypeDescription",this.gLOTransactionTypeDescription);
		this.tRATransactionAmount=Main.transactions.transactionAmount.like();
		this.addVariable("TRA:TransactionAmount",this.tRATransactionAmount);
		this.tRATransactionAmount_NormalFG=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		this.addVariable("TRA:TransactionAmount_NormalFG",this.tRATransactionAmount_NormalFG);
		this.tRATransactionAmount_NormalBG=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		this.addVariable("TRA:TransactionAmount_NormalBG",this.tRATransactionAmount_NormalBG);
		this.tRATransactionAmount_SelectedFG=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		this.addVariable("TRA:TransactionAmount_SelectedFG",this.tRATransactionAmount_SelectedFG);
		this.tRATransactionAmount_SelectedBG=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		this.addVariable("TRA:TransactionAmount_SelectedBG",this.tRATransactionAmount_SelectedBG);
		this.tRAReconciledTransaction=Main.transactions.reconciledTransaction.like();
		this.addVariable("TRA:ReconciledTransaction",this.tRAReconciledTransaction);
		this.aCCCreditLimit=Main.accounts.creditLimit.like();
		this.addVariable("ACC:CreditLimit",this.aCCCreditLimit);
		this.lOCAvailableFunds=lOCAvailableFunds.like();
		this.addVariable("LOC:AvailableFunds",this.lOCAvailableFunds);
		this.aCCAccountBalance=Main.accounts.accountBalance.like();
		this.addVariable("ACC:AccountBalance",this.aCCAccountBalance);
		this.tRASysID=Main.transactions.sysID.like();
		this.addVariable("TRA:SysID",this.tRASysID);
		this.tRATransactionType=Main.transactions.transactionType.like();
		this.addVariable("TRA:TransactionType",this.tRATransactionType);
		this.mark=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.addVariable("Mark",this.mark);
		this.viewPosition=Clarion.newString(1024);
		this.addVariable("ViewPosition",this.viewPosition);
	}
}
