package clarion;

import clarion.Abeip;
import clarion.Editmultiselectclass;
import clarion.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Msaction;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

public class Mswindowclass extends Windowmanager
{
	public Editmultiselectclass msec;
	public Mswindowclass()
	{
		msec=null;
	}

	public void deSelect(ClarionNumber index)
	{
		if (index.boolValue()) {
			this.msec.takeAction(Clarion.newNumber(Msaction.STARTPROCESS));
			this.msec.selected.get(index);
			CRun._assert(!(CError.errorCode()!=0));
			this.msec.available.item.setValue(this.msec.selected.item);
			this.msec.selected.delete();
			CRun._assert(!(CError.errorCode()!=0));
			this.msec.available.add();
			CWin.display();
			this.msec.takeAction(Clarion.newNumber(Msaction.DELETE),this.msec.selected.item.like());
			this.msec.takeAction(Clarion.newNumber(Msaction.ENDPROCESS));
			this.updateUD();
		}
	}
	public void init(Editmultiselectclass msec)
	{
		this.msec=msec;
	}
	public void select(ClarionNumber index)
	{
		if (index.boolValue()) {
			this.msec.takeAction(Clarion.newNumber(Msaction.STARTPROCESS));
			this.msec.available.get(index);
			CRun._assert(!(CError.errorCode()!=0));
			this.msec.selected.item.setValue(this.msec.available.item);
			this.msec.available.delete();
			CRun._assert(!(CError.errorCode()!=0));
			this.msec.selected.add();
			CWin.display();
			this.msec.takeAction(Clarion.newNumber(Msaction.ADD),this.msec.selected.item.like());
			this.msec.takeAction(Clarion.newNumber(Msaction.ENDPROCESS));
			this.updateUD();
		}
	}
	public ClarionNumber takeAccepted()
	{
		ClarionNumber a=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber p=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber rdy=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		{
			int case_1=CWin.field();
			boolean case_1_break=false;
			if (case_1==Abeip.multiWindow._selectSome) {
				p.setValue(this.msec.available.records());
				for (i.setValue(1);i.compareTo(p)<=0;i.increment(1)) {
					this.msec.available.get(i);
					if (this.msec.available.mark.boolValue()) {
						rdy.setValue(Constants.TRUE);
					}
				}
				if (rdy.boolValue()) {
					this.msec.takeAction(Clarion.newNumber(Msaction.STARTPROCESS));
					for (a.setValue(1);a.compareTo(p)<=0;a.increment(1)) {
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
						this.msec.takeAction(Clarion.newNumber(Msaction.ADD),this.msec.selected.item.like());
					}
					this.msec.takeAction(Clarion.newNumber(Msaction.ENDPROCESS));
					this.updateUD();
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1==Abeip.multiWindow._selectAll) {
				p.setValue(this.msec.available.records());
				if (p.boolValue()) {
					this.msec.takeAction(Clarion.newNumber(Msaction.STARTPROCESS));
				}
				for (a.setValue(1);a.compareTo(p)<=0;a.increment(1)) {
					this.msec.available.get(1);
					CRun._assert(!(CError.errorCode()!=0));
					this.msec.selected.item.setValue(this.msec.available.item);
					this.msec.available.delete();
					CRun._assert(!(CError.errorCode()!=0));
					this.msec.selected.add();
					CWin.display();
					this.msec.takeAction(Clarion.newNumber(Msaction.ADD),this.msec.selected.item.like());
				}
				if (p.boolValue()) {
					this.msec.takeAction(Clarion.newNumber(Msaction.ENDPROCESS));
					this.updateUD();
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1==Abeip.multiWindow._deselectSome) {
				p.setValue(this.msec.selected.records());
				for (i.setValue(1);i.compareTo(p)<=0;i.increment(1)) {
					this.msec.selected.get(i);
					if (this.msec.selected.mark.boolValue()) {
						rdy.setValue(Constants.TRUE);
					}
				}
				if (rdy.boolValue()) {
					this.msec.takeAction(Clarion.newNumber(Msaction.STARTPROCESS));
					for (a.setValue(1);a.compareTo(p)<=0;a.increment(1)) {
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
						this.msec.takeAction(Clarion.newNumber(Msaction.DELETE),this.msec.selected.item.like());
					}
					this.msec.takeAction(Clarion.newNumber(Msaction.ENDPROCESS));
					this.updateUD();
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1==Abeip.multiWindow._deselectAll) {
				p.setValue(this.msec.selected.records());
				if (p.boolValue()) {
					this.msec.takeAction(Clarion.newNumber(Msaction.STARTPROCESS));
				}
				for (a.setValue(1);a.compareTo(p)<=0;a.increment(1)) {
					this.msec.selected.get(1);
					CRun._assert(!(CError.errorCode()!=0));
					this.msec.available.item.setValue(this.msec.selected.item);
					this.msec.selected.delete();
					CRun._assert(!(CError.errorCode()!=0));
					this.msec.available.add();
					CWin.display();
					this.msec.takeAction(Clarion.newNumber(Msaction.DELETE),this.msec.selected.item.like());
				}
				if (p.boolValue()) {
					this.msec.takeAction(Clarion.newNumber(Msaction.ENDPROCESS));
					this.updateUD();
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1==Abeip.multiWindow._moveUp) {
				a.setValue(CWin.choice(Abeip.multiWindow._selected));
				if (a.compareTo(1)>0) {
					this.msec.selected.get(a);
					CRun._assert(!(CError.errorCode()!=0));
					p.setValue(this.msec.selected.getPointer()-1);
					this.msec.selected.delete();
					this.msec.selected.add(p);
					CRun._assert(!(CError.errorCode()!=0));
					CWin.select(Abeip.multiWindow._selected,p.intValue());
					this.msec.takeAction(Clarion.newNumber(Msaction.MOVE),this.msec.selected.item.like(),p.add(1).getNumber(),p.like());
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1==Abeip.multiWindow._moveDown) {
				a.setValue(CWin.choice(Abeip.multiWindow._selected));
				if (a.boolValue() && a.compareTo(this.msec.selected.records())<0) {
					this.msec.selected.get(a);
					CRun._assert(!(CError.errorCode()!=0));
					p.setValue(this.msec.selected.getPointer()+1);
					this.msec.selected.delete();
					this.msec.selected.add(p);
					CRun._assert(!(CError.errorCode()!=0));
					CWin.select(Abeip.multiWindow._selected,p.intValue());
					this.msec.takeAction(Clarion.newNumber(Msaction.MOVE),this.msec.selected.item.like(),p.subtract(1).getNumber(),p.like());
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1==Abeip.multiWindow._ok) {
				this.setResponse(Clarion.newNumber(Constants.REQUESTCOMPLETED));
				case_1_break=true;
			}
			if (!case_1_break && case_1==Abeip.multiWindow._cancel) {
				this.setResponse(Clarion.newNumber(Constants.REQUESTCANCELLED));
				case_1_break=true;
			}
		}
		return super.takeAccepted();
	}
	public ClarionNumber takeFieldEvent()
	{
		ClarionNumber rVal=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		rVal.setValue(super.takeFieldEvent());
		if (rVal.equals(Level.BENIGN)) {
			{
				int case_1=CWin.event();
				if (case_1==Event.ALERTKEY) {
					{
						int case_2=CWin.keyCode();
						if (case_2==Constants.MOUSELEFT2) {
							{
								int case_3=CWin.field();
								boolean case_3_break=false;
								if (case_3==Abeip.multiWindow._selected) {
									this.deSelect(Clarion.newNumber(CWin.choice(Abeip.multiWindow._selected)));
									case_3_break=true;
								}
								if (!case_3_break && case_3==Abeip.multiWindow._available) {
									this.select(Clarion.newNumber(CWin.choice(Abeip.multiWindow._available)));
									case_3_break=true;
								}
							}
						}
					}
				}
			}
		}
		return rVal.like();
	}
	public ClarionNumber takeNewSelection()
	{
		if (CWin.field()==Abeip.multiWindow._selected) {
			this.updateUD();
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public void updateUD()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber selected=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		for (i.setValue(1);i.compareTo(this.msec.selected.records())<=0;i.increment(1)) {
			this.msec.selected.get(i);
			if (this.msec.selected.mark.boolValue()) {
				selected.increment(1);
			}
			if (selected.compareTo(1)>0) {
				break;
			}
		}
		if (selected.equals(1)) {
			CWin.enable(Abeip.multiWindow._moveUp);
			CWin.enable(Abeip.multiWindow._moveDown);
		}
		else {
			CWin.disable(Abeip.multiWindow._moveUp);
			CWin.disable(Abeip.multiWindow._moveDown);
		}
	}
}
