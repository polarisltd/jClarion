package clarion;

import clarion.equates.Constants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class Translatorqueue extends ClarionQueue
{
	public ClarionString textProp=Clarion.newString(Constants.MAXTLEN).setEncoding(ClarionString.CSTRING);
	public ClarionString replacement=Clarion.newString(Constants.MAXTLEN).setEncoding(ClarionString.CSTRING);

	public Translatorqueue()
	{
		this.addVariable("TextProp",this.textProp);
		this.addVariable("Replacement",this.replacement);
	}
}
