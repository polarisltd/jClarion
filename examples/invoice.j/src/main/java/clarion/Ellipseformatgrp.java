package clarion;

import clarion.Pos_3;
import clarion.Style_1;
import org.jclarion.clarion.ClarionGroup;

public class Ellipseformatgrp extends ClarionGroup
{
	public Pos_3 pos=new Pos_3();
	public Style_1 style=new Style_1();

	public Ellipseformatgrp()
	{
		this.addVariable("Pos",this.pos);
		this.addVariable("Style",this.style);
	}
}
