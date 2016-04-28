package clarion.abtoolba;

import clarion.abwindow.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Prop;
import clarion.equates.Toolbar;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Toolbartarget
{
	public ClarionNumber control=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber helpbutton=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber insertbutton=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber changebutton=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber deletebutton=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber selectbutton=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber locatebutton=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public Toolbartarget()
	{
		control=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		helpbutton=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		insertbutton=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		changebutton=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		deletebutton=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		selectbutton=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		locatebutton=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	}

	public void displaybuttons()
	{
		if (!this.selectbutton.boolValue() || Clarion.getControl(this.selectbutton).getProperty(Prop.DISABLE).boolValue()) {
			CWin.disable(Toolbar.SELECT);
		}
		else {
			CWin.enable(Toolbar.SELECT);
		}
		if (!this.deletebutton.boolValue() || Clarion.getControl(this.deletebutton).getProperty(Prop.DISABLE).boolValue()) {
			CWin.disable(Toolbar.DELETE);
		}
		else {
			CWin.enable(Toolbar.DELETE);
		}
		if (!this.changebutton.boolValue() || Clarion.getControl(this.changebutton).getProperty(Prop.DISABLE).boolValue()) {
			CWin.disable(Toolbar.CHANGE);
		}
		else {
			CWin.enable(Toolbar.CHANGE);
		}
		if (!this.insertbutton.boolValue() || Clarion.getControl(this.insertbutton).getProperty(Prop.DISABLE).boolValue()) {
			CWin.disable(Toolbar.INSERT);
		}
		else {
			CWin.enable(Toolbar.INSERT);
		}
		if (!this.helpbutton.boolValue() || Clarion.getControl(this.helpbutton).getProperty(Prop.DISABLE).boolValue()) {
			CWin.disable(Toolbar.HELP);
		}
		else {
			CWin.enable(Toolbar.HELP);
		}
		if (!this.locatebutton.boolValue() || Clarion.getControl(this.locatebutton).getProperty(Prop.DISABLE).boolValue()) {
			CWin.disable(Toolbar.LOCATE);
		}
		else {
			CWin.enable(Toolbar.LOCATE);
		}
	}
	public void taketoolbar()
	{
	}
	public ClarionNumber trytaketoolbar()
	{
		return Clarion.newNumber(0);
	}
	public void takeevent(Windowmanager p1)
	{
		takeevent((ClarionNumber)null,p1);
	}
	public void takeevent(ClarionNumber vcr,Windowmanager wm)
	{
		{
			int case_1=CWin.accepted();
			boolean case_1_break=false;
			if (case_1==Toolbar.HELP) {
				CWin.pressKey(Constants.F1KEY);
				case_1_break=true;
			}
			if (!case_1_break && case_1==Toolbar.INSERT) {
				CWin.post(Event.ACCEPTED,this.insertbutton.intValue());
				case_1_break=true;
			}
			if (!case_1_break && case_1==Toolbar.CHANGE) {
				CWin.post(Event.ACCEPTED,this.changebutton.intValue());
				case_1_break=true;
			}
			if (!case_1_break && case_1==Toolbar.DELETE) {
				CWin.post(Event.ACCEPTED,this.deletebutton.intValue());
				case_1_break=true;
			}
		}
	}
}
