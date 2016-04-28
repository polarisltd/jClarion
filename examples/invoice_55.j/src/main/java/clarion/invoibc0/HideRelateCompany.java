package clarion.invoibc0;

import clarion.Main;
import clarion.abfile.Relationmanager;
import clarion.invoibc0.Invoibc0;
import org.jclarion.clarion.Clarion;

@SuppressWarnings("all")
public class HideRelateCompany extends Relationmanager
{
	public HideRelateCompany()
	{
	}

	public void init()
	{
		Invoibc0.hideAccessCompany.init();
		super.init(Main.accessCompany,Clarion.newNumber(1));
	}
	public void kill()
	{
		Invoibc0.hideAccessCompany.kill();
		super.kill();
		Main.relateCompany=null;
	}
}
