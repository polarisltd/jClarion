package clarion.invoi001;

import clarion.abbrowse.Browseclass;
import clarion.abfile.Relationmanager;
import clarion.abwindow.Windowmanager;
import clarion.invoi001.QueueBrowse_1_1;
import clarion.invoi001.Quickwindow_2;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Brw1_1 extends Browseclass
{
	public QueueBrowse_1_1 q=null;
	Quickwindow_2 quickwindow;
	public Brw1_1(Quickwindow_2 quickwindow)
	{
		this.quickwindow=quickwindow;
		q=null;
	}

	public void init(ClarionNumber listbox,ClarionString posit,ClarionView v,ClarionQueue q,Relationmanager rm,Windowmanager wm)
	{
		super.init(listbox.like(),posit,v,q,rm,wm);
		this.selectcontrol.setValue(quickwindow._select_2);
		this.hideselect.setValue(1);
	}
}
