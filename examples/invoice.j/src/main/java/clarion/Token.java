package clarion;

import clarion.equates.Constants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

public class Token extends ClarionGroup
{
	public ClarionNumber type=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString str=Clarion.newString(Constants.MAXATTRIBUTESIZE);

	public Token()
	{
		this.addVariable("Type",this.type);
		this.addVariable("Str",this.str);
	}
}
