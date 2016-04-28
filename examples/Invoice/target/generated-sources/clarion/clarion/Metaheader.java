package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

public class Metaheader extends ClarionGroup
{
	public ClarionNumber type=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber headerSize=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber version=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber size=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber noObjects=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber maxRecord=Clarion.newNumber().setEncoding(ClarionNumber.ULONG);
	public ClarionNumber noParameters=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);

	public Metaheader()
	{
		this.addVariable("Type",this.type);
		this.addVariable("HeaderSize",this.headerSize);
		this.addVariable("Version",this.version);
		this.addVariable("Size",this.size);
		this.addVariable("NoObjects",this.noObjects);
		this.addVariable("MaxRecord",this.maxRecord);
		this.addVariable("NoParameters",this.noParameters);
	}
}
