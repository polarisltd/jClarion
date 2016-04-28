package clarion;

import clarion.Browseclass;
import clarion.QueueBrowse_1_1;
import clarion.QuickWindow_2;
import clarion.Relationmanager;
import clarion.Windowmanager;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.view.ClarionView;

public class Brw1_1 extends Browseclass
{
	public QueueBrowse_1_1 q;
	QuickWindow_2 quickWindow;
	public Brw1_1(QuickWindow_2 quickWindow)
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
		this.selectControl.setValue(quickWindow._select_2);
		this.hideSelect.setValue(1);
	}
}
