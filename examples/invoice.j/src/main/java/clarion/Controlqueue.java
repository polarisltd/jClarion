package clarion;

import clarion.Positiongroup;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;

public class Controlqueue extends ClarionQueue
{
	public ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber type=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
	public ClarionNumber hasChildren=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber positionalStrategy=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber resizeStrategy=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public Positiongroup pos=new Positiongroup();
	public ClarionNumber parentID=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);

	public Controlqueue()
	{
		this.addVariable("ID",this.id);
		this.addVariable("Type",this.type);
		this.addVariable("HasChildren",this.hasChildren);
		this.addVariable("PositionalStrategy",this.positionalStrategy);
		this.addVariable("ResizeStrategy",this.resizeStrategy);
		this.addVariable("Pos",this.pos);
		this.addVariable("ParentID",this.parentID);
	}
}
