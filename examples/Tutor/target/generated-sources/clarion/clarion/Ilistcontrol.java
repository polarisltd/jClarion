package clarion;

import org.jclarion.clarion.ClarionNumber;

public abstract class Ilistcontrol
{

	public abstract ClarionNumber choice();
	public abstract ClarionNumber getControl();
	public abstract ClarionNumber getItems();
	public abstract ClarionNumber getVisible();
	public abstract void setChoice(ClarionNumber newChoice);
	public abstract void setControl(ClarionNumber newControl);
}
