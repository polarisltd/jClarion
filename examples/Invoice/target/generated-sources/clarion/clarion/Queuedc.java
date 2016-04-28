package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;

public class Queuedc extends ClarionQueue
{
	public ClarionNumber currentBrush=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber currentFont=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber currentPen=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber bKColor=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber bKMode=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber textAlign=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber textColor=Clarion.newNumber().setEncoding(ClarionNumber.LONG);

	public Queuedc()
	{
		this.addVariable("CurrentBrush",this.currentBrush);
		this.addVariable("CurrentFont",this.currentFont);
		this.addVariable("CurrentPen",this.currentPen);
		this.addVariable("BKColor",this.bKColor);
		this.addVariable("BKMode",this.bKMode);
		this.addVariable("TextAlign",this.textAlign);
		this.addVariable("TextColor",this.textColor);
	}
}
