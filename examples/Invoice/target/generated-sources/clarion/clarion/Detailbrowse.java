package clarion;

import clarion.Browseclass;
import clarion.Main;
import clarion.QueueBrowse;
import clarion.QuickWindow_7;
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

public class Detailbrowse extends Browseclass
{
	public QueueBrowse q;
	QuickWindow_7 quickWindow;
	ClarionDecimal totalTax;
	ClarionDecimal totalDiscount;
	ClarionDecimal totalCost;
	ClarionString lOCBackorder;
	public Detailbrowse(QuickWindow_7 quickWindow,ClarionDecimal totalTax,ClarionDecimal totalDiscount,ClarionDecimal totalCost,ClarionString lOCBackorder)
	{
		this.quickWindow=quickWindow;
		this.totalTax=totalTax;
		this.totalDiscount=totalDiscount;
		this.totalCost=totalCost;
		this.lOCBackorder=lOCBackorder;
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
		if (!wm.request.equals(Constants.VIEWRECORD)) {
			this.insertControl.setValue(quickWindow._insert);
			this.changeControl.setValue(quickWindow._change);
			this.deleteControl.setValue(quickWindow._delete);
		}
	}
	public void resetFromView()
	{
		ClarionReal totalTaxSum=Clarion.newReal();
		ClarionReal totalDiscountSum=Clarion.newReal();
		ClarionReal totalCostSum=Clarion.newReal();
		CWin.setCursor(Cursor.WAIT);
		Main.relateDetail.get().setQuickScan(Clarion.newNumber(1));
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
					CWin.setCursor(null);
					return;
					// UNREACHABLE! :case_1_break=true;
				}
			}
			this.setQueueRecord();
			totalTaxSum.increment(Main.detail.taxPaid);
			totalDiscountSum.increment(Main.detail.discount);
			totalCostSum.increment(Main.detail.totalCost);
		}
		totalTax.setValue(totalTaxSum);
		totalDiscount.setValue(totalDiscountSum);
		totalCost.setValue(totalCostSum);
		super.resetFromView();
		Main.relateDetail.get().setQuickScan(Clarion.newNumber(0));
		CWin.setCursor(null);
	}
	public void setQueueRecord()
	{
		if (Main.detail.backOrdered.boolValue()) {
			lOCBackorder.setValue("Yes");
		}
		else {
			lOCBackorder.setValue("No");
		}
		super.setQueueRecord();
		this.q.lOCBackorder.setValue(lOCBackorder);
	}
}
