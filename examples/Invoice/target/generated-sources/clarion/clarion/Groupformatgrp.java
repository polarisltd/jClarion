package clarion;

import clarion.Header;
import clarion.Pos_7;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

public class Groupformatgrp extends ClarionGroup
{
	public Pos_7 pos=new Pos_7();
	public Header header=new Header();
	public ClarionNumber x1=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber x2=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber lineColor=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber lineWidth=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber lineStyle=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);

	public Groupformatgrp()
	{
		this.addVariable("Pos",this.pos);
		this.addVariable("header",this.header);
		this.addVariable("X1",this.x1);
		this.addVariable("X2",this.x2);
		this.addVariable("LineColor",this.lineColor);
		this.addVariable("LineWidth",this.lineWidth);
		this.addVariable("LineStyle",this.lineStyle);
	}
}
