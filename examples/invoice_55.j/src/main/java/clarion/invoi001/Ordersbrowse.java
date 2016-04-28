package clarion.invoi001;

import clarion.Main;
import clarion.abbrowse.Browseclass;
import clarion.abfile.Relationmanager;
import clarion.abwindow.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Prop;
import clarion.invoi001.Detailbrowse;
import clarion.invoi001.QueueBrowse_1_2;
import clarion.invoi001.Quickwindow_5;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Ordersbrowse extends Browseclass
{
	public QueueBrowse_1_2 q=null;
	Quickwindow_5 quickwindow;
	Detailbrowse detailbrowse;
	ClarionString locShipped;
	public Ordersbrowse(Quickwindow_5 quickwindow,Detailbrowse detailbrowse,ClarionString locShipped)
	{
		this.quickwindow=quickwindow;
		this.detailbrowse=detailbrowse;
		this.locShipped=locShipped;
		q=null;
	}

	public void init(ClarionNumber listbox,ClarionString posit,ClarionView v,ClarionQueue q,Relationmanager rm,Windowmanager wm)
	{
		super.init(listbox.like(),posit,v,q,rm,wm);
		if (!wm.request.equals(Constants.VIEWRECORD)) {
			this.insertcontrol.setValue(quickwindow._insert_3);
			this.changecontrol.setValue(quickwindow._change_3);
			this.deletecontrol.setValue(quickwindow._delete_3);
		}
	}
	public void resetqueue(ClarionNumber resetmode)
	{
		super.resetqueue(resetmode.like());
		Clarion.getControl(detailbrowse.insertcontrol).setProperty(Prop.DISABLE,!this.listqueue.records().equals(0) ? Clarion.newNumber(Constants.FALSE) : Clarion.newNumber(Constants.TRUE));
	}
	public void setqueuerecord()
	{
		Main.glotShipcsz.setValue(Main.orders.shipcity.clip().concat(",  ",Main.orders.shipstate,"   ",Main.orders.shipzip.clip()));
		if (Main.orders.ordershipped.boolValue()) {
			locShipped.setValue("Yes");
		}
		else {
			locShipped.setValue("No");
		}
		super.setqueuerecord();
		this.q.locShipped.setValue(locShipped);
	}
}
