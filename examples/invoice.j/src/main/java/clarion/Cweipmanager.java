package clarion;

import clarion.Editclass;
import clarion.Editqueue;
import clarion.Eipmanager;
import clarion.Fieldpairsclass;
import clarion.equates.Button;
import clarion.equates.Constants;
import clarion.equates.Eipaction;
import clarion.equates.Event;
import clarion.equates.Icon;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.equates.Proplist;
import clarion.equates.Vcr;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

public class Cweipmanager extends Eipmanager
{
	public ClarionQueue q;
	public ClarionNumber tabAction;
	public ClarionNumber arrowAction;
	public ClarionNumber deleteAction;
	public ClarionNumber enterAction;
	public ClarionNumber focusLossAction;
	public ClarionNumber currentChoice;
	public ClarionNumber autoIncDone;
	public ClarionNumber wasPrimed;
	public Cweipmanager()
	{
		q=null;
		tabAction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		arrowAction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		deleteAction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		enterAction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		focusLossAction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		currentChoice=null;
		autoIncDone=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		wasPrimed=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		construct();
	}

	public ClarionNumber init()
	{
		ClarionNumber retVal=Clarion.newNumber(Constants.REQUESTCANCELLED).setEncoding(ClarionNumber.BYTE);
		ClarionNumber atEnd=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.currentChoice.setValue(CWin.choice(this.listControl.intValue()));
		{
			ClarionNumber case_1=this.req;
			boolean case_1_break=false;
			if (case_1.equals(Constants.INSERTRECORD)) {
				if (this.q.records()!=0) {
					if (this.insert.equals(Eipaction.APPEND)) {
						this.scrollEnd(Clarion.newNumber(Event.SCROLLBOTTOM));
					}
					if (this.primeRecord().boolValue()) {
						return Clarion.newNumber(Level.FATAL);
					}
					atEnd.setValue(this.currentChoice.equals(this.q.records()) ? 1 : 0);
					this.currentChoice.setValue(this.insert.equals(Eipaction.BEFORE) ? this.currentChoice : this.currentChoice.add(1));
					if (Clarion.newNumber(this.q.records()).compareTo(Clarion.getControl(this.listControl).getProperty(Prop.ITEMS))>=0) {
						if (atEnd.boolValue()) {
							this.q.get(1);
							this.currentChoice.decrement(1);
						}
						else {
							this.q.get(this.q.records());
						}
						this.q.delete();
					}
				}
				else {
					if (this.primeRecord().boolValue()) {
						return Clarion.newNumber(Level.FATAL);
					}
					this.currentChoice.setValue(1);
				}
				this.fields.clearRight();
				if (this.fields.equal().boolValue()) {
					this.wasPrimed.setValue(Constants.FALSE);
				}
				else {
					this.wasPrimed.setValue(Constants.TRUE);
				}
				this.setQueueRecord();
				this.q.add(this.currentChoice);
				CRun._assert(!(CError.errorCode()!=0));
				CWin.display(this.listControl.intValue());
				CWin.select(this.listControl.intValue(),this.currentChoice.intValue());
				this.column.setValue(1);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.DELETERECORD)) {
				{
					ClarionNumber case_2=this.deleteAction;
					boolean case_2_break=false;
					if (case_2.equals(Eipaction.NEVER)) {
						retVal.setValue(Constants.REQUESTCANCELLED);
						case_2_break=true;
					}
					if (!case_2_break && case_2.equals(Eipaction.PROMPTED)) {
						retVal.setValue(this.bCPrimaryDelete(Clarion.newNumber(Constants.TRUE)).equals(Level.BENIGN) ? Clarion.newNumber(Constants.REQUESTCOMPLETED) : Clarion.newNumber(Constants.REQUESTCANCELLED));
						case_2_break=true;
					}
					if (!case_2_break) {
						retVal.setValue(this.bCPrimaryDelete(Clarion.newNumber(Constants.FALSE)).equals(Level.BENIGN) ? Clarion.newNumber(Constants.REQUESTCOMPLETED) : Clarion.newNumber(Constants.REQUESTCANCELLED));
					}
				}
				this.response.setValue(retVal);
				return Clarion.newNumber(Level.FATAL);
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.CHANGERECORD)) {
				this.setQueueRecord();
				this.q.put();
				if (CWin.keyCode()==Constants.MOUSELEFT2) {
					this.column.setValue(Clarion.getControl(this.listControl).getProperty(Proplist.MOUSEUPFIELD));
				}
				case_1_break=true;
			}
			if (!case_1_break) {
				CRun._assert(0!=0);
			}
		}
		this.q.get(this.currentChoice);
		Clarion.getControl(this.listControl).setProperty(Prop.ALRT,Constants.MOUSELEFT2INDEX,0);
		return super.init();
	}
	public void takeCompleted(ClarionNumber force)
	{
		ClarionNumber saveAns=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
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
				saveAns.setValue(CWin.message(Clarion.newString("Do you want to save the changes to this record?"),Clarion.newString("Update Cancelled"),Icon.QUESTION,Button.YES+Button.NO+Button.CANCEL,Button.NO,0));
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
					this.q.delete();
					if (this.currentChoice.boolValue() && !this.insert.equals(Eipaction.BEFORE)) {
						this.currentChoice.decrement(1);
					}
					this.bCPrimaryCancelAutoInc();
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Button.YES)) {
				this.bCPrimarySaveBuffer();
				this.fields.assignRightToLeft();
				if (!(this.req.equals(Constants.INSERTRECORD) ? this.bCPrimaryInsert() : this.bCPrimaryUpdate()).equals(Level.BENIGN)) {
					this.again.setValue(1);
				}
				else {
					this.response.setValue(Constants.REQUESTCOMPLETED);
				}
				this.bCPrimaryRestoreBuffer();
				case_1_break=true;
			}
		}
		force.setValue(Button.NO);
		super.takeCompleted(force.like());
	}
	public ClarionNumber takeNewSelection()
	{
		if (Clarion.newNumber(CWin.field()).equals(this.listControl)) {
			if (Clarion.newNumber(CWin.choice(this.listControl.intValue())).equals(this.currentChoice)) {
				return super.takeNewSelection();
			}
			else {
				this.takeFocusLoss();
				if (this.again.boolValue()) {
					this.currentChoice.setValue(CWin.choice(this.listControl.intValue()));
					CWin.select(this.listControl.intValue(),this.currentChoice.intValue());
					return Clarion.newNumber(Level.BENIGN);
				}
				else {
					this.currentChoice.setValue(CWin.choice(this.listControl.intValue()));
					this.response.setValue(Constants.REQUESTCANCELLED);
					return Clarion.newNumber(Level.FATAL);
				}
			}
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public void clearColumn()
	{
		if (this.lastColumn.boolValue()) {
			CWin.update();
			this.q.put();
			if (CError.errorCode()!=0) {
				CWin.message(Clarion.newString(ClarionString.staticConcat("CWEIPManager.ClearColumn|LastColumn=",this.lastColumn,"|Error: (",CError.errorCode(),") ",CError.error())));
			}
			CRun._assert(!(CError.errorCode()!=0));
		}
		super.clearColumn();
	}
	public void takeAction(ClarionNumber action)
	{
		super.takeAction(action.like());
		{
			ClarionNumber case_1=this.vCRRequest;
			boolean case_1_break=false;
			if (case_1.equals(Vcr.FORWARD)) {
				this.vCRRequest.setValue(Constants.VCRFORWARD);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Vcr.BACKWARD)) {
				this.vCRRequest.setValue(Constants.VCRBACKWARD);
				case_1_break=true;
			}
		}
	}
	public void setUp(ClarionQueue pBrowseQueue,ClarionNumber pListControl,ClarionNumber pVCRRequest,ClarionNumber pCurrentChoice,ClarionNumber pTabAction,ClarionNumber pEnterAction,ClarionNumber pArrowAction,ClarionNumber pFocusLossAction,ClarionNumber pInsertPosition,ClarionNumber pDeleteAction)
	{
		this.q=pBrowseQueue;
		this.listControl.setValue(pListControl);
		this.vCRRequest=pVCRRequest;
		this.vCRRequest.setValue(Vcr.NONE);
		this.tabAction.setValue(pTabAction);
		this.enterAction.setValue(pEnterAction);
		this.arrowAction.setValue(pArrowAction);
		this.focusLossAction.setValue(pFocusLossAction);
		this.insert.setValue(pInsertPosition);
		this.tab=this.tabAction;
		this.arrow=this.arrowAction;
		this.enter=this.enterAction;
		this.focusLoss=this.focusLossAction;
		this.currentChoice=pCurrentChoice;
		this.deleteAction.setValue(pDeleteAction);
		this.autoIncDone.setValue(Constants.FALSE);
	}
	public void addColumn(ClarionObject p0,ClarionObject p1,ClarionNumber p3,ClarionNumber p4)
	{
		addColumn(p0,p1,(Editclass)null,p3,p4);
	}
	public void addColumn(ClarionObject p0,ClarionNumber p3,ClarionNumber p4)
	{
		addColumn(p0,(ClarionObject)null,p3,p4);
	}
	public void addColumn(ClarionNumber p3,ClarionNumber p4)
	{
		addColumn((ClarionObject)null,p3,p4);
	}
	public void addColumn(ClarionObject fromFile,ClarionObject fromQueue,Editclass ec,ClarionNumber id,ClarionNumber free)
	{
		this.fields.addPair(fromFile,fromQueue);
		this.addControl(ec,id.like(),free.like());
	}
	public void addColumn(ClarionString p0,ClarionString p1,ClarionNumber p3,ClarionNumber p4)
	{
		addColumn(p0,p1,(Editclass)null,p3,p4);
	}
	public void addColumn(ClarionString p0,ClarionNumber p3,ClarionNumber p4)
	{
		addColumn(p0,(ClarionString)null,p3,p4);
	}
	public void addColumn(ClarionString fromFile,ClarionString fromQueue,Editclass ec,ClarionNumber id,ClarionNumber free)
	{
		this.fields.addPair(fromFile,fromQueue);
		this.addControl(ec,id.like(),free.like());
	}
	public void addColumn(ClarionNumber p0,ClarionNumber p1,ClarionNumber p3,ClarionNumber p4)
	{
		addColumn(p0,p1,(Editclass)null,p3,p4);
	}
	public void addColumn(ClarionNumber p0,ClarionNumber p3,ClarionNumber p4)
	{
		addColumn(p0,(ClarionNumber)null,p3,p4);
	}
	public void addColumn(ClarionNumber fromFile,ClarionNumber fromQueue,Editclass ec,ClarionNumber id,ClarionNumber free)
	{
		this.fields.addPair(fromFile,fromQueue);
		this.addControl(ec,id.like(),free.like());
	}
	public void processScroll(ClarionNumber pEvent)
	{
	}
	public void scrollEnd(ClarionNumber pEvent)
	{
	}
	public void setQueueRecord()
	{
	}
	public ClarionNumber primeRecord()
	{
		return Clarion.newNumber(Level.BENIGN);
	}
	public void bCPrimarySaveBuffer()
	{
	}
	public void bCPrimaryRestoreBuffer()
	{
	}
	public void bCPrimaryCancelAutoInc()
	{
	}
	public ClarionNumber bCPrimaryDelete()
	{
		return bCPrimaryDelete(Clarion.newNumber(0));
	}
	public ClarionNumber bCPrimaryDelete(ClarionNumber pAsk)
	{
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber bCPrimaryInsert()
	{
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber bCPrimaryUpdate()
	{
		return Clarion.newNumber(Level.BENIGN);
	}
	public void construct()
	{
		this.eq=new Editqueue();
		this.fields=new Fieldpairsclass();
		this.fields.init();
		this.tab=this.tabAction;
		this.arrow=this.arrowAction;
		this.enter=this.enterAction;
		this.focusLoss=this.focusLossAction;
	}
	public void destruct()
	{
		this.eq.free();
		this.fields.kill();
		//this.eq;
		//this.fields;
	}
}
