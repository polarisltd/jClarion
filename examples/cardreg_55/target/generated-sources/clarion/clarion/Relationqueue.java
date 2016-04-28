package clarion;

import clarion.Bufferedpairsclass;
import clarion.Relationmanager;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.runtime.ref.RefVariable;

public class Relationqueue extends ClarionQueue
{
	public RefVariable<Relationmanager> file=new RefVariable<Relationmanager>(null);
	public RefVariable<Bufferedpairsclass> fields=new RefVariable<Bufferedpairsclass>(null);
	public RefVariable<ClarionKey> hisKey=new RefVariable<ClarionKey>(null);
	public ClarionNumber updateMode=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber deleteMode=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);

	public Relationqueue()
	{
		this.addVariable("File",this.file);
		this.addVariable("Fields",this.fields);
		this.addVariable("HisKey",this.hisKey);
		this.addVariable("UpdateMode",this.updateMode);
		this.addVariable("DeleteMode",this.deleteMode);
	}
}
