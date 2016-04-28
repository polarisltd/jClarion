package clarion;

import clarion.Invoi001;
import clarion.Main;
import clarion.QueueReltree;
import clarion.Rel1Loadedqueue;
import clarion.Rel1Toolbar;
import clarion.Resizer_2;
import clarion.Toolbarclass;
import clarion.Window_2;
import clarion.Windowmanager;
import clarion.equates.Appstrategy;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.equates.Proplist;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CWin;

public class Thiswindow_2 extends Windowmanager
{
	Window_2 window;
	Toolbarclass toolbar;
	QueueReltree queueRelTree;
	Rel1Loadedqueue rEL1LoadedQueue;
	ClarionNumber rEL1LoadAll;
	ClarionString displayString;
	Resizer_2 resizer;
	Rel1Toolbar rEL1Toolbar;
	Thiswindow_2 thisWindow;
	ClarionNumber rEL1Action;
	ClarionNumber rEL1CurrentChoice;
	ClarionNumber rEL1SaveLevel;
	ClarionNumber rEL1NewItemLevel;
	ClarionString rEL1NewItemPosition;
	ClarionNumber rEL1CurrentLevel;
	public Thiswindow_2(Window_2 window,Toolbarclass toolbar,QueueReltree queueRelTree,Rel1Loadedqueue rEL1LoadedQueue,ClarionNumber rEL1LoadAll,ClarionString displayString,Resizer_2 resizer,Rel1Toolbar rEL1Toolbar,Thiswindow_2 thisWindow,ClarionNumber rEL1Action,ClarionNumber rEL1CurrentChoice,ClarionNumber rEL1SaveLevel,ClarionNumber rEL1NewItemLevel,ClarionString rEL1NewItemPosition,ClarionNumber rEL1CurrentLevel)
	{
		this.window=window;
		this.toolbar=toolbar;
		this.queueRelTree=queueRelTree;
		this.rEL1LoadedQueue=rEL1LoadedQueue;
		this.rEL1LoadAll=rEL1LoadAll;
		this.displayString=displayString;
		this.resizer=resizer;
		this.rEL1Toolbar=rEL1Toolbar;
		this.thisWindow=thisWindow;
		this.rEL1Action=rEL1Action;
		this.rEL1CurrentChoice=rEL1CurrentChoice;
		this.rEL1SaveLevel=rEL1SaveLevel;
		this.rEL1NewItemLevel=rEL1NewItemLevel;
		this.rEL1NewItemPosition=rEL1NewItemPosition;
		this.rEL1CurrentLevel=rEL1CurrentLevel;
	}
	public Thiswindow_2() {}
	public void __Init__(Window_2 window,Toolbarclass toolbar,QueueReltree queueRelTree,Rel1Loadedqueue rEL1LoadedQueue,ClarionNumber rEL1LoadAll,ClarionString displayString,Resizer_2 resizer,Rel1Toolbar rEL1Toolbar,Thiswindow_2 thisWindow,ClarionNumber rEL1Action,ClarionNumber rEL1CurrentChoice,ClarionNumber rEL1SaveLevel,ClarionNumber rEL1NewItemLevel,ClarionString rEL1NewItemPosition,ClarionNumber rEL1CurrentLevel)
	{
		this.window=window;
		this.toolbar=toolbar;
		this.queueRelTree=queueRelTree;
		this.rEL1LoadedQueue=rEL1LoadedQueue;
		this.rEL1LoadAll=rEL1LoadAll;
		this.displayString=displayString;
		this.resizer=resizer;
		this.rEL1Toolbar=rEL1Toolbar;
		this.thisWindow=thisWindow;
		this.rEL1Action=rEL1Action;
		this.rEL1CurrentChoice=rEL1CurrentChoice;
		this.rEL1SaveLevel=rEL1SaveLevel;
		this.rEL1NewItemLevel=rEL1NewItemLevel;
		this.rEL1NewItemPosition=rEL1NewItemPosition;
		this.rEL1CurrentLevel=rEL1CurrentLevel;
	}

	public ClarionNumber init()
	{
		ClarionNumber returnValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalErrors.setProcedureName(Clarion.newString("BrowseAllOrders"));
		this.request.setValue(Main.globalRequest);
		returnValue.setValue(super.init());
		if (returnValue.boolValue()) {
			return returnValue.like();
		}
		this.firstField.setValue(window._relTree);
		this.vCRRequest=Main.vCRRequest;
		this.errors=Main.globalErrors;
		Main.globalRequest.clear();
		Main.globalResponse.clear();
		this.addItem(toolbar);
		this.addItem(Clarion.newNumber(window._close),Clarion.newNumber(Constants.REQUESTCANCELLED));
		Main.relateCustomers.get().open();
		this.filesOpened.setValue(Constants.TRUE);
		init_REL1ContractAll(queueRelTree,rEL1LoadedQueue,rEL1LoadAll,displayString);
		window.open();
		this.opened.setValue(Constants.TRUE);
		init_DefineListboxStyle();
		window.setProperty(Prop.MINWIDTH,295);
		window.setProperty(Prop.MINHEIGHT,193);
		resizer.init(Clarion.newNumber(Appstrategy.SPREAD));
		this.addItem(resizer);
		toolbar.addTarget(rEL1Toolbar,Clarion.newNumber(window._relTree));
		init_REL1AssignButtons(rEL1Toolbar,window,toolbar);
		Clarion.getControl(window._relTree).setProperty(Prop.ICONLIST,1,"~File.ico");
		Clarion.getControl(window._relTree).setProperty(Prop.ICONLIST,2,"~Folder.ico");
		Clarion.getControl(window._relTree).setProperty(Prop.ICONLIST,3,"~Invoice.ico");
		Clarion.getControl(window._relTree).setProperty(Prop.ICONLIST,4,"~star1.ico");
		Clarion.getControl(window._relTree).setProperty(Prop.SELECTED,1);
		Clarion.getControl(window._relTree).setProperty(Prop.ALRT,255,Constants.CTRLRIGHT);
		Clarion.getControl(window._relTree).setProperty(Prop.ALRT,254,Constants.CTRLLEFT);
		Clarion.getControl(window._relTree).setProperty(Prop.ALRT,253,Constants.MOUSELEFT2);
		this.setAlerts();
		return returnValue.like();
	}
	public void init_REL1ContractAll(QueueReltree queueRelTree,Rel1Loadedqueue rEL1LoadedQueue,ClarionNumber rEL1LoadAll,ClarionString displayString)
	{
		Invoi001.browseAllOrders_REL1ContractAll(queueRelTree,rEL1LoadedQueue,rEL1LoadAll,displayString);
	}
	public void init_REL1AssignButtons(Rel1Toolbar rEL1Toolbar,Window_2 window,Toolbarclass toolbar)
	{
		Invoi001.browseAllOrders_REL1AssignButtons(rEL1Toolbar,window,toolbar);
	}
	public void init_DefineListboxStyle()
	{
		Invoi001.browseAllOrders_DefineListboxStyle();
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
				boolean case_1_break=false;
				if (case_1==window._insert) {
					thisWindow.update();
					Clarion.getControl(window._relTree).setProperty(Proplist.MOUSEDOWNROW,CWin.choice(window._relTree));
					takeAccepted_REL1AddEntry(rEL1Action,window,rEL1LoadedQueue,queueRelTree,rEL1CurrentChoice,displayString,rEL1LoadAll,rEL1SaveLevel,rEL1NewItemLevel,rEL1NewItemPosition);
					case_1_break=true;
				}
				if (!case_1_break && case_1==window._change) {
					thisWindow.update();
					Clarion.getControl(window._relTree).setProperty(Proplist.MOUSEDOWNROW,CWin.choice(window._relTree));
					takeAccepted_REL1EditEntry(rEL1Action,window,rEL1LoadedQueue,queueRelTree,rEL1CurrentChoice,displayString,rEL1LoadAll,rEL1SaveLevel,rEL1NewItemLevel,rEL1NewItemPosition);
					case_1_break=true;
				}
				if (!case_1_break && case_1==window._delete) {
					thisWindow.update();
					Clarion.getControl(window._relTree).setProperty(Proplist.MOUSEDOWNROW,CWin.choice(window._relTree));
					takeAccepted_REL1RemoveEntry(rEL1Action,window,rEL1LoadedQueue,queueRelTree,rEL1CurrentChoice,displayString,rEL1LoadAll,rEL1SaveLevel,rEL1NewItemLevel,rEL1NewItemPosition);
					case_1_break=true;
				}
				if (!case_1_break && case_1==window._expand) {
					thisWindow.update();
					Clarion.getControl(window._relTree).setProperty(Proplist.MOUSEDOWNROW,CWin.choice(window._relTree));
					takeAccepted_REL1ExpandAll(queueRelTree,rEL1LoadedQueue,rEL1LoadAll,displayString);
					case_1_break=true;
				}
				if (!case_1_break && case_1==window._contract) {
					thisWindow.update();
					Clarion.getControl(window._relTree).setProperty(Proplist.MOUSEDOWNROW,CWin.choice(window._relTree));
					takeAccepted_REL1ContractAll(queueRelTree,rEL1LoadedQueue,rEL1LoadAll,displayString);
					case_1_break=true;
				}
			}
			return returnValue.like();
		}
		// UNREACHABLE! :returnValue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnValue.like();
	}
	public void takeAccepted_REL1RemoveEntry(ClarionNumber rEL1Action,Window_2 window,Rel1Loadedqueue rEL1LoadedQueue,QueueReltree queueRelTree,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll,ClarionNumber rEL1SaveLevel,ClarionNumber rEL1NewItemLevel,ClarionString rEL1NewItemPosition)
	{
		Invoi001.browseAllOrders_REL1RemoveEntry(rEL1Action,window,rEL1LoadedQueue,queueRelTree,rEL1CurrentChoice,displayString,rEL1LoadAll,rEL1SaveLevel,rEL1NewItemLevel,rEL1NewItemPosition);
	}
	public void takeAccepted_REL1AddEntry(ClarionNumber rEL1Action,Window_2 window,Rel1Loadedqueue rEL1LoadedQueue,QueueReltree queueRelTree,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll,ClarionNumber rEL1SaveLevel,ClarionNumber rEL1NewItemLevel,ClarionString rEL1NewItemPosition)
	{
		Invoi001.browseAllOrders_REL1AddEntry(rEL1Action,window,rEL1LoadedQueue,queueRelTree,rEL1CurrentChoice,displayString,rEL1LoadAll,rEL1SaveLevel,rEL1NewItemLevel,rEL1NewItemPosition);
	}
	public void takeAccepted_REL1ExpandAll(QueueReltree queueRelTree,Rel1Loadedqueue rEL1LoadedQueue,ClarionNumber rEL1LoadAll,ClarionString displayString)
	{
		Invoi001.browseAllOrders_REL1ExpandAll(queueRelTree,rEL1LoadedQueue,rEL1LoadAll,displayString);
	}
	public void takeAccepted_REL1ContractAll(QueueReltree queueRelTree,Rel1Loadedqueue rEL1LoadedQueue,ClarionNumber rEL1LoadAll,ClarionString displayString)
	{
		Invoi001.browseAllOrders_REL1ContractAll(queueRelTree,rEL1LoadedQueue,rEL1LoadAll,displayString);
	}
	public void takeAccepted_REL1EditEntry(ClarionNumber rEL1Action,Window_2 window,Rel1Loadedqueue rEL1LoadedQueue,QueueReltree queueRelTree,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll,ClarionNumber rEL1SaveLevel,ClarionNumber rEL1NewItemLevel,ClarionString rEL1NewItemPosition)
	{
		Invoi001.browseAllOrders_REL1EditEntry(rEL1Action,window,rEL1LoadedQueue,queueRelTree,rEL1CurrentChoice,displayString,rEL1LoadAll,rEL1SaveLevel,rEL1NewItemLevel,rEL1NewItemPosition);
	}
	public ClarionNumber takeFieldEvent()
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
			{
				int case_1=CWin.field();
				if (case_1==window._relTree) {
					{
						int case_2=CWin.event();
						boolean case_2_break=false;
						if (!case_2_break) {
							{
								int case_3=CWin.event();
								if (case_3==Event.ALERTKEY) {
									{
										int case_4=CWin.keyCode();
										boolean case_4_break=false;
										if (case_4==Constants.CTRLRIGHT) {
											Clarion.getControl(window._relTree).setProperty(Proplist.MOUSEDOWNROW,CWin.choice(window._relTree));
											CWin.post(Event.EXPANDED,window._relTree);
											case_4_break=true;
										}
										if (!case_4_break && case_4==Constants.CTRLLEFT) {
											Clarion.getControl(window._relTree).setProperty(Proplist.MOUSEDOWNROW,CWin.choice(window._relTree));
											CWin.post(Event.CONTRACTED,window._relTree);
											case_4_break=true;
										}
										if (!case_4_break && case_4==Constants.MOUSELEFT2) {
											takeFieldEvent_REL1EditEntry(rEL1Action,window,rEL1LoadedQueue,queueRelTree,rEL1CurrentChoice,displayString,rEL1LoadAll,rEL1SaveLevel,rEL1NewItemLevel,rEL1NewItemPosition);
											case_4_break=true;
										}
									}
								}
							}
						}
					}
				}
			}
			returnValue.setValue(super.takeFieldEvent());
			{
				int case_5=CWin.field();
				if (case_5==window._relTree) {
					{
						int case_6=CWin.event();
						boolean case_6_break=false;
						if (case_6==Event.EXPANDED) {
							takeFieldEvent_REL1LoadLevel(rEL1CurrentChoice,window,queueRelTree,rEL1LoadedQueue,displayString,rEL1LoadAll);
							case_6_break=true;
						}
						if (!case_6_break && case_6==Event.CONTRACTED) {
							takeFieldEvent_REL1UnloadLevel(rEL1CurrentChoice,window,queueRelTree,rEL1LoadedQueue,displayString,rEL1CurrentLevel);
							case_6_break=true;
						}
					}
				}
			}
			return returnValue.like();
		}
		// UNREACHABLE! :returnValue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnValue.like();
	}
	public void takeFieldEvent_REL1UnloadLevel(ClarionNumber rEL1CurrentChoice,Window_2 window,QueueReltree queueRelTree,Rel1Loadedqueue rEL1LoadedQueue,ClarionString displayString,ClarionNumber rEL1CurrentLevel)
	{
		Invoi001.browseAllOrders_REL1UnloadLevel(rEL1CurrentChoice,window,queueRelTree,rEL1LoadedQueue,displayString,rEL1CurrentLevel);
	}
	public void takeFieldEvent_REL1LoadLevel(ClarionNumber rEL1CurrentChoice,Window_2 window,QueueReltree queueRelTree,Rel1Loadedqueue rEL1LoadedQueue,ClarionString displayString,ClarionNumber rEL1LoadAll)
	{
		Invoi001.browseAllOrders_REL1LoadLevel(rEL1CurrentChoice,window,queueRelTree,rEL1LoadedQueue,displayString,rEL1LoadAll);
	}
	public void takeFieldEvent_REL1EditEntry(ClarionNumber rEL1Action,Window_2 window,Rel1Loadedqueue rEL1LoadedQueue,QueueReltree queueRelTree,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll,ClarionNumber rEL1SaveLevel,ClarionNumber rEL1NewItemLevel,ClarionString rEL1NewItemPosition)
	{
		Invoi001.browseAllOrders_REL1EditEntry(rEL1Action,window,rEL1LoadedQueue,queueRelTree,rEL1CurrentChoice,displayString,rEL1LoadAll,rEL1SaveLevel,rEL1NewItemLevel,rEL1NewItemPosition);
	}
	public ClarionNumber takeNewSelection()
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
			returnValue.setValue(super.takeNewSelection());
			{
				int case_1=CWin.field();
				if (case_1==window._relTree) {
					if (CWin.keyCode()==Constants.MOUSERIGHT) {
						{
							int execute_1=CWin.popup("Insert|Change|Delete|-|&Expand All|Co&ntract All");
							if (execute_1==1) {
								takeNewSelection_REL1AddEntry(rEL1Action,window,rEL1LoadedQueue,queueRelTree,rEL1CurrentChoice,displayString,rEL1LoadAll,rEL1SaveLevel,rEL1NewItemLevel,rEL1NewItemPosition);
							}
							if (execute_1==2) {
								takeNewSelection_REL1EditEntry(rEL1Action,window,rEL1LoadedQueue,queueRelTree,rEL1CurrentChoice,displayString,rEL1LoadAll,rEL1SaveLevel,rEL1NewItemLevel,rEL1NewItemPosition);
							}
							if (execute_1==3) {
								takeNewSelection_REL1RemoveEntry(rEL1Action,window,rEL1LoadedQueue,queueRelTree,rEL1CurrentChoice,displayString,rEL1LoadAll,rEL1SaveLevel,rEL1NewItemLevel,rEL1NewItemPosition);
							}
							if (execute_1==4) {
								takeNewSelection_REL1ExpandAll(queueRelTree,rEL1LoadedQueue,rEL1LoadAll,displayString);
							}
							if (execute_1==5) {
								takeNewSelection_REL1ContractAll(queueRelTree,rEL1LoadedQueue,rEL1LoadAll,displayString);
							}
						}
					}
				}
			}
			return returnValue.like();
		}
		// UNREACHABLE! :returnValue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnValue.like();
	}
	public void takeNewSelection_REL1RemoveEntry(ClarionNumber rEL1Action,Window_2 window,Rel1Loadedqueue rEL1LoadedQueue,QueueReltree queueRelTree,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll,ClarionNumber rEL1SaveLevel,ClarionNumber rEL1NewItemLevel,ClarionString rEL1NewItemPosition)
	{
		Invoi001.browseAllOrders_REL1RemoveEntry(rEL1Action,window,rEL1LoadedQueue,queueRelTree,rEL1CurrentChoice,displayString,rEL1LoadAll,rEL1SaveLevel,rEL1NewItemLevel,rEL1NewItemPosition);
	}
	public void takeNewSelection_REL1AddEntry(ClarionNumber rEL1Action,Window_2 window,Rel1Loadedqueue rEL1LoadedQueue,QueueReltree queueRelTree,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll,ClarionNumber rEL1SaveLevel,ClarionNumber rEL1NewItemLevel,ClarionString rEL1NewItemPosition)
	{
		Invoi001.browseAllOrders_REL1AddEntry(rEL1Action,window,rEL1LoadedQueue,queueRelTree,rEL1CurrentChoice,displayString,rEL1LoadAll,rEL1SaveLevel,rEL1NewItemLevel,rEL1NewItemPosition);
	}
	public void takeNewSelection_REL1ExpandAll(QueueReltree queueRelTree,Rel1Loadedqueue rEL1LoadedQueue,ClarionNumber rEL1LoadAll,ClarionString displayString)
	{
		Invoi001.browseAllOrders_REL1ExpandAll(queueRelTree,rEL1LoadedQueue,rEL1LoadAll,displayString);
	}
	public void takeNewSelection_REL1ContractAll(QueueReltree queueRelTree,Rel1Loadedqueue rEL1LoadedQueue,ClarionNumber rEL1LoadAll,ClarionString displayString)
	{
		Invoi001.browseAllOrders_REL1ContractAll(queueRelTree,rEL1LoadedQueue,rEL1LoadAll,displayString);
	}
	public void takeNewSelection_REL1EditEntry(ClarionNumber rEL1Action,Window_2 window,Rel1Loadedqueue rEL1LoadedQueue,QueueReltree queueRelTree,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll,ClarionNumber rEL1SaveLevel,ClarionNumber rEL1NewItemLevel,ClarionString rEL1NewItemPosition)
	{
		Invoi001.browseAllOrders_REL1EditEntry(rEL1Action,window,rEL1LoadedQueue,queueRelTree,rEL1CurrentChoice,displayString,rEL1LoadAll,rEL1SaveLevel,rEL1NewItemLevel,rEL1NewItemPosition);
	}
	public ClarionNumber takeWindowEvent()
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
			returnValue.setValue(super.takeWindowEvent());
			{
				int case_1=CWin.event();
				if (case_1==Event.GAINFOCUS) {
					rEL1CurrentChoice.setValue(CWin.choice(window._relTree));
					queueRelTree.get(rEL1CurrentChoice);
					rEL1NewItemLevel.setValue(queueRelTree.rEL1Level);
					rEL1NewItemPosition.setValue(queueRelTree.rEL1Position);
					takeWindowEvent_REL1RefreshTree(queueRelTree,rEL1LoadedQueue,rEL1LoadAll,displayString,rEL1NewItemLevel,rEL1CurrentChoice,rEL1NewItemPosition,window);
				}
			}
			return returnValue.like();
		}
		// UNREACHABLE! :returnValue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnValue.like();
	}
	public void takeWindowEvent_REL1RefreshTree(QueueReltree queueRelTree,Rel1Loadedqueue rEL1LoadedQueue,ClarionNumber rEL1LoadAll,ClarionString displayString,ClarionNumber rEL1NewItemLevel,ClarionNumber rEL1CurrentChoice,ClarionString rEL1NewItemPosition,Window_2 window)
	{
		Invoi001.browseAllOrders_REL1RefreshTree(queueRelTree,rEL1LoadedQueue,rEL1LoadAll,displayString,rEL1NewItemLevel,rEL1CurrentChoice,rEL1NewItemPosition,window);
	}
}
