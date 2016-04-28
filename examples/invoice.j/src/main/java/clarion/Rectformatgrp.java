package clarion;

import clarion.Pos_2;
import clarion.Style;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

public class Rectformatgrp extends ClarionGroup
{
	public Pos_2 pos=new Pos_2();
	public Style style=new Style();
	public ClarionNumber ell_width=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber ell_height=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);

	public Rectformatgrp()
	{
		this.addVariable("Pos",this.pos);
		this.addVariable("Style",this.style);
		this.addVariable("Ell_width",this.ell_width);
		this.addVariable("Ell_height",this.ell_height);
	}
}
