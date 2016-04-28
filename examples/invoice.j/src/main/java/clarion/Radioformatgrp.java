package clarion;

import clarion.Inner;
import clarion.Outer;
import clarion.Prompt_1;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

public class Radioformatgrp extends ClarionGroup
{
	public Prompt_1 prompt=new Prompt_1();
	public Outer outer=new Outer();
	public Inner inner=new Inner();
	public ClarionNumber checked=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);

	public Radioformatgrp()
	{
		this.addVariable("Prompt",this.prompt);
		this.addVariable("Outer",this.outer);
		this.addVariable("Inner",this.inner);
		this.addVariable("Checked",this.checked);
	}
}
