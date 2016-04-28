package clarion.invoi001;

import clarion.Customers;
import clarion.Detail;
import clarion.Main;
import clarion.Orders;
import clarion.abbrowse.Browseeipmanager;
import clarion.abbrowse.Filterlocatorclass;
import clarion.abbrowse.Incrementallocatorclass;
import clarion.abbrowse.Steplocatorclass;
import clarion.abbrowse.Steplongclass;
import clarion.abbrowse.Stepstringclass;
import clarion.abquery.Queryformclass_1;
import clarion.abquery.Queryformvisual_1;
import clarion.abreport.Printpreviewclass;
import clarion.abtoolba.Toolbarclass;
import clarion.abtoolba.Toolbarupdateclass;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.equates.Proplist;
import clarion.equates.Vcr;
import clarion.invoi001.Appframe;
import clarion.invoi001.Brw1;
import clarion.invoi001.Brw1ViewBrowse;
import clarion.invoi001.Brw1ViewBrowse_1;
import clarion.invoi001.Brw1ViewBrowse_2;
import clarion.invoi001.Brw1ViewBrowse_3;
import clarion.invoi001.Brw1_1;
import clarion.invoi001.Brw1_2;
import clarion.invoi001.Brw5ViewBrowse;
import clarion.invoi001.Detailbrowse;
import clarion.invoi001.Fieldcolorqueue;
import clarion.invoi001.Fieldcolorqueue_1;
import clarion.invoi001.Fieldcolorqueue_2;
import clarion.invoi001.Ordersbrowse;
import clarion.invoi001.ProcessView;
import clarion.invoi001.Progresswindow;
import clarion.invoi001.QueueBrowse;
import clarion.invoi001.QueueBrowse_1;
import clarion.invoi001.QueueBrowse_1_1;
import clarion.invoi001.QueueBrowse_1_2;
import clarion.invoi001.QueueBrowse_1_3;
import clarion.invoi001.QueueReltree;
import clarion.invoi001.Quickwindow;
import clarion.invoi001.Quickwindow_1;
import clarion.invoi001.Quickwindow_2;
import clarion.invoi001.Quickwindow_3;
import clarion.invoi001.Quickwindow_4;
import clarion.invoi001.Quickwindow_5;
import clarion.invoi001.Quickwindow_6;
import clarion.invoi001.Rel1Loadedqueue;
import clarion.invoi001.Rel1Toolbar;
import clarion.invoi001.Report;
import clarion.invoi001.Resizer;
import clarion.invoi001.Resizer_1;
import clarion.invoi001.Resizer_2;
import clarion.invoi001.Resizer_3;
import clarion.invoi001.Resizer_4;
import clarion.invoi001.Resizer_5;
import clarion.invoi001.Resizer_6;
import clarion.invoi001.Resizer_7;
import clarion.invoi001.Thisreport;
import clarion.invoi001.Thiswindow;
import clarion.invoi001.Thiswindow_1;
import clarion.invoi001.Thiswindow_2;
import clarion.invoi001.Thiswindow_3;
import clarion.invoi001.Thiswindow_4;
import clarion.invoi001.Thiswindow_5;
import clarion.invoi001.Thiswindow_6;
import clarion.invoi001.Thiswindow_7;
import clarion.invoi001.Thiswindow_8;
import clarion.invoi001.Thiswindow_9;
import clarion.invoi001.Window;
import clarion.invoi002.Invoi002;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CDate;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Invoi001
{
	public static Customers updatecustomers_historyCusRecord;
	public static Detail updatedetail_historyDtlRecord;
	public static Orders updateorders_historyOrdRecord;
	static {
		Main.__register_init(new Runnable() { public void run() { __static_init(); } });
		__static_init();
	}

	public static void __static_init() {
		updatecustomers_historyCusRecord=new Customers();
		updatedetail_historyDtlRecord=new Detail();
		updateorders_historyOrdRecord=new Orders();
	}


	public static void main()
	{
		ClarionNumber localrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesopened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString currenttab=Clarion.newString(80);
		ClarionNumber splashprocedurethread=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionString displaydaystring=Clarion.newString("Sunday   Monday   Tuesday  WednesdayThursday Friday   Saturday ");
		ClarionArray<ClarionString> displaydaytext=Clarion.newString(9).dim(7).setOver(displaydaystring);
		Appframe appframe=new Appframe();
		Toolbarclass toolbar=new Toolbarclass();
		Thiswindow_6 thiswindow=new Thiswindow_6(appframe,displaydaytext,toolbar,splashprocedurethread);
		try {
			Main.globalresponse.setValue(thiswindow.run());
		} finally {
			appframe.close();
		}
	}
	public static void main_menuReportmenu(Appframe appframe)
	{
		{
			int case_1=CWin.accepted();
			boolean case_1_break=false;
			if (case_1==appframe._reportsprintinvoice) {
				{
				CRun.start(new Runnable() { public void run() { Invoi002.printinvoice(); } } ).getId();
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1==appframe._reportsprintmailinglabels) {
				{
				CRun.start(new Runnable() { public void run() { Invoi002.printmailinglabels(); } } ).getId();
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1==appframe._printproKeyproductsku) {
				{
				CRun.start(new Runnable() { public void run() { Invoi002.printproKeyproductsku(); } } ).getId();
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1==appframe._printcusStatekey) {
				{
				CRun.start(new Runnable() { public void run() { Invoi002.printcusStatekey(); } } ).getId();
				}
				case_1_break=true;
			}
		}
	}
	public static void main_menuMaintenance(Appframe appframe)
	{
		{
			int case_1=CWin.accepted();
			if (case_1==appframe._updatecompanyfile) {
				Main.globalrequest.setValue(Constants.CHANGERECORD);
				Invoi002.updatecompany();
			}
		}
	}
	public static void selectstates()
	{
		ClarionString currenttab=Clarion.newString(80);
		ClarionNumber localrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesopened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionView brw1ViewBrowse=new Brw1ViewBrowse();
		QueueBrowse_1 queueBrowse_1=new QueueBrowse_1();
		Quickwindow quickwindow=new Quickwindow(queueBrowse_1);
		Toolbarclass toolbar=new Toolbarclass();
		Browseeipmanager brw1Eipmanager=new Browseeipmanager();
		Incrementallocatorclass brw1Sort0Locator=new Incrementallocatorclass();
		Stepstringclass brw1Sort0Stepclass=new Stepstringclass();
		Brw1 brw1=new Brw1(brw1Eipmanager,quickwindow);
		Resizer resizer=new Resizer();
		Thiswindow thiswindow=new Thiswindow(quickwindow,toolbar,brw1,queueBrowse_1,brw1ViewBrowse,brw1Sort0Stepclass,brw1Sort0Locator,resizer);
		try {
			Main.globalresponse.setValue(thiswindow.run());
		} finally {
			quickwindow.close();
			brw1Sort0Locator.destruct();
		}
	}
	public static void updatecustomers()
	{
		ClarionString currenttab=Clarion.newString(80);
		ClarionNumber localrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesopened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString actionmessage=Clarion.newString(40).setEncoding(ClarionString.CSTRING);
		ClarionNumber recordchanged=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Quickwindow_1 quickwindow=new Quickwindow_1();
		Toolbarclass toolbar=new Toolbarclass();
		Toolbarupdateclass toolbarform=new Toolbarupdateclass();
		Resizer_1 resizer=new Resizer_1();
		Fieldcolorqueue fieldcolorqueue=new Fieldcolorqueue();
		ClarionNumber curctrlfeq=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		Thiswindow_1 thiswindow=new Thiswindow_1();
		thiswindow.__Init__(actionmessage,quickwindow,toolbar,resizer,toolbarform,thiswindow,fieldcolorqueue);
		try {
			Main.globalresponse.setValue(thiswindow.run());
		} finally {
			quickwindow.close();
		}
	}
	public static void browseallorders()
	{
		ClarionNumber localrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesopened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString displaystring=Clarion.newString(255);
		ClarionNumber rel1Savelevel=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber rel1Action=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		QueueReltree queueReltree=new QueueReltree();
		Rel1Loadedqueue rel1Loadedqueue=new Rel1Loadedqueue();
		ClarionNumber rel1Currentchoice=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber rel1Currentlevel=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber rel1Newitemlevel=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionString rel1Newitemposition=Clarion.newString(1024);
		ClarionNumber rel1Loadall=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		Window window=new Window(queueReltree);
		Rel1Toolbar rel1Toolbar=new Rel1Toolbar(queueReltree,window,rel1Loadedqueue,rel1Savelevel,rel1Currentchoice,displaystring,rel1Loadall,rel1Action,rel1Newitemlevel,rel1Newitemposition,thiswindow);
		Toolbarclass toolbar=new Toolbarclass();
		Resizer_2 resizer=new Resizer_2();
		Thiswindow_2 thiswindow=new Thiswindow_2();
		thiswindow.__Init__(window,toolbar,queueReltree,rel1Loadedqueue,rel1Loadall,displaystring,resizer,rel1Toolbar,thiswindow,rel1Action,rel1Currentchoice,rel1Savelevel,rel1Newitemlevel,rel1Newitemposition,rel1Currentlevel);
		try {
			Main.globalresponse.setValue(thiswindow.run());
		} finally {
			window.close();
		}
	}
	public static void browseallorders_rel1Nextparent(QueueReltree queueReltree,Window window,Rel1Loadedqueue rel1Loadedqueue,ClarionNumber rel1Savelevel,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall)
	{
		queueReltree.get(CWin.choice(window._reltree));
		if (queueReltree.rel1Level.abs().compareTo(1)>0) {
			rel1Savelevel.setValue(queueReltree.rel1Level.abs().subtract(1));
			browseallorders_rel1Nextsavedlevel(queueReltree,rel1Loadedqueue,rel1Savelevel,window,rel1Currentchoice,displaystring,rel1Loadall);
		}
	}
	public static void browseallorders_rel1Removeentry(ClarionNumber rel1Action,Window window,Rel1Loadedqueue rel1Loadedqueue,QueueReltree queueReltree,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall,ClarionNumber rel1Savelevel,ClarionNumber rel1Newitemlevel,ClarionString rel1Newitemposition)
	{
		rel1Action.setValue(Constants.DELETERECORD);
		browseallorders_rel1Updateloop(window,rel1Action,rel1Loadedqueue,queueReltree,rel1Currentchoice,displaystring,rel1Loadall,rel1Savelevel,rel1Newitemlevel,rel1Newitemposition);
	}
	public static void browseallorders_rel1LoadDetail(Rel1Loadedqueue rel1Loadedqueue,QueueReltree queueReltree,ClarionString displaystring)
	{
		Main.detail.custnumber.setValue(Main.orders.custnumber);
		Main.detail.ordernumber.setValue(Main.orders.ordernumber);
		Main.detail.linenumber.clear();
		Main.accessDetail.usefile();
		Main.detail.keydetails.set(Main.detail.keydetails);
		while (true) {
			if (Main.accessDetail.next().boolValue()) {
				if (Main.accessDetail.geteof().boolValue()) {
					break;
				}
				else {
					CWin.post(Event.CLOSEWINDOW);
					return;
				}
			}
			if (!Main.detail.custnumber.equals(Main.orders.custnumber)) {
				break;
			}
			if (!Main.detail.ordernumber.equals(Main.orders.ordernumber)) {
				break;
			}
			queueReltree.rel1Loaded.setValue(0);
			queueReltree.rel1Position.setValue(Main.detail.getPosition());
			queueReltree.rel1Level.setValue(3);
			browseallorders_rel1FormatDetail(displaystring,rel1Loadedqueue,queueReltree);
			queueReltree.add(queueReltree.getPointer()+1);
		}
	}
	public static void browseallorders_rel1Refreshtree(QueueReltree queueReltree,Rel1Loadedqueue rel1Loadedqueue,ClarionNumber rel1Loadall,ClarionString displaystring,ClarionNumber rel1Newitemlevel,ClarionNumber rel1Currentchoice,ClarionString rel1Newitemposition,Window window)
	{
		queueReltree.free();
		browseallorders_rel1LoadCustomers(rel1Loadedqueue,queueReltree,rel1Loadall,displaystring);
		if (rel1Newitemlevel.boolValue()) {
			rel1Currentchoice.setValue(0);
			while (true) {
				rel1Currentchoice.increment(1);
				queueReltree.get(rel1Currentchoice);
				if (CError.errorCode()!=0) {
					break;
				}
				if (!queueReltree.rel1Level.abs().equals(rel1Newitemlevel.abs())) {
					continue;
				}
				if (!queueReltree.rel1Position.equals(rel1Newitemposition)) {
					continue;
				}
				CWin.select(window._reltree,rel1Currentchoice.intValue());
				break;
			}
		}
	}
	public static void browseallorders_rel1Contractall(QueueReltree queueReltree,Rel1Loadedqueue rel1Loadedqueue,ClarionNumber rel1Loadall,ClarionString displaystring)
	{
		queueReltree.free();
		rel1Loadedqueue.free();
		browseallorders_rel1LoadCustomers(rel1Loadedqueue,queueReltree,rel1Loadall,displaystring);
	}
	public static void browseallorders_rel1Updateloop(Window window,ClarionNumber rel1Action,Rel1Loadedqueue rel1Loadedqueue,QueueReltree queueReltree,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall,ClarionNumber rel1Savelevel,ClarionNumber rel1Newitemlevel,ClarionString rel1Newitemposition)
	{
		while (true) {
			Main.vcrrequest.setValue(Vcr.NONE);
			Clarion.getControl(window._reltree).setProperty(Proplist.MOUSEDOWNROW,CWin.choice(window._reltree));
			{
				ClarionNumber case_1=rel1Action;
				boolean case_1_break=false;
				if (case_1.equals(Constants.INSERTRECORD)) {
					browseallorders_rel1Addentryserver(window,rel1Loadedqueue,queueReltree,rel1Currentchoice,rel1Newitemlevel,rel1Newitemposition,rel1Loadall,displaystring);
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Constants.DELETERECORD)) {
					browseallorders_rel1Removeentryserver(window,rel1Loadedqueue,queueReltree,rel1Currentchoice,rel1Loadall,displaystring,rel1Newitemlevel,rel1Newitemposition);
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Constants.CHANGERECORD)) {
					browseallorders_rel1Editentryserver(window,rel1Loadedqueue,queueReltree,rel1Currentchoice,rel1Newitemlevel,rel1Newitemposition,rel1Loadall,displaystring);
					case_1_break=true;
				}
			}
			{
				ClarionNumber case_2=Main.vcrrequest;
				boolean case_2_break=false;
				if (case_2.equals(Vcr.FORWARD)) {
					browseallorders_rel1Nextrecord(window,queueReltree,rel1Loadedqueue,rel1Currentchoice,displaystring,rel1Loadall);
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(Vcr.BACKWARD)) {
					browseallorders_rel1Previousrecord(window,queueReltree,rel1Loadedqueue,rel1Currentchoice,displaystring,rel1Loadall);
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(Vcr.PAGEFORWARD)) {
					browseallorders_rel1Nextlevel(queueReltree,window,rel1Savelevel,rel1Loadedqueue,rel1Currentchoice,displaystring,rel1Loadall);
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(Vcr.PAGEBACKWARD)) {
					browseallorders_rel1Previouslevel(queueReltree,window,rel1Savelevel,rel1Loadedqueue,rel1Currentchoice,displaystring,rel1Loadall);
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(Vcr.FIRST)) {
					browseallorders_rel1Previousparent(queueReltree,window,rel1Loadedqueue,rel1Savelevel,rel1Currentchoice,displaystring,rel1Loadall);
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(Vcr.LAST)) {
					browseallorders_rel1Nextparent(queueReltree,window,rel1Loadedqueue,rel1Savelevel,rel1Currentchoice,displaystring,rel1Loadall);
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(Vcr.INSERT)) {
					browseallorders_rel1Previousparent(queueReltree,window,rel1Loadedqueue,rel1Savelevel,rel1Currentchoice,displaystring,rel1Loadall);
					rel1Action.setValue(Constants.INSERTRECORD);
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(Vcr.NONE)) {
					break;
					// UNREACHABLE! :case_2_break=true;
				}
			}
		}
	}
	public static void browseallorders_rel1Assignbuttons(Rel1Toolbar rel1Toolbar,Window window,Toolbarclass toolbar)
	{
		rel1Toolbar.deletebutton.setValue(window._delete);
		rel1Toolbar.insertbutton.setValue(window._insert);
		rel1Toolbar.changebutton.setValue(window._change);
		rel1Toolbar.helpbutton.setValue(window._help);
		toolbar.settarget(Clarion.newNumber(window._reltree));
	}
	public static void browseallorders_rel1FormatCustomers(ClarionString displaystring,Rel1Loadedqueue rel1Loadedqueue,QueueReltree queueReltree)
	{
		displaystring.setValue(Main.customers.firstname.clip().concat(" ",Main.customers.lastname.clip(),"  ",Main.customers.custnumber.getString().format("@P(#######)P")));
		queueReltree.rel1Display.setValue(displaystring);
		queueReltree.rel1Normalfg.setValue(128);
		queueReltree.rel1Normalbg.setValue(-1);
		queueReltree.rel1Selectedfg.setValue(-1);
		queueReltree.rel1Selectedbg.setValue(-1);
		queueReltree.rel1Icon.setValue(2);
	}
	public static void browseallorders_rel1Previousparent(QueueReltree queueReltree,Window window,Rel1Loadedqueue rel1Loadedqueue,ClarionNumber rel1Savelevel,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall)
	{
		queueReltree.get(CWin.choice(window._reltree));
		if (queueReltree.rel1Level.abs().compareTo(1)>0) {
			rel1Savelevel.setValue(queueReltree.rel1Level.abs().subtract(1));
			browseallorders_rel1Previoussavedlevel(queueReltree,rel1Loadedqueue,rel1Savelevel,window,rel1Currentchoice,displaystring,rel1Loadall);
		}
	}
	public static void browseallorders_rel1Unloadlevel(ClarionNumber rel1Currentchoice,Window window,QueueReltree queueReltree,Rel1Loadedqueue rel1Loadedqueue,ClarionString displaystring,ClarionNumber rel1Currentlevel)
	{
		rel1Currentchoice.setValue(Clarion.getControl(window._reltree).getProperty(Proplist.MOUSEDOWNROW));
		queueReltree.get(rel1Currentchoice);
		if (queueReltree.rel1Loaded.boolValue()) {
			queueReltree.rel1Level.setValue(queueReltree.rel1Level.abs().negate());
			queueReltree.put();
			queueReltree.rel1Loaded.setValue(Constants.FALSE);
			rel1Loadedqueue.rel1Loadedlevel.setValue(queueReltree.rel1Level.abs());
			rel1Loadedqueue.rel1Loadedposition.setValue(queueReltree.rel1Position);
			rel1Loadedqueue.get(rel1Loadedqueue.ORDER().ascend(rel1Loadedqueue.rel1Loadedlevel).ascend(rel1Loadedqueue.rel1Loadedposition));
			if (!(CError.errorCode()!=0)) {
				rel1Loadedqueue.delete();
			}
			{
				int execute_1=queueReltree.rel1Level.abs().intValue();
				if (execute_1==1) {
					Main.customers.keyfullname.reget(queueReltree.rel1Position);
					browseallorders_rel1FormatCustomers(displaystring,rel1Loadedqueue,queueReltree);
				}
				if (execute_1==2) {
					Main.orders.reget(queueReltree.rel1Position);
					browseallorders_rel1FormatOrders(displaystring,rel1Loadedqueue,queueReltree);
				}
				if (execute_1==3) {
					Main.detail.reget(queueReltree.rel1Position);
					browseallorders_rel1FormatDetail(displaystring,rel1Loadedqueue,queueReltree);
				}
			}
			queueReltree.put();
			rel1Currentlevel.setValue(queueReltree.rel1Level.abs());
			rel1Currentchoice.increment(1);
			while (true) {
				queueReltree.get(rel1Currentchoice);
				if (CError.errorCode()!=0) {
					break;
				}
				if (queueReltree.rel1Level.abs().compareTo(rel1Currentlevel)<=0) {
					break;
				}
				queueReltree.delete();
			}
		}
	}
	public static void browseallorders_rel1Editentryserver(Window window,Rel1Loadedqueue rel1Loadedqueue,QueueReltree queueReltree,ClarionNumber rel1Currentchoice,ClarionNumber rel1Newitemlevel,ClarionString rel1Newitemposition,ClarionNumber rel1Loadall,ClarionString displaystring)
	{
		if (Clarion.getControl(window._change).getProperty(Prop.DISABLE).boolValue()) {
			return;
		}
		rel1Currentchoice.setValue(Clarion.getControl(window._reltree).getProperty(Proplist.MOUSEDOWNROW));
		queueReltree.get(rel1Currentchoice);
		{
			ClarionNumber case_1=queueReltree.rel1Level.abs();
			boolean case_1_break=false;
			if (case_1.equals(1)) {
				Main.customers.watch();
				Main.customers.reget(queueReltree.rel1Position);
				Main.globalrequest.setValue(Constants.CHANGERECORD);
				Invoi001.updatecustomers();
				if (Main.globalresponse.equals(Constants.REQUESTCOMPLETED)) {
					rel1Newitemlevel.setValue(1);
					rel1Newitemposition.setValue(Main.customers.getPosition());
					browseallorders_rel1Refreshtree(queueReltree,rel1Loadedqueue,rel1Loadall,displaystring,rel1Newitemlevel,rel1Currentchoice,rel1Newitemposition,window);
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(2)) {
				Main.orders.watch();
				Main.orders.reget(queueReltree.rel1Position);
				Main.globalrequest.setValue(Constants.CHANGERECORD);
				Invoi001.updateorders();
				if (Main.globalresponse.equals(Constants.REQUESTCOMPLETED)) {
					rel1Newitemlevel.setValue(1);
					rel1Newitemposition.setValue(Main.orders.getPosition());
					browseallorders_rel1Refreshtree(queueReltree,rel1Loadedqueue,rel1Loadall,displaystring,rel1Newitemlevel,rel1Currentchoice,rel1Newitemposition,window);
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(3)) {
				Main.detail.watch();
				Main.detail.reget(queueReltree.rel1Position);
				Main.globalrequest.setValue(Constants.CHANGERECORD);
				Invoi001.updatedetail();
				if (Main.globalresponse.equals(Constants.REQUESTCOMPLETED)) {
					rel1Newitemlevel.setValue(1);
					rel1Newitemposition.setValue(Main.detail.getPosition());
					browseallorders_rel1Refreshtree(queueReltree,rel1Loadedqueue,rel1Loadall,displaystring,rel1Newitemlevel,rel1Currentchoice,rel1Newitemposition,window);
				}
				case_1_break=true;
			}
		}
	}
	public static void browseallorders_rel1Loadlevel(ClarionNumber rel1Currentchoice,Window window,QueueReltree queueReltree,Rel1Loadedqueue rel1Loadedqueue,ClarionString displaystring,ClarionNumber rel1Loadall)
	{
		rel1Currentchoice.setValue(Clarion.getControl(window._reltree).getProperty(Proplist.MOUSEDOWNROW));
		queueReltree.get(rel1Currentchoice);
		if (!queueReltree.rel1Loaded.boolValue()) {
			queueReltree.rel1Level.setValue(queueReltree.rel1Level.abs());
			queueReltree.put();
			queueReltree.rel1Loaded.setValue(Constants.TRUE);
			rel1Loadedqueue.rel1Loadedlevel.setValue(queueReltree.rel1Level.abs());
			rel1Loadedqueue.rel1Loadedposition.setValue(queueReltree.rel1Position);
			rel1Loadedqueue.add(rel1Loadedqueue.ORDER().ascend(rel1Loadedqueue.rel1Loadedlevel).ascend(rel1Loadedqueue.rel1Loadedposition));
			{
				int execute_1=queueReltree.rel1Level.abs().intValue();
				if (execute_1==1) {
					Main.customers.keyfullname.reget(queueReltree.rel1Position);
					browseallorders_rel1FormatCustomers(displaystring,rel1Loadedqueue,queueReltree);
				}
				if (execute_1==2) {
					Main.orders.reget(queueReltree.rel1Position);
					browseallorders_rel1FormatOrders(displaystring,rel1Loadedqueue,queueReltree);
				}
				if (execute_1==3) {
					Main.detail.reget(queueReltree.rel1Position);
					browseallorders_rel1FormatDetail(displaystring,rel1Loadedqueue,queueReltree);
				}
			}
			queueReltree.put();
			{
				int execute_2=queueReltree.rel1Level.abs().intValue();
				if (execute_2==1) {
					browseallorders_rel1LoadOrders(rel1Loadedqueue,queueReltree,rel1Loadall,displaystring);
				}
				if (execute_2==2) {
					browseallorders_rel1LoadDetail(rel1Loadedqueue,queueReltree,displaystring);
				}
			}
		}
	}
	public static void browseallorders_rel1Nextrecord(Window window,QueueReltree queueReltree,Rel1Loadedqueue rel1Loadedqueue,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall)
	{
		browseallorders_rel1Loadlevel(rel1Currentchoice,window,queueReltree,rel1Loadedqueue,displaystring,rel1Loadall);
		if (CWin.choice(window._reltree)<queueReltree.records()) {
			CWin.select(window._reltree,CWin.choice(window._reltree)+1);
		}
	}
	public static void browseallorders_rel1Addentry(ClarionNumber rel1Action,Window window,Rel1Loadedqueue rel1Loadedqueue,QueueReltree queueReltree,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall,ClarionNumber rel1Savelevel,ClarionNumber rel1Newitemlevel,ClarionString rel1Newitemposition)
	{
		rel1Action.setValue(Constants.INSERTRECORD);
		browseallorders_rel1Updateloop(window,rel1Action,rel1Loadedqueue,queueReltree,rel1Currentchoice,displaystring,rel1Loadall,rel1Savelevel,rel1Newitemlevel,rel1Newitemposition);
	}
	public static void browseallorders_rel1Removeentryserver(Window window,Rel1Loadedqueue rel1Loadedqueue,QueueReltree queueReltree,ClarionNumber rel1Currentchoice,ClarionNumber rel1Loadall,ClarionString displaystring,ClarionNumber rel1Newitemlevel,ClarionString rel1Newitemposition)
	{
		if (Clarion.getControl(window._delete).getProperty(Prop.DISABLE).boolValue()) {
			return;
		}
		rel1Currentchoice.setValue(Clarion.getControl(window._reltree).getProperty(Proplist.MOUSEDOWNROW));
		queueReltree.get(rel1Currentchoice);
		{
			ClarionNumber case_1=queueReltree.rel1Level.abs();
			boolean case_1_break=false;
			if (case_1.equals(1)) {
				Main.customers.reget(queueReltree.rel1Position);
				Main.globalrequest.setValue(Constants.DELETERECORD);
				Invoi001.updatecustomers();
				if (Main.globalresponse.equals(Constants.REQUESTCOMPLETED)) {
					browseallorders_rel1Refreshtree(queueReltree,rel1Loadedqueue,rel1Loadall,displaystring,rel1Newitemlevel,rel1Currentchoice,rel1Newitemposition,window);
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(2)) {
				Main.orders.reget(queueReltree.rel1Position);
				Main.globalrequest.setValue(Constants.DELETERECORD);
				Invoi001.updateorders();
				if (Main.globalresponse.equals(Constants.REQUESTCOMPLETED)) {
					browseallorders_rel1Refreshtree(queueReltree,rel1Loadedqueue,rel1Loadall,displaystring,rel1Newitemlevel,rel1Currentchoice,rel1Newitemposition,window);
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(3)) {
				Main.detail.reget(queueReltree.rel1Position);
				Main.globalrequest.setValue(Constants.DELETERECORD);
				Invoi001.updatedetail();
				if (Main.globalresponse.equals(Constants.REQUESTCOMPLETED)) {
					browseallorders_rel1Refreshtree(queueReltree,rel1Loadedqueue,rel1Loadall,displaystring,rel1Newitemlevel,rel1Currentchoice,rel1Newitemposition,window);
				}
				case_1_break=true;
			}
		}
	}
	public static void browseallorders_rel1Nextlevel(QueueReltree queueReltree,Window window,ClarionNumber rel1Savelevel,Rel1Loadedqueue rel1Loadedqueue,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall)
	{
		queueReltree.get(CWin.choice(window._reltree));
		rel1Savelevel.setValue(queueReltree.rel1Level.abs());
		browseallorders_rel1Nextsavedlevel(queueReltree,rel1Loadedqueue,rel1Savelevel,window,rel1Currentchoice,displaystring,rel1Loadall);
	}
	public static void browseallorders_rel1Nextsavedlevel(QueueReltree queueReltree,Rel1Loadedqueue rel1Loadedqueue,ClarionNumber rel1Savelevel,Window window,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall)
	{
		ClarionNumber savepointer=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		while (true) {
			while (true) {
				queueReltree.get(queueReltree.getPointer()+1);
				if (CError.errorCode()!=0) {
					return;
				}
				if (!(queueReltree.rel1Level.abs().compareTo(rel1Savelevel)>0)) break;
			}
			if (queueReltree.rel1Level.abs().equals(rel1Savelevel)) {
				CWin.select(window._reltree,queueReltree.getPointer());
				return;
			}
			savepointer.setValue(queueReltree.getPointer());
			Clarion.getControl(window._reltree).setClonedProperty(Proplist.MOUSEDOWNROW,savepointer);
			browseallorders_rel1Loadlevel(rel1Currentchoice,window,queueReltree,rel1Loadedqueue,displaystring,rel1Loadall);
			queueReltree.get(savepointer);
		}
	}
	public static void browseallorders_rel1FormatOrders(ClarionString displaystring,Rel1Loadedqueue rel1Loadedqueue,QueueReltree queueReltree)
	{
		displaystring.setValue(ClarionString.staticConcat("Invoice# ",Main.orders.invoicenumber.getString().format("@P######P"),", Order# ",Main.orders.ordernumber.getString().format("@P#######P"),", (",Main.orders.orderdate.getString().format("@D1").left(),")"));
		queueReltree.rel1Display.setValue(displaystring);
		queueReltree.rel1Normalfg.setValue(8388608);
		queueReltree.rel1Normalbg.setValue(-1);
		queueReltree.rel1Selectedfg.setValue(-1);
		queueReltree.rel1Selectedbg.setValue(-1);
		queueReltree.rel1Icon.setValue(3);
	}
	public static void browseallorders_rel1Previousrecord(Window window,QueueReltree queueReltree,Rel1Loadedqueue rel1Loadedqueue,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall)
	{
		ClarionNumber saverecords=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber savepointer=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		savepointer.setValue(CWin.choice(window._reltree)-1);
		while (true) {
			saverecords.setValue(queueReltree.records());
			Clarion.getControl(window._reltree).setClonedProperty(Proplist.MOUSEDOWNROW,savepointer);
			browseallorders_rel1Loadlevel(rel1Currentchoice,window,queueReltree,rel1Loadedqueue,displaystring,rel1Loadall);
			if (Clarion.newNumber(queueReltree.records()).equals(saverecords)) {
				break;
			}
			savepointer.increment(Clarion.newNumber(queueReltree.records()).subtract(saverecords));
		}
		CWin.select(window._reltree,savepointer.intValue());
	}
	public static void browseallorders_rel1LoadOrders(Rel1Loadedqueue rel1Loadedqueue,QueueReltree queueReltree,ClarionNumber rel1Loadall,ClarionString displaystring)
	{
		Main.orders.custnumber.setValue(Main.customers.custnumber);
		Main.orders.ordernumber.clear();
		Main.accessOrders.usefile();
		Main.orders.keycustordernumber.set(Main.orders.keycustordernumber);
		while (true) {
			if (Main.accessOrders.next().boolValue()) {
				if (Main.accessOrders.geteof().boolValue()) {
					break;
				}
				else {
					CWin.post(Event.CLOSEWINDOW);
					return;
				}
			}
			if (!Main.orders.custnumber.equals(Main.customers.custnumber)) {
				break;
			}
			queueReltree.rel1Loaded.setValue(0);
			queueReltree.rel1Position.setValue(Main.orders.getPosition());
			queueReltree.rel1Level.setValue(2);
			rel1Loadedqueue.rel1Loadedlevel.setValue(queueReltree.rel1Level.abs());
			rel1Loadedqueue.rel1Loadedposition.setValue(queueReltree.rel1Position);
			rel1Loadedqueue.get(rel1Loadedqueue.ORDER().ascend(rel1Loadedqueue.rel1Loadedlevel).ascend(rel1Loadedqueue.rel1Loadedposition));
			if (CError.errorCode()!=0 && rel1Loadall.equals(Constants.FALSE)) {
				Main.detail.custnumber.setValue(Main.orders.custnumber);
				Main.detail.ordernumber.setValue(Main.orders.ordernumber);
				Main.detail.linenumber.clear(0);
				Main.accessDetail.usefile();
				Main.detail.keydetails.set(Main.detail.keydetails);
				while (true) {
					if (Main.accessDetail.next().boolValue()) {
						if (Main.accessDetail.geteof().boolValue()) {
							break;
						}
						else {
							CWin.post(Event.CLOSEWINDOW);
							return;
						}
					}
					if (!Main.detail.custnumber.getString().upper().equals(Main.orders.custnumber.getString().upper())) {
						break;
					}
					if (!Main.detail.ordernumber.getString().upper().equals(Main.orders.ordernumber.getString().upper())) {
						break;
					}
					queueReltree.rel1Level.setValue(-2);
					break;
				}
				browseallorders_rel1FormatOrders(displaystring,rel1Loadedqueue,queueReltree);
				queueReltree.add(queueReltree.getPointer()+1);
			}
			else {
				if (rel1Loadall.boolValue()) {
					rel1Loadedqueue.add(rel1Loadedqueue.ORDER().ascend(rel1Loadedqueue.rel1Loadedlevel).ascend(rel1Loadedqueue.rel1Loadedposition));
				}
				queueReltree.rel1Level.setValue(2);
				queueReltree.rel1Loaded.setValue(Constants.TRUE);
				browseallorders_rel1FormatOrders(displaystring,rel1Loadedqueue,queueReltree);
				queueReltree.add(queueReltree.getPointer()+1);
				browseallorders_rel1LoadDetail(rel1Loadedqueue,queueReltree,displaystring);
			}
		}
	}
	public static void browseallorders_rel1FormatDetail(ClarionString displaystring,Rel1Loadedqueue rel1Loadedqueue,QueueReltree queueReltree)
	{
		displaystring.clear();
		Main.products.productnumber.setValue(Main.detail.productnumber);
		Main.accessProducts.fetch(Main.products.keyproductnumber);
		displaystring.setValue(Main.products.description.clip().concat(" (",Main.detail.quantityordered.getString().format("@N5").left().clip()," @ ",Main.detail.price.getString().format("@N$10.2").left().clip(),"), Tax = ",Main.detail.taxpaid.getString().format("@N$10.2").left().clip(),", Discount = ",Main.detail.discount.getString().format("@N$10.2").left().clip(),", ","Total Cost = ",Main.detail.totalcost.getString().format("@N$14.2").left()));
		queueReltree.rel1Display.setValue(displaystring);
		if (Main.detail.backordered.equals(Constants.TRUE)) {
			queueReltree.rel1Normalfg.setValue(255);
			queueReltree.rel1Normalbg.setValue(-1);
			queueReltree.rel1Selectedfg.setValue(-1);
			queueReltree.rel1Selectedbg.setValue(-1);
		}
		else {
			queueReltree.rel1Normalfg.setValue(32768);
			queueReltree.rel1Normalbg.setValue(-1);
			queueReltree.rel1Selectedfg.setValue(-1);
			queueReltree.rel1Selectedbg.setValue(-1);
		}
		queueReltree.rel1Icon.setValue(4);
	}
	public static void browseallorders_rel1LoadCustomers(Rel1Loadedqueue rel1Loadedqueue,QueueReltree queueReltree,ClarionNumber rel1Loadall,ClarionString displaystring)
	{
		queueReltree.rel1Display.setValue("CUSTOMERS' ORDERS");
		queueReltree.rel1Loaded.setValue(0);
		queueReltree.rel1Position.setValue("");
		queueReltree.rel1Level.setValue(0);
		queueReltree.rel1Icon.setValue(1);
		queueReltree.rel1Normalfg.setValue(-1);
		queueReltree.rel1Normalbg.setValue(-1);
		queueReltree.rel1Selectedfg.setValue(-1);
		queueReltree.rel1Selectedbg.setValue(-1);
		queueReltree.add();
		Main.accessCustomers.usefile();
		Main.customers.keyfullname.setStart();
		while (true) {
			if (!Main.accessCustomers.next().equals(Level.BENIGN)) {
				if (Main.accessCustomers.geteof().boolValue()) {
					break;
				}
				else {
					CWin.post(Event.CLOSEWINDOW);
					return;
				}
			}
			queueReltree.rel1Loaded.setValue(0);
			queueReltree.rel1Position.setValue(Main.customers.keyfullname.getPosition());
			queueReltree.rel1Level.setValue(1);
			rel1Loadedqueue.rel1Loadedlevel.setValue(queueReltree.rel1Level.abs());
			rel1Loadedqueue.rel1Loadedposition.setValue(queueReltree.rel1Position);
			rel1Loadedqueue.get(rel1Loadedqueue.ORDER().ascend(rel1Loadedqueue.rel1Loadedlevel).ascend(rel1Loadedqueue.rel1Loadedposition));
			if (CError.errorCode()!=0 && rel1Loadall.equals(Constants.FALSE)) {
				Main.orders.custnumber.setValue(Main.customers.custnumber);
				Main.orders.ordernumber.clear(0);
				Main.accessOrders.usefile();
				Main.orders.keycustordernumber.set(Main.orders.keycustordernumber);
				while (true) {
					if (Main.accessOrders.next().boolValue()) {
						if (Main.accessOrders.geteof().boolValue()) {
							break;
						}
						else {
							CWin.post(Event.CLOSEWINDOW);
							return;
						}
					}
					if (!Main.orders.custnumber.getString().upper().equals(Main.customers.custnumber.getString().upper())) {
						break;
					}
					queueReltree.rel1Level.setValue(-1);
					break;
				}
				browseallorders_rel1FormatCustomers(displaystring,rel1Loadedqueue,queueReltree);
				queueReltree.add(queueReltree.getPointer()+1);
			}
			else {
				if (rel1Loadall.boolValue()) {
					rel1Loadedqueue.add(rel1Loadedqueue.ORDER().ascend(rel1Loadedqueue.rel1Loadedlevel).ascend(rel1Loadedqueue.rel1Loadedposition));
				}
				queueReltree.rel1Level.setValue(1);
				queueReltree.rel1Loaded.setValue(Constants.TRUE);
				browseallorders_rel1FormatCustomers(displaystring,rel1Loadedqueue,queueReltree);
				queueReltree.add(queueReltree.getPointer()+1);
				browseallorders_rel1LoadOrders(rel1Loadedqueue,queueReltree,rel1Loadall,displaystring);
			}
		}
	}
	public static void browseallorders_rel1Previoussavedlevel(QueueReltree queueReltree,Rel1Loadedqueue rel1Loadedqueue,ClarionNumber rel1Savelevel,Window window,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall)
	{
		ClarionNumber saverecords=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber savepointer=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		while (true) {
			while (true) {
				queueReltree.get(queueReltree.getPointer()-1);
				if (CError.errorCode()!=0) {
					return;
				}
				if (!(queueReltree.rel1Level.abs().compareTo(rel1Savelevel)>0)) break;
			}
			if (queueReltree.rel1Level.abs().equals(rel1Savelevel)) {
				CWin.select(window._reltree,queueReltree.getPointer());
				return;
			}
			savepointer.setValue(queueReltree.getPointer());
			saverecords.setValue(queueReltree.records());
			Clarion.getControl(window._reltree).setClonedProperty(Proplist.MOUSEDOWNROW,savepointer);
			browseallorders_rel1Loadlevel(rel1Currentchoice,window,queueReltree,rel1Loadedqueue,displaystring,rel1Loadall);
			if (!Clarion.newNumber(queueReltree.records()).equals(saverecords)) {
				savepointer.increment(Clarion.newNumber(1+queueReltree.records()).subtract(saverecords));
			}
			queueReltree.get(savepointer);
		}
	}
	public static void browseallorders_rel1Addentryserver(Window window,Rel1Loadedqueue rel1Loadedqueue,QueueReltree queueReltree,ClarionNumber rel1Currentchoice,ClarionNumber rel1Newitemlevel,ClarionString rel1Newitemposition,ClarionNumber rel1Loadall,ClarionString displaystring)
	{
		if (Clarion.getControl(window._insert).getProperty(Prop.DISABLE).boolValue()) {
			return;
		}
		rel1Currentchoice.setValue(Clarion.getControl(window._reltree).getProperty(Proplist.MOUSEDOWNROW));
		queueReltree.get(rel1Currentchoice);
		{
			ClarionNumber case_1=queueReltree.rel1Level.abs();
			boolean case_1_break=false;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1.equals(0)) {
				Main.accessCustomers.primerecord();
				Main.globalrequest.setValue(Constants.INSERTRECORD);
				Invoi001.updatecustomers();
				if (Main.globalresponse.equals(Constants.REQUESTCOMPLETED)) {
					rel1Newitemlevel.setValue(1);
					rel1Newitemposition.setValue(Main.detail.getPosition());
					browseallorders_rel1Refreshtree(queueReltree,rel1Loadedqueue,rel1Loadall,displaystring,rel1Newitemlevel,rel1Currentchoice,rel1Newitemposition,window);
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(1)) {
				Main.customers.reget(queueReltree.rel1Position);
				Main.orders.get(Clarion.newString(String.valueOf(0)),null);
				Main.orders.clear();
				Main.orders.custnumber.setValue(Main.customers.custnumber);
				Main.accessOrders.primerecord(Clarion.newNumber(1));
				Main.globalrequest.setValue(Constants.INSERTRECORD);
				Invoi001.updateorders();
				if (Main.globalresponse.equals(Constants.REQUESTCOMPLETED)) {
					rel1Newitemlevel.setValue(2);
					rel1Newitemposition.setValue(Main.orders.getPosition());
					browseallorders_rel1Refreshtree(queueReltree,rel1Loadedqueue,rel1Loadall,displaystring,rel1Newitemlevel,rel1Currentchoice,rel1Newitemposition,window);
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(2)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(3)) {
				while (queueReltree.rel1Level.abs().equals(3)) {
					rel1Currentchoice.decrement(1);
					queueReltree.get(rel1Currentchoice);
					if (CError.errorCode()!=0) break;
				}
				Main.orders.reget(queueReltree.rel1Position);
				Main.detail.get(Clarion.newString(String.valueOf(0)),null);
				Main.detail.clear();
				Main.detail.custnumber.setValue(Main.orders.custnumber);
				Main.detail.ordernumber.setValue(Main.orders.ordernumber);
				Main.accessDetail.primerecord(Clarion.newNumber(1));
				Main.globalrequest.setValue(Constants.INSERTRECORD);
				Invoi001.updatedetail();
				if (Main.globalresponse.equals(Constants.REQUESTCOMPLETED)) {
					rel1Newitemlevel.setValue(3);
					rel1Newitemposition.setValue(Main.detail.getPosition());
					browseallorders_rel1Refreshtree(queueReltree,rel1Loadedqueue,rel1Loadall,displaystring,rel1Newitemlevel,rel1Currentchoice,rel1Newitemposition,window);
				}
				case_1_break=true;
			}
		}
	}
	public static void browseallorders_rel1Previouslevel(QueueReltree queueReltree,Window window,ClarionNumber rel1Savelevel,Rel1Loadedqueue rel1Loadedqueue,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall)
	{
		queueReltree.get(CWin.choice(window._reltree));
		rel1Savelevel.setValue(queueReltree.rel1Level.abs());
		browseallorders_rel1Previoussavedlevel(queueReltree,rel1Loadedqueue,rel1Savelevel,window,rel1Currentchoice,displaystring,rel1Loadall);
	}
	public static void browseallorders_rel1Expandall(QueueReltree queueReltree,Rel1Loadedqueue rel1Loadedqueue,ClarionNumber rel1Loadall,ClarionString displaystring)
	{
		queueReltree.free();
		rel1Loadedqueue.free();
		rel1Loadall.setValue(Constants.TRUE);
		browseallorders_rel1LoadCustomers(rel1Loadedqueue,queueReltree,rel1Loadall,displaystring);
		rel1Loadall.setValue(Constants.FALSE);
	}
	public static void browseallorders_rel1Editentry(ClarionNumber rel1Action,Window window,Rel1Loadedqueue rel1Loadedqueue,QueueReltree queueReltree,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall,ClarionNumber rel1Savelevel,ClarionNumber rel1Newitemlevel,ClarionString rel1Newitemposition)
	{
		rel1Action.setValue(Constants.CHANGERECORD);
		browseallorders_rel1Updateloop(window,rel1Action,rel1Loadedqueue,queueReltree,rel1Currentchoice,displaystring,rel1Loadall,rel1Savelevel,rel1Newitemlevel,rel1Newitemposition);
	}
	public static void selectproducts()
	{
		ClarionString currenttab=Clarion.newString(80);
		ClarionNumber localrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesopened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionView brw1ViewBrowse=new Brw1ViewBrowse_1();
		QueueBrowse_1_1 queueBrowse_1=new QueueBrowse_1_1();
		Quickwindow_2 quickwindow=new Quickwindow_2(queueBrowse_1);
		Toolbarclass toolbar=new Toolbarclass();
		Queryformclass_1 qbe5=new Queryformclass_1();
		Queryformvisual_1 qbv5=new Queryformvisual_1();
		Brw1_1 brw1=new Brw1_1(quickwindow);
		Incrementallocatorclass brw1Sort0Locator=new Incrementallocatorclass();
		Stepstringclass brw1Sort0Stepclass=new Stepstringclass();
		Resizer_3 resizer=new Resizer_3();
		Thiswindow_3 thiswindow=new Thiswindow_3(quickwindow,toolbar,brw1,queueBrowse_1,brw1ViewBrowse,qbe5,qbv5,brw1Sort0Stepclass,brw1Sort0Locator,resizer);
		try {
			Main.globalresponse.setValue(thiswindow.run());
		} finally {
			quickwindow.close();
			brw1Sort0Locator.destruct();
		}
	}
	public static void updatedetail()
	{
		ClarionString currenttab=Clarion.newString(80);
		ClarionNumber checkflag=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber localrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesopened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString actionmessage=Clarion.newString(40).setEncoding(ClarionString.CSTRING);
		ClarionNumber recordchanged=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionDecimal locRegtotalprice=Clarion.newDecimal(9,2);
		ClarionDecimal locDisctotalprice=Clarion.newDecimal(9,2);
		ClarionDecimal locQuantityavailable=Clarion.newDecimal(7,2);
		ClarionDecimal savQuantity=Clarion.newDecimal(7,2);
		ClarionDecimal newQuantity=Clarion.newDecimal(7,2);
		ClarionNumber savBackorder=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString productdescription=Clarion.newString(35);
		Quickwindow_3 quickwindow=new Quickwindow_3(productdescription);
		Toolbarclass toolbar=new Toolbarclass();
		Toolbarupdateclass toolbarform=new Toolbarupdateclass();
		Resizer_4 resizer=new Resizer_4();
		Fieldcolorqueue_1 fieldcolorqueue=new Fieldcolorqueue_1();
		ClarionNumber curctrlfeq=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		Thiswindow_4 thiswindow=new Thiswindow_4();
		thiswindow.__Init__(actionmessage,quickwindow,toolbar,savQuantity,savBackorder,checkflag,thiswindow,productdescription,resizer,toolbarform,locQuantityavailable,fieldcolorqueue,newQuantity,locRegtotalprice,locDisctotalprice);
		try {
			Main.globalresponse.setValue(thiswindow.run());
		} finally {
			quickwindow.close();
		}
	}
	public static void updatedetail_calcvalues(ClarionDecimal locRegtotalprice,ClarionDecimal locDisctotalprice)
	{
		if (Main.detail.taxrate.equals(0)) {
			if (Main.detail.discountrate.equals(0)) {
				Main.detail.totalcost.setValue(Main.detail.price.multiply(Main.detail.quantityordered));
			}
			else {
				locRegtotalprice.setValue(Main.detail.price.multiply(Main.detail.quantityordered));
				Main.detail.discount.setValue(locRegtotalprice.multiply(Main.detail.discountrate).divide(100));
				Main.detail.totalcost.setValue(locRegtotalprice.subtract(Main.detail.discount));
				Main.detail.savings.setValue(locRegtotalprice.subtract(Main.detail.totalcost));
			}
		}
		else {
			if (Main.detail.discountrate.equals(0)) {
				locRegtotalprice.setValue(Main.detail.price.multiply(Main.detail.quantityordered));
				Main.detail.taxpaid.setValue(locRegtotalprice.multiply(Main.detail.taxrate).divide(100));
				Main.detail.totalcost.setValue(locRegtotalprice.add(Main.detail.taxpaid));
			}
			else {
				locRegtotalprice.setValue(Main.detail.price.multiply(Main.detail.quantityordered));
				Main.detail.discount.setValue(locRegtotalprice.multiply(Main.detail.discountrate).divide(100));
				locDisctotalprice.setValue(locRegtotalprice.subtract(Main.detail.discount));
				Main.detail.taxpaid.setValue(locDisctotalprice.multiply(Main.detail.taxrate).divide(100));
				Main.detail.totalcost.setValue(locDisctotalprice.add(Main.detail.taxpaid));
				Main.detail.savings.setValue(locRegtotalprice.subtract(Main.detail.totalcost));
			}
		}
	}
	public static void updatedetail_updateotherfiles(Thiswindow_4 thiswindow,ClarionNumber savBackorder,ClarionDecimal savQuantity,ClarionDecimal newQuantity)
	{
		Main.products.productnumber.setValue(Main.detail.productnumber);
		Main.accessProducts.tryfetch(Main.products.keyproductnumber);
		{
			ClarionNumber case_1=thiswindow.request;
			boolean case_1_break=false;
			if (case_1.equals(Constants.INSERTRECORD)) {
				if (Main.detail.backordered.equals(Constants.FALSE)) {
					Main.products.quantityinstock.decrement(Main.detail.quantityordered);
					if (!Main.accessProducts.update().equals(Level.BENIGN)) {
						CRun.stop(CError.error());
					}
					Main.invhist.date.setValue(CDate.today());
					Main.invhist.productnumber.setValue(Main.detail.productnumber);
					Main.invhist.transtype.setValue("Sale");
					Main.invhist.quantity.setValue(Main.detail.quantityordered.negate());
					Main.invhist.cost.setValue(Main.products.cost);
					Main.invhist.notes.setValue("New purchase");
					if (!Main.accessInvhist.insert().equals(Level.BENIGN)) {
						CRun.stop(CError.error());
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.CHANGERECORD)) {
				if (savBackorder.equals(Constants.FALSE)) {
					Main.products.quantityinstock.increment(savQuantity);
					Main.products.quantityinstock.decrement(newQuantity);
					if (!Main.accessProducts.update().equals(Level.BENIGN)) {
						CRun.stop(CError.error());
					}
					Main.invhist.date.setValue(CDate.today());
					Main.invhist.productnumber.setValue(Main.detail.productnumber);
					Main.invhist.transtype.setValue("Adj.");
					Main.invhist.quantity.setValue(savQuantity.subtract(newQuantity));
					Main.invhist.notes.setValue("Change in quantity purchased");
					if (!Main.accessInvhist.insert().equals(Level.BENIGN)) {
						CRun.stop(CError.error());
					}
				}
				else if (savBackorder.equals(Constants.TRUE) && Main.detail.backordered.equals(Constants.FALSE)) {
					Main.products.quantityinstock.decrement(Main.detail.quantityordered);
					if (!Main.accessProducts.update().equals(Level.BENIGN)) {
						CRun.stop(CError.error());
					}
					Main.invhist.date.setValue(CDate.today());
					Main.invhist.productnumber.setValue(Main.detail.productnumber);
					Main.invhist.transtype.setValue("Sale");
					Main.invhist.quantity.setValue(Main.detail.quantityordered.negate());
					Main.invhist.cost.setValue(Main.products.cost);
					Main.invhist.notes.setValue("New purchase");
					if (!Main.accessInvhist.insert().equals(Level.BENIGN)) {
						CRun.stop(CError.error());
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.DELETERECORD)) {
				if (savBackorder.equals(Constants.FALSE)) {
					Main.products.quantityinstock.increment(Main.detail.quantityordered);
					if (!Main.accessProducts.update().equals(Level.BENIGN)) {
						CRun.stop(CError.error());
					}
					Main.invhist.date.setValue(CDate.today());
					Main.invhist.productnumber.setValue(Main.detail.productnumber);
					Main.invhist.transtype.setValue("Adj.");
					Main.invhist.quantity.setValue(Main.detail.quantityordered);
					Main.invhist.notes.setValue("Cancelled Order");
					if (!Main.accessInvhist.insert().equals(Level.BENIGN)) {
						CRun.stop(CError.error());
					}
				}
				case_1_break=true;
			}
		}
	}
	public static void updateorders()
	{
		ClarionString currenttab=Clarion.newString(80);
		ClarionNumber localrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesopened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString actionmessage=Clarion.newString(40).setEncoding(ClarionString.CSTRING);
		ClarionNumber recordchanged=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString locBackordered=Clarion.newString(3);
		ClarionDecimal locTotalprice=Clarion.newDecimal(9,2);
		Quickwindow_4 quickwindow=new Quickwindow_4();
		Toolbarclass toolbar=new Toolbarclass();
		Toolbarupdateclass toolbarform=new Toolbarupdateclass();
		Resizer_5 resizer=new Resizer_5();
		Fieldcolorqueue_2 fieldcolorqueue=new Fieldcolorqueue_2();
		ClarionNumber curctrlfeq=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		Thiswindow_5 thiswindow=new Thiswindow_5();
		thiswindow.__Init__(actionmessage,quickwindow,toolbar,resizer,toolbarform,thiswindow,fieldcolorqueue);
		try {
			Main.globalresponse.setValue(thiswindow.run());
		} finally {
			quickwindow.close();
		}
	}
	public static void printinvoicefrombrowse()
	{
		ClarionNumber localrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesopened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionDecimal extendprice=Clarion.newDecimal(7,2);
		ClarionString locCcsz=Clarion.newString(35);
		ClarionNumber progressThermometer=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionView processView=new ProcessView();
		Progresswindow progresswindow=new Progresswindow(progressThermometer);
		Report report=new Report(locCcsz,extendprice);
		Thisreport thisreport=new Thisreport(extendprice,report);
		Steplongclass progressmgr=new Steplongclass();
		Printpreviewclass previewer=new Printpreviewclass();
		Thiswindow_7 thiswindow=new Thiswindow_7(progresswindow,progressmgr,thisreport,processView,progressThermometer,report,previewer,locCcsz);
		try {
			Main.globalresponse.setValue(thiswindow.run());
		} finally {
			progresswindow.close();
			report.close();
		}
	}
	public static void browseorders()
	{
		ClarionString currenttab=Clarion.newString(80);
		ClarionNumber localrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesopened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString locShipped=Clarion.newString(3);
		ClarionString locBackorder=Clarion.newString(3);
		ClarionString taxstring=Clarion.newString(8);
		ClarionString discountstring=Clarion.newString(8);
		ClarionDecimal totaltax=Clarion.newDecimal(7,2);
		ClarionDecimal totaldiscount=Clarion.newDecimal(7,2);
		ClarionDecimal totalcost=Clarion.newDecimal(7,2);
		ClarionView brw1ViewBrowse=new Brw1ViewBrowse_2();
		QueueBrowse_1_2 queueBrowse_1=new QueueBrowse_1_2(locShipped);
		ClarionView brw5ViewBrowse=new Brw5ViewBrowse();
		QueueBrowse queueBrowse=new QueueBrowse(locBackorder);
		Quickwindow_5 quickwindow=new Quickwindow_5(queueBrowse_1,queueBrowse,totaltax,totaldiscount,totalcost);
		Toolbarclass toolbar=new Toolbarclass();
		Detailbrowse detailbrowse=new Detailbrowse(quickwindow,totaltax,totaldiscount,totalcost,locBackorder);
		Steplocatorclass brw1Sort0Locator=new Steplocatorclass();
		Steplongclass brw1Sort0Stepclass=new Steplongclass();
		Ordersbrowse ordersbrowse=new Ordersbrowse(quickwindow,detailbrowse,locShipped);
		Steplocatorclass brw5Sort0Locator=new Steplocatorclass();
		Resizer_6 resizer=new Resizer_6();
		Thiswindow_8 thiswindow=new Thiswindow_8();
		thiswindow.__Init__(quickwindow,toolbar,ordersbrowse,queueBrowse_1,brw1ViewBrowse,detailbrowse,queueBrowse,brw5ViewBrowse,brw1Sort0Stepclass,brw1Sort0Locator,locShipped,brw5Sort0Locator,locBackorder,resizer,thiswindow);
		try {
			Main.globalresponse.setValue(thiswindow.run());
		} finally {
			quickwindow.close();
			brw1Sort0Locator.destruct();
			brw5Sort0Locator.destruct();
		}
	}
	public static void browsecustomers()
	{
		ClarionString currenttab=Clarion.newString(80);
		ClarionNumber localrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesopened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString locNameletter=Clarion.newString(1);
		ClarionString locCompanyletter=Clarion.newString(1);
		ClarionString locZipnum=Clarion.newString(2);
		ClarionString locState=Clarion.newString(2);
		ClarionString locFilterstring=Clarion.newString(255);
		ClarionView brw1ViewBrowse=new Brw1ViewBrowse_3();
		QueueBrowse_1_3 queueBrowse_1=new QueueBrowse_1_3(locFilterstring,locCompanyletter,locZipnum,locState,locNameletter);
		Quickwindow_6 quickwindow=new Quickwindow_6(queueBrowse_1);
		Toolbarclass toolbar=new Toolbarclass();
		Queryformclass_1 qbe6=new Queryformclass_1();
		Queryformvisual_1 qbv6=new Queryformvisual_1();
		Brw1_2 brw1=new Brw1_2(quickwindow);
		Filterlocatorclass brw1Sort0Locator=new Filterlocatorclass();
		Filterlocatorclass brw1Sort1Locator=new Filterlocatorclass();
		Filterlocatorclass brw1Sort2Locator=new Filterlocatorclass();
		Filterlocatorclass brw1Sort3Locator=new Filterlocatorclass();
		Stepstringclass brw1Sort0Stepclass=new Stepstringclass();
		Stepstringclass brw1Sort1Stepclass=new Stepstringclass();
		Stepstringclass brw1Sort2Stepclass=new Stepstringclass();
		Stepstringclass brw1Sort3Stepclass=new Stepstringclass();
		Resizer_7 resizer=new Resizer_7();
		Thiswindow_9 thiswindow=new Thiswindow_9();
		thiswindow.__Init__(quickwindow,toolbar,brw1,queueBrowse_1,brw1ViewBrowse,qbe6,qbv6,brw1Sort1Stepclass,brw1Sort1Locator,brw1Sort2Stepclass,brw1Sort2Locator,brw1Sort3Stepclass,brw1Sort3Locator,brw1Sort0Stepclass,brw1Sort0Locator,locFilterstring,locCompanyletter,locZipnum,locState,locNameletter,resizer,thiswindow);
		try {
			Main.globalresponse.setValue(thiswindow.run());
		} finally {
			quickwindow.close();
			brw1Sort0Locator.destruct();
			brw1Sort1Locator.destruct();
			brw1Sort2Locator.destruct();
			brw1Sort3Locator.destruct();
		}
	}
}
