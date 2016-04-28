package clarion;

import org.jclarion.clarion.ClarionNumber;

public abstract class Windowcomponent
{

	public abstract void kill();
	public abstract void reset(ClarionNumber force);
	public abstract ClarionNumber resetRequired();
	public abstract void setAlerts();
	public abstract ClarionNumber takeEvent();
	public abstract void update();
	public abstract void updateWindow();
}
