package clarion;

import clarion.Browseclass;
import clarion.Browseeipmanager;
import clarion.QueueBrowse_1_4;
import clarion.QuickWindow_9;
import clarion.Relationmanager;
import clarion.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Eipaction;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.view.ClarionView;

public class Brw1_3 extends Browseclass
{
	public QueueBrowse_1_4 q;
	Brw1_3 brw1;
	Browseeipmanager bRW1EIPManager;
	QuickWindow_9 quickWindow;
	public Brw1_3(Brw1_3 brw1,Browseeipmanager bRW1EIPManager,QuickWindow_9 quickWindow)
	{
		this.brw1=brw1;
		this.bRW1EIPManager=bRW1EIPManager;
		this.quickWindow=quickWindow;
		q=null;
	}
	public Brw1_3() {}
	public void __Init__(Brw1_3 brw1,Browseeipmanager bRW1EIPManager,QuickWindow_9 quickWindow)
	{
		this.brw1=brw1;
		this.bRW1EIPManager=bRW1EIPManager;
		this.quickWindow=quickWindow;
		q=null;
	}

	public ClarionNumber ask(ClarionNumber request)
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(super.ask(request.like()));
		brw1.askProcedure.setValue(1);
		return returnValue.like();
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
		this.addEditControl(null,Clarion.newNumber(2));
		this.addEditControl(null,Clarion.newNumber(1));
		this.deleteAction.setValue(Eipaction.ALWAYS);
		this.arrowAction.setValue(Eipaction.DEFAULT+Eipaction.REMAIN+Eipaction.RETAINCOLUMN);
		if (!wm.request.equals(Constants.VIEWRECORD)) {
			this.insertControl.setValue(quickWindow._insert);
			this.changeControl.setValue(quickWindow._change);
			this.deleteControl.setValue(quickWindow._delete);
		}
		this.toolControl.setValue(quickWindow._toolbox);
	}
	public ClarionNumber resetSort(ClarionNumber force)
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (CWin.choice(quickWindow._currentTab)==2) {
			return this.setSort(Clarion.newNumber(1),force.like());
		}
		else {
			return this.setSort(Clarion.newNumber(2),force.like());
		}
		// UNREACHABLE! :returnValue.setValue(super.resetSort(force.like()));
		// UNREACHABLE! :return returnValue.like();
	}
	public ClarionNumber takeKey()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (this.listQueue.records().boolValue() && CWin.keyCode()==Constants.MOUSELEFT2) {
			brw1.askProcedure.setValue(0);
		}
		returnValue.setValue(super.takeKey());
		return returnValue.like();
	}
}
