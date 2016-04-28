package clarion;

import clarion.Main;
import clarion.Toolbarclass;
import clarion.Window_5;
import clarion.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CWin;

public class Thiswindow_14 extends Windowmanager
{
	Window_5 window;
	Toolbarclass toolbar;
	public Thiswindow_14(Window_5 window,Toolbarclass toolbar)
	{
		this.window=window;
		this.toolbar=toolbar;
	}

	public ClarionNumber init()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalErrors.setProcedureName(Clarion.newString("SplashScreen"));
		this.request.setValue(Main.globalRequest);
		returnValue.setValue(super.init());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		this.firstField.setValue(window._string3);
		this.vCRRequest=Main.vCRRequest;
		this.errors=Main.globalErrors;
		this.addItem(toolbar);
		Main.globalRequest.clear();
		Main.globalResponse.clear();
		window.open();
		this.opened.setValue(Constants.TRUE);
		CWin.getTarget().setProperty(Prop.TIMER,1000);
		CWin.getTarget().setProperty(Prop.ALRT,255,Constants.MOUSELEFT);
		CWin.getTarget().setProperty(Prop.ALRT,254,Constants.MOUSELEFT2);
		CWin.getTarget().setProperty(Prop.ALRT,253,Constants.MOUSERIGHT);
		this.setAlerts();
		return returnValue.like();
	}
	public ClarionNumber kill()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(super.kill());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		Main.globalErrors.setProcedureName();
		return returnValue.like();
	}
	public ClarionNumber takeWindowEvent()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber looped=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		while (true) {
			if (looped.boolValue()) {
				return Clarion.newNumber(Level.NOTIFY);
			}
			else {
				looped.setValue(1);
			}
			returnValue.setValue(super.takeWindowEvent());
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
			return returnValue.like();
		}
		// UNREACHABLE! :returnValue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnValue.like();
	}
}
