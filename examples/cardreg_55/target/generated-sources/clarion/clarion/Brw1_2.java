package clarion;

import clarion.Browseclass;
import clarion.Main;
import clarion.QueueBrowse_1_2;
import clarion.QuickWindow_4;
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
	public QueueBrowse_1_2 q;
	QuickWindow_4 quickWindow;
	public Brw1_2(QuickWindow_4 quickWindow)
	{
		this.quickWindow=quickWindow;
		q=null;
	}

	public void init(ClarionNumber listBox,ClarionString posit,ClarionView v,ClarionQueue q,Relationmanager rm,Windowmanager wm)
	{
		super.init(listBox.like(),posit,v,q,rm,wm);
		if (!wm.request.equals(Constants.VIEWRECORD)) {
			this.insertControl.setValue(quickWindow._insert_2);
			this.changeControl.setValue(quickWindow._change_2);
			this.deleteControl.setValue(quickWindow._delete_2);
		}
	}
	public ClarionNumber resetSort(ClarionNumber force)
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (CWin.choice(quickWindow._currentTab)==2) {
			return this.setSort(Clarion.newNumber(1),force.like());
		}
		else {
			return this.setSort(Clarion.newNumber(2),force.like());
		}
		// UNREACHABLE! :returnValue.setValue(super.resetSort(force.like()));
		// UNREACHABLE! :return returnValue.like();
	}
	public void setQueueRecord()
	{
		{
			ClarionString case_1=Main.transactions.transactionType;
			boolean case_1_break=false;
			if (case_1.equals("P")) {
				Main.gLOTransactionTypeDescription.setValue("Pmt/Credit");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals("C")) {
				Main.gLOTransactionTypeDescription.setValue("Charge");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals("F")) {
				Main.gLOTransactionTypeDescription.setValue("Fee");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals("I")) {
				Main.gLOTransactionTypeDescription.setValue("Interest");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals("B")) {
				Main.gLOTransactionTypeDescription.setValue("Balance");
				case_1_break=true;
			}
			if (!case_1_break) {
				Main.gLOTransactionTypeDescription.setValue("Advance");
			}
		}
		super.setQueueRecord();
		if (Main.transactions.transactionAmount.compareTo(0)<0) {
			this.q.tRATransactionAmount_NormalFG.setValue(255);
			this.q.tRATransactionAmount_NormalBG.setValue(-1);
			this.q.tRATransactionAmount_SelectedFG.setValue(-1);
			this.q.tRATransactionAmount_SelectedBG.setValue(-1);
		}
		else {
			this.q.tRATransactionAmount_NormalFG.setValue(-1);
			this.q.tRATransactionAmount_NormalBG.setValue(-1);
			this.q.tRATransactionAmount_SelectedFG.setValue(-1);
			this.q.tRATransactionAmount_SelectedBG.setValue(-1);
		}
	}
}
