package clarion.winla002;

import clarion.Main;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.view.*;

@SuppressWarnings("all")
public class Brw1ViewBrowse extends ClarionView
{

	public Brw1ViewBrowse()
	{
		setTable(Main.bankas_k);
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.bankas_k.kods}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.bankas_k.nos_s}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.bankas_k.nos_p}));
		this.add((new ViewProject()).setFields(new ClarionObject[] {Main.bankas_k.nos_a}));
	}
}
