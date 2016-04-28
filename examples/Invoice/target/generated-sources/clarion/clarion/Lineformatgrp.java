package clarion;

import clarion.Pos_1;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

public class Lineformatgrp extends ClarionGroup
{
	public Pos_1 pos=new Pos_1();
	public ClarionNumber color=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber width=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber style=Clarion.newNumber().setEncoding(ClarionNumber.LONG);

	public Lineformatgrp()
	{
		this.addVariable("Pos",this.pos);
		this.addVariable("Color",this.color);
		this.addVariable("Width",this.width);
		this.addVariable("Style",this.style);
	}
}
