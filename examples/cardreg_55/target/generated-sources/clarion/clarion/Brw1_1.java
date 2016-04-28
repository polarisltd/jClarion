package clarion;

import clarion.Browseclass;
import clarion.Main;
import clarion.QueueBrowse_1_1;
import clarion.QuickWindow_3;
import clarion.Relationmanager;
import clarion.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Cursor;
import clarion.equates.Level;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionReal;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.view.ClarionView;

public class Brw1_1 extends Browseclass
{
	public QueueBrowse_1_1 q;
	QuickWindow_3 quickWindow;
	ClarionDecimal lOCTotalOpenTransactions;
	ClarionDecimal lOCAvgTran;
	public Brw1_1(QuickWindow_3 quickWindow,ClarionDecimal lOCTotalOpenTransactions,ClarionDecimal lOCAvgTran)
	{
		this.quickWindow=quickWindow;
		this.lOCTotalOpenTransactions=lOCTotalOpenTransactions;
		this.lOCAvgTran=lOCAvgTran;
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
	public void resetFromView()
	{
		ClarionReal lOCTotalOpenTransactionsSum=Clarion.newReal();
		ClarionNumber lOCAvgTranCnt=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionReal lOCAvgTranSum=Clarion.newReal();
		CWin.setCursor(Cursor.WAIT);
		Main.relateTransactions.setQuickScan(Clarion.newNumber(1));
		this.reset();
		while (true) {
			{
				ClarionNumber case_1=this.next();
				boolean case_1_break=false;
				if (case_1.equals(Level.NOTIFY)) {
					break;
					// UNREACHABLE! :case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Level.FATAL)) {
					return;
					// UNREACHABLE! :case_1_break=true;
				}
			}
			this.setQueueRecord();
			lOCTotalOpenTransactionsSum.increment(Main.transactions.transactionAmount);
			if (!Main.transactions.transactionType.equals("P")) {
				lOCAvgTranCnt.increment(1);
				lOCAvgTranSum.increment(Main.transactions.transactionAmount);
			}
		}
		lOCTotalOpenTransactions.setValue(lOCTotalOpenTransactionsSum);
		lOCAvgTran.setValue(lOCAvgTranSum.divide(lOCAvgTranCnt));
		super.resetFromView();
		Main.relateTransactions.setQuickScan(Clarion.newNumber(0));
		CWin.setCursor(null);
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
