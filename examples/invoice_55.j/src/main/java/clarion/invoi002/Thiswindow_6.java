package clarion.invoi002;

import clarion.Main;
import clarion.abbrowse.Steplongclass;
import clarion.abreport.Printpreviewclass_1;
import clarion.abreport.Reportmanager_1;
import clarion.equates.Constants;
import clarion.equates.Prop;
import clarion.equates.Propagate;
import clarion.equates.Scrollsort;
import clarion.invoi002.Progresswindow_3;
import clarion.invoi002.Report_3;
import clarion.invoi002.Thisreport_3;
import clarion.invoi002.equates.Mconstants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Thiswindow_6 extends Reportmanager_1
{
	Progresswindow_3 progresswindow;
	Steplongclass progressmgr;
	Thisreport_3 thisreport;
	ClarionView processView;
	ClarionNumber progressThermometer;
	Report_3 report;
	Printpreviewclass_1 previewer;
	public Thiswindow_6(Progresswindow_3 progresswindow,Steplongclass progressmgr,Thisreport_3 thisreport,ClarionView processView,ClarionNumber progressThermometer,Report_3 report,Printpreviewclass_1 previewer)
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
		Main.globalerrors.setprocedurename(Clarion.newString("PrintMailingLabels"));
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
		Main.relateOrders.open();
		this.filesopened.setValue(Constants.TRUE);
		progresswindow.open();
		this.opened.setValue(Constants.TRUE);
		Main.inimgr.fetch(Clarion.newString("PrintMailingLabels"),progresswindow);
		progressmgr.init(Clarion.newNumber(Scrollsort.ALLOWNUMERIC));
		thisreport.init(processView,Main.relateOrders,Clarion.newNumber(progresswindow._progressPcttext),progressThermometer,progressmgr,Main.orders.custnumber);
		thisreport.addsortorder(Main.orders.keycustordernumber);
		this.additem(Clarion.newNumber(progresswindow._progressCancel),Clarion.newNumber(Constants.REQUESTCANCELLED));
		this.init(thisreport,report,previewer);
		Clarion.getControl(progresswindow._progressUserstring).setProperty(Prop.TEXT,"");
		Main.relateOrders.setquickscan(Clarion.newNumber(1),Clarion.newNumber(Propagate.ONEMANY));
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
			Main.relateOrders.close();
		}
		if (this.opened.boolValue()) {
			Main.inimgr.update(Clarion.newString("PrintMailingLabels"),progresswindow);
		}
		Main.globalerrors.setprocedurename();
		return returnvalue.like();
	}
}
