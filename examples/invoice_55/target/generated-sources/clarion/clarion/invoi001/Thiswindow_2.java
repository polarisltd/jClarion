package clarion.invoi001;

import clarion.Main;
import clarion.abtoolba.Toolbarclass;
import clarion.abwindow.Windowmanager;
import clarion.equates.Appstrategy;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.equates.Proplist;
import clarion.invoi001.Invoi001;
import clarion.invoi001.QueueReltree;
import clarion.invoi001.Rel1Loadedqueue;
import clarion.invoi001.Rel1Toolbar;
import clarion.invoi001.Resizer_2;
import clarion.invoi001.Window;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Thiswindow_2 extends Windowmanager
{
	Window window;
	Toolbarclass toolbar;
	QueueReltree queueReltree;
	Rel1Loadedqueue rel1Loadedqueue;
	ClarionNumber rel1Loadall;
	ClarionString displaystring;
	Resizer_2 resizer;
	Rel1Toolbar rel1Toolbar;
	Thiswindow_2 thiswindow;
	ClarionNumber rel1Action;
	ClarionNumber rel1Currentchoice;
	ClarionNumber rel1Savelevel;
	ClarionNumber rel1Newitemlevel;
	ClarionString rel1Newitemposition;
	ClarionNumber rel1Currentlevel;
	public Thiswindow_2(Window window,Toolbarclass toolbar,QueueReltree queueReltree,Rel1Loadedqueue rel1Loadedqueue,ClarionNumber rel1Loadall,ClarionString displaystring,Resizer_2 resizer,Rel1Toolbar rel1Toolbar,Thiswindow_2 thiswindow,ClarionNumber rel1Action,ClarionNumber rel1Currentchoice,ClarionNumber rel1Savelevel,ClarionNumber rel1Newitemlevel,ClarionString rel1Newitemposition,ClarionNumber rel1Currentlevel)
	{
		this.window=window;
		this.toolbar=toolbar;
		this.queueReltree=queueReltree;
		this.rel1Loadedqueue=rel1Loadedqueue;
		this.rel1Loadall=rel1Loadall;
		this.displaystring=displaystring;
		this.resizer=resizer;
		this.rel1Toolbar=rel1Toolbar;
		this.thiswindow=thiswindow;
		this.rel1Action=rel1Action;
		this.rel1Currentchoice=rel1Currentchoice;
		this.rel1Savelevel=rel1Savelevel;
		this.rel1Newitemlevel=rel1Newitemlevel;
		this.rel1Newitemposition=rel1Newitemposition;
		this.rel1Currentlevel=rel1Currentlevel;
	}
	public Thiswindow_2() {}
	public void __Init__(Window window,Toolbarclass toolbar,QueueReltree queueReltree,Rel1Loadedqueue rel1Loadedqueue,ClarionNumber rel1Loadall,ClarionString displaystring,Resizer_2 resizer,Rel1Toolbar rel1Toolbar,Thiswindow_2 thiswindow,ClarionNumber rel1Action,ClarionNumber rel1Currentchoice,ClarionNumber rel1Savelevel,ClarionNumber rel1Newitemlevel,ClarionString rel1Newitemposition,ClarionNumber rel1Currentlevel)
	{
		this.window=window;
		this.toolbar=toolbar;
		this.queueReltree=queueReltree;
		this.rel1Loadedqueue=rel1Loadedqueue;
		this.rel1Loadall=rel1Loadall;
		this.displaystring=displaystring;
		this.resizer=resizer;
		this.rel1Toolbar=rel1Toolbar;
		this.thiswindow=thiswindow;
		this.rel1Action=rel1Action;
		this.rel1Currentchoice=rel1Currentchoice;
		this.rel1Savelevel=rel1Savelevel;
		this.rel1Newitemlevel=rel1Newitemlevel;
		this.rel1Newitemposition=rel1Newitemposition;
		this.rel1Currentlevel=rel1Currentlevel;
	}

	public ClarionNumber init()
	{
		ClarionNumber returnvalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Main.globalerrors.setprocedurename(Clarion.newString("BrowseAllOrders"));
		this.request.setValue(Main.globalrequest);
		returnvalue.setValue(super.init());
		if (returnvalue.boolValue()) {
			return returnvalue.like();
		}
		this.firstfield.setValue(window._reltree);
		this.vcrrequest=Main.vcrrequest;
		this.errors=Main.globalerrors;
		this.additem(toolbar);
		Main.globalrequest.clear();
		Main.globalresponse.clear();
		this.additem(Clarion.newNumber(window._close),Clarion.newNumber(Constants.REQUESTCANCELLED));
		Main.relateCustomers.open();
		this.filesopened.setValue(Constants.TRUE);
		init_rel1Contractall(queueReltree,rel1Loadedqueue,rel1Loadall,displaystring);
		window.open();
		this.opened.setValue(Constants.TRUE);
		window.setProperty(Prop.MINWIDTH,295);
		window.setProperty(Prop.MINHEIGHT,193);
		resizer.init(Clarion.newNumber(Appstrategy.SPREAD));
		this.additem(resizer);
		Main.inimgr.fetch(Clarion.newString("BrowseAllOrders"),window);
		resizer.resize();
		resizer.reset();
		Clarion.getControl(window._reltree).setProperty(Prop.ICONLIST,1,"~File.ico");
		Clarion.getControl(window._reltree).setProperty(Prop.ICONLIST,2,"~Folder.ico");
		Clarion.getControl(window._reltree).setProperty(Prop.ICONLIST,3,"~Invoice.ico");
		Clarion.getControl(window._reltree).setProperty(Prop.ICONLIST,4,"~star1.ico");
		Clarion.getControl(window._reltree).setProperty(Prop.SELECTED,1);
		toolbar.addtarget(rel1Toolbar,Clarion.newNumber(window._reltree));
		init_rel1Assignbuttons(rel1Toolbar,window,toolbar);
		Clarion.getControl(window._reltree).setProperty(Prop.ALRT,255,Constants.CTRLRIGHT);
		Clarion.getControl(window._reltree).setProperty(Prop.ALRT,254,Constants.CTRLLEFT);
		Clarion.getControl(window._reltree).setProperty(Prop.ALRT,253,Constants.MOUSELEFT2);
		this.setalerts();
		return returnvalue.like();
	}
	public void init_rel1Contractall(QueueReltree queueReltree,Rel1Loadedqueue rel1Loadedqueue,ClarionNumber rel1Loadall,ClarionString displaystring)
	{
		Invoi001.browseallorders_rel1Contractall(queueReltree,rel1Loadedqueue,rel1Loadall,displaystring);
	}
	public void init_rel1Assignbuttons(Rel1Toolbar rel1Toolbar,Window window,Toolbarclass toolbar)
	{
		Invoi001.browseallorders_rel1Assignbuttons(rel1Toolbar,window,toolbar);
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
			Main.inimgr.update(Clarion.newString("BrowseAllOrders"),window);
		}
		Main.globalerrors.setprocedurename();
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
				if (case_1==window._insert) {
					thiswindow.update();
					Clarion.getControl(window._reltree).setProperty(Proplist.MOUSEDOWNROW,CWin.choice(window._reltree));
					takeaccepted_rel1Addentry(rel1Action,window,rel1Loadedqueue,queueReltree,rel1Currentchoice,displaystring,rel1Loadall,rel1Savelevel,rel1Newitemlevel,rel1Newitemposition);
					case_1_break=true;
				}
				if (!case_1_break && case_1==window._change) {
					thiswindow.update();
					Clarion.getControl(window._reltree).setProperty(Proplist.MOUSEDOWNROW,CWin.choice(window._reltree));
					takeaccepted_rel1Editentry(rel1Action,window,rel1Loadedqueue,queueReltree,rel1Currentchoice,displaystring,rel1Loadall,rel1Savelevel,rel1Newitemlevel,rel1Newitemposition);
					case_1_break=true;
				}
				if (!case_1_break && case_1==window._delete) {
					thiswindow.update();
					Clarion.getControl(window._reltree).setProperty(Proplist.MOUSEDOWNROW,CWin.choice(window._reltree));
					takeaccepted_rel1Removeentry(rel1Action,window,rel1Loadedqueue,queueReltree,rel1Currentchoice,displaystring,rel1Loadall,rel1Savelevel,rel1Newitemlevel,rel1Newitemposition);
					case_1_break=true;
				}
				if (!case_1_break && case_1==window._expand) {
					thiswindow.update();
					Clarion.getControl(window._reltree).setProperty(Proplist.MOUSEDOWNROW,CWin.choice(window._reltree));
					takeaccepted_rel1Expandall(queueReltree,rel1Loadedqueue,rel1Loadall,displaystring);
					case_1_break=true;
				}
				if (!case_1_break && case_1==window._contract) {
					thiswindow.update();
					Clarion.getControl(window._reltree).setProperty(Proplist.MOUSEDOWNROW,CWin.choice(window._reltree));
					takeaccepted_rel1Contractall(queueReltree,rel1Loadedqueue,rel1Loadall,displaystring);
					case_1_break=true;
				}
			}
			return returnvalue.like();
		}
		// UNREACHABLE! :returnvalue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnvalue.like();
	}
	public void takeaccepted_rel1Removeentry(ClarionNumber rel1Action,Window window,Rel1Loadedqueue rel1Loadedqueue,QueueReltree queueReltree,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall,ClarionNumber rel1Savelevel,ClarionNumber rel1Newitemlevel,ClarionString rel1Newitemposition)
	{
		Invoi001.browseallorders_rel1Removeentry(rel1Action,window,rel1Loadedqueue,queueReltree,rel1Currentchoice,displaystring,rel1Loadall,rel1Savelevel,rel1Newitemlevel,rel1Newitemposition);
	}
	public void takeaccepted_rel1Addentry(ClarionNumber rel1Action,Window window,Rel1Loadedqueue rel1Loadedqueue,QueueReltree queueReltree,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall,ClarionNumber rel1Savelevel,ClarionNumber rel1Newitemlevel,ClarionString rel1Newitemposition)
	{
		Invoi001.browseallorders_rel1Addentry(rel1Action,window,rel1Loadedqueue,queueReltree,rel1Currentchoice,displaystring,rel1Loadall,rel1Savelevel,rel1Newitemlevel,rel1Newitemposition);
	}
	public void takeaccepted_rel1Expandall(QueueReltree queueReltree,Rel1Loadedqueue rel1Loadedqueue,ClarionNumber rel1Loadall,ClarionString displaystring)
	{
		Invoi001.browseallorders_rel1Expandall(queueReltree,rel1Loadedqueue,rel1Loadall,displaystring);
	}
	public void takeaccepted_rel1Contractall(QueueReltree queueReltree,Rel1Loadedqueue rel1Loadedqueue,ClarionNumber rel1Loadall,ClarionString displaystring)
	{
		Invoi001.browseallorders_rel1Contractall(queueReltree,rel1Loadedqueue,rel1Loadall,displaystring);
	}
	public void takeaccepted_rel1Editentry(ClarionNumber rel1Action,Window window,Rel1Loadedqueue rel1Loadedqueue,QueueReltree queueReltree,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall,ClarionNumber rel1Savelevel,ClarionNumber rel1Newitemlevel,ClarionString rel1Newitemposition)
	{
		Invoi001.browseallorders_rel1Editentry(rel1Action,window,rel1Loadedqueue,queueReltree,rel1Currentchoice,displaystring,rel1Loadall,rel1Savelevel,rel1Newitemlevel,rel1Newitemposition);
	}
	public ClarionNumber takefieldevent()
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
				int case_1=CWin.field();
				if (case_1==window._reltree) {
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
											Clarion.getControl(window._reltree).setProperty(Proplist.MOUSEDOWNROW,CWin.choice(window._reltree));
											CWin.post(Event.EXPANDED,window._reltree);
											case_4_break=true;
										}
										if (!case_4_break && case_4==Constants.CTRLLEFT) {
											Clarion.getControl(window._reltree).setProperty(Proplist.MOUSEDOWNROW,CWin.choice(window._reltree));
											CWin.post(Event.CONTRACTED,window._reltree);
											case_4_break=true;
										}
										if (!case_4_break && case_4==Constants.MOUSELEFT2) {
											takefieldevent_rel1Editentry(rel1Action,window,rel1Loadedqueue,queueReltree,rel1Currentchoice,displaystring,rel1Loadall,rel1Savelevel,rel1Newitemlevel,rel1Newitemposition);
											case_4_break=true;
										}
									}
								}
							}
						}
					}
				}
			}
			returnvalue.setValue(super.takefieldevent());
			{
				int case_5=CWin.field();
				if (case_5==window._reltree) {
					{
						int case_6=CWin.event();
						boolean case_6_break=false;
						if (case_6==Event.EXPANDED) {
							takefieldevent_rel1Loadlevel(rel1Currentchoice,window,queueReltree,rel1Loadedqueue,displaystring,rel1Loadall);
							case_6_break=true;
						}
						if (!case_6_break && case_6==Event.CONTRACTED) {
							takefieldevent_rel1Unloadlevel(rel1Currentchoice,window,queueReltree,rel1Loadedqueue,displaystring,rel1Currentlevel);
							case_6_break=true;
						}
					}
				}
			}
			return returnvalue.like();
		}
		// UNREACHABLE! :returnvalue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnvalue.like();
	}
	public void takefieldevent_rel1Unloadlevel(ClarionNumber rel1Currentchoice,Window window,QueueReltree queueReltree,Rel1Loadedqueue rel1Loadedqueue,ClarionString displaystring,ClarionNumber rel1Currentlevel)
	{
		Invoi001.browseallorders_rel1Unloadlevel(rel1Currentchoice,window,queueReltree,rel1Loadedqueue,displaystring,rel1Currentlevel);
	}
	public void takefieldevent_rel1Loadlevel(ClarionNumber rel1Currentchoice,Window window,QueueReltree queueReltree,Rel1Loadedqueue rel1Loadedqueue,ClarionString displaystring,ClarionNumber rel1Loadall)
	{
		Invoi001.browseallorders_rel1Loadlevel(rel1Currentchoice,window,queueReltree,rel1Loadedqueue,displaystring,rel1Loadall);
	}
	public void takefieldevent_rel1Editentry(ClarionNumber rel1Action,Window window,Rel1Loadedqueue rel1Loadedqueue,QueueReltree queueReltree,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall,ClarionNumber rel1Savelevel,ClarionNumber rel1Newitemlevel,ClarionString rel1Newitemposition)
	{
		Invoi001.browseallorders_rel1Editentry(rel1Action,window,rel1Loadedqueue,queueReltree,rel1Currentchoice,displaystring,rel1Loadall,rel1Savelevel,rel1Newitemlevel,rel1Newitemposition);
	}
	public ClarionNumber takenewselection()
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
			returnvalue.setValue(super.takenewselection());
			{
				int case_1=CWin.field();
				if (case_1==window._reltree) {
					if (CWin.keyCode()==Constants.MOUSERIGHT) {
						{
							int execute_1=CWin.popup("Insert|Change|Delete|-|&Expand All|Co&ntract All");
							if (execute_1==1) {
								takenewselection_rel1Addentry(rel1Action,window,rel1Loadedqueue,queueReltree,rel1Currentchoice,displaystring,rel1Loadall,rel1Savelevel,rel1Newitemlevel,rel1Newitemposition);
							}
							if (execute_1==2) {
								takenewselection_rel1Editentry(rel1Action,window,rel1Loadedqueue,queueReltree,rel1Currentchoice,displaystring,rel1Loadall,rel1Savelevel,rel1Newitemlevel,rel1Newitemposition);
							}
							if (execute_1==3) {
								takenewselection_rel1Removeentry(rel1Action,window,rel1Loadedqueue,queueReltree,rel1Currentchoice,displaystring,rel1Loadall,rel1Savelevel,rel1Newitemlevel,rel1Newitemposition);
							}
							if (execute_1==4) {
								takenewselection_rel1Expandall(queueReltree,rel1Loadedqueue,rel1Loadall,displaystring);
							}
							if (execute_1==5) {
								takenewselection_rel1Contractall(queueReltree,rel1Loadedqueue,rel1Loadall,displaystring);
							}
						}
					}
				}
			}
			return returnvalue.like();
		}
		// UNREACHABLE! :returnvalue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnvalue.like();
	}
	public void takenewselection_rel1Removeentry(ClarionNumber rel1Action,Window window,Rel1Loadedqueue rel1Loadedqueue,QueueReltree queueReltree,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall,ClarionNumber rel1Savelevel,ClarionNumber rel1Newitemlevel,ClarionString rel1Newitemposition)
	{
		Invoi001.browseallorders_rel1Removeentry(rel1Action,window,rel1Loadedqueue,queueReltree,rel1Currentchoice,displaystring,rel1Loadall,rel1Savelevel,rel1Newitemlevel,rel1Newitemposition);
	}
	public void takenewselection_rel1Addentry(ClarionNumber rel1Action,Window window,Rel1Loadedqueue rel1Loadedqueue,QueueReltree queueReltree,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall,ClarionNumber rel1Savelevel,ClarionNumber rel1Newitemlevel,ClarionString rel1Newitemposition)
	{
		Invoi001.browseallorders_rel1Addentry(rel1Action,window,rel1Loadedqueue,queueReltree,rel1Currentchoice,displaystring,rel1Loadall,rel1Savelevel,rel1Newitemlevel,rel1Newitemposition);
	}
	public void takenewselection_rel1Expandall(QueueReltree queueReltree,Rel1Loadedqueue rel1Loadedqueue,ClarionNumber rel1Loadall,ClarionString displaystring)
	{
		Invoi001.browseallorders_rel1Expandall(queueReltree,rel1Loadedqueue,rel1Loadall,displaystring);
	}
	public void takenewselection_rel1Contractall(QueueReltree queueReltree,Rel1Loadedqueue rel1Loadedqueue,ClarionNumber rel1Loadall,ClarionString displaystring)
	{
		Invoi001.browseallorders_rel1Contractall(queueReltree,rel1Loadedqueue,rel1Loadall,displaystring);
	}
	public void takenewselection_rel1Editentry(ClarionNumber rel1Action,Window window,Rel1Loadedqueue rel1Loadedqueue,QueueReltree queueReltree,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall,ClarionNumber rel1Savelevel,ClarionNumber rel1Newitemlevel,ClarionString rel1Newitemposition)
	{
		Invoi001.browseallorders_rel1Editentry(rel1Action,window,rel1Loadedqueue,queueReltree,rel1Currentchoice,displaystring,rel1Loadall,rel1Savelevel,rel1Newitemlevel,rel1Newitemposition);
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
			returnvalue.setValue(super.takewindowevent());
			{
				int case_1=CWin.event();
				if (case_1==Event.GAINFOCUS) {
					rel1Currentchoice.setValue(CWin.choice(window._reltree));
					queueReltree.get(rel1Currentchoice);
					rel1Newitemlevel.setValue(queueReltree.rel1Level);
					rel1Newitemposition.setValue(queueReltree.rel1Position);
					takewindowevent_rel1Refreshtree(queueReltree,rel1Loadedqueue,rel1Loadall,displaystring,rel1Newitemlevel,rel1Currentchoice,rel1Newitemposition,window);
				}
			}
			return returnvalue.like();
		}
		// UNREACHABLE! :returnvalue.setValue(Level.FATAL);
		// UNREACHABLE! :return returnvalue.like();
	}
	public void takewindowevent_rel1Refreshtree(QueueReltree queueReltree,Rel1Loadedqueue rel1Loadedqueue,ClarionNumber rel1Loadall,ClarionString displaystring,ClarionNumber rel1Newitemlevel,ClarionNumber rel1Currentchoice,ClarionString rel1Newitemposition,Window window)
	{
		Invoi001.browseallorders_rel1Refreshtree(queueReltree,rel1Loadedqueue,rel1Loadall,displaystring,rel1Newitemlevel,rel1Currentchoice,rel1Newitemposition,window);
	}
}
