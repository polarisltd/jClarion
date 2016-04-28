package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.ref.RefVariable;

public class Params extends ClarionGroup implements org.jclarion.clarion.hooks.FilecallbackParams
{
	public ClarionNumber ahead=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
	public ClarionNumber behind=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
	public ClarionNumber buffer=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
	public ClarionNumber field=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public RefVariable<ClarionString> fieldList=new RefVariable<ClarionString>(null);
	public ClarionNumber fields=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public RefVariable<ClarionFile> file=new RefVariable<ClarionFile>(null);
	public ClarionNumber index=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public RefVariable<ClarionKey> key1=new RefVariable<ClarionKey>(null);
	public RefVariable<ClarionKey> key2=new RefVariable<ClarionKey>(null);
	public ClarionNumber len=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
	public ClarionNumber openMode=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber pointer=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public RefVariable<ClarionString> position=new RefVariable<ClarionString>(null);
	public RefVariable<ClarionString> property=new RefVariable<ClarionString>(null);
	public ClarionNumber records=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber seconds=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber start=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber state=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber stop=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public RefVariable<ClarionString> text=new RefVariable<ClarionString>(null);
	public ClarionNumber timeOut=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
	public RefVariable<ClarionString> returnStr=new RefVariable<ClarionString>(null);
	public ClarionNumber returnLong=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber restoreBuffer=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber transactionOpCode=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber saveBlob=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);

	public Params()
	{
		this.addVariable("Ahead",this.ahead);
		this.addVariable("Behind",this.behind);
		this.addVariable("Buffer",this.buffer);
		this.addVariable("Field",this.field);
		this.addVariable("FieldList",this.fieldList);
		this.addVariable("Fields",this.fields);
		this.addVariable("File",this.file);
		this.addVariable("Index",this.index);
		this.addVariable("Key1",this.key1);
		this.addVariable("Key2",this.key2);
		this.addVariable("Len",this.len);
		this.addVariable("openMode",this.openMode);
		this.addVariable("Pointer",this.pointer);
		this.addVariable("Position",this.position);
		this.addVariable("Property",this.property);
		this.addVariable("Records",this.records);
		this.addVariable("Seconds",this.seconds);
		this.addVariable("Start",this.start);
		this.addVariable("State",this.state);
		this.addVariable("Stop",this.stop);
		this.addVariable("Text",this.text);
		this.addVariable("TimeOut",this.timeOut);
		this.addVariable("ReturnStr",this.returnStr);
		this.addVariable("ReturnLong",this.returnLong);
		this.addVariable("RestoreBuffer",this.restoreBuffer);
		this.addVariable("TransactionOpCode",this.transactionOpCode);
		this.addVariable("SaveBlob",this.saveBlob);
	}
}
