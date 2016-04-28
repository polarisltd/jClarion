package clarion.abeip;

import clarion.abeip.Abeip;
import clarion.abeip.Editmultiselectclass;
import clarion.abwindow.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Msaction;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Mswindowclass extends Windowmanager
{
	public Editmultiselectclass msec=null;
	public Mswindowclass()
	{
		msec=null;
	}

	public void deselect(ClarionNumber index)
	{
		if (index.boolValue()) {
			this.msec.takeaction(Clarion.newNumber(Msaction.STARTPROCESS));
			this.msec.selected.get(index);
			CRun._assert(!(CError.errorCode()!=0));
			this.msec.available.item.setValue(this.msec.selected.item);
			this.msec.selected.delete();
			CRun._assert(!(CError.errorCode()!=0));
			this.msec.available.add();
			CWin.display();
			this.msec.takeaction(Clarion.newNumber(Msaction.DELETE),this.msec.selected.item.like());
			this.msec.takeaction(Clarion.newNumber(Msaction.ENDPROCESS));
			this.updateud();
		}
	}
	public void init(Editmultiselectclass msec)
	{
		this.msec=msec;
	}
	public void select(ClarionNumber index)
	{
		if (index.boolValue()) {
			this.msec.takeaction(Clarion.newNumber(Msaction.STARTPROCESS));
			this.msec.available.get(index);
			CRun._assert(!(CError.errorCode()!=0));
			this.msec.selected.item.setValue(this.msec.available.item);
			this.msec.available.delete();
			CRun._assert(!(CError.errorCode()!=0));
			this.msec.selected.add();
			CWin.display();
			this.msec.takeaction(Clarion.newNumber(Msaction.ADD),this.msec.selected.item.like());
			this.msec.takeaction(Clarion.newNumber(Msaction.ENDPROCESS));
			this.updateud();
		}
	}
	public ClarionNumber takeaccepted()
	{
		ClarionNumber a=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber p=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber rdy=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		{
			int case_1=CWin.field();
			boolean case_1_break=false;
			if (case_1==Abeip.multiwindow._selectsome) {
				p.setValue(this.msec.available.records());
				final ClarionNumber loop_1=p.like();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
					this.msec.available.get(i);
					if (this.msec.available.mark.boolValue()) {
						rdy.setValue(Constants.TRUE);
					}
				}
				if (rdy.boolValue()) {
					this.msec.takeaction(Clarion.newNumber(Msaction.STARTPROCESS));
					final ClarionNumber loop_2=p.like();for (a.setValue(1);a.compareTo(loop_2)<=0;a.increment(1)) {
						this.msec.available.get(a);
						CRun._assert(!(CError.errorCode()!=0));
						if (!this.msec.available.mark.boolValue()) {
							continue;
						}
						this.msec.selected.item.setValue(this.msec.available.item);
						this.msec.available.delete();
						CRun._assert(!(CError.errorCode()!=0));
						a.decrement(1);
						p.decrement(1);
						this.msec.selected.add();
						CWin.display();
						this.msec.takeaction(Clarion.newNumber(Msaction.ADD),this.msec.selected.item.like());
					}
					this.msec.takeaction(Clarion.newNumber(Msaction.ENDPROCESS));
					this.updateud();
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1==Abeip.multiwindow._selectall) {
				p.setValue(this.msec.available.records());
				if (p.boolValue()) {
					this.msec.takeaction(Clarion.newNumber(Msaction.STARTPROCESS));
				}
				final ClarionNumber loop_3=p.like();for (a.setValue(1);a.compareTo(loop_3)<=0;a.increment(1)) {
					this.msec.available.get(1);
					CRun._assert(!(CError.errorCode()!=0));
					this.msec.selected.item.setValue(this.msec.available.item);
					this.msec.available.delete();
					CRun._assert(!(CError.errorCode()!=0));
					this.msec.selected.add();
					CWin.display();
					this.msec.takeaction(Clarion.newNumber(Msaction.ADD),this.msec.selected.item.like());
				}
				if (p.boolValue()) {
					this.msec.takeaction(Clarion.newNumber(Msaction.ENDPROCESS));
					this.updateud();
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1==Abeip.multiwindow._deselectsome) {
				p.setValue(this.msec.selected.records());
				final ClarionNumber loop_4=p.like();for (i.setValue(1);i.compareTo(loop_4)<=0;i.increment(1)) {
					this.msec.selected.get(i);
					if (this.msec.selected.mark.boolValue()) {
						rdy.setValue(Constants.TRUE);
					}
				}
				if (rdy.boolValue()) {
					this.msec.takeaction(Clarion.newNumber(Msaction.STARTPROCESS));
					final ClarionNumber loop_5=p.like();for (a.setValue(1);a.compareTo(loop_5)<=0;a.increment(1)) {
						this.msec.selected.get(a);
						CRun._assert(!(CError.errorCode()!=0));
						if (!this.msec.selected.mark.boolValue()) {
							continue;
						}
						this.msec.available.item.setValue(this.msec.selected.item);
						this.msec.selected.delete();
						CRun._assert(!(CError.errorCode()!=0));
						a.decrement(1);
						p.decrement(1);
						this.msec.available.add();
						CWin.display();
						this.msec.takeaction(Clarion.newNumber(Msaction.DELETE),this.msec.selected.item.like());
					}
					this.msec.takeaction(Clarion.newNumber(Msaction.ENDPROCESS));
					this.updateud();
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1==Abeip.multiwindow._deselectall) {
				p.setValue(this.msec.selected.records());
				if (p.boolValue()) {
					this.msec.takeaction(Clarion.newNumber(Msaction.STARTPROCESS));
				}
				final ClarionNumber loop_6=p.like();for (a.setValue(1);a.compareTo(loop_6)<=0;a.increment(1)) {
					this.msec.selected.get(1);
					CRun._assert(!(CError.errorCode()!=0));
					this.msec.available.item.setValue(this.msec.selected.item);
					this.msec.selected.delete();
					CRun._assert(!(CError.errorCode()!=0));
					this.msec.available.add();
					CWin.display();
					this.msec.takeaction(Clarion.newNumber(Msaction.DELETE),this.msec.selected.item.like());
				}
				if (p.boolValue()) {
					this.msec.takeaction(Clarion.newNumber(Msaction.ENDPROCESS));
					this.updateud();
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1==Abeip.multiwindow._moveup) {
				a.setValue(CWin.choice(Abeip.multiwindow._selected));
				if (a.compareTo(1)>0) {
					this.msec.selected.get(a);
					CRun._assert(!(CError.errorCode()!=0));
					p.setValue(this.msec.selected.getPointer()-1);
					this.msec.selected.delete();
					this.msec.selected.add(p);
					CRun._assert(!(CError.errorCode()!=0));
					CWin.select(Abeip.multiwindow._selected,p.intValue());
					this.msec.takeaction(Clarion.newNumber(Msaction.MOVE),this.msec.selected.item.like(),p.add(1).getNumber(),p.like());
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1==Abeip.multiwindow._movedown) {
				a.setValue(CWin.choice(Abeip.multiwindow._selected));
				if (a.boolValue() && a.compareTo(this.msec.selected.records())<0) {
					this.msec.selected.get(a);
					CRun._assert(!(CError.errorCode()!=0));
					p.setValue(this.msec.selected.getPointer()+1);
					this.msec.selected.delete();
					this.msec.selected.add(p);
					CRun._assert(!(CError.errorCode()!=0));
					CWin.select(Abeip.multiwindow._selected,p.intValue());
					this.msec.takeaction(Clarion.newNumber(Msaction.MOVE),this.msec.selected.item.like(),p.subtract(1).getNumber(),p.like());
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1==Abeip.multiwindow._ok) {
				this.setresponse(Clarion.newNumber(Constants.REQUESTCOMPLETED));
				case_1_break=true;
			}
			if (!case_1_break && case_1==Abeip.multiwindow._cancel) {
				this.setresponse(Clarion.newNumber(Constants.REQUESTCANCELLED));
				case_1_break=true;
			}
		}
		return super.takeaccepted();
	}
	public ClarionNumber takefieldevent()
	{
		ClarionNumber rval=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		rval.setValue(super.takefieldevent());
		if (rval.equals(Level.BENIGN)) {
			{
				int case_1=CWin.event();
				if (case_1==Event.ALERTKEY) {
					{
						int case_2=CWin.keyCode();
						if (case_2==Constants.MOUSELEFT2) {
							{
								int case_3=CWin.field();
								boolean case_3_break=false;
								if (case_3==Abeip.multiwindow._selected) {
									this.deselect(Clarion.newNumber(CWin.choice(Abeip.multiwindow._selected)));
									case_3_break=true;
								}
								if (!case_3_break && case_3==Abeip.multiwindow._available) {
									this.select(Clarion.newNumber(CWin.choice(Abeip.multiwindow._available)));
									case_3_break=true;
								}
							}
						}
					}
				}
			}
		}
		return rval.like();
	}
	public ClarionNumber takenewselection()
	{
		if (CWin.field()==Abeip.multiwindow._selected) {
			this.updateud();
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public void updateud()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber selected=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		final int loop_1=this.msec.selected.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.msec.selected.get(i);
			if (this.msec.selected.mark.boolValue()) {
				selected.increment(1);
			}
			if (selected.compareTo(1)>0) {
				break;
			}
		}
		if (selected.equals(1)) {
			CWin.enable(Abeip.multiwindow._moveup);
			CWin.enable(Abeip.multiwindow._movedown);
		}
		else {
			CWin.disable(Abeip.multiwindow._moveup);
			CWin.disable(Abeip.multiwindow._movedown);
		}
	}
}
