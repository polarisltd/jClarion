package clarion;

import clarion.BRW1ViewBrowse;
import clarion.Brw1;
import clarion.Main;
import clarion.QueueBrowse_1;
import clarion.QuickWindow;
import clarion.Resizer;
import clarion.Steplocatorclass;
import clarion.Steplongclass;
import clarion.Stepstringclass;
import clarion.Thiswindow_1;
import clarion.Toolbarclass;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.view.ClarionView;

public class Tutor002
{

	public static void browseCUSTOMER()
	{
		ClarionString currentTab=Clarion.newString(80);
		ClarionView bRW1ViewBrowse=new BRW1ViewBrowse();
		QueueBrowse_1 queueBrowse_1=new QueueBrowse_1();
		QuickWindow quickWindow=new QuickWindow(queueBrowse_1);
		Toolbarclass toolbar=new Toolbarclass();
		Brw1 brw1=new Brw1(quickWindow);
		Steplocatorclass bRW1Sort0Locator=new Steplocatorclass();
		Steplocatorclass bRW1Sort1Locator=new Steplocatorclass();
		Steplocatorclass bRW1Sort2Locator=new Steplocatorclass();
		Steplongclass bRW1Sort0StepClass=new Steplongclass();
		Stepstringclass bRW1Sort1StepClass=new Stepstringclass();
		Steplongclass bRW1Sort2StepClass=new Steplongclass();
		Resizer resizer=new Resizer();
		Thiswindow_1 thisWindow=new Thiswindow_1(quickWindow,toolbar,brw1,queueBrowse_1,bRW1ViewBrowse,bRW1Sort1StepClass,bRW1Sort1Locator,bRW1Sort2StepClass,bRW1Sort2Locator,bRW1Sort0StepClass,bRW1Sort0Locator,resizer);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			quickWindow.close();
			brw1.destruct();
			bRW1Sort0Locator.destruct();
			bRW1Sort1Locator.destruct();
			bRW1Sort2Locator.destruct();
		}
	}
	public static void browseCUSTOMER_DefineListboxStyle()
	{
	}
}
