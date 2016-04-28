package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.ref.RefVariable;

@SuppressWarnings("all")
public class Errorentry extends ClarionQueue
{
	public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public RefVariable<ClarionString> message=new RefVariable<ClarionString>(null);
	public RefVariable<ClarionString> title=new RefVariable<ClarionString>(null);
	public ClarionNumber fatality=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString category=Clarion.newString().setEncoding(ClarionString.ASTRING);

	public Errorentry()
	{
		this.addVariable("Id",this.id);
		this.addVariable("Message",this.message);
		this.addVariable("Title",this.title);
		this.addVariable("Fatality",this.fatality);
		this.addVariable("Category",this.category);
	}
}
