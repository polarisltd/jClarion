package clarion;

import clarion.BRW1ViewBrowse_1;
import clarion.Brw1_1;
import clarion.Main;
import clarion.QueueBrowse_1_1;
import clarion.QuickWindow_2;
import clarion.Resizer_2;
import clarion.Steplocatorclass;
import clarion.Stepstringclass;
import clarion.Thiswindow_3;
import clarion.Toolbarclass;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.view.ClarionView;

public class Tutor015
{

	public static void selectStates()
	{
		ClarionString currentTab=Clarion.newString(80);
		ClarionView bRW1ViewBrowse=new BRW1ViewBrowse_1();
		QueueBrowse_1_1 queueBrowse_1=new QueueBrowse_1_1();
		QuickWindow_2 quickWindow=new QuickWindow_2(queueBrowse_1);
		Toolbarclass toolbar=new Toolbarclass();
		Brw1_1 brw1=new Brw1_1(quickWindow);
		Steplocatorclass bRW1Sort0Locator=new Steplocatorclass();
		Stepstringclass bRW1Sort0StepClass=new Stepstringclass();
		Resizer_2 resizer=new Resizer_2();
		Thiswindow_3 thisWindow=new Thiswindow_3(quickWindow,toolbar,brw1,queueBrowse_1,bRW1ViewBrowse,bRW1Sort0StepClass,bRW1Sort0Locator,resizer);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			quickWindow.close();
			brw1.destruct();
			bRW1Sort0Locator.destruct();
		}
	}
	public static void selectStates_DefineListboxStyle()
	{
	}
}
