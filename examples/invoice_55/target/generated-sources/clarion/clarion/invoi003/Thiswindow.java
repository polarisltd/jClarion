package clarion.invoi003;

import clarion.Main;
import clarion.abbrowse.Stepstringclass;
import clarion.abreport.Printpreviewclass_3;
import clarion.abreport.Reportmanager_3;
import clarion.equates.Constants;
import clarion.equates.Prop;
import clarion.equates.Propagate;
import clarion.equates.Scrollby;
import clarion.equates.Scrollsort;
import clarion.invoi003.Progresswindow;
import clarion.invoi003.Report;
import clarion.invoi003.Thisreport;
import clarion.invoi003.equates.Mconstants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Thiswindow extends Reportmanager_3
{
	Progresswindow progresswindow;
	Stepstringclass progressmgr;
	Thisreport thisreport;
	ClarionView processView;
	ClarionNumber progressThermometer;
	Report report;
	Printpreviewclass_3 previewer;
	public Thiswindow(Progresswindow progresswindow,Stepstringclass progressmgr,Thisreport thisreport,ClarionView processView,ClarionNumber progressThermometer,Report report,Printpreviewclass_3 previewer)
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
		Main.globalerrors.setprocedurename(Clarion.newString("PrintSelectedCustomer"));
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
		Main.inimgr.fetch(Clarion.newString("PrintSelectedCustomer"),progresswindow);
		progressmgr.init(Clarion.newNumber(Scrollsort.ALLOWALPHA+Scrollsort.ALLOWNUMERIC),Clarion.newNumber(Scrollby.RUNTIME));
		thisreport.init(processView,Main.relateCustomers,Clarion.newNumber(progresswindow._progressPcttext),progressThermometer,progressmgr,Main.customers.lastname);
		thisreport.casesensitivevalue.setValue(Constants.FALSE);
		thisreport.addsortorder(Main.customers.keyfullname);
		this.additem(Clarion.newNumber(progresswindow._progressCancel),Clarion.newNumber(Constants.REQUESTCANCELLED));
		this.init(thisreport,report,previewer);
		Clarion.getControl(progresswindow._progressUserstring).setProperty(Prop.TEXT,"");
		Main.relateCustomers.setquickscan(Clarion.newNumber(1),Clarion.newNumber(Propagate.ONEMANY));
		this.zoom.setValue(Mconstants.PAGEWIDTH);
		previewer.setinimanager(Main.inimgr);
		previewer.allowuserzoom.setValue(Constants.TRUE);
		previewer.maximize.setValue(Constants.TRUE);
		if (this.originalrequest.equals(Constants.PROCESSRECORD)) {
			this.deferwindow.clear(1);
			thisreport.addrange(Main.customers.mi);
		}
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
			Main.inimgr.update(Clarion.newString("PrintSelectedCustomer"),progresswindow);
		}
		Main.globalerrors.setprocedurename();
		return returnvalue.like();
	}
}
