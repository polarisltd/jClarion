package clarion;

import clarion.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Prop;
import clarion.equates.Toolbar;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CWin;

public class Toolbartarget
{
	public ClarionNumber control;
	public ClarionNumber helpButton;
	public ClarionNumber insertButton;
	public ClarionNumber changeButton;
	public ClarionNumber deleteButton;
	public ClarionNumber selectButton;
	public ClarionNumber locateButton;
	public Toolbartarget()
	{
		control=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		helpButton=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		insertButton=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		changeButton=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		deleteButton=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		selectButton=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		locateButton=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	}

	public void displayButtons()
	{
		if (!this.selectButton.boolValue() || Clarion.getControl(this.selectButton).getProperty(Prop.DISABLE).boolValue()) {
			CWin.disable(Toolbar.SELECT);
		}
		else {
			CWin.enable(Toolbar.SELECT);
		}
		if (!this.deleteButton.boolValue() || Clarion.getControl(this.deleteButton).getProperty(Prop.DISABLE).boolValue()) {
			CWin.disable(Toolbar.DELETE);
		}
		else {
			CWin.enable(Toolbar.DELETE);
		}
		if (!this.changeButton.boolValue() || Clarion.getControl(this.changeButton).getProperty(Prop.DISABLE).boolValue()) {
			CWin.disable(Toolbar.CHANGE);
		}
		else {
			CWin.enable(Toolbar.CHANGE);
		}
		if (!this.insertButton.boolValue() || Clarion.getControl(this.insertButton).getProperty(Prop.DISABLE).boolValue()) {
			CWin.disable(Toolbar.INSERT);
		}
		else {
			CWin.enable(Toolbar.INSERT);
		}
		if (!this.helpButton.boolValue() || Clarion.getControl(this.helpButton).getProperty(Prop.DISABLE).boolValue()) {
			CWin.disable(Toolbar.HELP);
		}
		else {
			CWin.enable(Toolbar.HELP);
		}
		if (!this.locateButton.boolValue() || Clarion.getControl(this.locateButton).getProperty(Prop.DISABLE).boolValue()) {
			CWin.disable(Toolbar.LOCATE);
		}
		else {
			CWin.enable(Toolbar.LOCATE);
		}
	}
	public void takeToolbar()
	{
	}
	public ClarionNumber tryTakeToolbar()
	{
		return Clarion.newNumber(0);
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
		}
	}
}
