package clarion;

import clarion.Browseclass;
import clarion.Main;
import clarion.QueueBrowse_1_3;
import clarion.QuickWindow_8;
import clarion.Relationmanager;
import clarion.Windowmanager;
import clarion.equates.Constants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.view.ClarionView;

public class Brw1_2 extends Browseclass
{
	public QueueBrowse_1_3 q;
	QuickWindow_8 quickWindow;
	public Brw1_2(QuickWindow_8 quickWindow)
	{
		this.quickWindow=quickWindow;
		q=null;
	}

	public void fetch(ClarionNumber direction)
	{
		ClarionNumber greenBarIndex=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		super.fetch(direction.like());
	}
	public void init(ClarionNumber listBox,ClarionString posit,ClarionView v,ClarionQueue q,Relationmanager rm,Windowmanager wm)
	{
		super.init(listBox.like(),posit,v,q,rm,wm);
		this.selectControl.setValue(quickWindow._select_2);
		this.hideSelect.setValue(1);
		if (!wm.request.equals(Constants.VIEWRECORD)) {
			this.insertControl.setValue(quickWindow._insert_3);
			this.changeControl.setValue(quickWindow._change_3);
			this.deleteControl.setValue(quickWindow._delete_3);
		}
		this.toolControl.setValue(quickWindow._toolbox);
	}
	public ClarionNumber resetSort(ClarionNumber force)
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (CWin.choice(quickWindow._currentTab)==2) {
			return this.setSort(Clarion.newNumber(1),force.like());
		}
		else if (CWin.choice(quickWindow._currentTab)==3) {
			return this.setSort(Clarion.newNumber(2),force.like());
		}
		else if (CWin.choice(quickWindow._currentTab)==4) {
			return this.setSort(Clarion.newNumber(3),force.like());
		}
		else {
			return this.setSort(Clarion.newNumber(4),force.like());
		}
		// UNREACHABLE! :returnValue.setValue(super.resetSort(force.like()));
		// UNREACHABLE! :return returnValue.like();
	}
	public void setQueueRecord()
	{
		Main.gLOTCusCSZ.setValue(Main.customers.city.clip().concat(",  ",Main.customers.state,"   ",Main.customers.zipCode.clip()));
		super.setQueueRecord();
	}
}
