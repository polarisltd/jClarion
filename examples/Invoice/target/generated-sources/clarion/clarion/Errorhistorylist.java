package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class Errorhistorylist extends ClarionQueue
{
	public ClarionString category=Clarion.newString().setEncoding(ClarionString.ASTRING);
	public ClarionString txt=Clarion.newString(1024).setEncoding(ClarionString.CSTRING);
	public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);

	public Errorhistorylist()
	{
		this.addVariable("Category",this.category);
		this.addVariable("Txt",this.txt);
		this.addVariable("Id",this.id);
	}
}
