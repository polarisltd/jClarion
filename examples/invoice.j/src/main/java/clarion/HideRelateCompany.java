package clarion;

import clarion.Invoibc0;
import clarion.Main;
import clarion.Relationmanager;
import org.jclarion.clarion.Clarion;

public class HideRelateCompany extends Relationmanager
{
	public HideRelateCompany()
	{
	}

	public void init()
	{
		Invoibc0._hideAccessCompany.get().init();
		this.init(Main.accessCompany.get(),Clarion.newNumber(1));
	}
	public void kill()
	{
		Invoibc0._hideAccessCompany.get().kill();
		super.kill();
		Main.relateCompany.set(null);
		Invoibc0._hideAccessCompany.get().destruct();
	}
}
