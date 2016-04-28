package clarion.invoi001;

import clarion.abbrowse.Browseclass;
import clarion.abbrowse.Browseeipmanager;
import clarion.abfile.Relationmanager;
import clarion.abwindow.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Eipaction;
import clarion.invoi001.QueueBrowse_1;
import clarion.invoi001.Quickwindow;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Brw1 extends Browseclass
{
	public QueueBrowse_1 q=null;
	Browseeipmanager brw1Eipmanager;
	Quickwindow quickwindow;
	public Brw1(Browseeipmanager brw1Eipmanager,Quickwindow quickwindow)
	{
		this.brw1Eipmanager=brw1Eipmanager;
		this.quickwindow=quickwindow;
		q=null;
	}

	public void init(ClarionNumber listbox,ClarionString posit,ClarionView v,ClarionQueue q,Relationmanager rm,Windowmanager wm)
	{
		super.init(listbox.like(),posit,v,q,rm,wm);
		this.eip=brw1Eipmanager;
		this.selectcontrol.setValue(quickwindow._select_2);
		this.hideselect.setValue(1);
		this.arrowaction.setValue(Eipaction.DEFAULT+Eipaction.REMAIN+Eipaction.RETAINCOLUMN);
		if (!wm.request.equals(Constants.VIEWRECORD)) {
			this.insertcontrol.setValue(quickwindow._insert_3);
			this.changecontrol.setValue(quickwindow._change_3);
			this.deletecontrol.setValue(quickwindow._delete_3);
		}
	}
}
