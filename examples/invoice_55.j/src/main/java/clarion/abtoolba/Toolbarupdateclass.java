package clarion.abtoolba;

import clarion.abtoolba.Abtoolba;
import clarion.abtoolba.Toolbartarget;
import clarion.abwindow.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Prop;
import clarion.equates.Toolbar;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Toolbarupdateclass extends Toolbartarget
{
	public ClarionNumber request=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber history=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Toolbarupdateclass()
	{
		request=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		history=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	}

	public void displaybuttons()
	{
		if (this.request.equals(Constants.INSERTRECORD)) {
			CWin.enable(Toolbar.DOWN);
			CWin.enable(Toolbar.INSERT);
			CWin.disable(Toolbar.CHANGE,Toolbar.PAGEUP);
			CWin.disable(Toolbar.UP,Toolbar.LOCATE);
			displaybuttons_seths();
		}
		else if (this.request.equals(Constants.CHANGERECORD)) {
			CWin.enable(Toolbar.BOTTOM,Toolbar.UP);
			CWin.enable(Toolbar.INSERT);
			CWin.disable(Toolbar.CHANGE,Toolbar.SELECT);
			displaybuttons_seths();
		}
		else {
			CWin.disable(Toolbar.FIRST,Toolbar.HISTORY);
		}
		CWin.display(Toolbar.FIRST,Toolbar.LAST);
	}
	public void displaybuttons_seths()
	{
		if (!this.helpbutton.boolValue() || Clarion.getControl(this.helpbutton).getProperty(Prop.DISABLE).boolValue()) {
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
	public void taketoolbar()
	{
		if (this.request.equals(Constants.INSERTRECORD)) {
			(new Abtoolba()).settips(Abtoolba.updateinserttips.getString());
		}
		else if (this.request.equals(Constants.CHANGERECORD)) {
			(new Abtoolba()).settips(Abtoolba.updatechangetips.getString());
		}
		this.displaybuttons();
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
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1>=Toolbar.BOTTOM && case_1<=Toolbar.UP) {
				case_1_match=true;
			}
			if (case_1_match || case_1==Toolbar.INSERT) {
				if (!(vcr==null)) {
					vcr.setValue(CWin.accepted());
				}
				wm.postcompleted();
				case_1_break=true;
			}
			if (!case_1_break) {
				super.takeevent(vcr,wm);
			}
		}
	}
	public ClarionNumber trytaketoolbar()
	{
		this.taketoolbar();
		return Clarion.newNumber(1);
	}
}
