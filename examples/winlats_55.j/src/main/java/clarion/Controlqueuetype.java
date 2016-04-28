package clarion;

import clarion.Controlpostype;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;

@SuppressWarnings("all")
public class Controlqueuetype extends ClarionQueue
{
	public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber type=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
	public ClarionNumber positionalstrategy=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber resizestrategy=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public Controlpostype pos=new Controlpostype();

	public Controlqueuetype()
	{
		this.addVariable("ID",this.id);
		this.addVariable("Type",this.type);
		this.addVariable("PositionalStrategy",this.positionalstrategy);
		this.addVariable("ResizeStrategy",this.resizestrategy);
		this.addVariable("Pos",this.pos);
	}
}
