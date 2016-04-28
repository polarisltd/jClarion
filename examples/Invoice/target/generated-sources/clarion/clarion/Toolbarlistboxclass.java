package clarion;

import clarion.Abtoolba;
import clarion.Browseclass;
import clarion.Toolbartarget;
import clarion.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Prop;
import clarion.equates.Toolbar;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CWin;

public class Toolbarlistboxclass extends Toolbartarget
{
	public Browseclass browse;
	public Toolbarlistboxclass()
	{
		browse=null;
	}

	public void displayButtons()
	{
		CWin.disable(Toolbar.HISTORY);
		CWin.enable(Toolbar.BOTTOM,Toolbar.LOCATE);
		super.displayButtons();
	}
	public void takeToolbar()
	{
		Abtoolba.setTips(Abtoolba.listBoxTips.getString());
		this.displayButtons();
	}
	public void takeEvent(Windowmanager p1)
	{
		takeEvent((ClarionNumber)null,p1);
	}
	public void takeEvent(ClarionNumber vcr,Windowmanager wm)
	{
		if (CWin.accepted()==Toolbar.SELECT) {
			wm.update();
			wm.response.setValue(Constants.REQUESTCOMPLETED);
			CWin.post(Event.CLOSEWINDOW);
			return;
		}
		{
			int execute_1=CWin.accepted()-Toolbar.BOTTOM+1;
			if (execute_1==1) {
				CWin.post(Event.SCROLLBOTTOM,this.control.intValue());
			}
			if (execute_1==2) {
				CWin.post(Event.SCROLLTOP,this.control.intValue());
			}
			if (execute_1==3) {
				CWin.post(Event.PAGEDOWN,this.control.intValue());
			}
			if (execute_1==4) {
				CWin.post(Event.PAGEUP,this.control.intValue());
			}
			if (execute_1==5) {
				CWin.post(Event.SCROLLDOWN,this.control.intValue());
			}
			if (execute_1==6) {
				CWin.post(Event.SCROLLUP,this.control.intValue());
			}
			if (execute_1==7) {
				CWin.post(Event.LOCATE,this.control.intValue());
			}
			if (execute_1<1 || execute_1>7) {
				super.takeEvent(null,wm);
			}
		}
	}
	public ClarionNumber tryTakeToolbar()
	{
		if (Clarion.getControl(this.browse.ilc.getControl()).getProperty(Prop.VISIBLE).boolValue()) {
			this.takeToolbar();
			return Clarion.newNumber(1);
		}
		else {
			return Clarion.newNumber(0);
		}
	}
}
