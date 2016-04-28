package clarion;

import clarion.Main;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.view.*;

public class BRW1ViewBrowse extends ClarionView
{

	public BRW1ViewBrowse()
	{
		setTable(Main.states);
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.states.stateCode}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.states.name}));
	}
}
