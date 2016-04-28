package clarion;

import clarion.Pos_6;
import clarion.Prompt;
import clarion.Style_3;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

public class Checkformatgrp extends ClarionGroup
{
	public Pos_6 pos=new Pos_6();
	public Style_3 style=new Style_3();
	public Prompt prompt=new Prompt();
	public ClarionNumber checked=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);

	public Checkformatgrp()
	{
		this.addVariable("Pos",this.pos);
		this.addVariable("Style",this.style);
		this.addVariable("Prompt",this.prompt);
		this.addVariable("Checked",this.checked);
	}
}
