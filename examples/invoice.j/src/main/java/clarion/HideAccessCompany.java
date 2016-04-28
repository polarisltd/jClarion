package clarion;

import clarion.Filemanager;
import clarion.Main;

public class HideAccessCompany extends Filemanager
{
	public HideAccessCompany()
	{
	}

	public void init()
	{
		this.init(Main.company,Main.globalErrors);
		this.fileNameValue.setValue("Company");
		this.buffer=Main.company;
		this.create.setValue(1);
		this.lockRecover.setValue(10);
		Main.accessCompany.set(this);
	}
	public void kill()
	{
		super.kill();
		Main.accessCompany.set(null);
	}
}
