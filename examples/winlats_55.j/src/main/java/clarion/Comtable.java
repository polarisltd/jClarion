package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Comtable extends ClarionQueue
{
	public ClarionString comtext=Clarion.newString(130);
	public ClarionNumber len=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber in=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);

	public Comtable()
	{
		this.addVariable("comtext",this.comtext);
		this.addVariable("LEN",this.len);
		this.addVariable("IN",this.in);
		this.setPrefix("C");
	}
}
