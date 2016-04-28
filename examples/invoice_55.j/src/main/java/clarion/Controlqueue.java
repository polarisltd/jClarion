package clarion;

import clarion.Positiongroup;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;

@SuppressWarnings("all")
public class Controlqueue extends ClarionQueue
{
	public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber type=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
	public ClarionNumber haschildren=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber positionalstrategy=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber resizestrategy=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public Positiongroup pos=new Positiongroup();
	public ClarionNumber parentid=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);

	public Controlqueue()
	{
		this.addVariable("ID",this.id);
		this.addVariable("Type",this.type);
		this.addVariable("HasChildren",this.haschildren);
		this.addVariable("PositionalStrategy",this.positionalstrategy);
		this.addVariable("ResizeStrategy",this.resizestrategy);
		this.addVariable("Pos",this.pos);
		this.addVariable("ParentID",this.parentid);
	}
}
