package clarion.invoi002;

import clarion.abbrowse.Browseclass;
import clarion.abbrowse.Browseeipmanager;
import clarion.abfile.Relationmanager;
import clarion.abwindow.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Eipaction;
import clarion.invoi002.QueueBrowse_1;
import clarion.invoi002.Quickwindow_1;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Brw1 extends Browseclass
{
	public QueueBrowse_1 q=null;
	Brw1 brw1;
	Browseeipmanager brw1Eipmanager;
	Quickwindow_1 quickwindow;
	public Brw1(Brw1 brw1,Browseeipmanager brw1Eipmanager,Quickwindow_1 quickwindow)
	{
		this.brw1=brw1;
		this.brw1Eipmanager=brw1Eipmanager;
		this.quickwindow=quickwindow;
		q=null;
	}
	public Brw1() {}
	public void __Init__(Brw1 brw1,Browseeipmanager brw1Eipmanager,Quickwindow_1 quickwindow)
	{
		this.brw1=brw1;
		this.brw1Eipmanager=brw1Eipmanager;
		this.quickwindow=quickwindow;
		q=null;
	}

	public ClarionNumber ask(ClarionNumber request)
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnvalue.setValue(super.ask(request.like()));
		brw1.askprocedure.setValue(1);
		return returnvalue.like();
	}
	public void init(ClarionNumber listbox,ClarionString posit,ClarionView v,ClarionQueue q,Relationmanager rm,Windowmanager wm)
	{
		super.init(listbox.like(),posit,v,q,rm,wm);
		this.eip=brw1Eipmanager;
		this.addeditcontrol(null,Clarion.newNumber(2));
		this.addeditcontrol(null,Clarion.newNumber(1));
		this.arrowaction.setValue(Eipaction.DEFAULT+Eipaction.REMAIN+Eipaction.RETAINCOLUMN);
		if (!wm.request.equals(Constants.VIEWRECORD)) {
			this.insertcontrol.setValue(quickwindow._insert);
			this.changecontrol.setValue(quickwindow._change);
			this.deletecontrol.setValue(quickwindow._delete);
		}
		this.toolcontrol.setValue(quickwindow._toolbox);
	}
	public ClarionNumber resetsort(ClarionNumber force)
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (CWin.choice(quickwindow._currenttab)==2) {
			return this.setsort(Clarion.newNumber(1),force.like());
		}
		else {
			return this.setsort(Clarion.newNumber(2),force.like());
		}
		// UNREACHABLE! :returnvalue.setValue(super.resetsort(force.like()));
		// UNREACHABLE! :return returnvalue.like();
	}
	public ClarionNumber takekey()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (this.listqueue.records().boolValue() && CWin.keyCode()==Constants.MOUSELEFT2) {
			brw1.askprocedure.setValue(0);
		}
		returnvalue.setValue(super.takekey());
		return returnvalue.like();
	}
}
