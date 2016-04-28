package clarion.invoi001;

import clarion.Main;
import clarion.abbrowse.Browseclass;
import clarion.abfile.Relationmanager;
import clarion.abwindow.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Cursor;
import clarion.equates.Level;
import clarion.invoi001.QueueBrowse;
import clarion.invoi001.Quickwindow_5;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionReal;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Detailbrowse extends Browseclass
{
	public QueueBrowse q=null;
	Quickwindow_5 quickwindow;
	ClarionDecimal totaltax;
	ClarionDecimal totaldiscount;
	ClarionDecimal totalcost;
	ClarionString locBackorder;
	public Detailbrowse(Quickwindow_5 quickwindow,ClarionDecimal totaltax,ClarionDecimal totaldiscount,ClarionDecimal totalcost,ClarionString locBackorder)
	{
		this.quickwindow=quickwindow;
		this.totaltax=totaltax;
		this.totaldiscount=totaldiscount;
		this.totalcost=totalcost;
		this.locBackorder=locBackorder;
		q=null;
	}

	public void init(ClarionNumber listbox,ClarionString posit,ClarionView v,ClarionQueue q,Relationmanager rm,Windowmanager wm)
	{
		super.init(listbox.like(),posit,v,q,rm,wm);
		if (!wm.request.equals(Constants.VIEWRECORD)) {
			this.insertcontrol.setValue(quickwindow._insert);
			this.changecontrol.setValue(quickwindow._change);
			this.deletecontrol.setValue(quickwindow._delete);
		}
	}
	public void resetfromview()
	{
		ClarionReal totaltaxSum=Clarion.newReal();
		ClarionReal totaldiscountSum=Clarion.newReal();
		ClarionReal totalcostSum=Clarion.newReal();
		CWin.setCursor(Cursor.WAIT);
		Main.relateDetail.setquickscan(Clarion.newNumber(1));
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
			this.setqueuerecord();
			totaltaxSum.increment(Main.detail.taxpaid);
			totaldiscountSum.increment(Main.detail.discount);
			totalcostSum.increment(Main.detail.totalcost);
		}
		totaltax.setValue(totaltaxSum);
		totaldiscount.setValue(totaldiscountSum);
		totalcost.setValue(totalcostSum);
		super.resetfromview();
		Main.relateDetail.setquickscan(Clarion.newNumber(0));
		CWin.setCursor(null);
	}
	public void setqueuerecord()
	{
		if (Main.detail.backordered.boolValue()) {
			locBackorder.setValue("Yes");
		}
		else {
			locBackorder.setValue("No");
		}
		super.setqueuerecord();
		this.q.locBackorder.setValue(locBackorder);
	}
}
