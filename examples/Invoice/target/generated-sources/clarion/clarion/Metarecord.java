package clarion;

import clarion.Brushindirect;
import clarion.Escapegrp;
import clarion.Longgrp;
import clarion.Penindirect;
import clarion.Shortgrp;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

public class Metarecord extends ClarionGroup
{
	public ClarionNumber size=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber funct=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionArray<ClarionNumber> params=Clarion.newNumber().setEncoding(ClarionNumber.USHORT).dim(1000);
	public Brushindirect brushIndirect=(Brushindirect)(new Brushindirect()).setOver(params);
	public Longgrp longGrp=(Longgrp)(new Longgrp()).setOver(params);
	public Shortgrp shortGrp=(Shortgrp)(new Shortgrp()).setOver(params);
	public Penindirect penIndirect=(Penindirect)(new Penindirect()).setOver(params);
	public Escapegrp escapeGrp=(Escapegrp)(new Escapegrp()).setOver(params);

	public Metarecord()
	{
		this.addVariable("Size",this.size);
		this.addVariable("Funct",this.funct);
		this.addVariable("Params",this.params);
		this.addVariable("BrushIndirect",this.brushIndirect);
		this.addVariable("LongGrp",this.longGrp);
		this.addVariable("ShortGrp",this.shortGrp);
		this.addVariable("PenIndirect",this.penIndirect);
		this.addVariable("EscapeGrp",this.escapeGrp);
	}
}
