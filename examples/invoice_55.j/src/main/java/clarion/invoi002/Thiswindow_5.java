package clarion.invoi002;

import clarion.Main;
import clarion.abbrowse.Steplongclass;
import clarion.abreport.Printpreviewclass_1;
import clarion.abreport.Reportmanager_1;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.equates.Propagate;
import clarion.equates.Scrollsort;
import clarion.invoi002.Progresswindow_2;
import clarion.invoi002.Report_2;
import clarion.invoi002.Thisreport_2;
import clarion.invoi002.equates.Mconstants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CExpression;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Thiswindow_5 extends Reportmanager_1
{
	public ClarionNumber paused=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber timer=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber cancelled=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	Progresswindow_2 progresswindow;
	Steplongclass progressmgr;
	Thisreport_2 thisreport;
	ClarionView processView;
	ClarionNumber progressThermometer;
	Report_2 report;
	Printpreviewclass_1 previewer;
	ClarionString locCcsz;
	Thiswindow_5 thiswindow;
	public Thiswindow_5(Progresswindow_2 progresswindow,Steplongclass progressmgr,Thisreport_2 thisreport,ClarionView processView,ClarionNumber progressThermometer,Report_2 report,Printpreviewclass_1 previewer,ClarionString locCcsz,Thiswindow_5 thiswindow)
	{
		this.progresswindow=progresswindow;
		this.progressmgr=progressmgr;
		this.thisreport=thisreport;
		this.processView=processView;
		this.progressThermometer=progressThermometer;
		this.report=report;
		this.previewer=previewer;
		this.locCcsz=locCcsz;
		this.thiswindow=thiswindow;
		paused=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		timer=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		cancelled=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	}
	public Thiswindow_5() {}
	public void __Init__(Progresswindow_2 progresswindow,Steplongclass progressmgr,Thisreport_2 thisreport,ClarionView processView,ClarionNumber progressThermometer,Report_2 report,Printpreviewclass_1 previewer,ClarionString locCcsz,Thiswindow_5 thiswindow)
	{
		this.progresswindow=progresswindow;
		this.progressmgr=progressmgr;
		this.thisreport=thisreport;
		this.processView=processView;
		this.progressThermometer=progressThermometer;
		this.report=report;
		this.previewer=previewer;
		this.locCcsz=locCcsz;
		this.thiswindow=thiswindow;
		paused=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		timer=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		cancelled=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	}

	public ClarionNumber init()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalerrors.setprocedurename(Clarion.newString("PrintInvoice"));
		this.request.setValue(Main.globalrequest);
		returnvalue.setValue(super.init());
		if (returnvalue.boolValue()) {
			return returnvalue.like();
		}
		this.firstfield.setValue(progresswindow._progressThermometer);
		this.vcrrequest=Main.vcrrequest;
		this.errors=Main.globalerrors;
		CExpression.bind("GLOT:CusCSZ",Main.glotCuscsz);
		CExpression.bind("GLOT:CustAddress",Main.glotCustaddress);
		CExpression.bind("GLOT:CustName",Main.glotCustname);
		Main.globalrequest.clear();
		Main.globalresponse.clear();
		Main.relateCompany.open();
		Main.relateCustomers.open();
		Main.accessOrders.usefile();
		this.filesopened.setValue(Constants.TRUE);
		progresswindow.open();
		this.opened.setValue(Constants.TRUE);
		Main.inimgr.fetch(Clarion.newString("PrintInvoice"),progresswindow);
		progressmgr.init(Clarion.newNumber(Scrollsort.ALLOWNUMERIC));
		thisreport.init(processView,Main.relateDetail,Clarion.newNumber(progresswindow._progressPcttext),progressThermometer,progressmgr,Main.detail.custnumber);
		thisreport.addsortorder(Main.detail.keydetails);
		thisreport.setfilter(Clarion.newString("DTL:CustNumber=ORD:CustNumber AND DTL:OrderNumber=ORD:OrderNumber"));
		this.additem(Clarion.newNumber(progresswindow._progressCancel),Clarion.newNumber(Constants.REQUESTCANCELLED));
		this.init(thisreport,report,previewer);
		Clarion.getControl(progresswindow._progressUserstring).setProperty(Prop.TEXT,"");
		Main.relateDetail.setquickscan(Clarion.newNumber(1),Clarion.newNumber(Propagate.ONEMANY));
		this.zoom.setValue(Mconstants.PAGEWIDTH);
		previewer.setinimanager(Main.inimgr);
		previewer.allowuserzoom.setValue(Constants.TRUE);
		previewer.maximize.setValue(Constants.TRUE);
		CRun._assert(!this.deferwindow.boolValue());
		this.deferopenreport.setValue(1);
		this.timer.setValue(CWin.getTarget().getProperty(Prop.TIMER));
		CWin.getTarget().setProperty(Prop.TIMER,0);
		Clarion.getControl(progresswindow._pause).setProperty(Prop.TEXT,"Go");
		this.paused.setValue(1);
		Clarion.getControl(progresswindow._progressCancel).setProperty(Prop.KEY,Constants.ESCKEY);
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
			Main.relateCompany.close();
			Main.relateCustomers.close();
		}
		if (this.opened.boolValue()) {
			Main.inimgr.update(Clarion.newString("PrintInvoice"),progresswindow);
		}
		Main.globalerrors.setprocedurename();
		return returnvalue.like();
	}
	public ClarionNumber next()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.company.set();
		Main.accessCompany.next();
		locCcsz.setValue(Main.company.city.clip().concat(", ",Main.company.state,"  ",Main.company.zipcode.clip()));
		returnvalue.setValue(super.next());
		return returnvalue.like();
	}
	public void reset()
	{
		reset(Clarion.newNumber(0));
	}
	public void reset(ClarionNumber force)
	{
		this.forcedreset.increment(force);
		if (progresswindow.getProperty(Prop.ACCEPTALL).boolValue()) {
			return;
		}
		Main.products.productnumber.setValue(Main.detail.productnumber);
		Main.accessProducts.fetch(Main.products.keyproductnumber);
		super.reset(force.like());
	}
	public ClarionNumber takeaccepted()
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
			{
				int case_1=CWin.accepted();
				if (case_1==progresswindow._pause) {
					if (this.paused.boolValue()) {
						CWin.getTarget().setClonedProperty(Prop.TIMER,this.timer);
						Clarion.getControl(progresswindow._pause).setProperty(Prop.TEXT,"Pause");
					}
					else {
						this.timer.setValue(CWin.getTarget().getProperty(Prop.TIMER));
						CWin.getTarget().setProperty(Prop.TIMER,0);
						Clarion.getControl(progresswindow._pause).setProperty(Prop.TEXT,"Restart");
					}
					this.paused.setValue(Clarion.newNumber(1).subtract(this.paused));
				}
			}
			returnvalue.setValue(super.takeaccepted());
			{
				int case_2=CWin.accepted();
				if (case_2==progresswindow._progressCancel) {
					thiswindow.update();
					this.cancelled.setValue(1);
				}
			}
			return returnvalue.like();
		}
		// UNREACHABLE! :returnvalue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnvalue.like();
	}
	public ClarionNumber takecloseevent()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		report.detail1.print();
		returnvalue.setValue(super.takecloseevent());
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
			{
				int case_1=CWin.event();
				boolean case_1_break=false;
				if (case_1==Event.CLOSEWINDOW) {
					this.keepvisible.setValue(1);
					case_1_break=true;
				}
				if (!case_1_break && case_1==Event.TIMER) {
					if (this.paused.boolValue()) {
						return Clarion.newNumber(Level.BENIGN);
					}
					case_1_break=true;
				}
			}
			returnvalue.setValue(super.takewindowevent());
			{
				int case_2=CWin.event();
				if (case_2==Event.CLOSEWINDOW) {
					if (!this.cancelled.boolValue()) {
						progressThermometer.setValue(0);
						Clarion.getControl(progresswindow._progressPcttext).setProperty(Prop.TEXT,"0% Completed");
						this.deferopenreport.setValue(1);
						CWin.getTarget().setProperty(Prop.TIMER,0);
						Clarion.getControl(progresswindow._pause).setProperty(Prop.TEXT,"Go");
						this.paused.setValue(1);
						this.process.close();
						this.response.setValue(Constants.REQUESTCANCELLED);
						CWin.display();
						return Clarion.newNumber(Level.NOTIFY);
					}
				}
			}
			return returnvalue.like();
		}
		// UNREACHABLE! :returnvalue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnvalue.like();
	}
	public void update()
	{
		super.update();
		Main.products.productnumber.setValue(Main.detail.productnumber);
		Main.accessProducts.fetch(Main.products.keyproductnumber);
	}
}
