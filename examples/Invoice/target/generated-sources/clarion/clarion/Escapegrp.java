package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

public class Escapegrp extends ClarionGroup
{
	public ClarionNumber p1=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber p2=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber magic=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber type=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionString ctlName=Clarion.newString(20).setEncoding(ClarionString.CSTRING);
	public ClarionNumber sLen=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber isSplit=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);

	public Escapegrp()
	{
		this.addVariable("P1",this.p1);
		this.addVariable("P2",this.p2);
		this.addVariable("Magic",this.magic);
		this.addVariable("Type",this.type);
		this.addVariable("CtlName",this.ctlName);
		this.addVariable("slen",this.sLen);
		this.addVariable("isSplit",this.isSplit);
	}
}
