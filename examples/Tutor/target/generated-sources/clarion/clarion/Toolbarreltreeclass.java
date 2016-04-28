package clarion;

import clarion.Abtoolba;
import clarion.Toolbartarget;
import clarion.equates.Toolbar;
import org.jclarion.clarion.runtime.CWin;

public class Toolbarreltreeclass extends Toolbartarget
{
	public Toolbarreltreeclass()
	{
	}

	public void displayButtons()
	{
		CWin.disable(Toolbar.HISTORY);
		CWin.enable(Toolbar.BOTTOM,Toolbar.UP);
		super.displayButtons();
	}
	public void takeToolbar()
	{
		Abtoolba.setTips(Abtoolba.reltreeBoxTips.getString());
		this.displayButtons();
	}
}
