package clarion.abwindow;

import clarion.abfile.Filemanager;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.runtime.ref.RefVariable;

@SuppressWarnings("all")
public class Filelist extends ClarionQueue
{
	public RefVariable<Filemanager> manager=new RefVariable<Filemanager>(null);
	public ClarionNumber saved=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);

	public Filelist()
	{
		this.addVariable("Manager",this.manager);
		this.addVariable("Saved",this.saved);
	}
}
