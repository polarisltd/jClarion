package clarion.invoi002;

import clarion.Main;
import clarion.abtoolba.Toolbarclass;
import clarion.abwindow.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.invoi002.Window_1;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Thiswindow_8 extends Windowmanager
{
	Window_1 window;
	Toolbarclass toolbar;
	public Thiswindow_8(Window_1 window,Toolbarclass toolbar)
	{
		this.window=window;
		this.toolbar=toolbar;
	}

	public ClarionNumber init()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalerrors.setprocedurename(Clarion.newString("SplashScreen"));
		this.request.setValue(Main.globalrequest);
		returnvalue.setValue(super.init());
		if (returnvalue.boolValue()) {
			return returnvalue.like();
		}
		this.firstfield.setValue(window._string2);
		this.vcrrequest=Main.vcrrequest;
		this.errors=Main.globalerrors;
		this.additem(toolbar);
		Main.globalrequest.clear();
		Main.globalresponse.clear();
		window.open();
		this.opened.setValue(Constants.TRUE);
		Main.inimgr.fetch(Clarion.newString("SplashScreen"),window);
		CWin.getTarget().setProperty(Prop.TIMER,1000);
		//CWin.getTarget().setProperty(Prop.ALRT,255,Constants.MOUSELEFT); not supported at runtime err %%%%%
		//CWin.getTarget().setProperty(Prop.ALRT,254,Constants.MOUSELEFT2); not supported at runtime err %%%%%
		//CWin.getTarget().setProperty(Prop.ALRT,253,Constants.MOUSERIGHT); not supported at runtime err %%%%%
		// this.setalerts();  not supported at runtime err %%%%%
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
			Main.inimgr.update(Clarion.newString("SplashScreen"),window);
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
					{
						int case_2=CWin.keyCode();
						boolean case_2_match=false;
						case_2_match=false;
						if (case_2==Constants.MOUSELEFT) {
							case_2_match=true;
						}
						if (case_2_match || case_2==Constants.MOUSELEFT2) {
							case_2_match=true;
						}
						if (case_2_match || case_2==Constants.MOUSERIGHT) {
							CWin.post(Event.CLOSEWINDOW);
						}
					}
					case_1_break=true;
				}
				if (!case_1_break && case_1==Event.LOSEFOCUS) {
					CWin.post(Event.CLOSEWINDOW);
					case_1_break=true;
				}
				if (!case_1_break && case_1==Event.TIMER) {
					CWin.post(Event.CLOSEWINDOW);
					case_1_break=true;
				}
				if (!case_1_break && case_1==Event.ALERTKEY) {
					{
						int case_3=CWin.keyCode();
						boolean case_3_match=false;
						case_3_match=false;
						if (case_3==Constants.MOUSELEFT) {
							case_3_match=true;
						}
						if (case_3_match || case_3==Constants.MOUSELEFT2) {
							case_3_match=true;
						}
						if (case_3_match || case_3==Constants.MOUSERIGHT) {
							CWin.post(Event.CLOSEWINDOW);
						}
					}
					case_1_break=true;
				}
				if (!case_1_break) {
				}
			}
			return returnvalue.like();
		}
		// UNREACHABLE! :returnvalue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnvalue.like();
	}
}
