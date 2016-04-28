package clarion.invoi002;

import clarion.Main;
import clarion.abbrowse.Stepstringclass;
import clarion.abreport.Printpreviewclass_1;
import clarion.abreport.Reportmanager_1;
import clarion.equates.Constants;
import clarion.equates.Prop;
import clarion.equates.Propagate;
import clarion.equates.Scrollby;
import clarion.equates.Scrollsort;
import clarion.invoi002.Progresswindow;
import clarion.invoi002.Report;
import clarion.invoi002.Thisreport;
import clarion.invoi002.equates.Mconstants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Thiswindow_3 extends Reportmanager_1
{
	Progresswindow progresswindow;
	Stepstringclass progressmgr;
	Thisreport thisreport;
	ClarionView processView;
	ClarionNumber progressThermometer;
	Report report;
	Printpreviewclass_1 previewer;
	public Thiswindow_3(Progresswindow progresswindow,Stepstringclass progressmgr,Thisreport thisreport,ClarionView processView,ClarionNumber progressThermometer,Report report,Printpreviewclass_1 previewer)
	{
		this.progresswindow=progresswindow;
		this.progressmgr=progressmgr;
		this.thisreport=thisreport;
		this.processView=processView;
		this.progressThermometer=progressThermometer;
		this.report=report;
		this.previewer=previewer;
	}

	public ClarionNumber init()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalerrors.setprocedurename(Clarion.newString("PrintCUS:StateKey"));
		this.request.setValue(Main.globalrequest);
		returnvalue.setValue(super.init());
		if (returnvalue.boolValue()) {
			return returnvalue.like();
		}
		this.firstfield.setValue(progresswindow._progressThermometer);
		this.vcrrequest=Main.vcrrequest;
		this.errors=Main.globalerrors;
		Main.globalrequest.clear();
		Main.globalresponse.clear();
		Main.relateCustomers.open();
		this.filesopened.setValue(Constants.TRUE);
		progresswindow.open();
		this.opened.setValue(Constants.TRUE);
		Main.inimgr.fetch(Clarion.newString("PrintCUS:StateKey"),progresswindow);
		progressmgr.init(Clarion.newNumber(Scrollsort.ALLOWALPHA+Scrollsort.ALLOWNUMERIC),Clarion.newNumber(Scrollby.RUNTIME));
		thisreport.init(processView,Main.relateCustomers,Clarion.newNumber(progresswindow._progressPcttext),progressThermometer,progressmgr,Main.customers.state);
		thisreport.casesensitivevalue.setValue(Constants.FALSE);
		thisreport.addsortorder(Main.customers.statekey);
		this.additem(Clarion.newNumber(progresswindow._progressCancel),Clarion.newNumber(Constants.REQUESTCANCELLED));
		this.init(thisreport,report,previewer);
		Clarion.getControl(progresswindow._progressUserstring).setProperty(Prop.TEXT,"");
		Main.relateCustomers.setquickscan(Clarion.newNumber(1),Clarion.newNumber(Propagate.ONEMANY));
		this.zoom.setValue(Mconstants.PAGEWIDTH);
		previewer.setinimanager(Main.inimgr);
		previewer.allowuserzoom.setValue(Constants.TRUE);
		previewer.maximize.setValue(Constants.TRUE);
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
		if (this.filesopened.boolValue()) {
			Main.relateCustomers.close();
		}
		if (this.opened.boolValue()) {
			Main.inimgr.update(Clarion.newString("PrintCUS:StateKey"),progresswindow);
		}
		Main.globalerrors.setprocedurename();
		return returnvalue.like();
	}
}
