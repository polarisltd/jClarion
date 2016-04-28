package clarion.abfile;

import clarion.abfile.Relationmanager;
import clarion.abutil.Bufferedpairsclass;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.runtime.ref.RefVariable;

@SuppressWarnings("all")
public class Relationqueue extends ClarionQueue
{
	public RefVariable<Relationmanager> file=new RefVariable<Relationmanager>(null);
	public RefVariable<Bufferedpairsclass> fields=new RefVariable<Bufferedpairsclass>(null);
	public RefVariable<ClarionKey> hiskey=new RefVariable<ClarionKey>(null);
	public ClarionNumber updatemode=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber deletemode=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);

	public Relationqueue()
	{
		this.addVariable("File",this.file);
		this.addVariable("Fields",this.fields);
		this.addVariable("HisKey",this.hiskey);
		this.addVariable("UpdateMode",this.updatemode);
		this.addVariable("DeleteMode",this.deletemode);
	}
}
