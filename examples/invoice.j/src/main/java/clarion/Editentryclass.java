package clarion;

import clarion.Editclass;
import clarion.equates.Create;
import org.jclarion.clarion.runtime.CWin;

public class Editentryclass extends Editclass
{
	public Editentryclass()
	{
	}

	public void createControl()
	{
		this.feq.setValue(CWin.createControl(0,Create.ENTRY,null,null));
	}
}
