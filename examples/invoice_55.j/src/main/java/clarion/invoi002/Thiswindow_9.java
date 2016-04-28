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
import clarion.invoi002.Progresswindow_4;
import clarion.invoi002.Report_4;
import clarion.invoi002.Thisreport_4;
import clarion.invoi002.equates.Mconstants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Thiswindow_9 extends Reportmanager_1
{
	Progresswindow_4 progresswindow;
	Stepstringclass progressmgr;
	Thisreport_4 thisreport;
	ClarionView processView;
	ClarionNumber progressThermometer;
	Report_4 report;
	Printpreviewclass_1 previewer;
	public Thiswindow_9(Progresswindow_4 progresswindow,Stepstringclass progressmgr,Thisreport_4 thisreport,ClarionView processView,ClarionNumber progressThermometer,Report_4 report,Printpreviewclass_1 previewer)
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
		Main.globalerrors.setprocedurename(Clarion.newString("PrintSelectedProduct"));
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
		Main.relateProducts.open();
		this.filesopened.setValue(Constants.TRUE);
		progresswindow.open();
		this.opened.setValue(Constants.TRUE);
		Main.inimgr.fetch(Clarion.newString("PrintSelectedProduct"),progresswindow);
		progressmgr.init(Clarion.newNumber(Scrollsort.ALLOWALPHA+Scrollsort.ALLOWNUMERIC),Clarion.newNumber(Scrollby.RUNTIME));
		thisreport.init(processView,Main.relateProducts,Clarion.newNumber(progresswindow._progressPcttext),progressThermometer,progressmgr,Main.products.productsku);
		thisreport.casesensitivevalue.setValue(Constants.FALSE);
		thisreport.addsortorder(Main.products.keyproductsku);
		this.additem(Clarion.newNumber(progresswindow._progressCancel),Clarion.newNumber(Constants.REQUESTCANCELLED));
		this.init(thisreport,report,previewer);
		Clarion.getControl(progresswindow._progressUserstring).setProperty(Prop.TEXT,"");
		Main.relateProducts.setquickscan(Clarion.newNumber(1),Clarion.newNumber(Propagate.ONEMANY));
		this.zoom.setValue(Mconstants.PAGEWIDTH);
		previewer.setinimanager(Main.inimgr);
		previewer.allowuserzoom.setValue(Constants.TRUE);
		previewer.maximize.setValue(Constants.TRUE);
		if (this.originalrequest.equals(Constants.PROCESSRECORD)) {
			this.deferwindow.clear(1);
			thisreport.addrange(Main.products.productsku);
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
			Main.relateProducts.close();
		}
		if (this.opened.boolValue()) {
			Main.inimgr.update(Clarion.newString("PrintSelectedProduct"),progresswindow);
		}
		Main.globalerrors.setprocedurename();
		return returnvalue.like();
	}
}
