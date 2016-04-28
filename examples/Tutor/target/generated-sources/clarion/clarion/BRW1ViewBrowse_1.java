package clarion;

import clarion.Main;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.view.*;

public class BRW1ViewBrowse_1 extends ClarionView
{

	public BRW1ViewBrowse_1()
	{
		setTable(Main.states);
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.states.state}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.states.stateName}));
	}
}
