package clarion.winla001;

import clarion.Main;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.view.*;

@SuppressWarnings("all")
public class Brw1ViewBrowse extends ClarionView
{

	public Brw1ViewBrowse()
	{
		setTable(Main.nodalas);
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.nodalas.u_nr}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.nodalas.svars}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.nodalas.kods}));
	}
}
