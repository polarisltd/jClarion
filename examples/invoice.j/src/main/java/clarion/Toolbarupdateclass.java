package clarion;

import clarion.Abtoolba;
import clarion.Toolbartarget;
import clarion.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Prop;
import clarion.equates.Toolbar;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CWin;

public class Toolbarupdateclass extends Toolbartarget
{
	public ClarionNumber request;
	public ClarionNumber history;
	public Toolbarupdateclass()
	{
		request=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		history=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	}

	public void displayButtons()
	{
		if (this.request.equals(Constants.INSERTRECORD)) {
			CWin.enable(Toolbar.DOWN);
			CWin.enable(Toolbar.INSERT);
			CWin.disable(Toolbar.CHANGE,Toolbar.PAGEUP);
			CWin.disable(Toolbar.UP,Toolbar.LOCATE);
			displayButtons_SetHs();
		}
		else if (this.request.equals(Constants.CHANGERECORD)) {
			CWin.enable(Toolbar.BOTTOM,Toolbar.UP);
			CWin.enable(Toolbar.INSERT);
			CWin.disable(Toolbar.CHANGE,Toolbar.SELECT);
			displayButtons_SetHs();
		}
		else {
			CWin.disable(Toolbar.FIRST,Toolbar.HISTORY);
		}
		CWin.display(Toolbar.FIRST,Toolbar.LAST);
	}
	public void displayButtons_SetHs()
	{
		if (!this.helpButton.boolValue() || Clarion.getControl(this.helpButton).getProperty(Prop.DISABLE).boolValue()) {
			CWin.disable(Toolbar.HELP);
		}
		else {
			CWin.enable(Toolbar.HELP);
		}
		if (this.history.boolValue()) {
			CWin.enable(Toolbar.HISTORY);
		}
		else {
			CWin.disable(Toolbar.HISTORY);
		}
	}
	public void takeToolbar()
	{
		if (this.request.equals(Constants.INSERTRECORD)) {
			Abtoolba.setTips(Abtoolba.updateInsertTips.getString());
		}
		else if (this.request.equals(Constants.CHANGERECORD)) {
			Abtoolba.setTips(Abtoolba.updateChangeTips.getString());
		}
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
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1>=Toolbar.BOTTOM && case_1<=Toolbar.UP) {
				case_1_match=true;
			}
			if (case_1_match || case_1==Toolbar.INSERT) {
				if (!(vcr==null)) {
					vcr.setValue(CWin.accepted());
				}
				wm.postCompleted();
				case_1_break=true;
			}
			if (!case_1_break) {
				super.takeEvent(vcr,wm);
			}
		}
	}
	public ClarionNumber tryTakeToolbar()
	{
		this.takeToolbar();
		return Clarion.newNumber(1);
	}
}
