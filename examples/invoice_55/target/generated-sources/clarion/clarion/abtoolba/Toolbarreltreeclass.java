package clarion.abtoolba;

import clarion.abtoolba.Abtoolba;
import clarion.abtoolba.Toolbartarget;
import clarion.equates.Toolbar;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Toolbarreltreeclass extends Toolbartarget
{
	public Toolbarreltreeclass()
	{
	}

	public void displaybuttons()
	{
		CWin.disable(Toolbar.HISTORY);
		CWin.enable(Toolbar.BOTTOM,Toolbar.UP);
		super.displaybuttons();
	}
	public void taketoolbar()
	{
		(new Abtoolba()).settips(Abtoolba.reltreeboxtips.getString());
		this.displaybuttons();
	}
}
