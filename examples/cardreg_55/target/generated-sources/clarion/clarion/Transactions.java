package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionSQLFile;
import org.jclarion.clarion.ClarionString;

public class Transactions extends ClarionSQLFile
{
	public ClarionNumber sysID=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber dateofTransaction=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString transactionDescription=Clarion.newString(35);
	public ClarionString transactionType=Clarion.newString(1);
	public ClarionDecimal transactionAmount=Clarion.newDecimal(7,2);
	public ClarionNumber reconciledTransaction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionKey sysIDKey=new ClarionKey("SysIDKey");
	public ClarionKey sysIDTypeKey=new ClarionKey("SysIDTypeKey");
	public ClarionKey sysIDDateKey=new ClarionKey("SysIDDateKey");
	public ClarionKey dateKey=new ClarionKey("DateKey");
	public ClarionKey typeKey=new ClarionKey("TypeKey");

	public Transactions()
	{
		setName(Clarion.newString("Transactions"));
		setPrefix("TRA");
		setCreate();
		this.addVariable("SysID",this.sysID);
		this.addVariable("DateofTransaction",this.dateofTransaction);
		this.addVariable("TransactionDescription",this.transactionDescription);
		this.addVariable("TransactionType",this.transactionType);
		this.addVariable("TransactionAmount",this.transactionAmount);
		this.addVariable("ReconciledTransaction",this.reconciledTransaction);
		sysIDKey.setDuplicate().setNocase().setOptional().addAscendingField(sysID);
		this.addKey(sysIDKey);
		sysIDTypeKey.setDuplicate().setNocase().setOptional().addAscendingField(sysID).addAscendingField(transactionType);
		this.addKey(sysIDTypeKey);
		sysIDDateKey.setDuplicate().setNocase().setOptional().addAscendingField(sysID).addAscendingField(dateofTransaction);
		this.addKey(sysIDDateKey);
		dateKey.setDuplicate().setNocase().setOptional().addAscendingField(dateofTransaction);
		this.addKey(dateKey);
		typeKey.setDuplicate().setNocase().setOptional().addAscendingField(transactionType);
		this.addKey(typeKey);
	}
}
