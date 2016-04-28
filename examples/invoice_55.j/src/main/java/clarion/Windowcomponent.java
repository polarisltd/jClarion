package clarion;

import org.jclarion.clarion.ClarionNumber;

@SuppressWarnings("all")
public abstract class Windowcomponent
{

	public abstract void kill();
	public abstract void reset(ClarionNumber force);
	public abstract ClarionNumber resetrequired();
	public abstract void setalerts();
	public abstract ClarionNumber takeevent();
	public abstract void update();
	public abstract void updatewindow();
}
