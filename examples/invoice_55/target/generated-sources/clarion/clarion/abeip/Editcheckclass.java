package clarion.abeip;

import clarion.abeip.Editclass;
import clarion.equates.Create;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Editcheckclass extends Editclass
{
	public Editcheckclass()
	{
	}

	public void createcontrol()
	{
		this.feq.setValue(CWin.createControl(0,Create.CHECK,null,null));
	}
}
