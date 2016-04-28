package clarion.winla002;

import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;

@SuppressWarnings("all")
public class Browsebuttons extends ClarionGroup
{
	public ClarionNumber listbox=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber insertbutton=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber changebutton=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber deletebutton=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber selectbutton=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);

	public Browsebuttons()
	{
		this.addVariable("ListBox",this.listbox);
		this.addVariable("InsertButton",this.insertbutton);
		this.addVariable("ChangeButton",this.changebutton);
		this.addVariable("DeleteButton",this.deletebutton);
		this.addVariable("SelectButton",this.selectbutton);
	}
}
