package clarion.abquery;

import clarion.abeip.Editentryclass;
import clarion.equates.Constants;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;

@SuppressWarnings("all")
public class Qeditentryclass_3 extends Editentryclass
{
	public Qeditentryclass_3()
	{
	}

	public void setalerts()
	{
		super.setalerts();
		Clarion.getControl(this.feq).setProperty(Prop.ALRT,7,Constants.MOUSERIGHT);
	}
}
