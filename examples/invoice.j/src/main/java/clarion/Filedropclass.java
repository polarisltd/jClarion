package clarion;

import clarion.Fieldpairsclass;
import clarion.Relationmanager;
import clarion.Viewmanager;
import clarion.Windowcomponent;
import clarion.Windowmanager;
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

public class Filedropclass extends Viewmanager
{
	public Fieldpairsclass displayFields;
	public Fieldpairsclass updateFields;
	public Windowmanager window;
	public ClarionNumber defaultFill;
	public ClarionNumber initSyncPair;
	public ClarionNumber allowReset;
	public ClarionNumber listControl;
	public ClarionNumber listField;
	public ClarionQueue listQueue;
	public ClarionNumber loaded;
	public ClarionString viewPosition;

	private static class _Windowcomponent_Impl extends Windowcomponent
	{
		private Filedropclass _owner;
		public _Windowcomponent_Impl(Filedropclass _owner)
		{
			this._owner=_owner;
		}
		public void kill()
		{
			_owner.kill();
		}
		public void reset(ClarionNumber force)
		{
			_owner.resetQueue(force.like());
		}
		public ClarionNumber resetRequired()
		{
			ClarionNumber ret=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
			ret.setValue(_owner.allowReset);
			_owner.allowReset.setValue(Constants.FALSE);
			return ret.like();
		}
		public void setAlerts()
		{
		}
		public ClarionNumber takeEvent()
		{
			_owner.takeEvent();
			if (CWin.event()==Event.OPENWINDOW) {
				_owner.resetQueue(Clarion.newNumber(Constants.TRUE));
			}
			return Clarion.newNumber(Level.BENIGN);
		}
		public void update()
		{
		}
		public void updateWindow()
		{
		}
	}
	private Windowcomponent _Windowcomponent_inst;
	public Windowcomponent windowcomponent()
	{
		if (_Windowcomponent_inst==null) _Windowcomponent_inst=new _Windowcomponent_Impl(this);
		return _Windowcomponent_inst;
	}
	public Filedropclass()
	{
		displayFields=null;
		updateFields=null;
		window=null;
		defaultFill=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		initSyncPair=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		allowReset=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		listControl=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		listField=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		listQueue=null;
		loaded=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		viewPosition=null;
	}

	public void addField(ClarionObject src,ClarionObject dest)
	{
		this.displayFields.addPair(src,dest);
	}
	public ClarionNumber addRecord()
	{
		this.listQueue.add();
		CRun._assert(!(CError.errorCode()!=0));
		return Clarion.newNumber(Constants.TRUE);
	}
	public void addUpdateField(ClarionObject src,ClarionObject dest)
	{
		this.updateFields.addPair(src,dest);
	}
	public ClarionNumber bufferMatches()
	{
		if (this.initSyncPair.boolValue()) {
			if (this.initSyncPair.compareTo(this.updateFields.list.records())<=0) {
				this.updateFields.list.get(this.initSyncPair);
				CRun._assert(!(CError.errorCode()!=0));
				if (this.updateFields.list.left.equals(this.updateFields.list.right)) {
					return Clarion.newNumber(Constants.TRUE);
				}
			}
		}
		return Clarion.newNumber(Constants.FALSE);
	}
	public void init(ClarionNumber fieldID,ClarionString pos,ClarionView v,ClarionQueue q,Relationmanager relMgr,Windowmanager wm)
	{
		this.listControl.setValue(fieldID);
		this.listField.setValue(this.listControl);
		Clarion.getControl(this.listControl).setProperty(Prop.IMM,Constants.FALSE);
		if (!Clarion.getControl(this.listControl).getProperty(Prop.FORMAT).boolValue()) {
			Clarion.getControl(this.listControl).setProperty(Prop.FORMAT,Clarion.getControl(this.listControl).getProperty(Prop.WIDTH).subtract(16).concat("L@",Clarion.getControl(this.listControl).getProperty(Prop.TEXT),"@"));
		}
		this.listQueue=q;
		this.viewPosition=pos;
		this.window=wm;
		CRun._assert(!(this.viewPosition==null));
		this.allowReset.setValue(Constants.FALSE);
		this.initSyncPair.setValue(1);
		this.defaultFill.setValue(1);
		this.displayFields=new Fieldpairsclass();
		this.displayFields.init();
		this.updateFields=new Fieldpairsclass();
		this.updateFields.init();
		super.init(v,relMgr);
	}
	public void kill()
	{
		if (!(this.displayFields==null)) {
			this.displayFields.kill();
			//this.displayFields;
		}
		if (!(this.updateFields==null)) {
			this.updateFields.kill();
			//this.updateFields;
		}
		super.kill();
	}
	public ClarionNumber resetQueue()
	{
		return resetQueue(Clarion.newNumber(0));
	}
	public ClarionNumber resetQueue(ClarionNumber force)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber ptr=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		if (this.applyRange().boolValue() || force.boolValue() || !this.loaded.boolValue()) {
			i.setValue(0);
			this.loaded.setValue(1);
			CWin.setCursor(Cursor.WAIT);
			this.listQueue.free();
			this.reset();
			while (!this.next().boolValue()) {
				if (this.validateRecord().equals(Record.OK)) {
					this.setQueueRecord();
					if (this.addRecord().boolValue()) {
						ptr.setValue(this.listQueue.getPointer());
						if (i.equals(0)) {
							if (this.bufferMatches().boolValue()) {
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
			if (i.equals(0) && this.defaultFill.boolValue() && this.listQueue.records()!=0) {
				i.setValue(1);
			}
			if (i.boolValue()) {
				Clarion.getControl(this.listField).setClonedProperty(Prop.SELECTED,i);
				this.takeNewSelection(this.listField.like());
			}
			Clarion.getControl(this.listField).setProperty(Prop.VSCROLL,Clarion.newNumber(this.listQueue.records()).compareTo(Clarion.getControl(this.listField).getProperty(Prop.ITEMS))>0 ? 1 : 0);
			CWin.setCursor(null);
		}
		else {
			i.setValue(CWin.choice(this.listField.intValue()));
		}
		return i.like();
	}
	public void setQueueRecord()
	{
		this.viewPosition.setValue(this.view.getPosition());
		this.displayFields.assignLeftToRight();
	}
	public void takeAccepted()
	{
	}
	public void takeEvent()
	{
		{
			int case_1=CWin.event();
			boolean case_1_break=false;
			if (case_1==Event.ACCEPTED) {
				this.takeAccepted();
				case_1_break=true;
			}
			if (!case_1_break && case_1==Event.NEWSELECTION) {
				this.takeNewSelection();
				case_1_break=true;
			}
		}
	}
	public void takeNewSelection()
	{
		this.takeNewSelection(Clarion.newNumber(CWin.field()));
	}
	public void takeNewSelection(ClarionNumber field)
	{
		if (field.equals(this.listField)) {
			if (CWin.choice(this.listField.intValue())!=0) {
				this.listQueue.get(CWin.choice(this.listField.intValue()));
				CRun._assert(!(CError.errorCode()!=0));
				this.reset();
				this.view.reset(this.viewPosition);
				if (!this.next().boolValue()) {
					this.updateFields.assignLeftToRight();
				}
				else {
					this.updateFields.clearRight();
				}
				this.close();
				this.allowReset.setValue(Constants.TRUE);
			}
			else {
				this.updateFields.clearRight();
			}
			this.window.reset();
		}
	}
	public ClarionNumber validateRecord()
	{
		return super.validateRecord();
	}
}
