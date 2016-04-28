package clarion.invoi001;

import clarion.Main;
import clarion.abbrowse.Filterlocatorclass;
import clarion.abbrowse.Stepstringclass;
import clarion.abquery.Queryformclass_1;
import clarion.abquery.Queryformvisual_1;
import clarion.abtoolba.Toolbarclass;
import clarion.abwindow.Windowmanager;
import clarion.equates.Appstrategy;
import clarion.equates.Constants;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.equates.Scrollby;
import clarion.equates.Scrollsort;
import clarion.invoi001.Brw1_2;
import clarion.invoi001.Invoi001;
import clarion.invoi001.QueueBrowse_1_3;
import clarion.invoi001.Quickwindow_6;
import clarion.invoi001.Resizer_7;
import clarion.invoi003.Invoi003;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CExpression;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Thiswindow_9 extends Windowmanager
{
	Quickwindow_6 quickwindow;
	Toolbarclass toolbar;
	Brw1_2 brw1;
	QueueBrowse_1_3 queueBrowse_1;
	ClarionView brw1ViewBrowse;
	Queryformclass_1 qbe6;
	Queryformvisual_1 qbv6;
	Stepstringclass brw1Sort1Stepclass;
	Filterlocatorclass brw1Sort1Locator;
	Stepstringclass brw1Sort2Stepclass;
	Filterlocatorclass brw1Sort2Locator;
	Stepstringclass brw1Sort3Stepclass;
	Filterlocatorclass brw1Sort3Locator;
	Stepstringclass brw1Sort0Stepclass;
	Filterlocatorclass brw1Sort0Locator;
	ClarionString locFilterstring;
	ClarionString locCompanyletter;
	ClarionString locZipnum;
	ClarionString locState;
	ClarionString locNameletter;
	Resizer_7 resizer;
	Thiswindow_9 thiswindow;
	public Thiswindow_9(Quickwindow_6 quickwindow,Toolbarclass toolbar,Brw1_2 brw1,QueueBrowse_1_3 queueBrowse_1,ClarionView brw1ViewBrowse,Queryformclass_1 qbe6,Queryformvisual_1 qbv6,Stepstringclass brw1Sort1Stepclass,Filterlocatorclass brw1Sort1Locator,Stepstringclass brw1Sort2Stepclass,Filterlocatorclass brw1Sort2Locator,Stepstringclass brw1Sort3Stepclass,Filterlocatorclass brw1Sort3Locator,Stepstringclass brw1Sort0Stepclass,Filterlocatorclass brw1Sort0Locator,ClarionString locFilterstring,ClarionString locCompanyletter,ClarionString locZipnum,ClarionString locState,ClarionString locNameletter,Resizer_7 resizer,Thiswindow_9 thiswindow)
	{
		this.quickwindow=quickwindow;
		this.toolbar=toolbar;
		this.brw1=brw1;
		this.queueBrowse_1=queueBrowse_1;
		this.brw1ViewBrowse=brw1ViewBrowse;
		this.qbe6=qbe6;
		this.qbv6=qbv6;
		this.brw1Sort1Stepclass=brw1Sort1Stepclass;
		this.brw1Sort1Locator=brw1Sort1Locator;
		this.brw1Sort2Stepclass=brw1Sort2Stepclass;
		this.brw1Sort2Locator=brw1Sort2Locator;
		this.brw1Sort3Stepclass=brw1Sort3Stepclass;
		this.brw1Sort3Locator=brw1Sort3Locator;
		this.brw1Sort0Stepclass=brw1Sort0Stepclass;
		this.brw1Sort0Locator=brw1Sort0Locator;
		this.locFilterstring=locFilterstring;
		this.locCompanyletter=locCompanyletter;
		this.locZipnum=locZipnum;
		this.locState=locState;
		this.locNameletter=locNameletter;
		this.resizer=resizer;
		this.thiswindow=thiswindow;
	}
	public Thiswindow_9() {}
	public void __Init__(Quickwindow_6 quickwindow,Toolbarclass toolbar,Brw1_2 brw1,QueueBrowse_1_3 queueBrowse_1,ClarionView brw1ViewBrowse,Queryformclass_1 qbe6,Queryformvisual_1 qbv6,Stepstringclass brw1Sort1Stepclass,Filterlocatorclass brw1Sort1Locator,Stepstringclass brw1Sort2Stepclass,Filterlocatorclass brw1Sort2Locator,Stepstringclass brw1Sort3Stepclass,Filterlocatorclass brw1Sort3Locator,Stepstringclass brw1Sort0Stepclass,Filterlocatorclass brw1Sort0Locator,ClarionString locFilterstring,ClarionString locCompanyletter,ClarionString locZipnum,ClarionString locState,ClarionString locNameletter,Resizer_7 resizer,Thiswindow_9 thiswindow)
	{
		this.quickwindow=quickwindow;
		this.toolbar=toolbar;
		this.brw1=brw1;
		this.queueBrowse_1=queueBrowse_1;
		this.brw1ViewBrowse=brw1ViewBrowse;
		this.qbe6=qbe6;
		this.qbv6=qbv6;
		this.brw1Sort1Stepclass=brw1Sort1Stepclass;
		this.brw1Sort1Locator=brw1Sort1Locator;
		this.brw1Sort2Stepclass=brw1Sort2Stepclass;
		this.brw1Sort2Locator=brw1Sort2Locator;
		this.brw1Sort3Stepclass=brw1Sort3Stepclass;
		this.brw1Sort3Locator=brw1Sort3Locator;
		this.brw1Sort0Stepclass=brw1Sort0Stepclass;
		this.brw1Sort0Locator=brw1Sort0Locator;
		this.locFilterstring=locFilterstring;
		this.locCompanyletter=locCompanyletter;
		this.locZipnum=locZipnum;
		this.locState=locState;
		this.locNameletter=locNameletter;
		this.resizer=resizer;
		this.thiswindow=thiswindow;
	}

	public ClarionNumber init()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalerrors.setprocedurename(Clarion.newString("BrowseCustomers"));
		this.request.setValue(Main.globalrequest);
		returnvalue.setValue(super.init());
		if (returnvalue.boolValue()) {
			return returnvalue.like();
		}
		this.firstfield.setValue(quickwindow._string7);
		this.vcrrequest=Main.vcrrequest;
		this.errors=Main.globalerrors;
		this.additem(toolbar);
		Main.globalrequest.clear();
		Main.globalresponse.clear();
		this.additem(Clarion.newNumber(quickwindow._close),Clarion.newNumber(Constants.REQUESTCANCELLED));
		Main.relateCustomers.open();
		this.filesopened.setValue(Constants.TRUE);
		brw1.init(Clarion.newNumber(quickwindow._browse_1),queueBrowse_1.viewposition,brw1ViewBrowse,queueBrowse_1,Main.relateCustomers,this);
		quickwindow.open();
		this.opened.setValue(Constants.TRUE);
		qbe6.init(qbv6,Main.inimgr,Clarion.newString("BrowseCustomers"),Main.globalerrors);
		qbe6.qksupport.setValue(Constants.TRUE);
		qbe6.qkmenuicon.setValue("QkQBE.ico");
		qbe6.qkicon.setValue("QkLoad.ico");
		brw1.q=queueBrowse_1;
		brw1Sort1Stepclass.init(Clarion.newNumber(Scrollsort.ALLOWALPHA),Clarion.newNumber(Scrollby.RUNTIME));
		brw1.addsortorder(brw1Sort1Stepclass,Main.customers.keycompany);
		brw1.addlocator(brw1Sort1Locator);
		brw1Sort1Locator.init(Clarion.newNumber(quickwindow._cusCompany),Main.customers.company,Clarion.newNumber(1),brw1);
		brw1Sort2Stepclass.init(Clarion.newNumber(Scrollsort.ALLOWALPHA),Clarion.newNumber(Scrollby.RUNTIME));
		brw1.addsortorder(brw1Sort2Stepclass,Main.customers.keyzipcode);
		brw1.addlocator(brw1Sort2Locator);
		brw1Sort2Locator.init(Clarion.newNumber(quickwindow._cusZipcode),Main.customers.zipcode,Clarion.newNumber(1),brw1);
		brw1Sort3Stepclass.init(Clarion.newNumber(Scrollsort.ALLOWALPHA),Clarion.newNumber(Scrollby.RUNTIME));
		brw1.addsortorder(brw1Sort3Stepclass,Main.customers.statekey);
		brw1.addlocator(brw1Sort3Locator);
		brw1Sort3Locator.init(Clarion.newNumber(quickwindow._cusState),Main.customers.state,Clarion.newNumber(1),brw1);
		brw1Sort0Stepclass.init(Clarion.newNumber(Scrollsort.ALLOWALPHA),Clarion.newNumber(Scrollby.RUNTIME));
		brw1.addsortorder(brw1Sort0Stepclass,Main.customers.keyfullname);
		brw1.addlocator(brw1Sort0Locator);
		brw1Sort0Locator.init(Clarion.newNumber(quickwindow._cusLastname),Main.customers.lastname,Clarion.newNumber(1),brw1);
		CExpression.bind("GLOT:CusCSZ",Main.glotCuscsz);
		CExpression.bind("LOC:FilterString",locFilterstring);
		CExpression.bind("LOC:CompanyLetter",locCompanyletter);
		CExpression.bind("LOC:ZipNum",locZipnum);
		CExpression.bind("LOC:State",locState);
		CExpression.bind("LOC:NameLetter",locNameletter);
		brw1.addfield(Main.customers.firstname,brw1.q.cusFirstname);
		brw1.addfield(Main.customers.mi,brw1.q.cusMi);
		brw1.addfield(Main.customers.lastname,brw1.q.cusLastname);
		brw1.addfield(Main.customers.company,brw1.q.cusCompany);
		brw1.addfield(Main.customers.state,brw1.q.cusState);
		brw1.addfield(Main.customers.zipcode,brw1.q.cusZipcode);
		brw1.addfield(Main.customers.address1,brw1.q.cusAddress1);
		brw1.addfield(Main.customers.address2,brw1.q.cusAddress2);
		brw1.addfield(Main.customers.city,brw1.q.cusCity);
		brw1.addfield(Main.glotCuscsz,brw1.q.glotCuscsz);
		brw1.addfield(Main.customers.phonenumber,brw1.q.cusPhonenumber);
		brw1.addfield(locFilterstring,brw1.q.locFilterstring);
		brw1.addfield(locCompanyletter,brw1.q.locCompanyletter);
		brw1.addfield(locZipnum,brw1.q.locZipnum);
		brw1.addfield(locState,brw1.q.locState);
		brw1.addfield(locNameletter,brw1.q.locNameletter);
		quickwindow.setProperty(Prop.MINWIDTH,315);
		quickwindow.setProperty(Prop.MINHEIGHT,209);
		resizer.init(Clarion.newNumber(Appstrategy.SPREAD));
		this.additem(resizer);
		Main.inimgr.fetch(Clarion.newString("BrowseCustomers"),quickwindow);
		resizer.resize();
		resizer.reset();
		brw1.querycontrol.setValue(quickwindow._query);
		brw1.query=qbe6;
		qbe6.additem(Clarion.newString("UPPER(CUS:FirstName)"),Clarion.newString("FirstName"),Clarion.newString("@s20"),Clarion.newNumber(1));
		qbe6.additem(Clarion.newString("UPPER(CUS:LastName)"),Clarion.newString("LastName"),Clarion.newString("@s25"),Clarion.newNumber(1));
		qbe6.additem(Clarion.newString("UPPER(CUS:Company)"),Clarion.newString("Company"),Clarion.newString("@s25"),Clarion.newNumber(1));
		qbe6.additem(Clarion.newString("UPPER(CUS:ZipCode)"),Clarion.newString("Zipcode"),Clarion.newString("@s10"),Clarion.newNumber(1));
		qbe6.additem(Clarion.newString("CUS:State"),Clarion.newString("State"),Clarion.newString("@s2"),Clarion.newNumber(1));
		brw1.askprocedure.setValue(1);
		brw1.addtoolbartarget(toolbar);
		brw1.toolbaritem.helpbutton.setValue(quickwindow._help);
		brw1.printprocedure.setValue(2);
		brw1.printcontrol.setValue(quickwindow._print);
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
			Main.inimgr.update(Clarion.newString("BrowseCustomers"),quickwindow);
		}
		Main.globalerrors.setprocedurename();
		return returnvalue.like();
	}
	public ClarionNumber run(ClarionNumber number,ClarionNumber request)
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnvalue.setValue(super.run(number.like(),request.like()));
		if (this.request.equals(Constants.VIEWRECORD)) {
			returnvalue.setValue(Constants.REQUESTCANCELLED);
		}
		else {
			Main.globalrequest.setValue(request);
			{
				int execute_1=number.intValue();
				if (execute_1==1) {
					Invoi001.updatecustomers();
				}
				if (execute_1==2) {
					Invoi003.printselectedcustomer();
				}
			}
			returnvalue.setValue(Main.globalresponse);
		}
		if (number.equals(2)) {
			thiswindow.reset(Clarion.newNumber(Constants.TRUE));
		}
		return returnvalue.like();
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
			returnvalue.setValue(super.takeaccepted());
			{
				int case_1=CWin.accepted();
				if (case_1==quickwindow._bobutton) {
					thiswindow.update();
					Invoi001.browseorders();
					thiswindow.reset();
				}
			}
			return returnvalue.like();
		}
		// UNREACHABLE! :returnvalue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnvalue.like();
	}
}
