package clarion;

import clarion.Editclass;
import clarion.Editentryclass;
import clarion.Editqueue;
import clarion.Fieldpairsclass;
import clarion.Windowmanager;
import clarion.equates.Button;
import clarion.equates.Color;
import clarion.equates.Constants;
import clarion.equates.Create;
import clarion.equates.Editaction;
import clarion.equates.Eipaction;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.equates.Proplist;
import clarion.equates.Vcr;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

public class Eipmanager extends Windowmanager
{
	public ClarionNumber again;
	public ClarionNumber arrow;
	public ClarionNumber column;
	public ClarionNumber enter;
	public Editqueue eq;
	public Fieldpairsclass fields;
	public ClarionNumber focusLoss;
	public ClarionNumber insert;
	public ClarionNumber listControl;
	public ClarionNumber lastColumn;
	public ClarionNumber repost;
	public ClarionNumber repostField;
	public ClarionNumber req;
	public ClarionNumber seekForward;
	public ClarionNumber tab;
	public Eipmanager()
	{
		again=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		arrow=null;
		column=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		enter=null;
		eq=null;
		fields=null;
		focusLoss=null;
		insert=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		listControl=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		lastColumn=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		repost=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		repostField=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		req=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		seekForward=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		tab=null;
	}

	public void addControl(Editclass p0,ClarionNumber p1)
	{
		addControl(p0,p1,Clarion.newNumber(0));
	}
	public void addControl(ClarionNumber p1)
	{
		addControl((Editclass)null,p1);
	}
	public void addControl(Editclass ec,ClarionNumber id,ClarionNumber free)
	{
		this.eq.control.set(ec);
		this.eq.field.setValue(id);
		this.eq.freeUp.setValue(free);
		this.eq.add(this.eq.ORDER().ascend(this.eq.field));
		CRun._assert(!(CError.errorCode()!=0));
	}
	public void clearColumn()
	{
		if (this.lastColumn.boolValue()) {
			Clarion.getControl(this.listControl).setProperty(Prop.EDIT,this.column,0);
			this.lastColumn.setValue(0);
		}
	}
	public ClarionNumber init()
	{
		if (this.column.equals(0)) {
			this.column.setValue(1);
		}
		this.lastColumn.setValue(0);
		this.repost.setValue(0);
		this.repostField.setValue(0);
		CRun._assert(!(this.eq==null));
		this.eq.field.setValue(1);
		this.initControls();
		this.resetColumn();
		return Clarion.newNumber(Level.BENIGN);
	}
	public void initControls()
	{
		CRun._assert(!(this.fields==null));
		while (Clarion.getControl(this.listControl).getProperty(Proplist.EXISTS,this.eq.field).boolValue()) {
			this.eq.get(this.eq.ORDER().ascend(this.eq.field));
			if (CError.errorCode()!=0) {
				this.eq.control.set(new Editentryclass());
				this.addControl(this.eq.control.get(),this.eq.field.like(),Clarion.newNumber(1));
			}
			this.fields.list.get(this.eq.field);
			CRun._assert(!(CError.errorCode()!=0));
			if (!(this.eq.control.get()==null)) {
				this.eq.control.get().init(this.eq.field.like(),this.listControl.like(),this.fields.list.right);
			}
			else {
				Clarion.getControl(this.listControl).setProperty(Proplist.TEXTCOLOR,this.eq.field,Color.GRAYTEXT);
			}
			this.eq.field.increment(1);
		}
	}
	public ClarionNumber kill()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		for (i.setValue(1);i.compareTo(this.eq.records())<=0;i.increment(1)) {
			this.eq.get(i);
			if (this.eq.control.get()==null) {
				Clarion.getControl(this.listControl).setProperty(Proplist.TEXTCOLOR,this.eq.field,Color.NONE);
			}
			else {
				this.eq.control.get().kill();
			}
		}
		Clarion.getControl(this.listControl).setProperty(Prop.ALRT,Constants.MOUSELEFT2INDEX,Constants.MOUSELEFT2);
		if (this.repost.boolValue()) {
			CWin.post(this.repost.intValue(),this.repostField.intValue());
			this.repost.setValue(0);
		}
		return super.kill();
	}
	public void next()
	{
		ClarionNumber scanned=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber lastCol=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		this.eq.get(this.eq.records());
		lastCol.setValue(this.eq.field);
		while (true) {
			this.eq.clear();
			this.eq.field.setValue(this.column);
			this.eq.get(this.eq.ORDER().ascend(this.eq.field));
			if (!(CError.errorCode()!=0) && this.getEdit().boolValue()) {
				break;
			}
			if (this.seekForward.boolValue()) {
				if (this.column.compareTo(lastCol)>=0) {
					CRun._assert(!scanned.boolValue());
					this.seekForward.setValue(0);
					scanned.setValue(1);
				}
				else {
					this.column.increment(1);
				}
			}
			else {
				if (this.column.compareTo(1)<=0) {
					this.seekForward.setValue(1);
					CRun._assert(!scanned.boolValue());
					scanned.setValue(1);
				}
				else {
					this.column.decrement(1);
				}
			}
		}
		this.seekForward.setValue(0);
	}
	public ClarionNumber getEdit()
	{
		return (this.eq.control.get()==null ? Clarion.newNumber(Constants.FALSE) : Clarion.newNumber(Constants.TRUE)).getNumber();
	}
	public void resetColumn()
	{
		CWin.setKeyCode(0);
		this.next();
		if (!this.column.equals(this.lastColumn)) {
			Clarion.getControl(this.listControl).setClonedProperty(Prop.EDIT,this.eq.field,this.eq.control.get().feq);
			CWin.select(this.eq.control.get().feq.intValue());
			this.lastColumn.setValue(this.column);
		}
	}
	public ClarionNumber run(ClarionNumber req)
	{
		this.req.setValue(req);
		return this.run();
	}
	public void takeAction(ClarionNumber action)
	{
		ClarionNumber rem=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber saveCol=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		{
			ClarionNumber case_1=action;
			boolean case_1_break=false;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1.equals(Editaction.FORWARD)) {
				this.clearColumn();
				rem.setValue(this.column);
				this.column.increment(1);
				this.seekForward.setValue(1);
				this.next();
				if (!rem.equals(this.column)) {
					this.resetColumn();
				}
				else {
					{
						ClarionObject case_2=this.tab==null ? Clarion.newNumber(Eipaction.ALWAYS) : Clarion.newNumber(this.tab.intValue() & Eipaction.SAVE);
						boolean case_2_break=false;
						if (case_2.equals(Eipaction.ALWAYS)) {
							this.takeCompleted(Clarion.newNumber(Button.YES));
							case_2_break=true;
						}
						if (!case_2_break && case_2.equals(Eipaction.NEVER)) {
							this.takeCompleted(Clarion.newNumber(Button.NO));
							case_2_break=true;
						}
						if (!case_2_break) {
							this.takeCompleted(Clarion.newNumber(0));
						}
					}
					if (!(this.tab==null) && (this.tab.intValue() & Eipaction.REMAIN)!=0 && !this.again.boolValue()) {
						this.vCRRequest.setValue(Vcr.FORWARD);
					}
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Editaction.BACKWARD)) {
				if (this.column.compareTo(1)>0) {
					this.clearColumn();
					rem.setValue(this.column);
					this.column.decrement(1);
					this.resetColumn();
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Editaction.NEXT)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Editaction.PREVIOUS)) {
				saveCol.setValue(this.column);
				{
					ClarionObject case_3=this.arrow==null ? Clarion.newNumber(Eipaction.DEFAULT) : Clarion.newNumber(this.arrow.intValue() & Eipaction.SAVE);
					boolean case_3_break=false;
					boolean case_3_match=false;
					case_3_match=false;
					if (case_3.equals(Eipaction.ALWAYS)) {
						case_3_match=true;
					}
					if (case_3_match || case_3.equals(Eipaction.DEFAULT)) {
						this.takeCompleted(Clarion.newNumber(Button.YES));
						case_3_break=true;
					}
					case_3_match=false;
					if (!case_3_break && case_3.equals(Eipaction.NEVER)) {
						this.takeCompleted(Clarion.newNumber(Button.NO));
						case_3_break=true;
					}
					if (!case_3_break) {
						this.takeCompleted(Clarion.newNumber(0));
					}
				}
				if (!(this.arrow==null) && (this.arrow.intValue() & Eipaction.REMAIN)!=0 && !this.again.boolValue()) {
					this.vCRRequest.setValue(action.equals(Editaction.NEXT) ? Clarion.newNumber(Vcr.FORWARD) : Clarion.newNumber(Vcr.BACKWARD));
				}
				if (!(this.arrow==null) && (this.arrow.intValue() & Eipaction.RETAINCOLUMN)!=0 && !this.again.boolValue()) {
					this.column.setValue(saveCol);
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Editaction.COMPLETE)) {
				{
					ClarionObject case_4=this.enter==null ? Clarion.newNumber(Eipaction.DEFAULT) : Clarion.newNumber(this.enter.intValue() & Eipaction.SAVE);
					boolean case_4_break=false;
					boolean case_4_match=false;
					case_4_match=false;
					if (case_4.equals(Eipaction.ALWAYS)) {
						case_4_match=true;
					}
					if (case_4_match || case_4.equals(Eipaction.DEFAULT)) {
						this.takeCompleted(Clarion.newNumber(Button.YES));
						case_4_break=true;
					}
					case_4_match=false;
					if (!case_4_break && case_4.equals(Eipaction.NEVER)) {
						this.takeCompleted(Clarion.newNumber(Button.NO));
						case_4_break=true;
					}
					if (!case_4_break) {
						this.takeCompleted(Clarion.newNumber(0));
					}
				}
				if (!(this.enter==null) && (this.enter.intValue() & Eipaction.REMAIN)!=0 && !this.again.boolValue()) {
					this.vCRRequest.setValue(Vcr.FORWARD);
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Editaction.CANCEL)) {
				this.takeCompleted(Clarion.newNumber(Button.NO));
				case_1_break=true;
			}
		}
	}
	public void takeCompleted(ClarionNumber force)
	{
		this.column.setValue(1);
		if (this.again.boolValue()) {
			this.resetColumn();
		}
	}
	public ClarionNumber takeEvent()
	{
		ClarionNumber rv=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		{
			int case_1=CWin.event();
			boolean case_1_break=false;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1==Event.SIZE) {
				case_1_match=true;
			}
			if (case_1_match || case_1==Event.ICONIZE) {
				case_1_match=true;
			}
			if (case_1_match || case_1==Event.MAXIMIZE) {
				return Clarion.newNumber(Level.NOTIFY);
				// UNREACHABLE! :case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1==Event.CLOSEDOWN) {
				case_1_match=true;
			}
			if (case_1_match || case_1==Event.CLOSEWINDOW) {
				case_1_match=true;
			}
			if (case_1_match || case_1==Event.SIZED) {
				this.takeFocusLoss();
				this.repost.setValue(CWin.event());
				return Clarion.newNumber(Level.FATAL);
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break) {
				this.again.setValue(1);
				rv.setValue(super.takeEvent());
				return (rv.equals(Level.BENIGN) ? !this.again.equals(0) ? Clarion.newNumber(Level.BENIGN) : Clarion.newNumber(Level.FATAL) : rv).getNumber();
			}
		}
		return Clarion.newNumber();
	}
	public ClarionNumber takeFieldEvent()
	{
		ClarionNumber i=Clarion.newNumber(1).setEncoding(ClarionNumber.UNSIGNED);
		if (Clarion.newNumber(CWin.field()).equals(this.listControl)) {
			return Clarion.newNumber(Level.BENIGN);
		}
		for (i.setValue(1);i.compareTo(this.eq.records()+1)<=0;i.increment(1)) {
			if (!(this.eq.control.get()==null) && this.eq.control.get().feq.equals(CWin.field())) {
				this.takeAction(this.eq.control.get().takeEvent(Clarion.newNumber(CWin.event())));
				return Clarion.newNumber(Level.BENIGN);
			}
			this.eq.get(i);
		}
		if (!Clarion.getControl(CWin.field()).getProperty(Prop.TYPE).equals(Create.BUTTON) || CWin.event()!=Event.SELECTED) {
			this.repost.setValue(CWin.event());
			this.repostField.setValue(CWin.field());
			this.takeFocusLoss();
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public void takeFocusLoss()
	{
		{
			ClarionObject case_1=this.focusLoss==null ? Clarion.newNumber(Eipaction.DEFAULT) : Clarion.newNumber(this.focusLoss.intValue() & Eipaction.SAVE);
			boolean case_1_break=false;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1.equals(Eipaction.ALWAYS)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Eipaction.DEFAULT)) {
				this.takeCompleted(Clarion.newNumber(Button.YES));
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Eipaction.NEVER)) {
				this.takeCompleted(Clarion.newNumber(Button.NO));
				case_1_break=true;
			}
			if (!case_1_break) {
				this.takeCompleted(Clarion.newNumber(0));
			}
		}
	}
	public ClarionNumber takeNewSelection()
	{
		if (Clarion.newNumber(CWin.field()).equals(this.listControl) && CWin.keyCode()==Constants.MOUSELEFT) {
			this.clearColumn();
			this.column.setValue(Clarion.getControl(this.listControl).getProperty(Proplist.MOUSEUPFIELD));
			this.resetColumn();
		}
		return Clarion.newNumber(Level.BENIGN);
	}
}
