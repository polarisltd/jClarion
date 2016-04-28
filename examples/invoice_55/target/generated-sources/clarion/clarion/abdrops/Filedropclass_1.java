package clarion.abdrops;

import clarion.Windowcomponent;
import clarion.abfile.Relationmanager;
import clarion.abfile.Viewmanager;
import clarion.abutil.Fieldpairsclass;
import clarion.abwindow.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Cursor;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.equates.Record;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Filedropclass_1 extends Viewmanager
{
	public Fieldpairsclass displayfields=null;
	public Fieldpairsclass updatefields=null;
	public Windowmanager window=null;
	public ClarionNumber defaultfill=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber initsyncpair=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber allowreset=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber listcontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber listfield=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionQueue listqueue=null;
	public ClarionNumber loaded=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString viewposition=null;

	private static class _Windowcomponent_Impl extends Windowcomponent
	{
		private Filedropclass_1 _owner;
		public _Windowcomponent_Impl(Filedropclass_1 _owner)
		{
			this._owner=_owner;
		}
		public void kill()
		{
			_owner.kill();
		}
		public void reset(ClarionNumber force)
		{
			_owner.resetqueue(force.like());
		}
		public ClarionNumber resetrequired()
		{
			ClarionNumber ret=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
			ret.setValue(_owner.allowreset);
			_owner.allowreset.setValue(Constants.FALSE);
			return ret.like();
		}
		public void setalerts()
		{
		}
		public ClarionNumber takeevent()
		{
			_owner.takeevent();
			if (CWin.event()==Event.OPENWINDOW) {
				_owner.resetqueue(Clarion.newNumber(Constants.TRUE));
			}
			return Clarion.newNumber(Level.BENIGN);
		}
		public void update()
		{
		}
		public void updatewindow()
		{
		}
	}
	private Windowcomponent _Windowcomponent_inst;
	public Windowcomponent windowcomponent()
	{
		if (_Windowcomponent_inst==null) _Windowcomponent_inst=new _Windowcomponent_Impl(this);
		return _Windowcomponent_inst;
	}
	public Filedropclass_1()
	{
		displayfields=null;
		updatefields=null;
		window=null;
		defaultfill=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		initsyncpair=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		allowreset=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		listcontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		listfield=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		listqueue=null;
		loaded=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		viewposition=null;
	}

	public void addfield(ClarionObject src,ClarionObject dest)
	{
		this.displayfields.addpair(src,dest);
	}
	public ClarionNumber addrecord()
	{
		this.listqueue.add();
		CRun._assert(!(CError.errorCode()!=0));
		return Clarion.newNumber(Constants.TRUE);
	}
	public void addupdatefield(ClarionObject src,ClarionObject dest)
	{
		this.updatefields.addpair(src,dest);
	}
	public ClarionNumber buffermatches()
	{
		if (this.initsyncpair.boolValue()) {
			if (this.initsyncpair.compareTo(this.updatefields.list.records())<=0) {
				this.updatefields.list.get(this.initsyncpair);
				CRun._assert(!(CError.errorCode()!=0));
				if (this.updatefields.list.left.equals(this.updatefields.list.right)) {
					return Clarion.newNumber(Constants.TRUE);
				}
			}
		}
		return Clarion.newNumber(Constants.FALSE);
	}
	public void init(ClarionNumber fieldid,ClarionString pos,ClarionView v,ClarionQueue q,Relationmanager relmgr,Windowmanager wm)
	{
		this.listcontrol.setValue(fieldid);
		this.listfield.setValue(this.listcontrol);
		Clarion.getControl(this.listcontrol).setProperty(Prop.IMM,Constants.FALSE);
		if (!Clarion.getControl(this.listcontrol).getProperty(Prop.FORMAT).boolValue()) {
			Clarion.getControl(this.listcontrol).setProperty(Prop.FORMAT,Clarion.getControl(this.listcontrol).getProperty(Prop.WIDTH).subtract(16).concat("L@",Clarion.getControl(this.listcontrol).getProperty(Prop.TEXT),"@"));
		}
		this.listqueue=q;
		this.viewposition=pos;
		this.window=wm;
		CRun._assert(!(this.viewposition==null));
		this.allowreset.setValue(Constants.FALSE);
		this.initsyncpair.setValue(1);
		this.defaultfill.setValue(1);
		this.displayfields=new Fieldpairsclass();
		this.displayfields.init();
		this.updatefields=new Fieldpairsclass();
		this.updatefields.init();
		super.init(v,relmgr);
	}
	public void kill()
	{
		if (!(this.displayfields==null)) {
			this.displayfields.kill();
			//this.displayfields;
		}
		if (!(this.updatefields==null)) {
			this.updatefields.kill();
			//this.updatefields;
		}
		super.kill();
	}
	public ClarionNumber resetqueue()
	{
		return resetqueue(Clarion.newNumber(0));
	}
	public ClarionNumber resetqueue(ClarionNumber force)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber ptr=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		if (this.applyrange().boolValue() || force.boolValue() || !this.loaded.boolValue()) {
			i.setValue(0);
			this.loaded.setValue(1);
			CWin.setCursor(Cursor.WAIT);
			this.listqueue.free();
			this.reset();
			while (!this.next().boolValue()) {
				if (this.validaterecord().equals(Record.OK)) {
					this.setqueuerecord();
					if (this.addrecord().boolValue()) {
						ptr.setValue(this.listqueue.getPointer());
						if (i.equals(0)) {
							if (this.buffermatches().boolValue()) {
								i.setValue(ptr);
							}
						}
						else if (ptr.compareTo(i)<=0) {
							i.increment(1);
						}
					}
				}
			}
			this.close();
			if (i.equals(0) && this.defaultfill.boolValue() && this.listqueue.records()!=0) {
				i.setValue(1);
			}
			if (i.boolValue()) {
				Clarion.getControl(this.listfield).setClonedProperty(Prop.SELECTED,i);
				this.takenewselection(this.listfield.like());
			}
			Clarion.getControl(this.listfield).setProperty(Prop.VSCROLL,Clarion.newNumber(this.listqueue.records()).compareTo(Clarion.getControl(this.listfield).getProperty(Prop.ITEMS))>0 ? 1 : 0);
			CWin.setCursor(null);
		}
		else {
			i.setValue(CWin.choice(this.listfield.intValue()));
		}
		return i.like();
	}
	public void setqueuerecord()
	{
		this.viewposition.setValue(this.view.getPosition());
		this.displayfields.assignlefttoright();
	}
	public void takeaccepted()
	{
	}
	public void takeevent()
	{
		{
			int case_1=CWin.event();
			boolean case_1_break=false;
			if (case_1==Event.ACCEPTED) {
				this.takeaccepted();
				case_1_break=true;
			}
			if (!case_1_break && case_1==Event.NEWSELECTION) {
				this.takenewselection();
				case_1_break=true;
			}
		}
	}
	public void takenewselection()
	{
		this.takenewselection(Clarion.newNumber(CWin.field()));
	}
	public void takenewselection(ClarionNumber field)
	{
		if (field.equals(this.listfield)) {
			if (CWin.choice(this.listfield.intValue())!=0) {
				this.listqueue.get(CWin.choice(this.listfield.intValue()));
				CRun._assert(!(CError.errorCode()!=0));
				this.reset();
				this.view.reset(this.viewposition);
				if (!this.next().boolValue()) {
					this.updatefields.assignlefttoright();
				}
				else {
					this.updatefields.clearright();
				}
				this.close();
				this.allowreset.setValue(Constants.TRUE);
			}
			else {
				this.updatefields.clearright();
			}
			this.window.reset();
		}
	}
	public ClarionNumber validaterecord()
	{
		return super.validaterecord();
	}
}
