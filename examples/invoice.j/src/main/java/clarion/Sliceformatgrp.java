package clarion;

import clarion.Style_4;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

public class Sliceformatgrp extends ClarionGroup
{
	public Style_4 style=new Style_4();
	public ClarionNumber startX=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber startY=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber endX=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber endY=Clarion.newNumber().setEncoding(ClarionNumber.LONG);

	public Sliceformatgrp()
	{
		this.addVariable("Style",this.style);
		this.addVariable("StartX",this.startX);
		this.addVariable("StartY",this.startY);
		this.addVariable("EndX",this.endX);
		this.addVariable("EndY",this.endY);
	}
}
