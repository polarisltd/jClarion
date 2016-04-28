package clarion;

import clarion.Abdrops;
import clarion.Errorclass;
import clarion.Filedropclass;
import clarion.Relationmanager;
import clarion.Windowmanager;
import clarion.equates.Button;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Msg;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.view.ClarionView;

public class Filedropcomboclass extends Filedropclass
{
	public ClarionNumber askProcedure;
	public ClarionAny useField;
	public ClarionNumber buttonField;
	public ClarionNumber entryField;
	public ClarionNumber entryCompletion;
	public ClarionNumber removeDuplicatesFlag;
	public Errorclass errMgr;
	public ClarionNumber autoAddFlag;
	public ClarionNumber caseSensitiveFlag;
	public ClarionNumber syncronizeViewFlag;
	public ClarionString promptCaption;
	public ClarionString promptText;
	public ClarionNumber eCOn;
	public Filedropcomboclass()
	{
		askProcedure=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		useField=Clarion.newAny();
		buttonField=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		entryField=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		entryCompletion=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		removeDuplicatesFlag=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		errMgr=null;
		autoAddFlag=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		caseSensitiveFlag=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		syncronizeViewFlag=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		promptCaption=Clarion.newString(80).setEncoding(ClarionString.PSTRING);
		promptText=Clarion.newString(256).setEncoding(ClarionString.PSTRING);
		eCOn=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	}

	public ClarionNumber addRecord()
	{
		if (!this.removeDuplicatesFlag.boolValue() || !this.uniquePosition().equals(0)) {
			if (this.caseSensitiveFlag.boolValue()) {
				this.listQueue.add(Main.__CaseSensitiveCompare);
			}
			else {
				this.listQueue.add(Main.__CaseInsensitiveCompare);
			}
			CRun._assert(!(CError.errorCode()!=0));
			return Clarion.newNumber(Constants.TRUE);
		}
		return Clarion.newNumber(Constants.FALSE);
	}
	public ClarionNumber ask()
	{
		ClarionNumber rVal=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
		if (this.askProcedure.boolValue()) {
			ask_PrimeForAdd();
			if (this.window.run(this.askProcedure.like(),Clarion.newNumber(Constants.INSERTRECORD)).equals(Constants.REQUESTCOMPLETED)) {
				rVal.setValue(Level.BENIGN);
			}
		}
		else if (this.autoAddFlag.boolValue()) {
			if (this.errMgr.message(Clarion.newNumber(Msg.ADDNEWRECORD),Clarion.newNumber(Button.YES+Button.NO),Clarion.newNumber(Button.YES)).equals(Button.YES)) {
				ask_PrimeForAdd();
				rVal.setValue(this.primary.me.insert());
			}
		}
		return rVal.like();
	}
	public void ask_PrimeForAdd()
	{
		ClarionAny cValue=Clarion.newAny();
		cValue.setValue(this.useField);
		this.primeRecord();
		this.displayFields.list.get(1);
		CRun._assert(!(CError.errorCode()!=0));
		this.displayFields.list.left.setValue(cValue);
	}
	public ClarionNumber bufferMatches()
	{
		if (this.initSyncPair.boolValue()) {
			return super.bufferMatches();
		}
		else {
			this.displayFields.list.get(1);
			return Clarion.newNumber(this.useField.equals(this.displayFields.list.left) ? 1 : 0);
		}
	}
	public ClarionNumber getQueueMatch(ClarionString lookFor)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		this.displayFields.list.get(1);
		CRun._assert(!(CError.errorCode()!=0));
		this.displayFields.list.right.setValue(lookFor.clip());
		i.setValue(this.listQueue.getPosition());
		if (CError.errorCode()==0) {
			return i.like();
		}
		if (i.compareTo(this.listQueue.records())>0) {
			return Clarion.newNumber(0);
		}
		this.listQueue.get(i);
		if (this.caseSensitiveFlag.boolValue()) {
			if (this.displayFields.list.right.getString().sub(1,lookFor.clip().len()).equals(lookFor)) {
				return i.like();
			}
		}
		else {
			if (this.displayFields.list.right.getString().sub(1,lookFor.clip().len()).upper().equals(lookFor.upper())) {
				return i.like();
			}
		}
		return Clarion.newNumber(0);
	}
	public void init(ClarionObject p0,ClarionNumber p1,ClarionString p2,ClarionView p3,ClarionQueue p4,Relationmanager p5,Windowmanager p6,Errorclass p7,ClarionNumber p8,ClarionNumber p9)
	{
		init(p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,Clarion.newNumber(0));
	}
	public void init(ClarionObject p0,ClarionNumber p1,ClarionString p2,ClarionView p3,ClarionQueue p4,Relationmanager p5,Windowmanager p6,Errorclass p7,ClarionNumber p8)
	{
		init(p0,p1,p2,p3,p4,p5,p6,p7,p8,Clarion.newNumber(1));
	}
	public void init(ClarionObject p0,ClarionNumber p1,ClarionString p2,ClarionView p3,ClarionQueue p4,Relationmanager p5,Windowmanager p6,Errorclass p7)
	{
		init(p0,p1,p2,p3,p4,p5,p6,p7,Clarion.newNumber(1));
	}
	public void init(ClarionObject useField,ClarionNumber fieldID,ClarionString pos,ClarionView v,ClarionQueue q,Relationmanager relMgr,Windowmanager wm,Errorclass errMgr,ClarionNumber autoAdd,ClarionNumber autoSync,ClarionNumber caseSense)
	{
		super.init(fieldID.like(),pos,v,q,relMgr,wm);
		this.useField.setReferenceValue(useField);
		this.errMgr=errMgr;
		this.autoAddFlag.setValue(autoAdd);
		this.syncronizeViewFlag.setValue(autoSync);
		this.caseSensitiveFlag.setValue(caseSense.boolValue() || !((q.what(1).getValue()) instanceof ClarionString) ? 1 : 0);
		this.entryCompletion.setValue(Constants.TRUE);
		this.removeDuplicatesFlag.setValue(Constants.FALSE);
	}
	public void kill()
	{
		this.useField.setReferenceValue(null);
		super.kill();
	}
	public ClarionNumber keyValid()
	{
		if (!(CWin.keyChar()!=0)) {
			return Clarion.newNumber(Constants.FALSE);
		}
		if ((CWin.keyState() & 0x400+0x200)!=0) {
			return Clarion.newNumber(Constants.FALSE);
		}
		if (CRun.inlist(String.valueOf(CWin.keyCode()),new ClarionString[] {Clarion.newString(String.valueOf(Constants.LEFTKEY)),Clarion.newString(String.valueOf(Constants.RIGHTKEY)),Clarion.newString(String.valueOf(Constants.SHIFTLEFT)),Clarion.newString(String.valueOf(Constants.SHIFTRIGHT))}).boolValue()) {
			return Clarion.newNumber(Constants.FALSE);
		}
		return Clarion.newNumber(Constants.TRUE);
	}
	public ClarionNumber resetQueue()
	{
		return resetQueue(Clarion.newNumber(0));
	}
	public ClarionNumber resetQueue(ClarionNumber force)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		i.setValue(super.resetQueue(force.like()));
		if (i.boolValue()) {
			this.listQueue.get(i);
			CRun._assert(!(CError.errorCode()!=0));
			this.displayFields.list.get(1);
			CRun._assert(!(CError.errorCode()!=0));
			this.useField.setValue(this.displayFields.list.right);
		}
		return i.like();
	}
	public void resetFromList()
	{
		ClarionNumber s=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		s.setValue(CWin.choice(this.listControl.intValue()));
		if (s.boolValue()) {
			this.listQueue.get(s);
			CRun._assert(!(CError.errorCode()!=0));
			this.reset();
			this.view.reset(this.viewPosition);
			if (this.next().equals(Level.BENIGN)) {
				this.displayFields.list.get(1);
				this.useField.setValue(this.displayFields.list.left);
				this.updateFields.assignLeftToRight();
				this.allowReset.setValue(Constants.TRUE);
			}
			else {
				this.updateFields.clearRight();
			}
			this.close();
		}
		else {
			this.updateFields.clearRight();
		}
	}
	public void takeAccepted()
	{
		ClarionNumber qm=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		if (Clarion.newNumber(CWin.field()).equals(this.entryField) && !Clarion.getControl(0).getProperty(Prop.ACCEPTALL).boolValue()) {
			this.useField.setValue(Clarion.getControl(this.entryField).getProperty(Prop.SCREENTEXT));
			qm.setValue(this.getQueueMatch(this.useField.getString()));
			if (qm.boolValue()) {
				if (!this.useField.boolValue()) {
					qm.setValue(0);
				}
				Clarion.getControl(this.listField).setClonedProperty(Prop.SELECTED,qm);
				this.resetFromList();
			}
			else if (qm.equals(0)) {
				if (!this.ask().equals(Level.BENIGN)) {
					CWin.select(this.entryField.intValue());
					this.useField.clear();
					return;
				}
				this.updateFields.assignLeftToRight();
				this.resetQueue(Clarion.newNumber(1));
				qm.setValue(this.getQueueMatch(this.useField.getString()));
			}
			Clarion.getControl(this.listField).setClonedProperty(Prop.SELECTED,qm);
			this.resetFromList();
		}
	}
	public void takeNewSelection()
	{
		this.takeNewSelection(Clarion.newNumber(CWin.field()));
	}
	public void takeNewSelection(ClarionNumber field)
	{
		ClarionString currentEntry=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
		ClarionNumber s=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		{
			ClarionNumber case_1=field;
			boolean case_1_break=false;
			if (case_1.equals(this.entryField)) {
				if (this.entryCompletion.boolValue()) {
					if (this.keyValid().boolValue()) {
						if (!this.eCOn.boolValue()) {
							if (!Clarion.getControl(this.entryField).getProperty(Prop.SELSTART).equals(Clarion.getControl(this.entryField).getProperty(Prop.SELEND)) || Clarion.getControl(this.entryField).getProperty(Prop.SCREENTEXT).getString().len()==0) {
								this.eCOn.setValue(Constants.TRUE);
							}
						}
						if (this.eCOn.boolValue()) {
							if (CWin.keyCode()==Constants.BSKEY) {
								currentEntry.setValue(Abdrops.takeNewSelection_number_LastEntry.equals("") ? Clarion.newString("") : Abdrops.takeNewSelection_number_LastEntry.sub(1,Abdrops.takeNewSelection_number_LastEntry.len()-1));
							}
							else {
								currentEntry.setValue(Clarion.getControl(this.entryField).getProperty(Prop.SCREENTEXT).getString().sub(1,Clarion.getControl(this.entryField).getProperty(Prop.SELSTART).subtract(1).intValue()));
							}
							if (!currentEntry.equals(Abdrops.takeNewSelection_number_LastEntry)) {
								if (currentEntry.boolValue()) {
									s.setValue(this.getQueueMatch(currentEntry.like()));
									if (s.boolValue()) {
										this.displayFields.list.get(1);
										CRun._assert(!(CError.errorCode()!=0));
										this.useField.setValue(this.displayFields.list.right);
										Clarion.getControl(this.entryField).setClonedProperty(Prop.SCREENTEXT,this.useField);
										Clarion.getControl(this.entryField).setProperty(Prop.SELSTART,currentEntry.len()+1);
										Clarion.getControl(this.entryField).setProperty(Prop.SELEND,this.useField.getString().clip().len());
										Clarion.getControl(this.listField).setClonedProperty(Prop.SELECTED,s);
										this.updateFields.assignLeftToRight();
										Clarion.getControl(this.listControl).setProperty(Prop.TOUCHED,Constants.TRUE);
										if (this.syncronizeViewFlag.boolValue()) {
											this.resetFromList();
										}
									}
									else {
										CWin.change(this.listControl.intValue(),Clarion.getControl(this.entryField).getProperty(Prop.SCREENTEXT));
										Clarion.getControl(this.listControl).setProperty(Prop.TOUCHED,Constants.TRUE);
										this.eCOn.setValue(Constants.FALSE);
									}
								}
								Abdrops.takeNewSelection_number_LastEntry.setValue(currentEntry);
							}
						}
						else {
							this.eCOn.setValue(Constants.TRUE);
						}
					}
					else {
						this.eCOn.setValue(Constants.FALSE);
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(this.listField)) {
				this.resetFromList();
				case_1_break=true;
			}
		}
	}
	public void takeEvent()
	{
		ClarionNumber qm=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		super.takeEvent();
		{
			int case_1=CWin.event();
			boolean case_1_break=false;
			if (case_1==Event.OPENWINDOW) {
				this.entryField.setValue(this.listControl);
				this.listField.setValue(this.listControl.add(1000));
				Clarion.getControl(this.listControl).setClonedProperty(Prop.LISTFEQ,this.listField);
				this.buttonField.setValue(this.listControl.add(2000));
				Clarion.getControl(this.listControl).setClonedProperty(Prop.BUTTONFEQ,this.buttonField);
				if (this.entryCompletion.boolValue()) {
					Clarion.getControl(this.entryField).setProperty(Prop.IMM,Constants.TRUE);
					Clarion.getControl(this.listControl).setProperty(Prop.AUTO,Constants.FALSE);
				}
				Clarion.getControl(this.listField).setProperty(Prop.IMM,Constants.FALSE);
				case_1_break=true;
			}
			if (!case_1_break && case_1==Event.SELECTED) {
				if (Clarion.newNumber(CWin.field()).equals(this.listControl)) {
					this.eCOn.setValue(this.entryCompletion);
				}
				case_1_break=true;
			}
		}
	}
	public ClarionNumber uniquePosition()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		i.setValue(this.listQueue.getPosition());
		if (CError.errorCode()==0) {
			return Clarion.newNumber(0);
		}
		return i.like();
	}
}
