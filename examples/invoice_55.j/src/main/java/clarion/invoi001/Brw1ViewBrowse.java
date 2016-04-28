package clarion.invoi001;

import clarion.Main;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.view.*;

@SuppressWarnings("all")
public class Brw1ViewBrowse extends ClarionView
{

	public Brw1ViewBrowse()
	{
		setTable(Main.states);
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.states.statecode}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.states.name}));
	}
}
