package clarion.invoi001;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class QueueReltree extends ClarionQueue
{
	public ClarionString rel1Display=Clarion.newString(200);
	public ClarionNumber rel1Normalfg=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber rel1Normalbg=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber rel1Selectedfg=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber rel1Selectedbg=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber rel1Icon=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber rel1Level=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber rel1Loaded=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionString rel1Position=Clarion.newString(1024);

	public QueueReltree()
	{
		this.addVariable("REL1::Display",this.rel1Display);
		this.addVariable("REL1::NormalFG",this.rel1Normalfg);
		this.addVariable("REL1::NormalBG",this.rel1Normalbg);
		this.addVariable("REL1::SelectedFG",this.rel1Selectedfg);
		this.addVariable("REL1::SelectedBG",this.rel1Selectedbg);
		this.addVariable("REL1::Icon",this.rel1Icon);
		this.addVariable("REL1::Level",this.rel1Level);
		this.addVariable("REL1::Loaded",this.rel1Loaded);
		this.addVariable("REL1::Position",this.rel1Position);
		this.setPrefix("");
	}
}
