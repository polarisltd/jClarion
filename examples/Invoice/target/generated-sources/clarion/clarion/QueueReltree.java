package clarion;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

public class QueueReltree extends ClarionQueue
{
	public ClarionString rEL1Display=Clarion.newString(200);
	public ClarionNumber rEL1NormalFG=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber rEL1NormalBG=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber rEL1SelectedFG=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber rEL1SelectedBG=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber rEL1Icon=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber rEL1Level=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber rEL1Loaded=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionString rEL1Position=Clarion.newString(1024);

	public QueueReltree()
	{
		this.addVariable("REL1::Display",this.rEL1Display);
		this.addVariable("REL1::NormalFG",this.rEL1NormalFG);
		this.addVariable("REL1::NormalBG",this.rEL1NormalBG);
		this.addVariable("REL1::SelectedFG",this.rEL1SelectedFG);
		this.addVariable("REL1::SelectedBG",this.rEL1SelectedBG);
		this.addVariable("REL1::Icon",this.rEL1Icon);
		this.addVariable("REL1::Level",this.rEL1Level);
		this.addVariable("REL1::Loaded",this.rEL1Loaded);
		this.addVariable("REL1::Position",this.rEL1Position);
	}
}
