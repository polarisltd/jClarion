package clarion;

import clarion.Filemanager;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.runtime.ref.RefVariable;

public class Filemapping extends ClarionQueue
{
	public ClarionNumber fileLabel=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public RefVariable<Filemanager> fileManager=new RefVariable<Filemanager>(null);

	public Filemapping()
	{
		this.addVariable("FileLabel",this.fileLabel);
		this.addVariable("FileManager",this.fileManager);
	}
}
