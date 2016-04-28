package clarion.invoi001;

import clarion.Main;
import clarion.abtoolba.Toolbarclass;
import clarion.abtoolba.Toolbarupdateclass;
import clarion.abwindow.Windowmanager;
import clarion.equates.Appstrategy;
import clarion.equates.Button;
import clarion.equates.Cancel;
import clarion.equates.Constants;
import clarion.equates.Delete;
import clarion.equates.Event;
import clarion.equates.Icon;
import clarion.equates.Insert;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.invoi001.Fieldcolorqueue_1;
import clarion.invoi001.Invoi001;
import clarion.invoi001.Quickwindow_3;
import clarion.invoi001.Resizer_4;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Thiswindow_4 extends Windowmanager
{
	ClarionString actionmessage;
	Quickwindow_3 quickwindow;
	Toolbarclass toolbar;
	ClarionDecimal savQuantity;
	ClarionNumber savBackorder;
	ClarionNumber checkflag;
	Thiswindow_4 thiswindow;
	ClarionString productdescription;
	Resizer_4 resizer;
	Toolbarupdateclass toolbarform;
	ClarionDecimal locQuantityavailable;
	Fieldcolorqueue_1 fieldcolorqueue;
	ClarionDecimal newQuantity;
	ClarionDecimal locRegtotalprice;
	ClarionDecimal locDisctotalprice;
	public Thiswindow_4(ClarionString actionmessage,Quickwindow_3 quickwindow,Toolbarclass toolbar,ClarionDecimal savQuantity,ClarionNumber savBackorder,ClarionNumber checkflag,Thiswindow_4 thiswindow,ClarionString productdescription,Resizer_4 resizer,Toolbarupdateclass toolbarform,ClarionDecimal locQuantityavailable,Fieldcolorqueue_1 fieldcolorqueue,ClarionDecimal newQuantity,ClarionDecimal locRegtotalprice,ClarionDecimal locDisctotalprice)
	{
		this.actionmessage=actionmessage;
		this.quickwindow=quickwindow;
		this.toolbar=toolbar;
		this.savQuantity=savQuantity;
		this.savBackorder=savBackorder;
		this.checkflag=checkflag;
		this.thiswindow=thiswindow;
		this.productdescription=productdescription;
		this.resizer=resizer;
		this.toolbarform=toolbarform;
		this.locQuantityavailable=locQuantityavailable;
		this.fieldcolorqueue=fieldcolorqueue;
		this.newQuantity=newQuantity;
		this.locRegtotalprice=locRegtotalprice;
		this.locDisctotalprice=locDisctotalprice;
	}
	public Thiswindow_4() {}
	public void __Init__(ClarionString actionmessage,Quickwindow_3 quickwindow,Toolbarclass toolbar,ClarionDecimal savQuantity,ClarionNumber savBackorder,ClarionNumber checkflag,Thiswindow_4 thiswindow,ClarionString productdescription,Resizer_4 resizer,Toolbarupdateclass toolbarform,ClarionDecimal locQuantityavailable,Fieldcolorqueue_1 fieldcolorqueue,ClarionDecimal newQuantity,ClarionDecimal locRegtotalprice,ClarionDecimal locDisctotalprice)
	{
		this.actionmessage=actionmessage;
		this.quickwindow=quickwindow;
		this.toolbar=toolbar;
		this.savQuantity=savQuantity;
		this.savBackorder=savBackorder;
		this.checkflag=checkflag;
		this.thiswindow=thiswindow;
		this.productdescription=productdescription;
		this.resizer=resizer;
		this.toolbarform=toolbarform;
		this.locQuantityavailable=locQuantityavailable;
		this.fieldcolorqueue=fieldcolorqueue;
		this.newQuantity=newQuantity;
		this.locRegtotalprice=locRegtotalprice;
		this.locDisctotalprice=locDisctotalprice;
	}

	public void ask()
	{
		{
			ClarionNumber case_1=this.request;
			boolean case_1_break=false;
			if (case_1.equals(Constants.VIEWRECORD)) {
				actionmessage.setValue("View Record");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.INSERTRECORD)) {
				actionmessage.setValue("Adding a Detail Record");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.CHANGERECORD)) {
				actionmessage.setValue("Changing a Detail Record");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.DELETERECORD)) {
				actionmessage.setValue("Deleting a Detail Record");
				case_1_break=true;
			}
		}
		quickwindow.setClonedProperty(Prop.TEXT,actionmessage);
		super.ask();
	}
	public ClarionNumber init()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalerrors.setprocedurename(Clarion.newString("UpdateDetail"));
		this.request.setValue(Main.globalrequest);
		returnvalue.setValue(super.init());
		if (returnvalue.boolValue()) {
			return returnvalue.like();
		}
		this.firstfield.setValue(quickwindow._dtlProductnumberPrompt);
		this.vcrrequest=Main.vcrrequest;
		this.errors=Main.globalerrors;
		this.additem(toolbar);
		Main.globalrequest.clear();
		Main.globalresponse.clear();
		savQuantity.setValue(Main.detail.quantityordered);
		savBackorder.setValue(Main.detail.backordered);
		checkflag.setValue(Constants.FALSE);
		this.historykey.setValue(734);
		this.addhistoryfile(Main.detail,Invoi001.updatedetail_historyDtlRecord);
		this.addhistoryfield(Clarion.newNumber(quickwindow._dtlProductnumber),Clarion.newNumber(4));
		this.addhistoryfield(Clarion.newNumber(quickwindow._dtlLinenumber),Clarion.newNumber(3));
		this.addhistoryfield(Clarion.newNumber(quickwindow._dtlQuantityordered),Clarion.newNumber(5));
		this.addhistoryfield(Clarion.newNumber(quickwindow._dtlPrice),Clarion.newNumber(7));
		this.addhistoryfield(Clarion.newNumber(quickwindow._dtlTaxrate),Clarion.newNumber(8));
		this.addhistoryfield(Clarion.newNumber(quickwindow._dtlDiscountrate),Clarion.newNumber(10));
		this.addhistoryfield(Clarion.newNumber(quickwindow._dtlBackordered),Clarion.newNumber(6));
		this.addupdatefile(Main.accessDetail);
		this.additem(Clarion.newNumber(quickwindow._cancel),Clarion.newNumber(Constants.REQUESTCANCELLED));
		Main.relateDetail.open();
		Main.relateInvhist.open();
		Main.relateProducts.open();
		this.filesopened.setValue(Constants.TRUE);
		this.primary=Main.relateDetail;
		if (this.request.equals(Constants.VIEWRECORD)) {
			this.insertaction.setValue(Insert.NONE);
			this.deleteaction.setValue(Delete.NONE);
			this.changeaction.setValue(0);
			this.cancelaction.setValue(Cancel.CANCEL);
			this.okcontrol.setValue(0);
		}
		else {
			this.insertaction.setValue(Insert.QUERY);
			this.deleteaction.setValue(Delete.FORM);
			this.cancelaction.setValue(Cancel.CANCEL+Cancel.QUERY);
			this.okcontrol.setValue(quickwindow._ok);
			if (this.primeupdate().boolValue()) {
				return Clarion.newNumber(Level.NOTIFY);
			}
		}
		quickwindow.open();
		this.opened.setValue(Constants.TRUE);
		if (thiswindow.request.equals(Constants.CHANGERECORD) || thiswindow.request.equals(Constants.DELETERECORD)) {
			Main.products.productnumber.setValue(Main.detail.productnumber);
			Main.accessProducts.tryfetch(Main.products.keyproductnumber);
			productdescription.setValue(Main.products.description);
		}
		quickwindow.setProperty(Prop.MINWIDTH,191);
		quickwindow.setProperty(Prop.MINHEIGHT,112);
		resizer.init(Clarion.newNumber(Appstrategy.SPREAD));
		this.additem(resizer);
		Main.inimgr.fetch(Clarion.newString("UpdateDetail"),quickwindow);
		resizer.resize();
		resizer.reset();
		toolbarform.helpbutton.setValue(quickwindow._help);
		this.additem(toolbarform);
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
			Main.relateDetail.close();
			Main.relateInvhist.close();
			Main.relateProducts.close();
		}
		if (this.opened.boolValue()) {
			Main.inimgr.update(Clarion.newString("UpdateDetail"),quickwindow);
		}
		Main.globalerrors.setprocedurename();
		return returnvalue.like();
	}
	public ClarionNumber run()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		returnvalue.setValue(super.run());
		if (this.request.equals(Constants.VIEWRECORD)) {
			returnvalue.setValue(Constants.REQUESTCANCELLED);
		}
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
			Invoi001.selectproducts();
			returnvalue.setValue(Main.globalresponse);
		}
		if (Main.globalresponse.equals(Constants.REQUESTCOMPLETED)) {
			Main.detail.productnumber.setValue(Main.products.productnumber);
			productdescription.setValue(Main.products.description);
			Main.detail.price.setValue(Main.products.price);
			locQuantityavailable.setValue(Main.products.quantityinstock);
			CWin.display();
			if (locQuantityavailable.compareTo(0)<=0) {
				{
					int case_1=CWin.message(Clarion.newString("Yes for BACKORDER or No for CANCEL"),Clarion.newString("OUT OF STOCK: Select Order Options"),Icon.QUESTION,Button.YES+Button.NO,Button.YES,1);
					boolean case_1_break=false;
					if (case_1==Button.YES) {
						Main.detail.backordered.setValue(Constants.TRUE);
						CWin.display();
						CWin.select(quickwindow._dtlQuantityordered);
						case_1_break=true;
					}
					if (!case_1_break && case_1==Button.NO) {
						if (thiswindow.request.equals(Constants.INSERTRECORD)) {
							thiswindow.response.setValue(Constants.REQUESTCANCELLED);
							Main.accessDetail.cancelautoinc();
							CWin.post(Event.CLOSEWINDOW);
						}
						case_1_break=true;
					}
				}
			}
			if (thiswindow.request.equals(Constants.CHANGERECORD)) {
				if (Main.detail.quantityordered.compareTo(locQuantityavailable)<0) {
					Main.detail.backordered.setValue(Constants.FALSE);
					CWin.display();
				}
				else {
					Main.detail.backordered.setValue(Constants.TRUE);
					CWin.display();
				}
			}
			if (productdescription.equals("")) {
				Main.detail.price.clear();
				CWin.select(quickwindow._calllookup);
			}
			CWin.select(quickwindow._dtlQuantityordered);
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
				boolean case_1_break=false;
				if (case_1==quickwindow._dtlProductnumber) {
					if (Main.accessDetail.tryvalidatefield(Clarion.newNumber(4)).boolValue()) {
						CWin.select(quickwindow._dtlProductnumber);
						quickwindow.setProperty(Prop.ACCEPTALL,Constants.FALSE);
						continue;
					}
					else {
						fieldcolorqueue.feq.setValue(quickwindow._dtlProductnumber);
						fieldcolorqueue.get(fieldcolorqueue.ORDER().ascend(fieldcolorqueue.feq));
						if (!(CError.errorCode()!=0)) {
							Clarion.getControl(quickwindow._dtlProductnumber).setClonedProperty(Prop.FONTCOLOR,fieldcolorqueue.oldcolor);
							fieldcolorqueue.delete();
						}
					}
					case_1_break=true;
				}
				if (!case_1_break && case_1==quickwindow._calllookup) {
					thiswindow.update();
					Main.products.productnumber.setValue(Main.detail.productnumber);
					if (this.run(Clarion.newNumber(1),Clarion.newNumber(Constants.SELECTRECORD)).equals(Constants.REQUESTCOMPLETED)) {
						Main.detail.productnumber.setValue(Main.products.productnumber);
					}
					thiswindow.reset(Clarion.newNumber(1));
					case_1_break=true;
				}
				if (!case_1_break && case_1==quickwindow._dtlQuantityordered) {
					if (Main.accessDetail.tryvalidatefield(Clarion.newNumber(5)).boolValue()) {
						CWin.select(quickwindow._dtlQuantityordered);
						quickwindow.setProperty(Prop.ACCEPTALL,Constants.FALSE);
						continue;
					}
					else {
						fieldcolorqueue.feq.setValue(quickwindow._dtlQuantityordered);
						fieldcolorqueue.get(fieldcolorqueue.ORDER().ascend(fieldcolorqueue.feq));
						if (!(CError.errorCode()!=0)) {
							Clarion.getControl(quickwindow._dtlQuantityordered).setClonedProperty(Prop.FONTCOLOR,fieldcolorqueue.oldcolor);
							fieldcolorqueue.delete();
						}
					}
					newQuantity.setValue(Main.detail.quantityordered);
					if (checkflag.equals(Constants.FALSE)) {
						if (locQuantityavailable.compareTo(0)>0) {
							if (Main.detail.quantityordered.compareTo(locQuantityavailable)>0) {
								{
									int case_2=CWin.message(Clarion.newString("Yes for BACKORDER or No for CANCEL"),Clarion.newString("LOW STOCK: Select Order Options"),Icon.QUESTION,Button.YES+Button.NO,Button.YES,1);
									boolean case_2_break=false;
									if (case_2==Button.YES) {
										Main.detail.backordered.setValue(Constants.TRUE);
										CWin.display();
										case_2_break=true;
									}
									if (!case_2_break && case_2==Button.NO) {
										if (thiswindow.request.equals(Constants.INSERTRECORD)) {
											thiswindow.response.setValue(Constants.REQUESTCANCELLED);
											Main.accessDetail.cancelautoinc();
											CWin.post(Event.CLOSEWINDOW);
										}
										case_2_break=true;
									}
								}
							}
							else {
								Main.detail.backordered.setValue(Constants.FALSE);
								CWin.display();
							}
						}
						if (thiswindow.request.equals(Constants.CHANGERECORD)) {
							if (Main.detail.quantityordered.compareTo(locQuantityavailable)<=0) {
								Main.detail.backordered.setValue(Constants.FALSE);
								CWin.display();
							}
							else {
								Main.detail.backordered.setValue(Constants.TRUE);
								CWin.display();
							}
						}
						checkflag.setValue(Constants.TRUE);
					}
					case_1_break=true;
				}
				if (!case_1_break && case_1==quickwindow._ok) {
					thiswindow.update();
					takeaccepted_calcvalues(locRegtotalprice,locDisctotalprice);
					if (this.request.equals(Constants.VIEWRECORD)) {
						CWin.post(Event.CLOSEWINDOW);
					}
					case_1_break=true;
				}
			}
			return returnvalue.like();
		}
		// UNREACHABLE! :returnvalue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnvalue.like();
	}
	public void takeaccepted_calcvalues(ClarionDecimal locRegtotalprice,ClarionDecimal locDisctotalprice)
	{
		Invoi001.updatedetail_calcvalues(locRegtotalprice,locDisctotalprice);
	}
	public ClarionNumber takecompleted()
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
			takecompleted_updateotherfiles(thiswindow,savBackorder,savQuantity,newQuantity);
			returnvalue.setValue(super.takecompleted());
			return returnvalue.like();
		}
		// UNREACHABLE! :returnvalue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnvalue.like();
	}
	public void takecompleted_updateotherfiles(Thiswindow_4 thiswindow,ClarionNumber savBackorder,ClarionDecimal savQuantity,ClarionDecimal newQuantity)
	{
		Invoi001.updatedetail_updateotherfiles(thiswindow,savBackorder,savQuantity,newQuantity);
	}
	public ClarionNumber takeselected()
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
			returnvalue.setValue(super.takeselected());
			{
				int case_1=CWin.field();
				if (case_1==quickwindow._dtlProductnumber) {
					Main.products.productnumber.setValue(Main.detail.productnumber);
					if (Main.accessProducts.tryfetch(Main.products.keyproductnumber).boolValue()) {
						if (this.run(Clarion.newNumber(1),Clarion.newNumber(Constants.SELECTRECORD)).equals(Constants.REQUESTCOMPLETED)) {
							Main.detail.productnumber.setValue(Main.products.productnumber);
						}
					}
					thiswindow.reset();
				}
			}
			return returnvalue.like();
		}
		// UNREACHABLE! :returnvalue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnvalue.like();
	}
}
