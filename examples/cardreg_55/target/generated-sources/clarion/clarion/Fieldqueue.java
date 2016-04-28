package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.ref.RefVariable;

public class Fieldqueue extends ClarionQueue
{
	public ClarionString name=Clarion.newString(100).setEncoding(ClarionString.CSTRING);
	public ClarionString title=Clarion.newString(100).setEncoding(ClarionString.CSTRING);
	public ClarionString picture=Clarion.newString(40).setEncoding(ClarionString.CSTRING);
	public ClarionString queryString=Clarion.newString(1500).setEncoding(ClarionString.CSTRING);
	public RefVariable<ClarionString> low=new RefVariable<ClarionString>(null);
	public RefVariable<ClarionString> middle=new RefVariable<ClarionString>(null);
	public RefVariable<ClarionString> high=new RefVariable<ClarionString>(null);
	public ClarionNumber forceEditPicture=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);

	public Fieldqueue()
	{
		this.addVariable("Name",this.name);
		this.addVariable("Title",this.title);
		this.addVariable("Picture",this.picture);
		this.addVariable("QueryString",this.queryString);
		this.addVariable("Low",this.low);
		this.addVariable("Middle",this.middle);
		this.addVariable("High",this.high);
		this.addVariable("ForceEditPicture",this.forceEditPicture);
	}
}
