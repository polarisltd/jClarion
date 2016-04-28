package clarion;

import clarion.Pos_5;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

public class Stringformatgrp extends ClarionGroup
{
	public Pos_5 pos=new Pos_5();
	public ClarionNumber topText=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber leftText=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber backgroundColor=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber color=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString face=Clarion.newString(32).setEncoding(ClarionString.CSTRING);
	public ClarionNumber size=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber style=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber angle=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);

	public Stringformatgrp()
	{
		this.addVariable("Pos",this.pos);
		this.addVariable("topText",this.topText);
		this.addVariable("leftText",this.leftText);
		this.addVariable("BackgroundColor",this.backgroundColor);
		this.addVariable("Color",this.color);
		this.addVariable("Face",this.face);
		this.addVariable("Size",this.size);
		this.addVariable("Style",this.style);
		this.addVariable("Angle",this.angle);
	}
}
