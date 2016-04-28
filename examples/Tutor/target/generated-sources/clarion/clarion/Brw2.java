package clarion;

import clarion.Browseclass;
import clarion.QueueBrowse_2;
import clarion.QuickWindow_1;
import clarion.Relationmanager;
import clarion.Windowmanager;
import clarion.equates.Constants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.view.ClarionView;

public class Brw2 extends Browseclass
{
	public QueueBrowse_2 q;
	QuickWindow_1 quickWindow;
	public Brw2(QuickWindow_1 quickWindow)
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
		if (!wm.request.equals(Constants.VIEWRECORD)) {
			this.insertControl.setValue(quickWindow._insert_3);
			this.changeControl.setValue(quickWindow._change_3);
			this.deleteControl.setValue(quickWindow._delete_3);
		}
	}
}
