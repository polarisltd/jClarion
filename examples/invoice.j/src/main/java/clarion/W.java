package clarion;

import clarion.equates.Font;
import org.jclarion.clarion.ClarionWindow;

public class W extends ClarionWindow
{
	public W()
	{
		this.setFont("MS Sans Serif",8,null,Font.REGULAR,null).setCenter().setSystem().setToolbox().setTimer(50);
		this.setId("popupclass.asktoolbox.w");
	}
}
