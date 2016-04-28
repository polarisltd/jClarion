package clarion;

import clarion.Main;
import clarion.Toolbarclass;
import clarion.Window_1;
import clarion.Windowmanager;
import clarion.equates.Constants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;

public class Thiswindow extends Windowmanager
{
	Window_1 window;
	Toolbarclass toolbar;
	public Thiswindow(Window_1 window,Toolbarclass toolbar)
	{
		this.window=window;
		this.toolbar=toolbar;
	}

	public ClarionNumber init()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalErrors.setProcedureName(Clarion.newString("AuthorInformation"));
		this.request.setValue(Main.globalRequest);
		returnValue.setValue(super.init());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		this.firstField.setValue(window._panel1);
		this.vCRRequest=Main.vCRRequest;
		this.errors=Main.globalErrors;
		this.addItem(toolbar);
		Main.globalRequest.clear();
		Main.globalResponse.clear();
		window.open();
		this.opened.setValue(Constants.TRUE);
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
}
