package clarion;

import clarion.Browseclass;
import clarion.Detailbrowse;
import clarion.Main;
import clarion.QueueBrowse_1_2;
import clarion.QuickWindow_7;
import clarion.Relationmanager;
import clarion.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.view.ClarionView;

public class Ordersbrowse extends Browseclass
{
	public QueueBrowse_1_2 q;
	QuickWindow_7 quickWindow;
	Detailbrowse detailBrowse;
	ClarionString lOCShipped;
	public Ordersbrowse(QuickWindow_7 quickWindow,Detailbrowse detailBrowse,ClarionString lOCShipped)
	{
		this.quickWindow=quickWindow;
		this.detailBrowse=detailBrowse;
		this.lOCShipped=lOCShipped;
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
			this.insertControl.setValue(quickWindow._insert_3);
			this.changeControl.setValue(quickWindow._change_3);
			this.deleteControl.setValue(quickWindow._delete_3);
		}
	}
	public void resetQueue(ClarionNumber resetMode)
	{
		super.resetQueue(resetMode.like());
		Clarion.getControl(detailBrowse.insertControl).setProperty(Prop.DISABLE,!this.listQueue.records().equals(0) ? Clarion.newNumber(Constants.FALSE) : Clarion.newNumber(Constants.TRUE));
	}
	public void setQueueRecord()
	{
		Main.gLOTShipCSZ.setValue(Main.orders.shipCity.clip().concat(",  ",Main.orders.shipState,"   ",Main.orders.shipZip.clip()));
		if (Main.orders.orderShipped.boolValue()) {
			lOCShipped.setValue("Yes");
		}
		else {
			lOCShipped.setValue("No");
		}
		super.setQueueRecord();
		this.q.lOCShipped.setValue(lOCShipped);
	}
}
