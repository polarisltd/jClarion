package clarion;

import clarion.Editclass;
import clarion.equates.Create;
import org.jclarion.clarion.runtime.CWin;

public class Editcheckclass extends Editclass
{
	public Editcheckclass()
	{
	}

	public void createControl()
	{
		this.feq.setValue(CWin.createControl(0,Create.CHECK,null,null));
	}
}
