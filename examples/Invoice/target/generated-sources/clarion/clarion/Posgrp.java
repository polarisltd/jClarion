package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

public class Posgrp extends ClarionGroup
{
	public ClarionNumber top=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber left=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber bottom=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber right=Clarion.newNumber().setEncoding(ClarionNumber.LONG);

	public Posgrp()
	{
		this.addVariable("Top",this.top);
		this.addVariable("Left",this.left);
		this.addVariable("Bottom",this.bottom);
		this.addVariable("Right",this.right);
	}
}
