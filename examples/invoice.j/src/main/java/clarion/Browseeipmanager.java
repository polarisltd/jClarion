package clarion;

import clarion.Browseclass;
import clarion.Eipmanager;
import clarion.equates.Button;
import clarion.equates.Constants;
import clarion.equates.Eipaction;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Msg;
import clarion.equates.Prop;
import clarion.equates.Proplist;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

public class Browseeipmanager extends Eipmanager
{
	public ClarionNumber wasPrimed;
	public ClarionNumber deleteAction;
	public Browseclass bc;
	public Browseeipmanager()
	{
		wasPrimed=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		deleteAction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		bc=null;
	}

	public void clearColumn()
	{
		if (this.lastColumn.boolValue()) {
			CWin.update();
			this.bc.listQueue.update();
			CRun._assert(!(CError.errorCode()!=0));
		}
		super.clearColumn();
	}
	public ClarionNumber init()
	{
		ClarionNumber retVal=Clarion.newNumber(Constants.REQUESTCANCELLED).setEncoding(ClarionNumber.BYTE);
		ClarionNumber atEnd=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.bc.currentChoice.setValue(CWin.choice(this.listControl.intValue()));
		{
			ClarionNumber case_1=this.req;
			boolean case_1_break=false;
			if (case_1.equals(Constants.INSERTRECORD)) {
				if (this.bc.listQueue.records().boolValue()) {
					if (this.insert.equals(Eipaction.APPEND)) {
						this.bc.scrollEnd(Clarion.newNumber(Event.SCROLLBOTTOM));
					}
					if (this.bc.primeRecord().boolValue()) {
						return Clarion.newNumber(Level.FATAL);
					}
					this.bc.primary.save();
					atEnd.setValue(this.bc.currentChoice.equals(this.bc.listQueue.records()) ? 1 : 0);
					this.bc.currentChoice.setValue(this.insert.equals(Eipaction.BEFORE) ? this.bc.currentChoice : this.bc.currentChoice.add(1));
					if (this.bc.listQueue.records().compareTo(this.bc.lastItems)>=0) {
						if (atEnd.boolValue()) {
							this.bc.listQueue.fetch(Clarion.newNumber(1));
							this.bc.currentChoice.decrement(1);
						}
						else {
							this.bc.listQueue.fetch(this.bc.listQueue.records());
						}
						this.bc.listQueue.delete();
					}
				}
				else {
					if (this.bc.primeRecord().boolValue()) {
						return Clarion.newNumber(Level.FATAL);
					}
					this.bc.primary.save();
					this.bc.currentChoice.setValue(1);
				}
				this.fields.clearRight();
				if (this.fields.equal().boolValue()) {
					this.wasPrimed.setValue(Constants.FALSE);
				}
				else {
					this.wasPrimed.setValue(Constants.TRUE);
				}
				this.bc.setQueueRecord();
				this.bc.listQueue.insert(this.bc.currentChoice.like());
				CRun._assert(!(CError.errorCode()!=0));
				CWin.display(this.listControl.intValue());
				CWin.select(this.listControl.intValue(),this.bc.currentChoice.intValue());
				this.column.setValue(1);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.DELETERECORD)) {
				{
					ClarionNumber case_2=this.deleteAction;
					boolean case_2_break=false;
					if (case_2.equals(Eipaction.PROMPTED)) {
						retVal.setValue(this.bc.primary.delete(Clarion.newNumber(Constants.TRUE)).equals(Level.BENIGN) ? Clarion.newNumber(Constants.REQUESTCOMPLETED) : Clarion.newNumber(Constants.REQUESTCANCELLED));
						case_2_break=true;
					}
					if (!case_2_break && case_2.equals(Eipaction.NEVER)) {
						retVal.setValue(Constants.REQUESTCANCELLED);
						case_2_break=true;
					}
					if (!case_2_break) {
						retVal.setValue(this.bc.primary.delete(Clarion.newNumber(Constants.FALSE)).equals(Level.BENIGN) ? Clarion.newNumber(Constants.REQUESTCOMPLETED) : Clarion.newNumber(Constants.REQUESTCANCELLED));
					}
				}
				this.response.setValue(retVal);
				return Clarion.newNumber(Level.FATAL);
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.CHANGERECORD)) {
				this.bc.setQueueRecord();
				this.bc.listQueue.update();
				this.bc.primary.save();
				if (CWin.keyCode()==Constants.MOUSELEFT2) {
					this.column.setValue(Clarion.getControl(this.listControl).getProperty(Proplist.MOUSEUPFIELD));
				}
				case_1_break=true;
			}
			if (!case_1_break) {
				CRun._assert(0!=0);
			}
		}
		this.bc.listQueue.fetch(this.bc.currentChoice.like());
		Clarion.getControl(this.listControl).setProperty(Prop.ALRT,Constants.MOUSELEFT2INDEX,0);
		return super.init();
	}
	public ClarionNumber kill()
	{
		this.bc.resetFromAsk(this.req,this.response);
		return super.kill();
	}
	public void takeCompleted(ClarionNumber force)
	{
		ClarionNumber saveAns=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		if (force.equals(Button.YES) || force.equals(0)) {
			if (!this.takeAcceptAll().boolValue()) {
				return;
			}
		}
		this.again.setValue(0);
		this.clearColumn();
		saveAns.setValue(force.equals(0) ? Clarion.newNumber(Button.YES) : force);
		if (this.fields.equal().boolValue() && !this.wasPrimed.boolValue()) {
			saveAns.setValue(Button.NO);
		}
		else {
			if (!force.boolValue()) {
				saveAns.setValue(this.errors.message(Clarion.newNumber(Msg.SAVERECORD),Clarion.newNumber(Button.YES+Button.NO+Button.CANCEL),Clarion.newNumber(Button.YES)));
			}
		}
		this.response.setValue(Constants.REQUESTCANCELLED);
		{
			ClarionNumber case_1=saveAns;
			boolean case_1_break=false;
			if (case_1.equals(Button.CANCEL)) {
				this.again.setValue(1);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Button.NO)) {
				if (this.req.equals(Constants.INSERTRECORD)) {
					this.bc.listQueue.delete();
					if (this.bc.currentChoice.boolValue() && !this.insert.equals(Eipaction.BEFORE)) {
						this.bc.currentChoice.decrement(1);
					}
					this.bc.primary.me.cancelAutoInc();
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Button.YES)) {
				id.setValue(this.bc.primary.me.saveBuffer());
				this.bc.updateBuffer();
				if (!(this.req.equals(Constants.INSERTRECORD) ? this.bc.primary.me.insert() : this.bc.primary.update()).equals(Level.BENIGN)) {
					this.again.setValue(1);
				}
				else {
					this.response.setValue(Constants.REQUESTCOMPLETED);
				}
				this.bc.primary.me.restoreBuffer(id,this.again.like());
				this.bc.view.flush();
				case_1_break=true;
			}
		}
		force.setValue(Button.NO);
		super.takeCompleted(force.like());
	}
	public ClarionNumber takeNewSelection()
	{
		if (Clarion.newNumber(CWin.field()).equals(this.listControl)) {
			if (Clarion.newNumber(CWin.choice(this.listControl.intValue())).equals(this.bc.currentChoice)) {
				return super.takeNewSelection();
			}
			else {
				this.takeFocusLoss();
				if (this.again.boolValue()) {
					CWin.select(this.listControl.intValue(),this.bc.currentChoice.intValue());
					return Clarion.newNumber(Level.BENIGN);
				}
				else {
					this.bc.currentChoice.setValue(CWin.choice(this.listControl.intValue()));
					this.response.setValue(Constants.REQUESTCANCELLED);
					return Clarion.newNumber(Level.FATAL);
				}
			}
		}
		return Clarion.newNumber(Level.BENIGN);
	}
}
