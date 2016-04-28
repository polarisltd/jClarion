package clarion;

import clarion.Abtoolba;
import clarion.Formvcrclass;
import clarion.Toolbartarget;
import clarion.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Prop;
import clarion.equates.Toolbar;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CWin;

public class Toolbarformvcrclass extends Toolbartarget
{
	public Formvcrclass formVCR;
	public Toolbarformvcrclass()
	{
		formVCR=null;
	}

	public void displayButtons()
	{
		if (this.formVCR.getAction().equals(Constants.INSERTRECORD)) {
			CWin.enable(Toolbar.HISTORY);
		}
		else {
			CWin.disable(Toolbar.HISTORY);
		}
		Clarion.getControl(Toolbar.BOTTOM).setProperty(Prop.DISABLE,this.formVCR.getActionAllowed(Clarion.newNumber(Event.SCROLLBOTTOM),Clarion.newNumber(0)).intValue()==1 ?Constants.FALSE:Constants.TRUE);
		Clarion.getControl(Toolbar.TOP).setProperty(Prop.DISABLE,this.formVCR.getActionAllowed(Clarion.newNumber(Event.SCROLLTOP),Clarion.newNumber(0)).intValue()==1 ?Constants.FALSE:Constants.TRUE);
		Clarion.getControl(Toolbar.PAGEDOWN).setProperty(Prop.DISABLE,this.formVCR.getActionAllowed(Clarion.newNumber(Event.PAGEDOWN),Clarion.newNumber(0)).intValue()==1 ?Constants.FALSE:Constants.TRUE);
		Clarion.getControl(Toolbar.PAGEUP).setProperty(Prop.DISABLE,this.formVCR.getActionAllowed(Clarion.newNumber(Event.PAGEUP),Clarion.newNumber(0)).intValue()==1 ?Constants.FALSE:Constants.TRUE);
		Clarion.getControl(Toolbar.DOWN).setProperty(Prop.DISABLE,this.formVCR.getActionAllowed(Clarion.newNumber(Event.SCROLLDOWN),Clarion.newNumber(0)).intValue()==1 ?Constants.FALSE:Constants.TRUE);
		Clarion.getControl(Toolbar.UP).setProperty(Prop.DISABLE,this.formVCR.getActionAllowed(Clarion.newNumber(Event.SCROLLUP),Clarion.newNumber(0)).intValue()==1 ?Constants.FALSE:Constants.TRUE);
		CWin.disable(Toolbar.LOCATE);
		super.displayButtons();
	}
	public void takeToolbar()
	{
		Abtoolba.setTips(Abtoolba.updateVCRTips.getString());
		this.displayButtons();
	}
	public void takeEvent(Windowmanager p1)
	{
		takeEvent((ClarionNumber)null,p1);
	}
	public void takeEvent(ClarionNumber vcr,Windowmanager wm)
	{
		{
			int case_1=CWin.accepted();
			boolean case_1_break=false;
			if (case_1==Toolbar.HELP) {
				CWin.pressKey(Constants.F1KEY);
				case_1_break=true;
			}
			if (!case_1_break && case_1==Toolbar.INSERT) {
				CWin.post(Event.ACCEPTED,this.insertButton.intValue());
				case_1_break=true;
			}
			if (!case_1_break && case_1==Toolbar.CHANGE) {
				CWin.post(Event.ACCEPTED,this.changeButton.intValue());
				case_1_break=true;
			}
			if (!case_1_break && case_1==Toolbar.DELETE) {
				CWin.post(Event.ACCEPTED,this.deleteButton.intValue());
				case_1_break=true;
			}
			if (!case_1_break && case_1==Toolbar.SELECT) {
				CWin.post(Event.ACCEPTED,this.selectButton.intValue());
				case_1_break=true;
			}
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
		this.takeToolbar();
		return Clarion.newNumber(1);
	}
}
