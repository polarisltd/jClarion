package clarion.invoi002;

import clarion.Main;
import clarion.abtoolba.Toolbarclass;
import clarion.abtoolba.Toolbarupdateclass;
import clarion.abutil.Selectfileclass;
import clarion.abwindow.Windowmanager;
import clarion.equates.Appstrategy;
import clarion.equates.Cancel;
import clarion.equates.Constants;
import clarion.equates.Delete;
import clarion.equates.Event;
import clarion.equates.Insert;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.invoi002.Invoi002;
import clarion.invoi002.Quickwindow;
import clarion.invoi002.Resizer;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CFile;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Thiswindow extends Windowmanager
{
	ClarionString actionmessage;
	Quickwindow quickwindow;
	Toolbarclass toolbar;
	Resizer resizer;
	Toolbarupdateclass toolbarform;
	Selectfileclass filelookup5;
	Thiswindow thiswindow;
	ClarionString locFilename;
	public Thiswindow(ClarionString actionmessage,Quickwindow quickwindow,Toolbarclass toolbar,Resizer resizer,Toolbarupdateclass toolbarform,Selectfileclass filelookup5,Thiswindow thiswindow,ClarionString locFilename)
	{
		this.actionmessage=actionmessage;
		this.quickwindow=quickwindow;
		this.toolbar=toolbar;
		this.resizer=resizer;
		this.toolbarform=toolbarform;
		this.filelookup5=filelookup5;
		this.thiswindow=thiswindow;
		this.locFilename=locFilename;
	}
	public Thiswindow() {}
	public void __Init__(ClarionString actionmessage,Quickwindow quickwindow,Toolbarclass toolbar,Resizer resizer,Toolbarupdateclass toolbarform,Selectfileclass filelookup5,Thiswindow thiswindow,ClarionString locFilename)
	{
		this.actionmessage=actionmessage;
		this.quickwindow=quickwindow;
		this.toolbar=toolbar;
		this.resizer=resizer;
		this.toolbarform=toolbarform;
		this.filelookup5=filelookup5;
		this.thiswindow=thiswindow;
		this.locFilename=locFilename;
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
				actionmessage.setValue("Record Will Be Added");
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.CHANGERECORD)) {
				actionmessage.setValue("Record Will Be Changed");
				case_1_break=true;
			}
		}
		quickwindow.setClonedProperty(Prop.TEXT,actionmessage);
		{
			ClarionNumber case_2=this.request;
			boolean case_2_break=false;
			boolean case_2_match=false;
			case_2_match=false;
			if (case_2.equals(Constants.CHANGERECORD)) {
				case_2_match=true;
			}
			if (case_2_match || case_2.equals(Constants.DELETERECORD)) {
				quickwindow.setProperty(Prop.TEXT,quickwindow.getProperty(Prop.TEXT).concat("  (",Main.products.description.clip(),")"));
				case_2_break=true;
			}
			case_2_match=false;
			if (!case_2_break && case_2.equals(Constants.INSERTRECORD)) {
				quickwindow.setProperty(Prop.TEXT,quickwindow.getProperty(Prop.TEXT).concat("  (New)"));
				case_2_break=true;
			}
		}
		super.ask();
	}
	public ClarionNumber init()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalerrors.setprocedurename(Clarion.newString("UpdateProducts"));
		this.request.setValue(Main.globalrequest);
		returnvalue.setValue(super.init());
		if (returnvalue.boolValue()) {
			return returnvalue.like();
		}
		this.firstfield.setValue(quickwindow._proProductskuPrompt);
		this.vcrrequest=Main.vcrrequest;
		this.errors=Main.globalerrors;
		this.additem(toolbar);
		Main.globalrequest.clear();
		Main.globalresponse.clear();
		this.historykey.setValue(734);
		this.addhistoryfile(Main.products,Invoi002.updateproducts_historyProRecord);
		this.addhistoryfield(Clarion.newNumber(quickwindow._proProductsku),Clarion.newNumber(2));
		this.addhistoryfield(Clarion.newNumber(quickwindow._proDescription),Clarion.newNumber(3));
		this.addhistoryfield(Clarion.newNumber(quickwindow._proPrice),Clarion.newNumber(4));
		this.addhistoryfield(Clarion.newNumber(quickwindow._proCost),Clarion.newNumber(7));
		this.addhistoryfield(Clarion.newNumber(quickwindow._proQuantityinstock),Clarion.newNumber(5));
		this.addhistoryfield(Clarion.newNumber(quickwindow._proReorderquantity),Clarion.newNumber(6));
		this.addhistoryfield(Clarion.newNumber(quickwindow._proPicturefile),Clarion.newNumber(8));
		this.addupdatefile(Main.accessProducts);
		this.additem(Clarion.newNumber(quickwindow._cancel),Clarion.newNumber(Constants.REQUESTCANCELLED));
		Main.relateProducts.open();
		this.filesopened.setValue(Constants.TRUE);
		this.primary=Main.relateProducts;
		if (this.request.equals(Constants.VIEWRECORD)) {
			this.insertaction.setValue(Insert.NONE);
			this.deleteaction.setValue(Delete.NONE);
			this.changeaction.setValue(0);
			this.cancelaction.setValue(Cancel.CANCEL);
			this.okcontrol.setValue(0);
		}
		else {
			this.insertaction.setValue(Insert.QUERY);
			this.okcontrol.setValue(quickwindow._ok);
			if (this.primeupdate().boolValue()) {
				return Clarion.newNumber(Level.NOTIFY);
			}
		}
		quickwindow.open();
		this.opened.setValue(Constants.TRUE);
		quickwindow.setProperty(Prop.MINWIDTH,281);
		quickwindow.setProperty(Prop.MINHEIGHT,127);
		quickwindow.setProperty(Prop.MAXWIDTH,281);
		quickwindow.setProperty(Prop.MAXHEIGHT,127);
		resizer.init(Clarion.newNumber(Appstrategy.NORESIZE));
		this.additem(resizer);
		Main.inimgr.fetch(Clarion.newString("UpdateProducts"),quickwindow);
		if (this.request.equals(Constants.CHANGERECORD) || this.request.equals(Constants.DELETERECORD)) {
			Clarion.getControl(quickwindow._image1).setClonedProperty(Prop.TEXT,Main.products.picturefile);
		}
		toolbarform.helpbutton.setValue(quickwindow._help);
		this.additem(toolbarform);
		filelookup5.init();
		filelookup5.setmask(Clarion.newString("GIF Images"),Clarion.newString("*.GIF"));
		filelookup5.addmask(Clarion.newString("BMP Images"),Clarion.newString("*.BMP"));
		filelookup5.windowtitle.setValue("Locate and Select Product Image File");
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
			Main.inimgr.update(Clarion.newString("UpdateProducts"),quickwindow);
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
	public ClarionNumber takeaccepted()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber looped=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber _lx_number=Clarion.newNumber();
		ClarionNumber _x_number=Clarion.newNumber();
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
				if (case_1==quickwindow._lookupfile) {
					thiswindow.update();
					Main.products.picturefile.setValue(filelookup5.ask(Clarion.newNumber(0)));
					CWin.display();
					_lx_number.setValue(Main.products.picturefile.clip().len());
					for (_x_number.setValue(_lx_number);_x_number.compareTo(1)>=0;_x_number.increment(-1)) {
						if (Main.products.picturefile.stringAt(_x_number).equals("\\")) {
							break;
						}
					}
					locFilename.setValue(Main.products.picturefile.stringAt(_x_number.add(1),_lx_number));
					if (Main.products.picturefile.stringAt(1,_x_number.subtract(1)).upper().equals(CFile.getPath())) {
						Main.products.picturefile.setValue(locFilename.clip().upper());
						CWin.display();
					}
					Clarion.getControl(quickwindow._image1).setClonedProperty(Prop.TEXT,Main.products.picturefile);
					case_1_break=true;
				}
				if (!case_1_break && case_1==quickwindow._ok) {
					thiswindow.update();
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
}
