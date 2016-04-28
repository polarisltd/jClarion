package clarion;

import clarion.Brw1_2;
import clarion.Filterlocatorclass;
import clarion.Invoi001;
import clarion.Invoi002;
import clarion.Main;
import clarion.Queryformclass;
import clarion.Queryformvisual;
import clarion.QueueBrowse_1_3;
import clarion.QuickWindow_8;
import clarion.Resizer_9;
import clarion.Stepstringclass;
import clarion.Toolbarclass;
import clarion.Windowmanager;
import clarion.equates.Appstrategy;
import clarion.equates.Constants;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.equates.Scrollby;
import clarion.equates.Scrollsort;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CExpression;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.view.ClarionView;

public class Thiswindow_16 extends Windowmanager
{
	QuickWindow_8 quickWindow;
	ClarionString lOCFilterString;
	ClarionString lOCCompanyLetter;
	ClarionString lOCZipNum;
	ClarionString lOCState;
	ClarionString lOCNameLetter;
	Toolbarclass toolbar;
	Brw1_2 brw1;
	QueueBrowse_1_3 queueBrowse_1;
	ClarionView bRW1ViewBrowse;
	Queryformclass qbe6;
	Queryformvisual qbv6;
	Stepstringclass bRW1Sort1StepClass;
	Filterlocatorclass bRW1Sort1Locator;
	Stepstringclass bRW1Sort2StepClass;
	Filterlocatorclass bRW1Sort2Locator;
	Stepstringclass bRW1Sort3StepClass;
	Filterlocatorclass bRW1Sort3Locator;
	Stepstringclass bRW1Sort0StepClass;
	Filterlocatorclass bRW1Sort0Locator;
	Resizer_9 resizer;
	Thiswindow_16 thisWindow;
	public Thiswindow_16(QuickWindow_8 quickWindow,ClarionString lOCFilterString,ClarionString lOCCompanyLetter,ClarionString lOCZipNum,ClarionString lOCState,ClarionString lOCNameLetter,Toolbarclass toolbar,Brw1_2 brw1,QueueBrowse_1_3 queueBrowse_1,ClarionView bRW1ViewBrowse,Queryformclass qbe6,Queryformvisual qbv6,Stepstringclass bRW1Sort1StepClass,Filterlocatorclass bRW1Sort1Locator,Stepstringclass bRW1Sort2StepClass,Filterlocatorclass bRW1Sort2Locator,Stepstringclass bRW1Sort3StepClass,Filterlocatorclass bRW1Sort3Locator,Stepstringclass bRW1Sort0StepClass,Filterlocatorclass bRW1Sort0Locator,Resizer_9 resizer,Thiswindow_16 thisWindow)
	{
		this.quickWindow=quickWindow;
		this.lOCFilterString=lOCFilterString;
		this.lOCCompanyLetter=lOCCompanyLetter;
		this.lOCZipNum=lOCZipNum;
		this.lOCState=lOCState;
		this.lOCNameLetter=lOCNameLetter;
		this.toolbar=toolbar;
		this.brw1=brw1;
		this.queueBrowse_1=queueBrowse_1;
		this.bRW1ViewBrowse=bRW1ViewBrowse;
		this.qbe6=qbe6;
		this.qbv6=qbv6;
		this.bRW1Sort1StepClass=bRW1Sort1StepClass;
		this.bRW1Sort1Locator=bRW1Sort1Locator;
		this.bRW1Sort2StepClass=bRW1Sort2StepClass;
		this.bRW1Sort2Locator=bRW1Sort2Locator;
		this.bRW1Sort3StepClass=bRW1Sort3StepClass;
		this.bRW1Sort3Locator=bRW1Sort3Locator;
		this.bRW1Sort0StepClass=bRW1Sort0StepClass;
		this.bRW1Sort0Locator=bRW1Sort0Locator;
		this.resizer=resizer;
		this.thisWindow=thisWindow;
	}
	public Thiswindow_16() {}
	public void __Init__(QuickWindow_8 quickWindow,ClarionString lOCFilterString,ClarionString lOCCompanyLetter,ClarionString lOCZipNum,ClarionString lOCState,ClarionString lOCNameLetter,Toolbarclass toolbar,Brw1_2 brw1,QueueBrowse_1_3 queueBrowse_1,ClarionView bRW1ViewBrowse,Queryformclass qbe6,Queryformvisual qbv6,Stepstringclass bRW1Sort1StepClass,Filterlocatorclass bRW1Sort1Locator,Stepstringclass bRW1Sort2StepClass,Filterlocatorclass bRW1Sort2Locator,Stepstringclass bRW1Sort3StepClass,Filterlocatorclass bRW1Sort3Locator,Stepstringclass bRW1Sort0StepClass,Filterlocatorclass bRW1Sort0Locator,Resizer_9 resizer,Thiswindow_16 thisWindow)
	{
		this.quickWindow=quickWindow;
		this.lOCFilterString=lOCFilterString;
		this.lOCCompanyLetter=lOCCompanyLetter;
		this.lOCZipNum=lOCZipNum;
		this.lOCState=lOCState;
		this.lOCNameLetter=lOCNameLetter;
		this.toolbar=toolbar;
		this.brw1=brw1;
		this.queueBrowse_1=queueBrowse_1;
		this.bRW1ViewBrowse=bRW1ViewBrowse;
		this.qbe6=qbe6;
		this.qbv6=qbv6;
		this.bRW1Sort1StepClass=bRW1Sort1StepClass;
		this.bRW1Sort1Locator=bRW1Sort1Locator;
		this.bRW1Sort2StepClass=bRW1Sort2StepClass;
		this.bRW1Sort2Locator=bRW1Sort2Locator;
		this.bRW1Sort3StepClass=bRW1Sort3StepClass;
		this.bRW1Sort3Locator=bRW1Sort3Locator;
		this.bRW1Sort0StepClass=bRW1Sort0StepClass;
		this.bRW1Sort0Locator=bRW1Sort0Locator;
		this.resizer=resizer;
		this.thisWindow=thisWindow;
	}

	public ClarionNumber init()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalErrors.setProcedureName(Clarion.newString("BrowseCustomers"));
		this.request.setValue(Main.globalRequest);
		returnValue.setValue(super.init());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		this.firstField.setValue(quickWindow._string7);
		this.vCRRequest=Main.vCRRequest;
		this.errors=Main.globalErrors;
		CExpression.bind("GLOT:CusCSZ",Main.gLOTCusCSZ);
		CExpression.bind("LOC:FilterString",lOCFilterString);
		CExpression.bind("LOC:CompanyLetter",lOCCompanyLetter);
		CExpression.bind("LOC:ZipNum",lOCZipNum);
		CExpression.bind("LOC:State",lOCState);
		CExpression.bind("LOC:NameLetter",lOCNameLetter);
		Main.globalRequest.clear();
		Main.globalResponse.clear();
		this.addItem(toolbar);
		this.addItem(Clarion.newNumber(quickWindow._close),Clarion.newNumber(Constants.REQUESTCANCELLED));
		Main.relateCustomers.get().open();
		this.filesOpened.setValue(Constants.TRUE);
		brw1.init(Clarion.newNumber(quickWindow._browse_1),queueBrowse_1.viewPosition,bRW1ViewBrowse,queueBrowse_1,Main.relateCustomers.get(),this);
		quickWindow.open();
		this.opened.setValue(Constants.TRUE);
		Clarion.getControl(quickWindow._browse_1).setProperty(Prop.LINEHEIGHT,0);
		init_DefineListboxStyle();
		qbe6.init(qbv6,Main.iNIMgr,Clarion.newString("BrowseCustomers"),Main.globalErrors);
		qbe6.qkSupport.setValue(Constants.TRUE);
		qbe6.qkMenuIcon.setValue("QkQBE.ico");
		qbe6.qkIcon.setValue("QkLoad.ico");
		brw1.q=queueBrowse_1;
		bRW1Sort1StepClass.init(Clarion.newNumber(Scrollsort.ALLOWALPHA),Clarion.newNumber(Scrollby.RUNTIME));
		brw1.addSortOrder(bRW1Sort1StepClass,Main.customers.keyCompany);
		brw1.addLocator(bRW1Sort1Locator);
		bRW1Sort1Locator.init(Clarion.newNumber(quickWindow._cUSCompany),Main.customers.company,Clarion.newNumber(1),brw1);
		bRW1Sort2StepClass.init(Clarion.newNumber(Scrollsort.ALLOWALPHA),Clarion.newNumber(Scrollby.RUNTIME));
		brw1.addSortOrder(bRW1Sort2StepClass,Main.customers.keyZipCode);
		brw1.addLocator(bRW1Sort2Locator);
		bRW1Sort2Locator.init(Clarion.newNumber(quickWindow._cUSZipCode),Main.customers.zipCode,Clarion.newNumber(1),brw1);
		bRW1Sort3StepClass.init(Clarion.newNumber(Scrollsort.ALLOWALPHA),Clarion.newNumber(Scrollby.RUNTIME));
		brw1.addSortOrder(bRW1Sort3StepClass,Main.customers.stateKey);
		brw1.addLocator(bRW1Sort3Locator);
		bRW1Sort3Locator.init(Clarion.newNumber(quickWindow._cUSState),Main.customers.state,Clarion.newNumber(1),brw1);
		bRW1Sort0StepClass.init(Clarion.newNumber(Scrollsort.ALLOWALPHA),Clarion.newNumber(Scrollby.RUNTIME));
		brw1.addSortOrder(bRW1Sort0StepClass,Main.customers.keyFullName);
		brw1.addLocator(bRW1Sort0Locator);
		bRW1Sort0Locator.init(Clarion.newNumber(quickWindow._cUSLastName),Main.customers.lastName,Clarion.newNumber(1),brw1);
		brw1.addField(Main.customers.firstName,brw1.q.cUSFirstName);
		brw1.addField(Main.customers.mi,brw1.q.cusMi);
		brw1.addField(Main.customers.lastName,brw1.q.cUSLastName);
		brw1.addField(Main.customers.company,brw1.q.cUSCompany);
		brw1.addField(Main.customers.state,brw1.q.cUSState);
		brw1.addField(Main.customers.zipCode,brw1.q.cUSZipCode);
		brw1.addField(Main.customers.address1,brw1.q.cUSAddress1);
		brw1.addField(Main.customers.address2,brw1.q.cUSAddress2);
		brw1.addField(Main.customers.city,brw1.q.cUSCity);
		brw1.addField(Main.gLOTCusCSZ,brw1.q.gLOTCusCSZ);
		brw1.addField(Main.customers.phoneNumber,brw1.q.cUSPhoneNumber);
		brw1.addField(lOCFilterString,brw1.q.lOCFilterString);
		brw1.addField(lOCCompanyLetter,brw1.q.lOCCompanyLetter);
		brw1.addField(lOCZipNum,brw1.q.lOCZipNum);
		brw1.addField(lOCState,brw1.q.lOCState);
		brw1.addField(lOCNameLetter,brw1.q.lOCNameLetter);
		quickWindow.setProperty(Prop.MINWIDTH,315);
		quickWindow.setProperty(Prop.MINHEIGHT,209);
		resizer.init(Clarion.newNumber(Appstrategy.SPREAD));
		this.addItem(resizer);
		brw1.queryControl.setValue(quickWindow._query);
		brw1.query=qbe6;
		qbe6.addItem(Clarion.newString("UPPER(CUS:FirstName)"),Clarion.newString("FirstName"),Clarion.newString("@s20"),Clarion.newNumber(1));
		qbe6.addItem(Clarion.newString("UPPER(CUS:LastName)"),Clarion.newString("LastName"),Clarion.newString("@s25"),Clarion.newNumber(1));
		qbe6.addItem(Clarion.newString("UPPER(CUS:Company)"),Clarion.newString("Company"),Clarion.newString("@s25"),Clarion.newNumber(1));
		qbe6.addItem(Clarion.newString("UPPER(CUS:ZipCode)"),Clarion.newString("Zipcode"),Clarion.newString("@s10"),Clarion.newNumber(1));
		qbe6.addItem(Clarion.newString("CUS:State"),Clarion.newString("State"),Clarion.newString("@s2"),Clarion.newNumber(1));
		brw1.askProcedure.setValue(1);
		brw1.addToolbarTarget(toolbar);
		brw1.toolbarItem.helpButton.setValue(quickWindow._help);
		brw1.printProcedure.setValue(2);
		brw1.printControl.setValue(quickWindow._print);
		this.setAlerts();
		return returnValue.like();
	}
	public void init_DefineListboxStyle()
	{
		Invoi002.browseCustomers_DefineListboxStyle();
	}
	public ClarionNumber kill()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(super.kill());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		if (this.filesOpened.boolValue()) {
			Main.relateCustomers.get().close();
		}
		Main.globalErrors.setProcedureName();
		return returnValue.like();
	}
	public ClarionNumber run(ClarionNumber number,ClarionNumber request)
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnValue.setValue(super.run(number.like(),request.like()));
		if (this.request.equals(Constants.VIEWRECORD)) {
			returnValue.setValue(Constants.REQUESTCANCELLED);
		}
		else {
			Main.globalRequest.setValue(request);
			{
				int execute_1=number.intValue();
				if (execute_1==1) {
					Invoi001.updateCustomers();
				}
				if (execute_1==2) {
					Invoi002.printSelectedCustomer();
				}
			}
			returnValue.setValue(Main.globalResponse);
		}
		if (number.equals(2)) {
			thisWindow.reset(Clarion.newNumber(Constants.TRUE));
		}
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
			returnValue.setValue(super.takeAccepted());
			{
				int case_1=CWin.accepted();
				if (case_1==quickWindow._bOButton) {
					thisWindow.update();
					Invoi002.browseOrders();
					thisWindow.reset();
				}
			}
			return returnValue.like();
		}
		// UNREACHABLE! :returnValue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnValue.like();
	}
}
