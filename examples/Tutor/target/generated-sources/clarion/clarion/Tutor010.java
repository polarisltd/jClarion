package clarion;

import clarion.Main;
import clarion.equates.Constants;
import clarion.equates.Msg;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.runtime.CWin;

public class Tutor010
{

	public static void reportStatesBySTAKeyState()
	{
		Main.globalErrors.throwMessage(Clarion.newNumber(Msg.PROCEDURETODO),Clarion.newString("ReportStatesBySTA:KeyState"));
		CWin.setKeyCode(0);
		Main.globalResponse.setValue(Constants.REQUESTCANCELLED);
	}
}
