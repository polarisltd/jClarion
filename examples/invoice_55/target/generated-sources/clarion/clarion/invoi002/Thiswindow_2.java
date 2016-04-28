package clarion.invoi002;

import clarion.Main;
import clarion.abtoolba.Toolbarclass;
import clarion.abwindow.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.invoi002.Window;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Thiswindow_2 extends Windowmanager
{
	Window window;
	Toolbarclass toolbar;
	public Thiswindow_2(Window window,Toolbarclass toolbar)
	{
		this.window=window;
		this.toolbar=toolbar;
	}

	public ClarionNumber init()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalerrors.setprocedurename(Clarion.newString("AboutAuthor"));
		this.request.setValue(Main.globalrequest);
		returnvalue.setValue(super.init());
		if (returnvalue.boolValue()) {
			return returnvalue.like();
		}
		this.firstfield.setValue(window._string7);
		this.vcrrequest=Main.vcrrequest;
		this.errors=Main.globalerrors;
		this.additem(toolbar);
		Main.globalrequest.clear();
		Main.globalresponse.clear();
		window.open();
		this.opened.setValue(Constants.TRUE);
		Main.inimgr.fetch(Clarion.newString("AboutAuthor"),window);
		this.setalerts();
		return returnvalue.like();
	}
	public ClarionNumber kill()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnvalue.setValue(super.kill());
		if (returnvalue.boolValue()) {
			return returnvalue.like();
		}
		if (this.opened.boolValue()) {
			Main.inimgr.update(Clarion.newString("AboutAuthor"),window);
		}
		Main.globalerrors.setprocedurename();
		return returnvalue.like();
	}
	public ClarionNumber takewindowevent()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber looped=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		while (true) {
			if (looped.boolValue()) {
				return Clarion.newNumber(Level.NOTIFY);
			}
			else {
				looped.setValue(1);
			}
			returnvalue.setValue(super.takewindowevent());
			{
				int case_1=CWin.event();
				boolean case_1_break=false;
				if (case_1==Event.ALERTKEY) {
					CWin.post(Event.CLOSEWINDOW);
					case_1_break=true;
				}
				if (!case_1_break && case_1==Event.TIMER) {
					CWin.post(Event.CLOSEWINDOW);
					case_1_break=true;
				}
			}
			return returnvalue.like();
		}
		// UNREACHABLE! :returnvalue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnvalue.like();
	}
}
