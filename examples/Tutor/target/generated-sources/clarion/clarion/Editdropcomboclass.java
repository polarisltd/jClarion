package clarion;

import clarion.Editdroplistclass;
import clarion.equates.Create;
import org.jclarion.clarion.runtime.CWin;

public class Editdropcomboclass extends Editdroplistclass
{
	public Editdropcomboclass()
	{
	}

	public void createControl()
	{
		this.feq.setValue(CWin.createControl(0,Create.DROPCOMBO,null,null));
	}
}
