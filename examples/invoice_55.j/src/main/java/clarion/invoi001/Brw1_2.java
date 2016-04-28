package clarion.invoi001;

import clarion.Main;
import clarion.abbrowse.Browseclass;
import clarion.abfile.Relationmanager;
import clarion.abwindow.Windowmanager;
import clarion.equates.Constants;
import clarion.invoi001.QueueBrowse_1_3;
import clarion.invoi001.Quickwindow_6;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Brw1_2 extends Browseclass
{
	public QueueBrowse_1_3 q=null;
	Quickwindow_6 quickwindow;
	public Brw1_2(Quickwindow_6 quickwindow)
	{
		this.quickwindow=quickwindow;
		q=null;
	}

	public void init(ClarionNumber listbox,ClarionString posit,ClarionView v,ClarionQueue q,Relationmanager rm,Windowmanager wm)
	{
		super.init(listbox.like(),posit,v,q,rm,wm);
		this.selectcontrol.setValue(quickwindow._select_2);
		this.hideselect.setValue(1);
		if (!wm.request.equals(Constants.VIEWRECORD)) {
			this.insertcontrol.setValue(quickwindow._insert_3);
			this.changecontrol.setValue(quickwindow._change_3);
			this.deletecontrol.setValue(quickwindow._delete_3);
		}
		this.toolcontrol.setValue(quickwindow._toolbox);
	}
	public ClarionNumber resetsort(ClarionNumber force)
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (CWin.choice(quickwindow._currenttab)==2) {
			return this.setsort(Clarion.newNumber(1),force.like());
		}
		else if (CWin.choice(quickwindow._currenttab)==3) {
			return this.setsort(Clarion.newNumber(2),force.like());
		}
		else if (CWin.choice(quickwindow._currenttab)==4) {
			return this.setsort(Clarion.newNumber(3),force.like());
		}
		else {
			return this.setsort(Clarion.newNumber(4),force.like());
		}
		// UNREACHABLE! :returnvalue.setValue(super.resetsort(force.like()));
		// UNREACHABLE! :return returnvalue.like();
	}
	public void setqueuerecord()
	{
		Main.glotCuscsz.setValue(Main.customers.city.clip().concat(",  ",Main.customers.state,"   ",Main.customers.zipcode.clip()));
		super.setqueuerecord();
	}
}
