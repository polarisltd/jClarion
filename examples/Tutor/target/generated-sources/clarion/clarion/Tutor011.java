package clarion;

import clarion.BRW2ViewBrowse;
import clarion.Brw2;
import clarion.Customer;
import clarion.Fieldcolorqueue;
import clarion.Main;
import clarion.QueueBrowse_2;
import clarion.QuickWindow_1;
import clarion.Resizer_1;
import clarion.Steplongclass;
import clarion.Thiswindow_2;
import clarion.Toolbarclass;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.view.ClarionView;

public class Tutor011
{

	public static void updateCUSTOMER()
	{
		ClarionString currentTab=Clarion.newString(80);
		ClarionString actionMessage=Clarion.newString(40).setEncoding(ClarionString.CSTRING);
		ClarionView bRW2ViewBrowse=new BRW2ViewBrowse();
		QueueBrowse_2 queueBrowse_2=new QueueBrowse_2();
		Customer historyCUSRecord=(Customer)(new Customer()).getThread();
		QuickWindow_1 quickWindow=new QuickWindow_1(queueBrowse_2);
		Toolbarclass toolbar=new Toolbarclass();
		Brw2 brw2=new Brw2(quickWindow);
		Steplongclass bRW2Sort0StepClass=new Steplongclass();
		Resizer_1 resizer=new Resizer_1();
		Fieldcolorqueue fieldColorQueue=new Fieldcolorqueue();
		ClarionNumber curCtrlFeq=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		Thiswindow_2 thisWindow=new Thiswindow_2();
		thisWindow.__Init__(actionMessage,quickWindow,toolbar,historyCUSRecord,brw2,queueBrowse_2,bRW2ViewBrowse,bRW2Sort0StepClass,resizer,thisWindow,fieldColorQueue);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			quickWindow.close();
			brw2.destruct();
		}
	}
	public static void updateCUSTOMER_DefineListboxStyle()
	{
	}
}
