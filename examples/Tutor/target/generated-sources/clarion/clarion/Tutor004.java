package clarion;

import clarion.Main;
import clarion.equates.Constants;
import clarion.equates.Msg;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.runtime.CWin;

public class Tutor004
{

	public static void reportCUSTOMERByCUSKEYCOMPANY()
	{
		Main.globalErrors.throwMessage(Clarion.newNumber(Msg.PROCEDURETODO),Clarion.newString("ReportCUSTOMERByCUS:KEYCOMPANY"));
		CWin.setKeyCode(0);
		Main.globalResponse.setValue(Constants.REQUESTCANCELLED);
	}
}
