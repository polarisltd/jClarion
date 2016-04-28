package clarion;

import clarion.Main;
import clarion.Toolbarclass;
import clarion.Window_4;
import clarion.Windowmanager;
import clarion.equates.Constants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;

public class Thiswindow_13 extends Windowmanager
{
	Window_4 window;
	Toolbarclass toolbar;
	public Thiswindow_13(Window_4 window,Toolbarclass toolbar)
	{
		this.window=window;
		this.toolbar=toolbar;
	}

	public ClarionNumber init()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalErrors.setProcedureName(Clarion.newString("UpdateDates"));
		this.request.setValue(Main.globalRequest);
		returnValue.setValue(super.init());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		this.firstField.setValue(window._string1);
		this.vCRRequest=Main.vCRRequest;
		this.errors=Main.globalErrors;
		this.addItem(toolbar);
		Main.globalRequest.clear();
		Main.globalResponse.clear();
		Main.relateAccounts.open();
		Main.accessTransactions.useFile();
		this.filesOpened.setValue(Constants.TRUE);
		window.open();
		this.opened.setValue(Constants.TRUE);
		Main.iNIMgr.fetch(Clarion.newString("UpdateDates"),window);
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
		if (this.filesOpened.boolValue()) {
			Main.relateAccounts.close();
		}
		if (this.opened.boolValue()) {
			Main.iNIMgr.update(Clarion.newString("UpdateDates"),window);
		}
		Main.globalErrors.setProcedureName();
		return returnValue.like();
	}
}
