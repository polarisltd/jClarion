package clarion;

import clarion.Editentryclass;
import clarion.equates.Constants;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;

public class Qeditentryclass extends Editentryclass
{
	public Qeditentryclass()
	{
	}

	public void setAlerts()
	{
		super.setAlerts();
		Clarion.getControl(this.feq).setProperty(Prop.ALRT,7,Constants.MOUSERIGHT);
	}
}
