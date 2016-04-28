package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionBool;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

@SuppressWarnings("all")
public class Security_attributes extends ClarionGroup
{
	public ClarionNumber nlength=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber lpsecuritydescriptor=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionBool binherithandle=Clarion.newBool();

	public Security_attributes()
	{
		this.addVariable("nLength",this.nlength);
		this.addVariable("lpSecurityDescriptor",this.lpsecuritydescriptor);
		this.addVariable("bInheritHandle",this.binherithandle);
	}
}
