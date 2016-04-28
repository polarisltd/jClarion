package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

public class Longgrp extends ClarionGroup
{
	public ClarionNumber param1=Clarion.newNumber().setEncoding(ClarionNumber.LONG);

	public Longgrp()
	{
		this.addVariable("Param1",this.param1);
	}
}
