package clarion.abeip;

import clarion.abeip.Editdroplistclass;
import clarion.equates.Create;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Editdropcomboclass extends Editdroplistclass
{
	public Editdropcomboclass()
	{
	}

	public void createcontrol()
	{
		this.feq.setValue(CWin.createControl(0,Create.DROPCOMBO,null,null));
	}
}
