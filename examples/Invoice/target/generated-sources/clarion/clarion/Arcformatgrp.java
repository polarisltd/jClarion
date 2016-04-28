package clarion;

import clarion.Pos_4;
import clarion.Style_2;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

public class Arcformatgrp extends ClarionGroup
{
	public Pos_4 pos=new Pos_4();
	public Style_2 style=new Style_2();
	public ClarionNumber startX=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber startY=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber endX=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber endY=Clarion.newNumber().setEncoding(ClarionNumber.LONG);

	public Arcformatgrp()
	{
		this.addVariable("Pos",this.pos);
		this.addVariable("Style",this.style);
		this.addVariable("StartX",this.startX);
		this.addVariable("StartY",this.startY);
		this.addVariable("EndX",this.endX);
		this.addVariable("EndY",this.endY);
	}
}
