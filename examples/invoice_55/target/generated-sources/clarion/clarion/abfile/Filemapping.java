package clarion.abfile;

import clarion.abfile.Filemanager;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.runtime.ref.RefVariable;

@SuppressWarnings("all")
public class Filemapping extends ClarionQueue
{
	public ClarionNumber filelabel=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public RefVariable<Filemanager> filemanager=new RefVariable<Filemanager>(null);

	public Filemapping()
	{
		this.addVariable("FileLabel",this.filelabel);
		this.addVariable("FileManager",this.filemanager);
	}
}
