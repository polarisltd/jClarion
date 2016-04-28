package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

public class Metafileheader extends ClarionGroup
{
	public ClarionNumber key=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber hmf=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber bboxLeft=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber bboxTop=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber bboxRight=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber bboxBottom=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber inch=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber reserved=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber checksum=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);

	public Metafileheader()
	{
		this.addVariable("key",this.key);
		this.addVariable("hmf",this.hmf);
		this.addVariable("bbox:left",this.bboxLeft);
		this.addVariable("bbox:top",this.bboxTop);
		this.addVariable("bbox:right",this.bboxRight);
		this.addVariable("bbox:bottom",this.bboxBottom);
		this.addVariable("inch",this.inch);
		this.addVariable("reserved",this.reserved);
		this.addVariable("checksum",this.checksum);
	}
}
