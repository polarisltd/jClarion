package clarion.abeip;

import clarion.abeip.Editclass;
import clarion.equates.Create;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Editentryclass extends Editclass
{
	public Editentryclass()
	{
	}

	public void createcontrol()
	{
		this.feq.setValue(CWin.createControl(0,Create.ENTRY,null,null));
	}
}
