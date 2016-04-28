package clarion;

import clarion.Browseclass;
import clarion.Browseeipmanager;
import clarion.QueueBrowse_1;
import clarion.QuickWindow;
import clarion.Relationmanager;
import clarion.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Eipaction;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.view.ClarionView;

public class Brw1 extends Browseclass
{
	public QueueBrowse_1 q;
	Browseeipmanager bRW1EIPManager;
	QuickWindow quickWindow;
	public Brw1(Browseeipmanager bRW1EIPManager,QuickWindow quickWindow)
	{
		this.bRW1EIPManager=bRW1EIPManager;
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
		this.eip=bRW1EIPManager;
		this.selectControl.setValue(quickWindow._select_2);
		this.hideSelect.setValue(1);
		this.deleteAction.setValue(Eipaction.ALWAYS);
		this.arrowAction.setValue(Eipaction.DEFAULT+Eipaction.REMAIN+Eipaction.RETAINCOLUMN);
		if (!wm.request.equals(Constants.VIEWRECORD)) {
			this.insertControl.setValue(quickWindow._insert_3);
			this.changeControl.setValue(quickWindow._change_3);
			this.deleteControl.setValue(quickWindow._delete_3);
		}
	}
}
