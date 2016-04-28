package clarion;

import clarion.Browseclass;
import clarion.Main;
import clarion.QueueBrowse_1;
import clarion.QuickWindow_1;
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

public class Brw1 extends Browseclass
{
	public QueueBrowse_1 q;
	QuickWindow_1 quickWindow;
	ClarionDecimal lOCTotalOutstandingDebt;
	ClarionString lOCCityStateZip;
	ClarionString lOCOrdinalExtension;
	public Brw1(QuickWindow_1 quickWindow,ClarionDecimal lOCTotalOutstandingDebt,ClarionString lOCCityStateZip,ClarionString lOCOrdinalExtension)
	{
		this.quickWindow=quickWindow;
		this.lOCTotalOutstandingDebt=lOCTotalOutstandingDebt;
		this.lOCCityStateZip=lOCCityStateZip;
		this.lOCOrdinalExtension=lOCOrdinalExtension;
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
		ClarionReal lOCTotalOutstandingDebtSum=Clarion.newReal();
		CWin.setCursor(Cursor.WAIT);
		Main.relateAccounts.setQuickScan(Clarion.newNumber(1));
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
			lOCTotalOutstandingDebtSum.increment(Main.accounts.accountBalance);
		}
		lOCTotalOutstandingDebt.setValue(lOCTotalOutstandingDebtSum);
		super.resetFromView();
		Main.relateAccounts.setQuickScan(Clarion.newNumber(0));
		CWin.setCursor(null);
	}
	public void setQueueRecord()
	{
		lOCCityStateZip.setValue(Main.accounts.vendorCity.clip().concat(", ",Main.accounts.vendorState," ",Main.accounts.vendorZip));
		{
			ClarionString case_1=Main.accounts.cardType;
			boolean case_1_break=false;
			if (case_1.equals("M")) {
				Main.gLOCardTypeDescription.setValue("MASTER CARD");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals("V")) {
				Main.gLOCardTypeDescription.setValue("VISA CARD");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals("D")) {
				Main.gLOCardTypeDescription.setValue("DISCOVER CARD");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals("A")) {
				Main.gLOCardTypeDescription.setValue("AMERICAN EXPRESS");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals("S")) {
				Main.gLOCardTypeDescription.setValue("STORE CARD");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals("G")) {
				Main.gLOCardTypeDescription.setValue("GASOLINE CARD");
				case_1_break=true;
			}
			if (!case_1_break) {
				Main.gLOCardTypeDescription.setValue("CHARGE CARD");
			}
		}
		{
			ClarionNumber case_2=Main.accounts.billingDay;
			boolean case_2_break=false;
			if (case_2.equals(1)) {
				lOCOrdinalExtension.setValue("st");
				case_2_break=true;
			}
			if (!case_2_break && case_2.equals(2)) {
				lOCOrdinalExtension.setValue("nd");
				case_2_break=true;
			}
			if (!case_2_break && case_2.equals(3)) {
				lOCOrdinalExtension.setValue("rd");
				case_2_break=true;
			}
			if (!case_2_break && case_2.equals(21)) {
				lOCOrdinalExtension.setValue("st");
				case_2_break=true;
			}
			if (!case_2_break && case_2.equals(22)) {
				lOCOrdinalExtension.setValue("nd");
				case_2_break=true;
			}
			if (!case_2_break && case_2.equals(23)) {
				lOCOrdinalExtension.setValue("rd");
				case_2_break=true;
			}
			if (!case_2_break) {
				lOCOrdinalExtension.setValue("th");
			}
		}
		super.setQueueRecord();
		this.q.lOCCityStateZip.setValue(lOCCityStateZip);
		this.q.lOCOrdinalExtension.setValue(lOCOrdinalExtension);
	}
}
