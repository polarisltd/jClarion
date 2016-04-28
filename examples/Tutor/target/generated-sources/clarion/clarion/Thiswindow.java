package clarion;

import clarion.AppFrame;
import clarion.Main;
import clarion.Toolbarclass;
import clarion.Tutor001;
import clarion.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Level;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CWin;

public class Thiswindow extends Windowmanager
{
	Toolbarclass toolbar;
	AppFrame appFrame;
	public Thiswindow(Toolbarclass toolbar,AppFrame appFrame)
	{
		this.toolbar=toolbar;
		this.appFrame=appFrame;
	}

	public ClarionNumber init()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalErrors.setProcedureName(Clarion.newString("Main"));
		this.request.setValue(Main.globalRequest);
		returnValue.setValue(super.init());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		this.firstField.setValue(1);
		this.vCRRequest=Main.vCRRequest;
		this.errors=Main.globalErrors;
		Main.globalRequest.clear();
		Main.globalResponse.clear();
		this.addItem(toolbar);
		appFrame.open();
		this.opened.setValue(Constants.TRUE);
		init_DefineListboxStyle();
		Main.iNIMgr.fetch(Clarion.newString("Main"),appFrame);
		this.setAlerts();
		return returnValue.like();
	}
	public void init_DefineListboxStyle()
	{
		Tutor001.main_DefineListboxStyle();
	}
	public ClarionNumber kill()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(super.kill());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		if (this.opened.boolValue()) {
			Main.iNIMgr.update(Clarion.newString("Main"),appFrame);
		}
		Main.globalErrors.setProcedureName();
		return returnValue.like();
	}
	public ClarionNumber takeAccepted()
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
			{
				int case_1=CWin.accepted();
				boolean case_1_break=false;
				if (!case_1_break) {
					takeAccepted_MenuMenubar();
					takeAccepted_MenuFileMenu();
					takeAccepted_MenuEditMenu();
					takeAccepted_MenuBrowseMenu(appFrame);
					takeAccepted_MenuReportMenu(appFrame);
					takeAccepted_MenuReportCUSTOMER(appFrame);
					takeAccepted_MenuReportORDERS(appFrame);
					takeAccepted_MenuWindowMenu();
					takeAccepted_MenuHelpMenu();
				}
			}
			returnValue.setValue(super.takeAccepted());
			return returnValue.like();
		}
		// UNREACHABLE! :returnValue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnValue.like();
	}
	public void takeAccepted_MenuEditMenu()
	{
		Tutor001.main_MenuEditMenu();
	}
	public void takeAccepted_MenuBrowseMenu(AppFrame appFrame)
	{
		Tutor001.main_MenuBrowseMenu(appFrame);
	}
	public void takeAccepted_MenuWindowMenu()
	{
		Tutor001.main_MenuWindowMenu();
	}
	public void takeAccepted_MenuMenubar()
	{
		Tutor001.main_MenuMenubar();
	}
	public void takeAccepted_MenuReportCUSTOMER(AppFrame appFrame)
	{
		Tutor001.main_MenuReportCUSTOMER(appFrame);
	}
	public void takeAccepted_MenuReportMenu(AppFrame appFrame)
	{
		Tutor001.main_MenuReportMenu(appFrame);
	}
	public void takeAccepted_MenuHelpMenu()
	{
		Tutor001.main_MenuHelpMenu();
	}
	public void takeAccepted_MenuFileMenu()
	{
		Tutor001.main_MenuFileMenu();
	}
	public void takeAccepted_MenuReportORDERS(AppFrame appFrame)
	{
		Tutor001.main_MenuReportORDERS(appFrame);
	}
}
