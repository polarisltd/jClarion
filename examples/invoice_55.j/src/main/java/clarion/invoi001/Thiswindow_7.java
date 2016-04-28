package clarion.invoi001;

import clarion.Main;
import clarion.abbrowse.Steplongclass;
import clarion.abreport.Printpreviewclass;
import clarion.abreport.Reportmanager;
import clarion.equates.Constants;
import clarion.equates.Prop;
import clarion.equates.Propagate;
import clarion.equates.Scrollsort;
import clarion.invoi001.Progresswindow;
import clarion.invoi001.Report;
import clarion.invoi001.Thisreport;
import clarion.invoi001.equates.Mconstants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CExpression;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Thiswindow_7 extends Reportmanager
{
	Progresswindow progresswindow;
	Steplongclass progressmgr;
	Thisreport thisreport;
	ClarionView processView;
	ClarionNumber progressThermometer;
	Report report;
	Printpreviewclass previewer;
	ClarionString locCcsz;
	public Thiswindow_7(Progresswindow progresswindow,Steplongclass progressmgr,Thisreport thisreport,ClarionView processView,ClarionNumber progressThermometer,Report report,Printpreviewclass previewer,ClarionString locCcsz)
	{
		this.progresswindow=progresswindow;
		this.progressmgr=progressmgr;
		this.thisreport=thisreport;
		this.processView=processView;
		this.progressThermometer=progressThermometer;
		this.report=report;
		this.previewer=previewer;
		this.locCcsz=locCcsz;
	}

	public ClarionNumber init()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalerrors.setprocedurename(Clarion.newString("PrintInvoiceFromBrowse"));
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
		Main.inimgr.fetch(Clarion.newString("PrintInvoiceFromBrowse"),progresswindow);
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
			Main.inimgr.update(Clarion.newString("PrintInvoiceFromBrowse"),progresswindow);
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
	public ClarionNumber takecloseevent()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		report.detail1.print();
		returnvalue.setValue(super.takecloseevent());
		return returnvalue.like();
	}
	public void update()
	{
		super.update();
		Main.products.productnumber.setValue(Main.detail.productnumber);
		Main.accessProducts.fetch(Main.products.keyproductnumber);
	}
}
