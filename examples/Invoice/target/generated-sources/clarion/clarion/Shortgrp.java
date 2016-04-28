package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

public class Shortgrp extends ClarionGroup
{
	public ClarionNumber param1=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber param2=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber param3=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber param4=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber param5=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber param6=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber param7=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber param8=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);

	public Shortgrp()
	{
		this.addVariable("Param1",this.param1);
		this.addVariable("Param2",this.param2);
		this.addVariable("Param3",this.param3);
		this.addVariable("Param4",this.param4);
		this.addVariable("Param5",this.param5);
		this.addVariable("Param6",this.param6);
		this.addVariable("Param7",this.param7);
		this.addVariable("Param8",this.param8);
	}
}
