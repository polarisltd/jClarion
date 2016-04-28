package clarion.winla_sf;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Cs_group extends ClarionGroup
{
	public ClarionString overridecharacters=Clarion.newString("`!\"$%^&*()'-=_+][#;~@:/.,?\\| ");
	public ClarionString numericcharacters=Clarion.newString("0123456789");
	public ClarionString sortcharacters=Clarion.newString(255);
	public ClarionNumber sortcharactercount=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString stringroot=Clarion.newString(255);
	public ClarionNumber stringrootlen=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber stepvalue=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber currentstep=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber lowvalue=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber highvalue=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString lowstring=Clarion.newString(4);
	public ClarionString highstring=Clarion.newString(4);

	public Cs_group()
	{
		this.addVariable("OverrideCharacters",this.overridecharacters);
		this.addVariable("NumericCharacters",this.numericcharacters);
		this.addVariable("SortCharacters",this.sortcharacters);
		this.addVariable("SortCharacterCount",this.sortcharactercount);
		this.addVariable("StringRoot",this.stringroot);
		this.addVariable("StringRootLen",this.stringrootlen);
		this.addVariable("StepValue",this.stepvalue);
		this.addVariable("CurrentStep",this.currentstep);
		this.addVariable("LowValue",this.lowvalue);
		this.addVariable("HighValue",this.highvalue);
		this.addVariable("LowString",this.lowstring);
		this.addVariable("HighString",this.highstring);
		this.setPrefix("CS_");
	}
}
