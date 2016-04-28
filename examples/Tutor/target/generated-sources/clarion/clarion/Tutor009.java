package clarion;

import clarion.Main;
import clarion.equates.Constants;
import clarion.equates.Msg;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.runtime.CWin;

public class Tutor009
{

	public static void browseStates()
	{
		Main.globalErrors.throwMessage(Clarion.newNumber(Msg.PROCEDURETODO),Clarion.newString("BrowseStates"));
		CWin.setKeyCode(0);
		Main.globalResponse.setValue(Constants.REQUESTCANCELLED);
	}
}
