package clarion;

import clarion.Pos;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

public class Imageformatgrp extends ClarionGroup
{
	public Pos pos=new Pos();
	public ClarionNumber stretchMode=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);

	public Imageformatgrp()
	{
		this.addVariable("Pos",this.pos);
		this.addVariable("StretchMode",this.stretchMode);
	}
}
