package clarion.abutil;

import clarion.abutil.equates.Mconstants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Translatorqueue extends ClarionQueue
{
	public ClarionString textprop=Clarion.newString(Mconstants.MAXTLEN).setEncoding(ClarionString.CSTRING);
	public ClarionString replacement=Clarion.newString(Mconstants.MAXTLEN).setEncoding(ClarionString.CSTRING);

	public Translatorqueue()
	{
		this.addVariable("TextProp",this.textprop);
		this.addVariable("Replacement",this.replacement);
	}
}
