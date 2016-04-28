package clarion.invoibc0;

import clarion.Main;
import clarion.abfile.Filemanager;

@SuppressWarnings("all")
public class HideAccessCompany extends Filemanager
{
	public HideAccessCompany()
	{
	}

	public void init()
	{
		this.init(Main.company,Main.globalerrors);
		this.filenamevalue.setValue("Company");
		this.buffer=Main.company;
		this.create.setValue(1);
		this.lockrecover.setValue(10);
		Main.accessCompany=this;
	}
	public void kill()
	{
		super.kill();
		Main.accessCompany=null;
	}
}
