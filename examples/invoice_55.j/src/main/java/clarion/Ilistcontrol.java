package clarion;

import org.jclarion.clarion.ClarionNumber;

@SuppressWarnings("all")
public abstract class Ilistcontrol
{

	public abstract ClarionNumber choice();
	public abstract ClarionNumber getcontrol();
	public abstract ClarionNumber getitems();
	public abstract ClarionNumber getvisible();
	public abstract void setchoice(ClarionNumber newchoice);
	public abstract void setcontrol(ClarionNumber newcontrol);
}
