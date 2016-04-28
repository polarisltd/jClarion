package clarion;

import clarion.AppFrame;
import clarion.BRW1ViewBrowse;
import clarion.BRW1ViewBrowse_1;
import clarion.Browseeipmanager;
import clarion.Brw1;
import clarion.Brw1_1;
import clarion.Customers;
import clarion.Detail;
import clarion.Fieldcolorqueue;
import clarion.Fieldcolorqueue_1;
import clarion.Fieldcolorqueue_2;
import clarion.Incrementallocatorclass;
import clarion.Invoi003;
import clarion.Main;
import clarion.Orders;
import clarion.Queryformclass;
import clarion.Queryformvisual;
import clarion.QueueBrowse_1;
import clarion.QueueBrowse_1_1;
import clarion.QueueReltree;
import clarion.QuickWindow;
import clarion.QuickWindow_1;
import clarion.QuickWindow_2;
import clarion.QuickWindow_3;
import clarion.QuickWindow_4;
import clarion.Rel1Loadedqueue;
import clarion.Rel1Toolbar;
import clarion.Resizer;
import clarion.Resizer_1;
import clarion.Resizer_2;
import clarion.Resizer_3;
import clarion.Resizer_4;
import clarion.Resizer_5;
import clarion.Stepstringclass;
import clarion.Thiswindow;
import clarion.Thiswindow_1;
import clarion.Thiswindow_2;
import clarion.Thiswindow_3;
import clarion.Thiswindow_4;
import clarion.Thiswindow_5;
import clarion.Thiswindow_6;
import clarion.Toolbarclass;
import clarion.Toolbarupdateclass;
import clarion.Window_2;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.equates.Proplist;
import clarion.equates.Vcr;
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

public class Invoi001
{

	public static void main()
	{
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString currentTab=Clarion.newString(80);
		ClarionNumber splashProcedureThread=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionString displayDayString=Clarion.newString("Sunday   Monday   Tuesday  WednesdayThursday Friday   Saturday ");
		ClarionArray<ClarionString> displayDayText=Clarion.newString(9).dim(7).setOver(displayDayString);
		AppFrame appFrame=new AppFrame();
		Toolbarclass toolbar=new Toolbarclass();
		Thiswindow_6 thisWindow=new Thiswindow_6(appFrame,displayDayText,toolbar);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			appFrame.close();
		}
	}
	public static void main_MenuReportMenu(AppFrame appFrame)
	{
		{
			int case_1=CWin.accepted();
			boolean case_1_break=false;
			if (case_1==appFrame._reportsPrintInvoice) {
				{
					CRun.start(new Runnable() { public void run() { Invoi003.printInvoice(); } } );
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1==appFrame._reportsPrintMailingLabels) {
				{
					CRun.start(new Runnable() { public void run() { Invoi003.printMailingLabels(); } } );
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1==appFrame._reportsSelectCWRWReport) {
				if (Main.re.loadReportLibrary(Clarion.newString("Invoice.txr")).boolValue()) {
					Main.re.setPreview();
					Main.re.printReport(Clarion.newString(String.valueOf(0)));
					Main.re.unloadReportLibrary();
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1==appFrame._printPROKeyProductSKU) {
				{
					CRun.start(new Runnable() { public void run() { Invoi003.printPROKeyProductSKU(); } } );
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1==appFrame._printCUSStateKey) {
				{
					CRun.start(new Runnable() { public void run() { Invoi003.printCUSStateKey(); } } );
				}
				case_1_break=true;
			}
		}
	}
	public static void main_MenuMaintenance(AppFrame appFrame)
	{
		{
			int case_1=CWin.accepted();
			if (case_1==appFrame._updateCompanyFile) {
				Main.globalRequest.setValue(Constants.CHANGERECORD);
				Invoi003.updateCompany();
			}
		}
	}
	public static void main_DefineListboxStyle()
	{
	}
	public static void selectStates()
	{
		ClarionString currentTab=Clarion.newString(80);
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionView bRW1ViewBrowse=new BRW1ViewBrowse();
		QueueBrowse_1 queueBrowse_1=new QueueBrowse_1();
		QuickWindow quickWindow=new QuickWindow(queueBrowse_1);
		Toolbarclass toolbar=new Toolbarclass();
		Incrementallocatorclass bRW1Sort0Locator=new Incrementallocatorclass();
		Browseeipmanager bRW1EIPManager=new Browseeipmanager();
		Stepstringclass bRW1Sort0StepClass=new Stepstringclass();
		Brw1 brw1=new Brw1(bRW1EIPManager,quickWindow);
		Resizer resizer=new Resizer();
		Thiswindow thisWindow=new Thiswindow(quickWindow,toolbar,brw1,queueBrowse_1,bRW1ViewBrowse,bRW1Sort0StepClass,bRW1Sort0Locator,resizer);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			quickWindow.close();
			bRW1Sort0Locator.destruct();
			brw1.destruct();
		}
	}
	public static void selectStates_DefineListboxStyle()
	{
	}
	public static void updateCustomers()
	{
		ClarionString currentTab=Clarion.newString(80);
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString actionMessage=Clarion.newString(40).setEncoding(ClarionString.CSTRING);
		ClarionNumber recordChanged=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Customers historyCUSRecord=(Customers)(new Customers()).getThread();
		QuickWindow_1 quickWindow=new QuickWindow_1();
		Toolbarclass toolbar=new Toolbarclass();
		Toolbarupdateclass toolbarForm=new Toolbarupdateclass();
		Resizer_1 resizer=new Resizer_1();
		Fieldcolorqueue fieldColorQueue=new Fieldcolorqueue();
		ClarionNumber curCtrlFeq=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		Thiswindow_1 thisWindow=new Thiswindow_1();
		thisWindow.__Init__(actionMessage,quickWindow,toolbar,historyCUSRecord,resizer,toolbarForm,thisWindow,fieldColorQueue);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			quickWindow.close();
		}
	}
	public static void updateCustomers_DefineListboxStyle()
	{
	}
	public static void browseAllOrders()
	{
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString displayString=Clarion.newString(255);
		ClarionNumber rEL1SaveLevel=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber rEL1Action=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		QueueReltree queueRelTree=new QueueReltree();
		Rel1Loadedqueue rEL1LoadedQueue=new Rel1Loadedqueue();
		ClarionNumber rEL1CurrentChoice=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber rEL1CurrentLevel=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber rEL1NewItemLevel=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionString rEL1NewItemPosition=Clarion.newString(1024);
		ClarionNumber rEL1LoadAll=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		Window_2 window=new Window_2(queueRelTree);
		Rel1Toolbar rEL1Toolbar=new Rel1Toolbar(queueRelTree,window,rEL1LoadedQueue,rEL1SaveLevel,rEL1CurrentChoice,displayString,rEL1LoadAll,rEL1Action,rEL1NewItemLevel,rEL1NewItemPosition,thisWindow);
		Toolbarclass toolbar=new Toolbarclass();
		Resizer_2 resizer=new Resizer_2();
		Thiswindow_2 thisWindow=new Thiswindow_2();
		thisWindow.__Init__(window,toolbar,queueRelTree,rEL1LoadedQueue,rEL1LoadAll,displayString,resizer,rEL1Toolbar,thisWindow,rEL1Action,rEL1CurrentChoice,rEL1SaveLevel,rEL1NewItemLevel,rEL1NewItemPosition,rEL1CurrentLevel);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			window.close();
		}
	}
	public static void browseAllOrders_REL1NextParent(QueueReltree queueRelTree,Window_2 window,Rel1Loadedqueue rEL1LoadedQueue,ClarionNumber rEL1SaveLevel,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll)
	{
		queueRelTree.get(CWin.choice(window._relTree));
		if (queueRelTree.rEL1Level.abs().compareTo(1)>0) {
			rEL1SaveLevel.setValue(queueRelTree.rEL1Level.abs().subtract(1));
			browseAllOrders_REL1NextSavedLevel(queueRelTree,rEL1LoadedQueue,rEL1SaveLevel,window,rEL1CurrentChoice,displayString,rEL1LoadAll);
		}
	}
	public static void browseAllOrders_REL1RemoveEntry(ClarionNumber rEL1Action,Window_2 window,Rel1Loadedqueue rEL1LoadedQueue,QueueReltree queueRelTree,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll,ClarionNumber rEL1SaveLevel,ClarionNumber rEL1NewItemLevel,ClarionString rEL1NewItemPosition)
	{
		rEL1Action.setValue(Constants.DELETERECORD);
		browseAllOrders_REL1UpdateLoop(window,rEL1Action,rEL1LoadedQueue,queueRelTree,rEL1CurrentChoice,displayString,rEL1LoadAll,rEL1SaveLevel,rEL1NewItemLevel,rEL1NewItemPosition);
	}
	public static void browseAllOrders_REL1LoadDetail(Rel1Loadedqueue rEL1LoadedQueue,QueueReltree queueRelTree,ClarionString displayString)
	{
		Main.detail.custNumber.setValue(Main.orders.custNumber);
		Main.detail.orderNumber.setValue(Main.orders.orderNumber);
		Main.detail.lineNumber.clear();
		Main.accessDetail.get().useFile();
		Main.detail.keyDetails.set(Main.detail.keyDetails);
		while (true) {
			if (Main.accessDetail.get().next().boolValue()) {
				if (Main.accessDetail.get().getEOF().boolValue()) {
					break;
				}
				else {
					CWin.post(Event.CLOSEWINDOW);
					return;
				}
			}
			if (!Main.detail.custNumber.equals(Main.orders.custNumber)) {
				break;
			}
			if (!Main.detail.orderNumber.equals(Main.orders.orderNumber)) {
				break;
			}
			queueRelTree.rEL1Loaded.setValue(0);
			queueRelTree.rEL1Position.setValue(Main.detail.getPosition());
			queueRelTree.rEL1Level.setValue(3);
			browseAllOrders_REL1FormatDetail(displayString,rEL1LoadedQueue,queueRelTree);
			queueRelTree.add(queueRelTree.getPointer()+1);
		}
	}
	public static void browseAllOrders_REL1RefreshTree(QueueReltree queueRelTree,Rel1Loadedqueue rEL1LoadedQueue,ClarionNumber rEL1LoadAll,ClarionString displayString,ClarionNumber rEL1NewItemLevel,ClarionNumber rEL1CurrentChoice,ClarionString rEL1NewItemPosition,Window_2 window)
	{
		queueRelTree.free();
		browseAllOrders_REL1LoadCustomers(rEL1LoadedQueue,queueRelTree,rEL1LoadAll,displayString);
		if (rEL1NewItemLevel.boolValue()) {
			rEL1CurrentChoice.setValue(0);
			while (true) {
				rEL1CurrentChoice.increment(1);
				queueRelTree.get(rEL1CurrentChoice);
				if (CError.errorCode()!=0) {
					break;
				}
				if (!queueRelTree.rEL1Level.abs().equals(rEL1NewItemLevel.abs())) {
					continue;
				}
				if (!queueRelTree.rEL1Position.equals(rEL1NewItemPosition)) {
					continue;
				}
				CWin.select(window._relTree,rEL1CurrentChoice.intValue());
				break;
			}
		}
	}
	public static void browseAllOrders_REL1ContractAll(QueueReltree queueRelTree,Rel1Loadedqueue rEL1LoadedQueue,ClarionNumber rEL1LoadAll,ClarionString displayString)
	{
		queueRelTree.free();
		rEL1LoadedQueue.free();
		browseAllOrders_REL1LoadCustomers(rEL1LoadedQueue,queueRelTree,rEL1LoadAll,displayString);
	}
	public static void browseAllOrders_REL1UpdateLoop(Window_2 window,ClarionNumber rEL1Action,Rel1Loadedqueue rEL1LoadedQueue,QueueReltree queueRelTree,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll,ClarionNumber rEL1SaveLevel,ClarionNumber rEL1NewItemLevel,ClarionString rEL1NewItemPosition)
	{
		while (true) {
			Main.vCRRequest.setValue(Vcr.NONE);
			Clarion.getControl(window._relTree).setProperty(Proplist.MOUSEDOWNROW,CWin.choice(window._relTree));
			{
				ClarionNumber case_1=rEL1Action;
				boolean case_1_break=false;
				if (case_1.equals(Constants.INSERTRECORD)) {
					browseAllOrders_REL1AddEntryServer(window,rEL1LoadedQueue,queueRelTree,rEL1CurrentChoice,rEL1NewItemLevel,rEL1NewItemPosition,rEL1LoadAll,displayString);
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Constants.DELETERECORD)) {
					browseAllOrders_REL1RemoveEntryServer(window,rEL1LoadedQueue,queueRelTree,rEL1CurrentChoice,rEL1LoadAll,displayString,rEL1NewItemLevel,rEL1NewItemPosition);
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Constants.CHANGERECORD)) {
					browseAllOrders_REL1EditEntryServer(window,rEL1LoadedQueue,queueRelTree,rEL1CurrentChoice,rEL1NewItemLevel,rEL1NewItemPosition,rEL1LoadAll,displayString);
					case_1_break=true;
				}
			}
			{
				ClarionNumber case_2=Main.vCRRequest;
				boolean case_2_break=false;
				if (case_2.equals(Vcr.FORWARD)) {
					browseAllOrders_REL1NextRecord(window,queueRelTree,rEL1LoadedQueue,rEL1CurrentChoice,displayString,rEL1LoadAll);
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(Vcr.BACKWARD)) {
					browseAllOrders_REL1PreviousRecord(window,queueRelTree,rEL1LoadedQueue,rEL1CurrentChoice,displayString,rEL1LoadAll);
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(Vcr.PAGEFORWARD)) {
					browseAllOrders_REL1NextLevel(queueRelTree,window,rEL1SaveLevel,rEL1LoadedQueue,rEL1CurrentChoice,displayString,rEL1LoadAll);
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(Vcr.PAGEBACKWARD)) {
					browseAllOrders_REL1PreviousLevel(queueRelTree,window,rEL1SaveLevel,rEL1LoadedQueue,rEL1CurrentChoice,displayString,rEL1LoadAll);
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(Vcr.FIRST)) {
					browseAllOrders_REL1PreviousParent(queueRelTree,window,rEL1LoadedQueue,rEL1SaveLevel,rEL1CurrentChoice,displayString,rEL1LoadAll);
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(Vcr.LAST)) {
					browseAllOrders_REL1NextParent(queueRelTree,window,rEL1LoadedQueue,rEL1SaveLevel,rEL1CurrentChoice,displayString,rEL1LoadAll);
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(Vcr.INSERT)) {
					browseAllOrders_REL1PreviousParent(queueRelTree,window,rEL1LoadedQueue,rEL1SaveLevel,rEL1CurrentChoice,displayString,rEL1LoadAll);
					rEL1Action.setValue(Constants.INSERTRECORD);
					case_2_break=true;
				}
				if (!case_2_break && case_2.equals(Vcr.NONE)) {
					break;
					// UNREACHABLE! :case_2_break=true;
				}
			}
		}
	}
	public static void browseAllOrders_REL1AssignButtons(Rel1Toolbar rEL1Toolbar,Window_2 window,Toolbarclass toolbar)
	{
		rEL1Toolbar.deleteButton.setValue(window._delete);
		rEL1Toolbar.insertButton.setValue(window._insert);
		rEL1Toolbar.changeButton.setValue(window._change);
		rEL1Toolbar.helpButton.setValue(window._help);
		toolbar.setTarget(Clarion.newNumber(window._relTree));
	}
	public static void browseAllOrders_REL1FormatCustomers(ClarionString displayString,Rel1Loadedqueue rEL1LoadedQueue,QueueReltree queueRelTree)
	{
		displayString.setValue(Main.customers.firstName.clip().concat(" ",Main.customers.lastName.clip(),"  ",Main.customers.custNumber.getString().format("@P(#######)P")));
		queueRelTree.rEL1Display.setValue(displayString);
		queueRelTree.rEL1NormalFG.setValue(128);
		queueRelTree.rEL1NormalBG.setValue(-1);
		queueRelTree.rEL1SelectedFG.setValue(-1);
		queueRelTree.rEL1SelectedBG.setValue(-1);
		queueRelTree.rEL1Icon.setValue(2);
	}
	public static void browseAllOrders_REL1PreviousParent(QueueReltree queueRelTree,Window_2 window,Rel1Loadedqueue rEL1LoadedQueue,ClarionNumber rEL1SaveLevel,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll)
	{
		queueRelTree.get(CWin.choice(window._relTree));
		if (queueRelTree.rEL1Level.abs().compareTo(1)>0) {
			rEL1SaveLevel.setValue(queueRelTree.rEL1Level.abs().subtract(1));
			browseAllOrders_REL1PreviousSavedLevel(queueRelTree,rEL1LoadedQueue,rEL1SaveLevel,window,rEL1CurrentChoice,displayString,rEL1LoadAll);
		}
	}
	public static void browseAllOrders_REL1UnloadLevel(ClarionNumber rEL1CurrentChoice,Window_2 window,QueueReltree queueRelTree,Rel1Loadedqueue rEL1LoadedQueue,ClarionString displayString,ClarionNumber rEL1CurrentLevel)
	{
		rEL1CurrentChoice.setValue(Clarion.getControl(window._relTree).getProperty(Proplist.MOUSEDOWNROW));
		queueRelTree.get(rEL1CurrentChoice);
		if (queueRelTree.rEL1Loaded.boolValue()) {
			queueRelTree.rEL1Level.setValue(queueRelTree.rEL1Level.abs().negate());
			queueRelTree.put();
			queueRelTree.rEL1Loaded.setValue(Constants.FALSE);
			rEL1LoadedQueue.rEL1LoadedLevel.setValue(queueRelTree.rEL1Level.abs());
			rEL1LoadedQueue.rEL1LoadedPosition.setValue(queueRelTree.rEL1Position);
			rEL1LoadedQueue.get(rEL1LoadedQueue.ORDER().ascend(rEL1LoadedQueue.rEL1LoadedLevel).ascend(rEL1LoadedQueue.rEL1LoadedPosition));
			if (!(CError.errorCode()!=0)) {
				rEL1LoadedQueue.delete();
			}
			{
				int execute_1=queueRelTree.rEL1Level.abs().intValue();
				if (execute_1==1) {
					Main.customers.keyFullName.reget(queueRelTree.rEL1Position);
					browseAllOrders_REL1FormatCustomers(displayString,rEL1LoadedQueue,queueRelTree);
				}
				if (execute_1==2) {
					Main.orders.reget(queueRelTree.rEL1Position);
					browseAllOrders_REL1FormatOrders(displayString,rEL1LoadedQueue,queueRelTree);
				}
				if (execute_1==3) {
					Main.detail.reget(queueRelTree.rEL1Position);
					browseAllOrders_REL1FormatDetail(displayString,rEL1LoadedQueue,queueRelTree);
				}
			}
			queueRelTree.put();
			rEL1CurrentLevel.setValue(queueRelTree.rEL1Level.abs());
			rEL1CurrentChoice.increment(1);
			while (true) {
				queueRelTree.get(rEL1CurrentChoice);
				if (CError.errorCode()!=0) {
					break;
				}
				if (queueRelTree.rEL1Level.abs().compareTo(rEL1CurrentLevel)<=0) {
					break;
				}
				queueRelTree.delete();
			}
		}
	}
	public static void browseAllOrders_REL1EditEntryServer(Window_2 window,Rel1Loadedqueue rEL1LoadedQueue,QueueReltree queueRelTree,ClarionNumber rEL1CurrentChoice,ClarionNumber rEL1NewItemLevel,ClarionString rEL1NewItemPosition,ClarionNumber rEL1LoadAll,ClarionString displayString)
	{
		if (Clarion.getControl(window._change).getProperty(Prop.DISABLE).boolValue()) {
			return;
		}
		rEL1CurrentChoice.setValue(Clarion.getControl(window._relTree).getProperty(Proplist.MOUSEDOWNROW));
		queueRelTree.get(rEL1CurrentChoice);
		{
			ClarionNumber case_1=queueRelTree.rEL1Level.abs();
			boolean case_1_break=false;
			if (case_1.equals(1)) {
				Main.customers.watch();
				Main.customers.reget(queueRelTree.rEL1Position);
				Main.globalRequest.setValue(Constants.CHANGERECORD);
				Invoi001.updateCustomers();
				if (Main.globalResponse.equals(Constants.REQUESTCOMPLETED)) {
					rEL1NewItemLevel.setValue(1);
					rEL1NewItemPosition.setValue(Main.customers.getPosition());
					browseAllOrders_REL1RefreshTree(queueRelTree,rEL1LoadedQueue,rEL1LoadAll,displayString,rEL1NewItemLevel,rEL1CurrentChoice,rEL1NewItemPosition,window);
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(2)) {
				Main.orders.watch();
				Main.orders.reget(queueRelTree.rEL1Position);
				Main.globalRequest.setValue(Constants.CHANGERECORD);
				Invoi001.updateOrders();
				if (Main.globalResponse.equals(Constants.REQUESTCOMPLETED)) {
					rEL1NewItemLevel.setValue(1);
					rEL1NewItemPosition.setValue(Main.orders.getPosition());
					browseAllOrders_REL1RefreshTree(queueRelTree,rEL1LoadedQueue,rEL1LoadAll,displayString,rEL1NewItemLevel,rEL1CurrentChoice,rEL1NewItemPosition,window);
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(3)) {
				Main.detail.watch();
				Main.detail.reget(queueRelTree.rEL1Position);
				Main.globalRequest.setValue(Constants.CHANGERECORD);
				Invoi001.updateDetail();
				if (Main.globalResponse.equals(Constants.REQUESTCOMPLETED)) {
					rEL1NewItemLevel.setValue(1);
					rEL1NewItemPosition.setValue(Main.detail.getPosition());
					browseAllOrders_REL1RefreshTree(queueRelTree,rEL1LoadedQueue,rEL1LoadAll,displayString,rEL1NewItemLevel,rEL1CurrentChoice,rEL1NewItemPosition,window);
				}
				case_1_break=true;
			}
		}
	}
	public static void browseAllOrders_REL1LoadLevel(ClarionNumber rEL1CurrentChoice,Window_2 window,QueueReltree queueRelTree,Rel1Loadedqueue rEL1LoadedQueue,ClarionString displayString,ClarionNumber rEL1LoadAll)
	{
		rEL1CurrentChoice.setValue(Clarion.getControl(window._relTree).getProperty(Proplist.MOUSEDOWNROW));
		queueRelTree.get(rEL1CurrentChoice);
		if (!queueRelTree.rEL1Loaded.boolValue()) {
			queueRelTree.rEL1Level.setValue(queueRelTree.rEL1Level.abs());
			queueRelTree.put();
			queueRelTree.rEL1Loaded.setValue(Constants.TRUE);
			rEL1LoadedQueue.rEL1LoadedLevel.setValue(queueRelTree.rEL1Level.abs());
			rEL1LoadedQueue.rEL1LoadedPosition.setValue(queueRelTree.rEL1Position);
			rEL1LoadedQueue.add(rEL1LoadedQueue.ORDER().ascend(rEL1LoadedQueue.rEL1LoadedLevel).ascend(rEL1LoadedQueue.rEL1LoadedPosition));
			{
				int execute_1=queueRelTree.rEL1Level.abs().intValue();
				if (execute_1==1) {
					Main.customers.keyFullName.reget(queueRelTree.rEL1Position);
					browseAllOrders_REL1FormatCustomers(displayString,rEL1LoadedQueue,queueRelTree);
				}
				if (execute_1==2) {
					Main.orders.reget(queueRelTree.rEL1Position);
					browseAllOrders_REL1FormatOrders(displayString,rEL1LoadedQueue,queueRelTree);
				}
				if (execute_1==3) {
					Main.detail.reget(queueRelTree.rEL1Position);
					browseAllOrders_REL1FormatDetail(displayString,rEL1LoadedQueue,queueRelTree);
				}
			}
			queueRelTree.put();
			{
				int execute_2=queueRelTree.rEL1Level.abs().intValue();
				if (execute_2==1) {
					browseAllOrders_REL1LoadOrders(rEL1LoadedQueue,queueRelTree,rEL1LoadAll,displayString);
				}
				if (execute_2==2) {
					browseAllOrders_REL1LoadDetail(rEL1LoadedQueue,queueRelTree,displayString);
				}
			}
		}
	}
	public static void browseAllOrders_REL1NextRecord(Window_2 window,QueueReltree queueRelTree,Rel1Loadedqueue rEL1LoadedQueue,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll)
	{
		browseAllOrders_REL1LoadLevel(rEL1CurrentChoice,window,queueRelTree,rEL1LoadedQueue,displayString,rEL1LoadAll);
		if (CWin.choice(window._relTree)<queueRelTree.records()) {
			CWin.select(window._relTree,CWin.choice(window._relTree)+1);
		}
	}
	public static void browseAllOrders_REL1AddEntry(ClarionNumber rEL1Action,Window_2 window,Rel1Loadedqueue rEL1LoadedQueue,QueueReltree queueRelTree,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll,ClarionNumber rEL1SaveLevel,ClarionNumber rEL1NewItemLevel,ClarionString rEL1NewItemPosition)
	{
		rEL1Action.setValue(Constants.INSERTRECORD);
		browseAllOrders_REL1UpdateLoop(window,rEL1Action,rEL1LoadedQueue,queueRelTree,rEL1CurrentChoice,displayString,rEL1LoadAll,rEL1SaveLevel,rEL1NewItemLevel,rEL1NewItemPosition);
	}
	public static void browseAllOrders_REL1RemoveEntryServer(Window_2 window,Rel1Loadedqueue rEL1LoadedQueue,QueueReltree queueRelTree,ClarionNumber rEL1CurrentChoice,ClarionNumber rEL1LoadAll,ClarionString displayString,ClarionNumber rEL1NewItemLevel,ClarionString rEL1NewItemPosition)
	{
		if (Clarion.getControl(window._delete).getProperty(Prop.DISABLE).boolValue()) {
			return;
		}
		rEL1CurrentChoice.setValue(Clarion.getControl(window._relTree).getProperty(Proplist.MOUSEDOWNROW));
		queueRelTree.get(rEL1CurrentChoice);
		{
			ClarionNumber case_1=queueRelTree.rEL1Level.abs();
			boolean case_1_break=false;
			if (case_1.equals(1)) {
				Main.customers.reget(queueRelTree.rEL1Position);
				Main.globalRequest.setValue(Constants.DELETERECORD);
				Invoi001.updateCustomers();
				if (Main.globalResponse.equals(Constants.REQUESTCOMPLETED)) {
					browseAllOrders_REL1RefreshTree(queueRelTree,rEL1LoadedQueue,rEL1LoadAll,displayString,rEL1NewItemLevel,rEL1CurrentChoice,rEL1NewItemPosition,window);
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(2)) {
				Main.orders.reget(queueRelTree.rEL1Position);
				Main.globalRequest.setValue(Constants.DELETERECORD);
				Invoi001.updateOrders();
				if (Main.globalResponse.equals(Constants.REQUESTCOMPLETED)) {
					browseAllOrders_REL1RefreshTree(queueRelTree,rEL1LoadedQueue,rEL1LoadAll,displayString,rEL1NewItemLevel,rEL1CurrentChoice,rEL1NewItemPosition,window);
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(3)) {
				Main.detail.reget(queueRelTree.rEL1Position);
				Main.globalRequest.setValue(Constants.DELETERECORD);
				Invoi001.updateDetail();
				if (Main.globalResponse.equals(Constants.REQUESTCOMPLETED)) {
					browseAllOrders_REL1RefreshTree(queueRelTree,rEL1LoadedQueue,rEL1LoadAll,displayString,rEL1NewItemLevel,rEL1CurrentChoice,rEL1NewItemPosition,window);
				}
				case_1_break=true;
			}
		}
	}
	public static void browseAllOrders_REL1NextLevel(QueueReltree queueRelTree,Window_2 window,ClarionNumber rEL1SaveLevel,Rel1Loadedqueue rEL1LoadedQueue,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll)
	{
		queueRelTree.get(CWin.choice(window._relTree));
		rEL1SaveLevel.setValue(queueRelTree.rEL1Level.abs());
		browseAllOrders_REL1NextSavedLevel(queueRelTree,rEL1LoadedQueue,rEL1SaveLevel,window,rEL1CurrentChoice,displayString,rEL1LoadAll);
	}
	public static void browseAllOrders_REL1NextSavedLevel(QueueReltree queueRelTree,Rel1Loadedqueue rEL1LoadedQueue,ClarionNumber rEL1SaveLevel,Window_2 window,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll)
	{
		ClarionNumber savePointer=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		while (true) {
			while (true) {
				queueRelTree.get(queueRelTree.getPointer()+1);
				if (CError.errorCode()!=0) {
					return;
				}
				if (!(queueRelTree.rEL1Level.abs().compareTo(rEL1SaveLevel)>0)) break;
			}
			if (queueRelTree.rEL1Level.abs().equals(rEL1SaveLevel)) {
				CWin.select(window._relTree,queueRelTree.getPointer());
				return;
			}
			savePointer.setValue(queueRelTree.getPointer());
			Clarion.getControl(window._relTree).setClonedProperty(Proplist.MOUSEDOWNROW,savePointer);
			browseAllOrders_REL1LoadLevel(rEL1CurrentChoice,window,queueRelTree,rEL1LoadedQueue,displayString,rEL1LoadAll);
			queueRelTree.get(savePointer);
		}
	}
	public static void browseAllOrders_REL1FormatOrders(ClarionString displayString,Rel1Loadedqueue rEL1LoadedQueue,QueueReltree queueRelTree)
	{
		displayString.setValue(ClarionString.staticConcat("Invoice# ",Main.orders.invoiceNumber.getString().format("@P######P"),", Order# ",Main.orders.orderNumber.getString().format("@P#######P"),", (",Main.orders.orderDate.getString().format("@D1").left(),")"));
		queueRelTree.rEL1Display.setValue(displayString);
		queueRelTree.rEL1NormalFG.setValue(8388608);
		queueRelTree.rEL1NormalBG.setValue(-1);
		queueRelTree.rEL1SelectedFG.setValue(-1);
		queueRelTree.rEL1SelectedBG.setValue(-1);
		queueRelTree.rEL1Icon.setValue(3);
	}
	public static void browseAllOrders_REL1PreviousRecord(Window_2 window,QueueReltree queueRelTree,Rel1Loadedqueue rEL1LoadedQueue,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll)
	{
		ClarionNumber saveRecords=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber savePointer=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		savePointer.setValue(CWin.choice(window._relTree)-1);
		while (true) {
			saveRecords.setValue(queueRelTree.records());
			Clarion.getControl(window._relTree).setClonedProperty(Proplist.MOUSEDOWNROW,savePointer);
			browseAllOrders_REL1LoadLevel(rEL1CurrentChoice,window,queueRelTree,rEL1LoadedQueue,displayString,rEL1LoadAll);
			if (Clarion.newNumber(queueRelTree.records()).equals(saveRecords)) {
				break;
			}
			savePointer.increment(Clarion.newNumber(queueRelTree.records()).subtract(saveRecords));
		}
		CWin.select(window._relTree,savePointer.intValue());
	}
	public static void browseAllOrders_REL1LoadOrders(Rel1Loadedqueue rEL1LoadedQueue,QueueReltree queueRelTree,ClarionNumber rEL1LoadAll,ClarionString displayString)
	{
		Main.orders.custNumber.setValue(Main.customers.custNumber);
		Main.orders.orderNumber.clear();
		Main.accessOrders.get().useFile();
		Main.orders.keyCustOrderNumber.set(Main.orders.keyCustOrderNumber);
		while (true) {
			if (Main.accessOrders.get().next().boolValue()) {
				if (Main.accessOrders.get().getEOF().boolValue()) {
					break;
				}
				else {
					CWin.post(Event.CLOSEWINDOW);
					return;
				}
			}
			if (!Main.orders.custNumber.equals(Main.customers.custNumber)) {
				break;
			}
			queueRelTree.rEL1Loaded.setValue(0);
			queueRelTree.rEL1Position.setValue(Main.orders.getPosition());
			queueRelTree.rEL1Level.setValue(2);
			rEL1LoadedQueue.rEL1LoadedLevel.setValue(queueRelTree.rEL1Level.abs());
			rEL1LoadedQueue.rEL1LoadedPosition.setValue(queueRelTree.rEL1Position);
			rEL1LoadedQueue.get(rEL1LoadedQueue.ORDER().ascend(rEL1LoadedQueue.rEL1LoadedLevel).ascend(rEL1LoadedQueue.rEL1LoadedPosition));
			if (CError.errorCode()!=0 && rEL1LoadAll.equals(Constants.FALSE)) {
				Main.detail.custNumber.setValue(Main.orders.custNumber);
				Main.detail.orderNumber.setValue(Main.orders.orderNumber);
				Main.detail.lineNumber.clear(0);
				Main.accessDetail.get().useFile();
				Main.detail.keyDetails.set(Main.detail.keyDetails);
				while (true) {
					if (Main.accessDetail.get().next().boolValue()) {
						if (Main.accessDetail.get().getEOF().boolValue()) {
							break;
						}
						else {
							CWin.post(Event.CLOSEWINDOW);
							return;
						}
					}
					if (!Main.detail.custNumber.getString().upper().equals(Main.orders.custNumber.getString().upper())) {
						break;
					}
					if (!Main.detail.orderNumber.getString().upper().equals(Main.orders.orderNumber.getString().upper())) {
						break;
					}
					queueRelTree.rEL1Level.setValue(-2);
					break;
				}
				browseAllOrders_REL1FormatOrders(displayString,rEL1LoadedQueue,queueRelTree);
				queueRelTree.add(queueRelTree.getPointer()+1);
			}
			else {
				if (rEL1LoadAll.boolValue()) {
					rEL1LoadedQueue.add(rEL1LoadedQueue.ORDER().ascend(rEL1LoadedQueue.rEL1LoadedLevel).ascend(rEL1LoadedQueue.rEL1LoadedPosition));
				}
				queueRelTree.rEL1Level.setValue(2);
				queueRelTree.rEL1Loaded.setValue(Constants.TRUE);
				browseAllOrders_REL1FormatOrders(displayString,rEL1LoadedQueue,queueRelTree);
				queueRelTree.add(queueRelTree.getPointer()+1);
				browseAllOrders_REL1LoadDetail(rEL1LoadedQueue,queueRelTree,displayString);
			}
		}
	}
	public static void browseAllOrders_REL1FormatDetail(ClarionString displayString,Rel1Loadedqueue rEL1LoadedQueue,QueueReltree queueRelTree)
	{
		displayString.clear();
		Main.products.productNumber.setValue(Main.detail.productNumber);
		Main.accessProducts.get().fetch(Main.products.keyProductNumber);
		displayString.setValue(Main.products.description.clip().concat(" (",Main.detail.quantityOrdered.getString().format("@N5").left().clip()," @ ",Main.detail.price.getString().format("@N$10.2").left().clip(),"), Tax = ",Main.detail.taxPaid.getString().format("@N$10.2").left().clip(),", Discount = ",Main.detail.discount.getString().format("@N$10.2").left().clip(),", ","Total Cost = ",Main.detail.totalCost.getString().format("@N$14.2").left()));
		queueRelTree.rEL1Display.setValue(displayString);
		if (Main.detail.backOrdered.equals(Constants.TRUE)) {
			queueRelTree.rEL1NormalFG.setValue(255);
			queueRelTree.rEL1NormalBG.setValue(-1);
			queueRelTree.rEL1SelectedFG.setValue(-1);
			queueRelTree.rEL1SelectedBG.setValue(-1);
		}
		else {
			queueRelTree.rEL1NormalFG.setValue(32768);
			queueRelTree.rEL1NormalBG.setValue(-1);
			queueRelTree.rEL1SelectedFG.setValue(-1);
			queueRelTree.rEL1SelectedBG.setValue(-1);
		}
		queueRelTree.rEL1Icon.setValue(4);
	}
	public static void browseAllOrders_REL1LoadCustomers(Rel1Loadedqueue rEL1LoadedQueue,QueueReltree queueRelTree,ClarionNumber rEL1LoadAll,ClarionString displayString)
	{
		queueRelTree.rEL1Display.setValue("CUSTOMERS'' ORDERS");
		queueRelTree.rEL1Loaded.setValue(0);
		queueRelTree.rEL1Position.setValue("");
		queueRelTree.rEL1Level.setValue(0);
		queueRelTree.rEL1Icon.setValue(1);
		queueRelTree.rEL1NormalFG.setValue(-1);
		queueRelTree.rEL1NormalBG.setValue(-1);
		queueRelTree.rEL1SelectedFG.setValue(-1);
		queueRelTree.rEL1SelectedBG.setValue(-1);
		queueRelTree.add();
		Main.accessCustomers.get().useFile();
		Main.customers.keyFullName.setStart();
		while (true) {
			if (!Main.accessCustomers.get().next().equals(Level.BENIGN)) {
				if (Main.accessCustomers.get().getEOF().boolValue()) {
					break;
				}
				else {
					CWin.post(Event.CLOSEWINDOW);
					return;
				}
			}
			queueRelTree.rEL1Loaded.setValue(0);
			queueRelTree.rEL1Position.setValue(Main.customers.keyFullName.getPosition());
			queueRelTree.rEL1Level.setValue(1);
			rEL1LoadedQueue.rEL1LoadedLevel.setValue(queueRelTree.rEL1Level.abs());
			rEL1LoadedQueue.rEL1LoadedPosition.setValue(queueRelTree.rEL1Position);
			rEL1LoadedQueue.get(rEL1LoadedQueue.ORDER().ascend(rEL1LoadedQueue.rEL1LoadedLevel).ascend(rEL1LoadedQueue.rEL1LoadedPosition));
			if (CError.errorCode()!=0 && rEL1LoadAll.equals(Constants.FALSE)) {
				Main.orders.custNumber.setValue(Main.customers.custNumber);
				Main.orders.orderNumber.clear(0);
				Main.accessOrders.get().useFile();
				Main.orders.keyCustOrderNumber.set(Main.orders.keyCustOrderNumber);
				while (true) {
					if (Main.accessOrders.get().next().boolValue()) {
						if (Main.accessOrders.get().getEOF().boolValue()) {
							break;
						}
						else {
							CWin.post(Event.CLOSEWINDOW);
							return;
						}
					}
					if (!Main.orders.custNumber.getString().upper().equals(Main.customers.custNumber.getString().upper())) {
						break;
					}
					queueRelTree.rEL1Level.setValue(-1);
					break;
				}
				browseAllOrders_REL1FormatCustomers(displayString,rEL1LoadedQueue,queueRelTree);
				queueRelTree.add(queueRelTree.getPointer()+1);
			}
			else {
				if (rEL1LoadAll.boolValue()) {
					rEL1LoadedQueue.add(rEL1LoadedQueue.ORDER().ascend(rEL1LoadedQueue.rEL1LoadedLevel).ascend(rEL1LoadedQueue.rEL1LoadedPosition));
				}
				queueRelTree.rEL1Level.setValue(1);
				queueRelTree.rEL1Loaded.setValue(Constants.TRUE);
				browseAllOrders_REL1FormatCustomers(displayString,rEL1LoadedQueue,queueRelTree);
				queueRelTree.add(queueRelTree.getPointer()+1);
				browseAllOrders_REL1LoadOrders(rEL1LoadedQueue,queueRelTree,rEL1LoadAll,displayString);
			}
		}
	}
	public static void browseAllOrders_REL1PreviousSavedLevel(QueueReltree queueRelTree,Rel1Loadedqueue rEL1LoadedQueue,ClarionNumber rEL1SaveLevel,Window_2 window,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll)
	{
		ClarionNumber saveRecords=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber savePointer=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		while (true) {
			while (true) {
				queueRelTree.get(queueRelTree.getPointer()-1);
				if (CError.errorCode()!=0) {
					return;
				}
				if (!(queueRelTree.rEL1Level.abs().compareTo(rEL1SaveLevel)>0)) break;
			}
			if (queueRelTree.rEL1Level.abs().equals(rEL1SaveLevel)) {
				CWin.select(window._relTree,queueRelTree.getPointer());
				return;
			}
			savePointer.setValue(queueRelTree.getPointer());
			saveRecords.setValue(queueRelTree.records());
			Clarion.getControl(window._relTree).setClonedProperty(Proplist.MOUSEDOWNROW,savePointer);
			browseAllOrders_REL1LoadLevel(rEL1CurrentChoice,window,queueRelTree,rEL1LoadedQueue,displayString,rEL1LoadAll);
			if (!Clarion.newNumber(queueRelTree.records()).equals(saveRecords)) {
				savePointer.increment(Clarion.newNumber(1+queueRelTree.records()).subtract(saveRecords));
			}
			queueRelTree.get(savePointer);
		}
	}
	public static void browseAllOrders_DefineListboxStyle()
	{
	}
	public static void browseAllOrders_REL1AddEntryServer(Window_2 window,Rel1Loadedqueue rEL1LoadedQueue,QueueReltree queueRelTree,ClarionNumber rEL1CurrentChoice,ClarionNumber rEL1NewItemLevel,ClarionString rEL1NewItemPosition,ClarionNumber rEL1LoadAll,ClarionString displayString)
	{
		if (Clarion.getControl(window._insert).getProperty(Prop.DISABLE).boolValue()) {
			return;
		}
		rEL1CurrentChoice.setValue(Clarion.getControl(window._relTree).getProperty(Proplist.MOUSEDOWNROW));
		queueRelTree.get(rEL1CurrentChoice);
		{
			ClarionNumber case_1=queueRelTree.rEL1Level.abs();
			boolean case_1_break=false;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1.equals(0)) {
				Main.accessCustomers.get().primeRecord();
				Main.globalRequest.setValue(Constants.INSERTRECORD);
				Invoi001.updateCustomers();
				if (Main.globalResponse.equals(Constants.REQUESTCOMPLETED)) {
					rEL1NewItemLevel.setValue(1);
					rEL1NewItemPosition.setValue(Main.detail.getPosition());
					browseAllOrders_REL1RefreshTree(queueRelTree,rEL1LoadedQueue,rEL1LoadAll,displayString,rEL1NewItemLevel,rEL1CurrentChoice,rEL1NewItemPosition,window);
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(1)) {
				Main.customers.reget(queueRelTree.rEL1Position);
				Main.orders.get(Clarion.newString(String.valueOf(0)),null);
				Main.orders.clear();
				Main.orders.custNumber.setValue(Main.customers.custNumber);
				Main.accessOrders.get().primeRecord(Clarion.newNumber(1));
				Main.globalRequest.setValue(Constants.INSERTRECORD);
				Invoi001.updateOrders();
				if (Main.globalResponse.equals(Constants.REQUESTCOMPLETED)) {
					rEL1NewItemLevel.setValue(2);
					rEL1NewItemPosition.setValue(Main.orders.getPosition());
					browseAllOrders_REL1RefreshTree(queueRelTree,rEL1LoadedQueue,rEL1LoadAll,displayString,rEL1NewItemLevel,rEL1CurrentChoice,rEL1NewItemPosition,window);
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(2)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(3)) {
				while (queueRelTree.rEL1Level.abs().equals(3)) {
					rEL1CurrentChoice.decrement(1);
					queueRelTree.get(rEL1CurrentChoice);
					if (CError.errorCode()!=0) break;
				}
				Main.orders.reget(queueRelTree.rEL1Position);
				Main.detail.get(Clarion.newString(String.valueOf(0)),null);
				Main.detail.clear();
				Main.detail.custNumber.setValue(Main.orders.custNumber);
				Main.detail.orderNumber.setValue(Main.orders.orderNumber);
				Main.accessDetail.get().primeRecord(Clarion.newNumber(1));
				Main.globalRequest.setValue(Constants.INSERTRECORD);
				Invoi001.updateDetail();
				if (Main.globalResponse.equals(Constants.REQUESTCOMPLETED)) {
					rEL1NewItemLevel.setValue(3);
					rEL1NewItemPosition.setValue(Main.detail.getPosition());
					browseAllOrders_REL1RefreshTree(queueRelTree,rEL1LoadedQueue,rEL1LoadAll,displayString,rEL1NewItemLevel,rEL1CurrentChoice,rEL1NewItemPosition,window);
				}
				case_1_break=true;
			}
		}
	}
	public static void browseAllOrders_REL1PreviousLevel(QueueReltree queueRelTree,Window_2 window,ClarionNumber rEL1SaveLevel,Rel1Loadedqueue rEL1LoadedQueue,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll)
	{
		queueRelTree.get(CWin.choice(window._relTree));
		rEL1SaveLevel.setValue(queueRelTree.rEL1Level.abs());
		browseAllOrders_REL1PreviousSavedLevel(queueRelTree,rEL1LoadedQueue,rEL1SaveLevel,window,rEL1CurrentChoice,displayString,rEL1LoadAll);
	}
	public static void browseAllOrders_REL1ExpandAll(QueueReltree queueRelTree,Rel1Loadedqueue rEL1LoadedQueue,ClarionNumber rEL1LoadAll,ClarionString displayString)
	{
		queueRelTree.free();
		rEL1LoadedQueue.free();
		rEL1LoadAll.setValue(Constants.TRUE);
		browseAllOrders_REL1LoadCustomers(rEL1LoadedQueue,queueRelTree,rEL1LoadAll,displayString);
		rEL1LoadAll.setValue(Constants.FALSE);
	}
	public static void browseAllOrders_REL1EditEntry(ClarionNumber rEL1Action,Window_2 window,Rel1Loadedqueue rEL1LoadedQueue,QueueReltree queueRelTree,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll,ClarionNumber rEL1SaveLevel,ClarionNumber rEL1NewItemLevel,ClarionString rEL1NewItemPosition)
	{
		rEL1Action.setValue(Constants.CHANGERECORD);
		browseAllOrders_REL1UpdateLoop(window,rEL1Action,rEL1LoadedQueue,queueRelTree,rEL1CurrentChoice,displayString,rEL1LoadAll,rEL1SaveLevel,rEL1NewItemLevel,rEL1NewItemPosition);
	}
	public static void selectProducts()
	{
		ClarionString currentTab=Clarion.newString(80);
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionView bRW1ViewBrowse=new BRW1ViewBrowse_1();
		QueueBrowse_1_1 queueBrowse_1=new QueueBrowse_1_1();
		QuickWindow_2 quickWindow=new QuickWindow_2(queueBrowse_1);
		Toolbarclass toolbar=new Toolbarclass();
		Queryformclass qbe5=new Queryformclass();
		Queryformvisual qbv5=new Queryformvisual();
		Brw1_1 brw1=new Brw1_1(quickWindow);
		Incrementallocatorclass bRW1Sort0Locator=new Incrementallocatorclass();
		Stepstringclass bRW1Sort0StepClass=new Stepstringclass();
		Resizer_3 resizer=new Resizer_3();
		Thiswindow_3 thisWindow=new Thiswindow_3(quickWindow,toolbar,brw1,queueBrowse_1,bRW1ViewBrowse,qbe5,qbv5,bRW1Sort0StepClass,bRW1Sort0Locator,resizer);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			quickWindow.close();
			brw1.destruct();
			bRW1Sort0Locator.destruct();
		}
	}
	public static void selectProducts_DefineListboxStyle()
	{
	}
	public static void updateDetail()
	{
		ClarionString currentTab=Clarion.newString(80);
		ClarionNumber checkFlag=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString actionMessage=Clarion.newString(40).setEncoding(ClarionString.CSTRING);
		ClarionNumber recordChanged=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionDecimal lOCRegTotalPrice=Clarion.newDecimal(9,2);
		ClarionDecimal lOCDiscTotalPrice=Clarion.newDecimal(9,2);
		ClarionDecimal lOCQuantityAvailable=Clarion.newDecimal(7,2);
		ClarionDecimal sAVQuantity=Clarion.newDecimal(7,2);
		ClarionDecimal nEWQuantity=Clarion.newDecimal(7,2);
		ClarionNumber sAVBackOrder=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString productDescription=Clarion.newString(35);
		Detail historyDTLRecord=(Detail)(new Detail()).getThread();
		QuickWindow_3 quickWindow=new QuickWindow_3(productDescription);
		Toolbarclass toolbar=new Toolbarclass();
		Toolbarupdateclass toolbarForm=new Toolbarupdateclass();
		Resizer_4 resizer=new Resizer_4();
		Fieldcolorqueue_1 fieldColorQueue=new Fieldcolorqueue_1();
		ClarionNumber curCtrlFeq=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		Thiswindow_4 thisWindow=new Thiswindow_4();
		thisWindow.__Init__(actionMessage,quickWindow,toolbar,sAVQuantity,sAVBackOrder,checkFlag,historyDTLRecord,thisWindow,productDescription,resizer,toolbarForm,lOCQuantityAvailable,fieldColorQueue,nEWQuantity,lOCRegTotalPrice,lOCDiscTotalPrice);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			quickWindow.close();
		}
	}
	public static void updateDetail_CalcValues(ClarionDecimal lOCRegTotalPrice,ClarionDecimal lOCDiscTotalPrice)
	{
		if (Main.detail.taxRate.equals(0)) {
			if (Main.detail.discountRate.equals(0)) {
				Main.detail.totalCost.setValue(Main.detail.price.multiply(Main.detail.quantityOrdered));
			}
			else {
				lOCRegTotalPrice.setValue(Main.detail.price.multiply(Main.detail.quantityOrdered));
				Main.detail.discount.setValue(lOCRegTotalPrice.multiply(Main.detail.discountRate).divide(100));
				Main.detail.totalCost.setValue(lOCRegTotalPrice.subtract(Main.detail.discount));
				Main.detail.savings.setValue(lOCRegTotalPrice.subtract(Main.detail.totalCost));
			}
		}
		else {
			if (Main.detail.discountRate.equals(0)) {
				lOCRegTotalPrice.setValue(Main.detail.price.multiply(Main.detail.quantityOrdered));
				Main.detail.taxPaid.setValue(lOCRegTotalPrice.multiply(Main.detail.taxRate).divide(100));
				Main.detail.totalCost.setValue(lOCRegTotalPrice.add(Main.detail.taxPaid));
			}
			else {
				lOCRegTotalPrice.setValue(Main.detail.price.multiply(Main.detail.quantityOrdered));
				Main.detail.discount.setValue(lOCRegTotalPrice.multiply(Main.detail.discountRate).divide(100));
				lOCDiscTotalPrice.setValue(lOCRegTotalPrice.subtract(Main.detail.discount));
				Main.detail.taxPaid.setValue(lOCDiscTotalPrice.multiply(Main.detail.taxRate).divide(100));
				Main.detail.totalCost.setValue(lOCDiscTotalPrice.add(Main.detail.taxPaid));
				Main.detail.savings.setValue(lOCRegTotalPrice.subtract(Main.detail.totalCost));
			}
		}
	}
	public static void updateDetail_UpdateOtherFiles(Thiswindow_4 thisWindow,ClarionNumber sAVBackOrder,ClarionDecimal sAVQuantity,ClarionDecimal nEWQuantity)
	{
		Main.products.productNumber.setValue(Main.detail.productNumber);
		Main.accessProducts.get().tryFetch(Main.products.keyProductNumber);
		{
			ClarionNumber case_1=thisWindow.request;
			boolean case_1_break=false;
			if (case_1.equals(Constants.INSERTRECORD)) {
				if (Main.detail.backOrdered.equals(Constants.FALSE)) {
					Main.products.quantityInStock.decrement(Main.detail.quantityOrdered);
					if (!Main.accessProducts.get().update().equals(Level.BENIGN)) {
						CRun.stop(CError.error());
					}
					Main.invHist.date.setValue(CDate.today());
					Main.invHist.productNumber.setValue(Main.detail.productNumber);
					Main.invHist.transType.setValue("Sale");
					Main.invHist.quantity.setValue(Main.detail.quantityOrdered.negate());
					Main.invHist.cost.setValue(Main.products.cost);
					Main.invHist.notes.setValue("New purchase");
					if (!Main.accessInvHist.get().insert().equals(Level.BENIGN)) {
						CRun.stop(CError.error());
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.CHANGERECORD)) {
				if (sAVBackOrder.equals(Constants.FALSE)) {
					Main.products.quantityInStock.increment(sAVQuantity);
					Main.products.quantityInStock.decrement(nEWQuantity);
					if (!Main.accessProducts.get().update().equals(Level.BENIGN)) {
						CRun.stop(CError.error());
					}
					Main.invHist.date.setValue(CDate.today());
					Main.invHist.productNumber.setValue(Main.detail.productNumber);
					Main.invHist.transType.setValue("Adj.");
					Main.invHist.quantity.setValue(sAVQuantity.subtract(nEWQuantity));
					Main.invHist.notes.setValue("Change in quantity purchased");
					if (!Main.accessInvHist.get().insert().equals(Level.BENIGN)) {
						CRun.stop(CError.error());
					}
				}
				else if (sAVBackOrder.equals(Constants.TRUE) && Main.detail.backOrdered.equals(Constants.FALSE)) {
					Main.products.quantityInStock.decrement(Main.detail.quantityOrdered);
					if (!Main.accessProducts.get().update().equals(Level.BENIGN)) {
						CRun.stop(CError.error());
					}
					Main.invHist.date.setValue(CDate.today());
					Main.invHist.productNumber.setValue(Main.detail.productNumber);
					Main.invHist.transType.setValue("Sale");
					Main.invHist.quantity.setValue(Main.detail.quantityOrdered.negate());
					Main.invHist.cost.setValue(Main.products.cost);
					Main.invHist.notes.setValue("New purchase");
					if (!Main.accessInvHist.get().insert().equals(Level.BENIGN)) {
						CRun.stop(CError.error());
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.DELETERECORD)) {
				if (sAVBackOrder.equals(Constants.FALSE)) {
					Main.products.quantityInStock.increment(Main.detail.quantityOrdered);
					if (!Main.accessProducts.get().update().equals(Level.BENIGN)) {
						CRun.stop(CError.error());
					}
					Main.invHist.date.setValue(CDate.today());
					Main.invHist.productNumber.setValue(Main.detail.productNumber);
					Main.invHist.transType.setValue("Adj.");
					Main.invHist.quantity.setValue(Main.detail.quantityOrdered);
					Main.invHist.notes.setValue("Cancelled Order");
					if (!Main.accessInvHist.get().insert().equals(Level.BENIGN)) {
						CRun.stop(CError.error());
					}
				}
				case_1_break=true;
			}
		}
	}
	public static void updateDetail_DefineListboxStyle()
	{
	}
	public static void updateOrders()
	{
		ClarionString currentTab=Clarion.newString(80);
		ClarionNumber localRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString actionMessage=Clarion.newString(40).setEncoding(ClarionString.CSTRING);
		ClarionNumber recordChanged=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString lOCBackOrdered=Clarion.newString(3);
		ClarionDecimal lOCTotalPrice=Clarion.newDecimal(9,2);
		Orders historyORDRecord=(Orders)(new Orders()).getThread();
		QuickWindow_4 quickWindow=new QuickWindow_4();
		Toolbarclass toolbar=new Toolbarclass();
		Toolbarupdateclass toolbarForm=new Toolbarupdateclass();
		Resizer_5 resizer=new Resizer_5();
		Fieldcolorqueue_2 fieldColorQueue=new Fieldcolorqueue_2();
		ClarionNumber curCtrlFeq=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		Thiswindow_5 thisWindow=new Thiswindow_5();
		thisWindow.__Init__(actionMessage,quickWindow,toolbar,historyORDRecord,resizer,toolbarForm,thisWindow,fieldColorQueue);
		try {
			Main.globalResponse.setValue(thisWindow.run());
		} finally {
			quickWindow.close();
		}
	}
	public static void updateOrders_DefineListboxStyle()
	{
	}
}
