package clarion.invoi001;

import clarion.abtoolba.Toolbarreltreeclass;
import clarion.abwindow.Windowmanager;
import clarion.equates.Proplist;
import clarion.equates.Toolbar;
import clarion.invoi001.Invoi001;
import clarion.invoi001.QueueReltree;
import clarion.invoi001.Rel1Loadedqueue;
import clarion.invoi001.Thiswindow_2;
import clarion.invoi001.Window;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Rel1Toolbar extends Toolbarreltreeclass
{
	QueueReltree queueReltree;
	Window window;
	Rel1Loadedqueue rel1Loadedqueue;
	ClarionNumber rel1Savelevel;
	ClarionNumber rel1Currentchoice;
	ClarionString displaystring;
	ClarionNumber rel1Loadall;
	ClarionNumber rel1Action;
	ClarionNumber rel1Newitemlevel;
	ClarionString rel1Newitemposition;
	Thiswindow_2 thiswindow;
	public Rel1Toolbar(QueueReltree queueReltree,Window window,Rel1Loadedqueue rel1Loadedqueue,ClarionNumber rel1Savelevel,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall,ClarionNumber rel1Action,ClarionNumber rel1Newitemlevel,ClarionString rel1Newitemposition,Thiswindow_2 thiswindow)
	{
		this.queueReltree=queueReltree;
		this.window=window;
		this.rel1Loadedqueue=rel1Loadedqueue;
		this.rel1Savelevel=rel1Savelevel;
		this.rel1Currentchoice=rel1Currentchoice;
		this.displaystring=displaystring;
		this.rel1Loadall=rel1Loadall;
		this.rel1Action=rel1Action;
		this.rel1Newitemlevel=rel1Newitemlevel;
		this.rel1Newitemposition=rel1Newitemposition;
		this.thiswindow=thiswindow;
	}

	public void takeevent(Windowmanager p1)
	{
		takeevent((ClarionNumber)null,p1);
	}
	public void takeevent(ClarionNumber vcr,Windowmanager wm)
	{
		{
			int case_1=CWin.accepted();
			boolean case_1_break=false;
			if (case_1>=Toolbar.BOTTOM && case_1<=Toolbar.UP) {
				Clarion.getControl(this.control).setProperty(Proplist.MOUSEDOWNROW,CWin.choice(this.control.intValue()));
				{
					int execute_1=CWin.accepted()-Toolbar.BOTTOM+1;
					if (execute_1==1) {
						takeevent_rel1Nextparent(queueReltree,window,rel1Loadedqueue,rel1Savelevel,rel1Currentchoice,displaystring,rel1Loadall);
					}
					if (execute_1==2) {
						takeevent_rel1Previousparent(queueReltree,window,rel1Loadedqueue,rel1Savelevel,rel1Currentchoice,displaystring,rel1Loadall);
					}
					if (execute_1==3) {
						takeevent_rel1Nextlevel(queueReltree,window,rel1Savelevel,rel1Loadedqueue,rel1Currentchoice,displaystring,rel1Loadall);
					}
					if (execute_1==4) {
						takeevent_rel1Previouslevel(queueReltree,window,rel1Savelevel,rel1Loadedqueue,rel1Currentchoice,displaystring,rel1Loadall);
					}
					if (execute_1==5) {
						takeevent_rel1Nextrecord(window,queueReltree,rel1Loadedqueue,rel1Currentchoice,displaystring,rel1Loadall);
					}
					if (execute_1==6) {
						takeevent_rel1Previousrecord(window,queueReltree,rel1Loadedqueue,rel1Currentchoice,displaystring,rel1Loadall);
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1>=Toolbar.INSERT && case_1<=Toolbar.DELETE) {
				Clarion.getControl(this.control).setProperty(Proplist.MOUSEDOWNROW,CWin.choice(this.control.intValue()));
				{
					int execute_2=CWin.accepted()-Toolbar.INSERT+1;
					if (execute_2==1) {
						takeevent_rel1Addentry(rel1Action,window,rel1Loadedqueue,queueReltree,rel1Currentchoice,displaystring,rel1Loadall,rel1Savelevel,rel1Newitemlevel,rel1Newitemposition);
					}
					if (execute_2==2) {
						takeevent_rel1Editentry(rel1Action,window,rel1Loadedqueue,queueReltree,rel1Currentchoice,displaystring,rel1Loadall,rel1Savelevel,rel1Newitemlevel,rel1Newitemposition);
					}
					if (execute_2==3) {
						takeevent_rel1Removeentry(rel1Action,window,rel1Loadedqueue,queueReltree,rel1Currentchoice,displaystring,rel1Loadall,rel1Savelevel,rel1Newitemlevel,rel1Newitemposition);
					}
				}
				case_1_break=true;
			}
			if (!case_1_break) {
				super.takeevent(vcr,thiswindow);
			}
		}
	}
	public void takeevent_rel1Previousparent(QueueReltree queueReltree,Window window,Rel1Loadedqueue rel1Loadedqueue,ClarionNumber rel1Savelevel,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall)
	{
		Invoi001.browseallorders_rel1Previousparent(queueReltree,window,rel1Loadedqueue,rel1Savelevel,rel1Currentchoice,displaystring,rel1Loadall);
	}
	public void takeevent_rel1Nextparent(QueueReltree queueReltree,Window window,Rel1Loadedqueue rel1Loadedqueue,ClarionNumber rel1Savelevel,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall)
	{
		Invoi001.browseallorders_rel1Nextparent(queueReltree,window,rel1Loadedqueue,rel1Savelevel,rel1Currentchoice,displaystring,rel1Loadall);
	}
	public void takeevent_rel1Removeentry(ClarionNumber rel1Action,Window window,Rel1Loadedqueue rel1Loadedqueue,QueueReltree queueReltree,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall,ClarionNumber rel1Savelevel,ClarionNumber rel1Newitemlevel,ClarionString rel1Newitemposition)
	{
		Invoi001.browseallorders_rel1Removeentry(rel1Action,window,rel1Loadedqueue,queueReltree,rel1Currentchoice,displaystring,rel1Loadall,rel1Savelevel,rel1Newitemlevel,rel1Newitemposition);
	}
	public void takeevent_rel1Previouslevel(QueueReltree queueReltree,Window window,ClarionNumber rel1Savelevel,Rel1Loadedqueue rel1Loadedqueue,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall)
	{
		Invoi001.browseallorders_rel1Previouslevel(queueReltree,window,rel1Savelevel,rel1Loadedqueue,rel1Currentchoice,displaystring,rel1Loadall);
	}
	public void takeevent_rel1Nextrecord(Window window,QueueReltree queueReltree,Rel1Loadedqueue rel1Loadedqueue,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall)
	{
		Invoi001.browseallorders_rel1Nextrecord(window,queueReltree,rel1Loadedqueue,rel1Currentchoice,displaystring,rel1Loadall);
	}
	public void takeevent_rel1Addentry(ClarionNumber rel1Action,Window window,Rel1Loadedqueue rel1Loadedqueue,QueueReltree queueReltree,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall,ClarionNumber rel1Savelevel,ClarionNumber rel1Newitemlevel,ClarionString rel1Newitemposition)
	{
		Invoi001.browseallorders_rel1Addentry(rel1Action,window,rel1Loadedqueue,queueReltree,rel1Currentchoice,displaystring,rel1Loadall,rel1Savelevel,rel1Newitemlevel,rel1Newitemposition);
	}
	public void takeevent_rel1Previousrecord(Window window,QueueReltree queueReltree,Rel1Loadedqueue rel1Loadedqueue,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall)
	{
		Invoi001.browseallorders_rel1Previousrecord(window,queueReltree,rel1Loadedqueue,rel1Currentchoice,displaystring,rel1Loadall);
	}
	public void takeevent_rel1Nextlevel(QueueReltree queueReltree,Window window,ClarionNumber rel1Savelevel,Rel1Loadedqueue rel1Loadedqueue,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall)
	{
		Invoi001.browseallorders_rel1Nextlevel(queueReltree,window,rel1Savelevel,rel1Loadedqueue,rel1Currentchoice,displaystring,rel1Loadall);
	}
	public void takeevent_rel1Editentry(ClarionNumber rel1Action,Window window,Rel1Loadedqueue rel1Loadedqueue,QueueReltree queueReltree,ClarionNumber rel1Currentchoice,ClarionString displaystring,ClarionNumber rel1Loadall,ClarionNumber rel1Savelevel,ClarionNumber rel1Newitemlevel,ClarionString rel1Newitemposition)
	{
		Invoi001.browseallorders_rel1Editentry(rel1Action,window,rel1Loadedqueue,queueReltree,rel1Currentchoice,displaystring,rel1Loadall,rel1Savelevel,rel1Newitemlevel,rel1Newitemposition);
	}
}
