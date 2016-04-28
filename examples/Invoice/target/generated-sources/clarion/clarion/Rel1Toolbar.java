package clarion;

import clarion.Invoi001;
import clarion.QueueReltree;
import clarion.Rel1Loadedqueue;
import clarion.Thiswindow_2;
import clarion.Toolbarreltreeclass;
import clarion.Window_2;
import clarion.Windowmanager;
import clarion.equates.Proplist;
import clarion.equates.Toolbar;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CWin;

public class Rel1Toolbar extends Toolbarreltreeclass
{
	QueueReltree queueRelTree;
	Window_2 window;
	Rel1Loadedqueue rEL1LoadedQueue;
	ClarionNumber rEL1SaveLevel;
	ClarionNumber rEL1CurrentChoice;
	ClarionString displayString;
	ClarionNumber rEL1LoadAll;
	ClarionNumber rEL1Action;
	ClarionNumber rEL1NewItemLevel;
	ClarionString rEL1NewItemPosition;
	Thiswindow_2 thisWindow;
	public Rel1Toolbar(QueueReltree queueRelTree,Window_2 window,Rel1Loadedqueue rEL1LoadedQueue,ClarionNumber rEL1SaveLevel,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll,ClarionNumber rEL1Action,ClarionNumber rEL1NewItemLevel,ClarionString rEL1NewItemPosition,Thiswindow_2 thisWindow)
	{
		this.queueRelTree=queueRelTree;
		this.window=window;
		this.rEL1LoadedQueue=rEL1LoadedQueue;
		this.rEL1SaveLevel=rEL1SaveLevel;
		this.rEL1CurrentChoice=rEL1CurrentChoice;
		this.displayString=displayString;
		this.rEL1LoadAll=rEL1LoadAll;
		this.rEL1Action=rEL1Action;
		this.rEL1NewItemLevel=rEL1NewItemLevel;
		this.rEL1NewItemPosition=rEL1NewItemPosition;
		this.thisWindow=thisWindow;
	}

	public void takeEvent(Windowmanager p1)
	{
		takeEvent((ClarionNumber)null,p1);
	}
	public void takeEvent(ClarionNumber vcr,Windowmanager wm)
	{
		{
			int case_1=CWin.accepted();
			boolean case_1_break=false;
			if (case_1>=Toolbar.BOTTOM && case_1<=Toolbar.UP) {
				Clarion.getControl(this.control).setProperty(Proplist.MOUSEDOWNROW,CWin.choice(this.control.intValue()));
				{
					int execute_1=CWin.accepted()-Toolbar.BOTTOM+1;
					if (execute_1==1) {
						takeEvent_REL1NextParent(queueRelTree,window,rEL1LoadedQueue,rEL1SaveLevel,rEL1CurrentChoice,displayString,rEL1LoadAll);
					}
					if (execute_1==2) {
						takeEvent_REL1PreviousParent(queueRelTree,window,rEL1LoadedQueue,rEL1SaveLevel,rEL1CurrentChoice,displayString,rEL1LoadAll);
					}
					if (execute_1==3) {
						takeEvent_REL1NextLevel(queueRelTree,window,rEL1SaveLevel,rEL1LoadedQueue,rEL1CurrentChoice,displayString,rEL1LoadAll);
					}
					if (execute_1==4) {
						takeEvent_REL1PreviousLevel(queueRelTree,window,rEL1SaveLevel,rEL1LoadedQueue,rEL1CurrentChoice,displayString,rEL1LoadAll);
					}
					if (execute_1==5) {
						takeEvent_REL1NextRecord(window,queueRelTree,rEL1LoadedQueue,rEL1CurrentChoice,displayString,rEL1LoadAll);
					}
					if (execute_1==6) {
						takeEvent_REL1PreviousRecord(window,queueRelTree,rEL1LoadedQueue,rEL1CurrentChoice,displayString,rEL1LoadAll);
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1>=Toolbar.INSERT && case_1<=Toolbar.DELETE) {
				Clarion.getControl(this.control).setProperty(Proplist.MOUSEDOWNROW,CWin.choice(this.control.intValue()));
				{
					int execute_2=CWin.accepted()-Toolbar.INSERT+1;
					if (execute_2==1) {
						takeEvent_REL1AddEntry(rEL1Action,window,rEL1LoadedQueue,queueRelTree,rEL1CurrentChoice,displayString,rEL1LoadAll,rEL1SaveLevel,rEL1NewItemLevel,rEL1NewItemPosition);
					}
					if (execute_2==2) {
						takeEvent_REL1EditEntry(rEL1Action,window,rEL1LoadedQueue,queueRelTree,rEL1CurrentChoice,displayString,rEL1LoadAll,rEL1SaveLevel,rEL1NewItemLevel,rEL1NewItemPosition);
					}
					if (execute_2==3) {
						takeEvent_REL1RemoveEntry(rEL1Action,window,rEL1LoadedQueue,queueRelTree,rEL1CurrentChoice,displayString,rEL1LoadAll,rEL1SaveLevel,rEL1NewItemLevel,rEL1NewItemPosition);
					}
				}
				case_1_break=true;
			}
			if (!case_1_break) {
				super.takeEvent(vcr,thisWindow);
			}
		}
	}
	public void takeEvent_REL1PreviousParent(QueueReltree queueRelTree,Window_2 window,Rel1Loadedqueue rEL1LoadedQueue,ClarionNumber rEL1SaveLevel,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll)
	{
		Invoi001.browseAllOrders_REL1PreviousParent(queueRelTree,window,rEL1LoadedQueue,rEL1SaveLevel,rEL1CurrentChoice,displayString,rEL1LoadAll);
	}
	public void takeEvent_REL1NextParent(QueueReltree queueRelTree,Window_2 window,Rel1Loadedqueue rEL1LoadedQueue,ClarionNumber rEL1SaveLevel,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll)
	{
		Invoi001.browseAllOrders_REL1NextParent(queueRelTree,window,rEL1LoadedQueue,rEL1SaveLevel,rEL1CurrentChoice,displayString,rEL1LoadAll);
	}
	public void takeEvent_REL1RemoveEntry(ClarionNumber rEL1Action,Window_2 window,Rel1Loadedqueue rEL1LoadedQueue,QueueReltree queueRelTree,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll,ClarionNumber rEL1SaveLevel,ClarionNumber rEL1NewItemLevel,ClarionString rEL1NewItemPosition)
	{
		Invoi001.browseAllOrders_REL1RemoveEntry(rEL1Action,window,rEL1LoadedQueue,queueRelTree,rEL1CurrentChoice,displayString,rEL1LoadAll,rEL1SaveLevel,rEL1NewItemLevel,rEL1NewItemPosition);
	}
	public void takeEvent_REL1PreviousLevel(QueueReltree queueRelTree,Window_2 window,ClarionNumber rEL1SaveLevel,Rel1Loadedqueue rEL1LoadedQueue,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll)
	{
		Invoi001.browseAllOrders_REL1PreviousLevel(queueRelTree,window,rEL1SaveLevel,rEL1LoadedQueue,rEL1CurrentChoice,displayString,rEL1LoadAll);
	}
	public void takeEvent_REL1NextRecord(Window_2 window,QueueReltree queueRelTree,Rel1Loadedqueue rEL1LoadedQueue,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll)
	{
		Invoi001.browseAllOrders_REL1NextRecord(window,queueRelTree,rEL1LoadedQueue,rEL1CurrentChoice,displayString,rEL1LoadAll);
	}
	public void takeEvent_REL1AddEntry(ClarionNumber rEL1Action,Window_2 window,Rel1Loadedqueue rEL1LoadedQueue,QueueReltree queueRelTree,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll,ClarionNumber rEL1SaveLevel,ClarionNumber rEL1NewItemLevel,ClarionString rEL1NewItemPosition)
	{
		Invoi001.browseAllOrders_REL1AddEntry(rEL1Action,window,rEL1LoadedQueue,queueRelTree,rEL1CurrentChoice,displayString,rEL1LoadAll,rEL1SaveLevel,rEL1NewItemLevel,rEL1NewItemPosition);
	}
	public void takeEvent_REL1PreviousRecord(Window_2 window,QueueReltree queueRelTree,Rel1Loadedqueue rEL1LoadedQueue,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll)
	{
		Invoi001.browseAllOrders_REL1PreviousRecord(window,queueRelTree,rEL1LoadedQueue,rEL1CurrentChoice,displayString,rEL1LoadAll);
	}
	public void takeEvent_REL1NextLevel(QueueReltree queueRelTree,Window_2 window,ClarionNumber rEL1SaveLevel,Rel1Loadedqueue rEL1LoadedQueue,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll)
	{
		Invoi001.browseAllOrders_REL1NextLevel(queueRelTree,window,rEL1SaveLevel,rEL1LoadedQueue,rEL1CurrentChoice,displayString,rEL1LoadAll);
	}
	public void takeEvent_REL1EditEntry(ClarionNumber rEL1Action,Window_2 window,Rel1Loadedqueue rEL1LoadedQueue,QueueReltree queueRelTree,ClarionNumber rEL1CurrentChoice,ClarionString displayString,ClarionNumber rEL1LoadAll,ClarionNumber rEL1SaveLevel,ClarionNumber rEL1NewItemLevel,ClarionString rEL1NewItemPosition)
	{
		Invoi001.browseAllOrders_REL1EditEntry(rEL1Action,window,rEL1LoadedQueue,queueRelTree,rEL1CurrentChoice,displayString,rEL1LoadAll,rEL1SaveLevel,rEL1NewItemLevel,rEL1NewItemPosition);
	}
}
