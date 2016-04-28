package clarion;

import clarion.Browsesortorder;
import clarion.Formvcrwindowcomponent;
import clarion.Locatorclass;
import clarion.Relationmanager;
import clarion.Toolbarclass;
import clarion.Toolbarformvcrclass;
import clarion.Viewmanager;
import clarion.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Insert;
import clarion.equates.Level;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.view.ClarionView;

public class Formvcrclass extends Viewmanager
{
	public ClarionNumber saveRequired;
	public ClarionNumber restoreRequired;
	public ClarionString viewPosition;
	public ClarionNumber currentEvent;
	public ClarionNumber itemsToFill;
	public ClarionNumber vCRPageSize;
	public ClarionNumber quickScan;
	public ClarionNumber onFirstRecord;
	public ClarionNumber onLastRecord;
	public ClarionNumber noRecords;
	public ClarionNumber insertWhenNoRecords;
	public ClarionNumber mSAccessMode;
	public ClarionNumber mSAccessOnInsertMode;
	public ClarionNumber moveDirection;
	public ClarionNumber vCRGroup;
	public ClarionNumber vCRTop;
	public ClarionNumber vCRUp;
	public ClarionNumber vCRPageUp;
	public ClarionNumber vCRPageDown;
	public ClarionNumber vCRDown;
	public ClarionNumber vCRBottom;
	public ClarionNumber vCRRequest;
	public ClarionNumber vCRPrevRequest;
	public ClarionNumber vCRInsert;
	public ClarionNumber vCRChange;
	public ClarionNumber vCRDelete;
	public ClarionNumber vCRView;
	public ClarionNumber vCRNewRecord;
	public Windowmanager window;
	public ClarionNumber recordStatus;
	public Browsesortorder sort;
	public Toolbarclass toolbar;
	public Toolbarformvcrclass toolbarItem;

	private static class _Formvcrwindowcomponent_Impl extends Formvcrwindowcomponent
	{
		private Formvcrclass _owner;
		public _Formvcrwindowcomponent_Impl(Formvcrclass _owner)
		{
			this._owner=_owner;
		}
		public ClarionNumber primaryBufferSaveRequired()
		{
			return _owner.saveRequired.like();
		}
		public ClarionNumber primaryBufferRestoreRequired()
		{
			return _owner.restoreRequired.like();
		}
		public void primaryBufferSaved()
		{
			if (_owner.saveRequired.equals(Constants.TRUE)) {
				_owner.saveRequired.setValue(Constants.FALSE);
				_owner.viewPosition.setValue(_owner.view.getPosition());
				_owner.updateWindow();
			}
		}
		public void primaryBufferRestored()
		{
			if (_owner.restoreRequired.equals(Constants.TRUE)) {
				_owner.restoreRequired.setValue(Constants.FALSE);
			}
		}
		public void kill()
		{
			_owner.kill();
		}
		public void reset(ClarionNumber force)
		{
			_owner.resetSort(Clarion.newNumber(Constants.FALSE));
		}
		public ClarionNumber resetRequired()
		{
			return _owner.applyRange();
		}
		public void setAlerts()
		{
			_owner.setAlerts();
			_owner.scrollEnd(Clarion.newNumber(Event.SCROLLTOP));
			_owner.updateWindow();
			if (_owner.window.request.equals(Constants.INSERTRECORD)) {
				if (_owner.getActionAllowed(Clarion.newNumber(Event.ACCEPTED),Clarion.newNumber(Constants.INSERTRECORD)).boolValue()) {
					_owner.takeRequestChanged(Clarion.newNumber(0),Clarion.newNumber(Constants.INSERTRECORD));
				}
			}
			else {
				if (_owner.noRecords.boolValue()) {
					if (_owner.insertWhenNoRecords.boolValue()) {
						if (_owner.getActionAllowed(Clarion.newNumber(Event.ACCEPTED),Clarion.newNumber(Constants.INSERTRECORD)).boolValue()) {
							_owner.window.request.setValue(Constants.INSERTRECORD);
							_owner.takeRequestChanged(Clarion.newNumber(0),Clarion.newNumber(Constants.INSERTRECORD));
							_owner.vCRPrevRequest.setValue(_owner.window.request);
						}
					}
				}
			}
		}
		public ClarionNumber takeEvent()
		{
			_owner.takeEvent();
			return Clarion.newNumber(Level.BENIGN);
		}
		public void update()
		{
		}
		public void updateWindow()
		{
			_owner.updateWindow();
		}
	}
	private Formvcrwindowcomponent _Formvcrwindowcomponent_inst;
	public Formvcrwindowcomponent formvcrwindowcomponent()
	{
		if (_Formvcrwindowcomponent_inst==null) _Formvcrwindowcomponent_inst=new _Formvcrwindowcomponent_Impl(this);
		return _Formvcrwindowcomponent_inst;
	}
	public Formvcrclass()
	{
		saveRequired=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		restoreRequired=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		viewPosition=Clarion.newString(1024);
		currentEvent=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		itemsToFill=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		vCRPageSize=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		quickScan=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		onFirstRecord=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		onLastRecord=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		noRecords=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		insertWhenNoRecords=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		mSAccessMode=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		mSAccessOnInsertMode=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		moveDirection=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		vCRGroup=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		vCRTop=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		vCRUp=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		vCRPageUp=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		vCRPageDown=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		vCRDown=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		vCRBottom=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		vCRRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		vCRPrevRequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		vCRInsert=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		vCRChange=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		vCRDelete=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		vCRView=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		vCRNewRecord=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		window=null;
		recordStatus=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		sort=null;
		toolbar=null;
		toolbarItem=null;
	}

	public void init(ClarionNumber pVCRGroup,ClarionNumber vCRPageSize,ClarionView v,Relationmanager rm,Windowmanager wm)
	{
		this.vCRGroup.setValue(pVCRGroup);
		this.onFirstRecord.setValue(Constants.TRUE);
		this.onLastRecord.setValue(Constants.FALSE);
		this.noRecords.setValue(Constants.FALSE);
		this.vCRPageSize.setValue(vCRPageSize);
		this.moveDirection.setValue(Event.SCROLLDOWN);
		this.insertWhenNoRecords.setValue(Constants.FALSE);
		this.window=wm;
		if (this.window.request.equals(0)) {
			this.window.request.setValue(Constants.VIEWRECORD);
		}
		this.sort=new Browsesortorder();
		super.init(v,rm,this.sort);
		this.window.addItem(this.formvcrwindowcomponent());
		this.window.formVCR=this;
		this.window.batchProcessing.setValue(Constants.TRUE);
	}
	public void setVCRControls(ClarionNumber p0,ClarionNumber p1,ClarionNumber p2,ClarionNumber p3,ClarionNumber p4,ClarionNumber p5)
	{
		setVCRControls(p0,p1,p2,p3,p4,p5,Clarion.newNumber(0));
	}
	public void setVCRControls(ClarionNumber pVCRTop,ClarionNumber pVCRPageUp,ClarionNumber pVCRUp,ClarionNumber pVCRDown,ClarionNumber pVCRPageDown,ClarionNumber pVCRBottom,ClarionNumber pVCRNewRecord)
	{
		this.vCRTop.setValue(pVCRTop);
		this.vCRUp.setValue(pVCRUp);
		this.vCRPageUp.setValue(pVCRPageUp);
		this.vCRPageDown.setValue(pVCRPageDown);
		this.vCRDown.setValue(pVCRDown);
		this.vCRBottom.setValue(pVCRBottom);
		if (pVCRNewRecord.boolValue()) {
			this.vCRNewRecord.setValue(pVCRNewRecord);
		}
	}
	public void setRequestControl(ClarionNumber pVCRRequest,ClarionNumber pVCRViewRecord,ClarionNumber pVCRInsertRecord,ClarionNumber pVCRChangeRecord,ClarionNumber pVCRDeleteRecord)
	{
		this.vCRInsert.setValue(pVCRInsertRecord);
		this.vCRChange.setValue(pVCRChangeRecord);
		this.vCRDelete.setValue(pVCRDeleteRecord);
		this.vCRView.setValue(pVCRViewRecord);
		if (this.vCRView.boolValue()) {
			Clarion.getControl(this.vCRView).setProperty(Prop.VALUE,Constants.VIEWRECORD);
		}
		if (this.vCRInsert.boolValue()) {
			Clarion.getControl(this.vCRInsert).setProperty(Prop.VALUE,Constants.INSERTRECORD);
			this.window.insertAction.setValue(Insert.BATCH);
		}
		if (this.vCRChange.boolValue()) {
			Clarion.getControl(this.vCRChange).setProperty(Prop.VALUE,Constants.CHANGERECORD);
		}
		if (this.vCRDelete.boolValue()) {
			Clarion.getControl(this.vCRDelete).setProperty(Prop.VALUE,Constants.DELETERECORD);
		}
		this.vCRRequest.setValue(pVCRRequest);
		if (this.vCRRequest.boolValue()) {
			Clarion.getControl(this.vCRRequest).setProperty(Prop.USE,this.window.request);
			CWin.display(this.vCRRequest.intValue());
		}
		this.vCRPrevRequest.setValue(this.window.request);
	}
	public void addLocator(Locatorclass l)
	{
		this.sort.locator.set(l);
		this.sort.put();
	}
	public void addToolbarTarget(Toolbarclass t)
	{
		this.toolbar=t;
		this.toolbarItem=new Toolbarformvcrclass();
		this.toolbarItem.formVCR=this;
		t.addTarget(this.toolbarItem,this.vCRGroup.like());
		this.updateToolbarButtons();
	}
	public void takeScroll()
	{
		takeScroll(Clarion.newNumber(0));
	}
	public void takeScroll(ClarionNumber e)
	{
		if (!e.boolValue()) {
			e.setValue(CWin.event());
		}
		{
			ClarionNumber case_1=e;
			boolean case_1_break=false;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1.equals(Event.SCROLLUP)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Event.SCROLLDOWN)) {
				this.scrollOne(e.like());
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Event.PAGEUP)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Event.PAGEDOWN)) {
				this.scrollPage(e.like());
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Event.SCROLLTOP)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Event.SCROLLBOTTOM)) {
				this.scrollEnd(e.like());
				case_1_break=true;
			}
		}
		this.window.reset();
		this.updateWindow();
	}
	public void takeLocate()
	{
	}
	public void takeEvent()
	{
		ClarionNumber vsp=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (CWin.event()==Event.ACCEPTED) {
			{
				int case_1=CWin.accepted();
				boolean case_1_break=false;
				boolean case_1_match=false;
				case_1_match=false;
				if (case_1==0) {
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && Clarion.newNumber(case_1).equals(this.vCRTop)) {
					if (this.window.request.equals(Constants.CHANGERECORD) && this.mSAccessMode.boolValue()) {
						if (this.window.okControl.boolValue()) {
							this.moveDirection.setValue(Event.SCROLLTOP);
							CWin.post(Event.ACCEPTED,this.window.okControl.intValue());
						}
					}
					else {
						this.takeScroll(Clarion.newNumber(Event.SCROLLTOP));
					}
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && Clarion.newNumber(case_1).equals(this.vCRPageUp)) {
					if (this.window.request.equals(Constants.CHANGERECORD) && this.mSAccessMode.boolValue()) {
						if (this.window.okControl.boolValue()) {
							this.moveDirection.setValue(Event.PAGEUP);
							CWin.post(Event.ACCEPTED,this.window.okControl.intValue());
						}
					}
					else {
						this.takeScroll(Clarion.newNumber(Event.PAGEUP));
					}
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && Clarion.newNumber(case_1).equals(this.vCRUp)) {
					if (this.window.request.equals(Constants.CHANGERECORD) && this.mSAccessMode.boolValue()) {
						if (this.window.okControl.boolValue()) {
							this.moveDirection.setValue(Event.SCROLLUP);
							CWin.post(Event.ACCEPTED,this.window.okControl.intValue());
						}
					}
					else {
						this.takeScroll(Clarion.newNumber(Event.SCROLLUP));
					}
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && Clarion.newNumber(case_1).equals(this.vCRDown)) {
					if (this.window.request.equals(Constants.CHANGERECORD) && this.mSAccessMode.boolValue()) {
						if (this.window.okControl.boolValue()) {
							this.moveDirection.setValue(Event.SCROLLDOWN);
							CWin.post(Event.ACCEPTED,this.window.okControl.intValue());
						}
					}
					else {
						this.takeScroll(Clarion.newNumber(Event.SCROLLDOWN));
					}
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && Clarion.newNumber(case_1).equals(this.vCRPageDown)) {
					if (this.window.request.equals(Constants.CHANGERECORD) && this.mSAccessMode.boolValue()) {
						if (this.window.okControl.boolValue()) {
							this.moveDirection.setValue(Event.PAGEDOWN);
							CWin.post(Event.ACCEPTED,this.window.okControl.intValue());
						}
					}
					else {
						this.takeScroll(Clarion.newNumber(Event.PAGEDOWN));
					}
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && Clarion.newNumber(case_1).equals(this.vCRBottom)) {
					if (this.window.request.equals(Constants.CHANGERECORD) && this.mSAccessMode.boolValue()) {
						if (this.window.okControl.boolValue()) {
							this.moveDirection.setValue(Event.SCROLLBOTTOM);
							CWin.post(Event.ACCEPTED,this.window.okControl.intValue());
						}
					}
					else {
						this.takeScroll(Clarion.newNumber(Event.SCROLLBOTTOM));
					}
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && Clarion.newNumber(case_1).equals(this.vCRNewRecord)) {
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && Clarion.newNumber(case_1).equals(this.vCRInsert)) {
					if (this.vCRInsert.boolValue()) {
						this.window.request.setValue(Constants.INSERTRECORD);
						CWin.post(Event.ACCEPTED,this.vCRRequest.intValue());
					}
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && Clarion.newNumber(case_1).equals(this.vCRChange)) {
					if (this.vCRChange.boolValue()) {
						this.window.request.setValue(Constants.CHANGERECORD);
						CWin.post(Event.ACCEPTED,this.vCRRequest.intValue());
					}
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && Clarion.newNumber(case_1).equals(this.vCRDelete)) {
					if (this.vCRDelete.boolValue()) {
						this.window.request.setValue(Constants.DELETERECORD);
						CWin.post(Event.ACCEPTED,this.vCRRequest.intValue());
					}
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && Clarion.newNumber(case_1).equals(this.vCRView)) {
					if (this.vCRView.boolValue()) {
						this.window.request.setValue(Constants.VIEWRECORD);
						CWin.post(Event.ACCEPTED,this.vCRRequest.intValue());
					}
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && Clarion.newNumber(case_1).equals(this.vCRRequest)) {
					if (this.getActionAllowed(Clarion.newNumber(Event.ACCEPTED),this.window.request.like()).boolValue()) {
						CWin.change(this.vCRRequest.intValue(),this.window.request);
						this.window.originalRequest.setValue(this.window.request);
						this.takeRequestChanged(this.vCRPrevRequest.like(),this.window.request.like());
						this.vCRPrevRequest.setValue(this.window.request);
					}
					else {
						if (this.noRecords.boolValue()) {
							this.noRecords.setValue(this.view.records());
							if (!this.getActionAllowed(Clarion.newNumber(Event.ACCEPTED),this.window.request.like()).boolValue()) {
								this.window.request.setValue(this.vCRPrevRequest);
								CWin.change(this.vCRRequest.intValue(),this.window.request);
								this.updateWindow();
							}
							else {
								CWin.change(this.vCRRequest.intValue(),this.window.request);
								this.window.originalRequest.setValue(this.window.request);
								this.takeRequestChanged(this.vCRPrevRequest.like(),this.window.request.like());
								this.vCRPrevRequest.setValue(this.window.request);
							}
						}
					}
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && Clarion.newNumber(case_1).equals(this.window.okControl)) {
					case_1_match=true;
				}
				if (case_1_match || Clarion.newNumber(case_1).equals(this.window.saveControl)) {
					this.viewPosition.setValue(this.view.getPosition());
					this.saveRequired.setValue(Constants.TRUE);
					if (this.onFirstRecord.boolValue()) {
						this.moveDirection.setValue(Event.SCROLLDOWN);
					}
					case_1_break=true;
				}
				if (!case_1_break) {
					if (!Clarion.getControl(0).getProperty(Prop.ACCEPTALL).boolValue()) {
						this.takeAcceptedLocator();
					}
				}
			}
		}
		else {
			if (Clarion.newNumber(CWin.field()).equals(this.vCRGroup) && this.vCRGroup.boolValue()) {
				{
					int case_2=CWin.event();
					boolean case_2_match=false;
					case_2_match=false;
					if (case_2==Event.SCROLLUP) {
						case_2_match=true;
					}
					if (case_2_match || case_2==Event.SCROLLDOWN) {
						case_2_match=true;
					}
					if (case_2_match || case_2==Event.PAGEUP) {
						case_2_match=true;
					}
					if (case_2_match || case_2==Event.PAGEDOWN) {
						case_2_match=true;
					}
					if (case_2_match || case_2==Event.SCROLLTOP) {
						case_2_match=true;
					}
					if (case_2_match || case_2==Event.SCROLLBOTTOM) {
						this.takeScroll();
					}
				}
			}
		}
	}
	public void takeAcceptedLocator()
	{
		if (!(this.sort.locator.get()==null) && Clarion.newNumber(CWin.accepted()).equals(this.sort.locator.get().control)) {
			if (!this.window.request.equals(Constants.INSERTRECORD)) {
				if (this.sort.locator.get().takeAccepted().boolValue()) {
					if (this.sort.mainKey.get()==null) {
						this.reset(Clarion.newNumber(1));
					}
					else {
						this.reset(this.getFreeElementPosition());
					}
					this.viewPosition.setValue("");
					this.itemsToFill.setValue(1);
					this.fetch(Clarion.newNumber(Constants.FILLFORWARD));
					this.sort.locator.get().reset();
					this.updateWindow();
					this.window.reset();
				}
				else {
					if (this.noRecords.boolValue()) {
						this.takeScroll(Clarion.newNumber(Event.SCROLLTOP));
					}
				}
			}
			else {
				CWin.change(this.sort.locator.get().control.intValue(),Clarion.newString(""));
			}
		}
	}
	public void takeRequestChanged(ClarionNumber pPreviousRequest,ClarionNumber pActualRequest)
	{
		ClarionNumber i=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE);
		if (!pPreviousRequest.equals(pActualRequest)) {
			if (pPreviousRequest.equals(Constants.INSERTRECORD)) {
				if (this.primary.me.cancelAutoInc().boolValue()) {
					return;
				}
				else {
					if (this.viewPosition.boolValue()) {
						this.view.reset(this.viewPosition);
						i.setValue(this.previous());
					}
					this.checkBorders();
					CWin.select(this.window.firstField.intValue());
					this.saveRequired.setValue(Constants.TRUE);
					this.window.reset();
					return;
				}
			}
			if (pActualRequest.equals(Constants.INSERTRECORD)) {
				if (this.primeRecord().boolValue()) {
					this.window.response.setValue(Constants.REQUESTCANCELLED);
					this.window.reset();
					return;
				}
				else {
					this.window.primeFields();
					this.window.response.setValue(Constants.REQUESTCANCELLED);
				}
				this.viewPosition.setValue(this.view.getPosition());
				this.saveRequired.setValue(Constants.TRUE);
				CWin.select(this.window.firstField.intValue());
				this.window.reset();
				return;
			}
			this.window.reset();
		}
	}
	public ClarionNumber previous()
	{
		ClarionNumber res=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		res.setValue(super.previous());
		{
			ClarionNumber case_1=res;
			boolean case_1_break=false;
			if (case_1.equals(Level.NOTIFY)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Level.FATAL)) {
				case_1_break=true;
			}
		}
		return res.like();
	}
	public ClarionNumber next()
	{
		ClarionNumber res=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		res.setValue(super.next());
		{
			ClarionNumber case_1=res;
			boolean case_1_break=false;
			if (case_1.equals(Level.NOTIFY)) {
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Level.FATAL)) {
				case_1_break=true;
			}
		}
		return res.like();
	}
	public void takeNextRecord()
	{
		if (this.window.request.equals(Constants.INSERTRECORD)) {
			return;
		}
		{
			ClarionNumber case_1=this.moveDirection;
			boolean case_1_break=false;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1.equals(Event.SCROLLUP)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Event.SCROLLTOP)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Event.PAGEUP)) {
				if (!this.onFirstRecord.boolValue()) {
					this.takeScroll(this.moveDirection.like());
					this.saveRequired.setValue(Constants.FALSE);
				}
				else {
					if (!this.window.request.equals(Constants.DELETERECORD)) {
						this.saveRequired.setValue(Constants.FALSE);
						this.viewPosition.setValue(this.view.getPosition());
						this.updateWindow();
					}
					else {
						this.window.request.setValue(Constants.CHANGERECORD);
						if (!this.onLastRecord.boolValue()) {
							this.takeScroll(Clarion.newNumber(Event.SCROLLDOWN));
							this.saveRequired.setValue(Constants.FALSE);
						}
						else {
							this.window.reset();
						}
						this.updateWindow();
					}
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Event.PAGEDOWN)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Event.SCROLLDOWN)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Event.SCROLLBOTTOM)) {
				if (!this.onLastRecord.boolValue()) {
					this.takeScroll(this.moveDirection.like());
					this.saveRequired.setValue(Constants.FALSE);
				}
				else {
					if (!this.window.request.equals(Constants.DELETERECORD)) {
						this.saveRequired.setValue(Constants.FALSE);
						this.viewPosition.setValue(this.view.getPosition());
						this.updateWindow();
					}
					else {
						this.window.request.setValue(Constants.CHANGERECORD);
						if (!this.onFirstRecord.boolValue()) {
							this.takeScroll(Clarion.newNumber(Event.SCROLLUP));
							this.saveRequired.setValue(Constants.FALSE);
						}
						else {
							this.window.reset();
						}
						this.updateWindow();
					}
				}
				case_1_break=true;
			}
			if (!case_1_break) {
				CWin.message(Clarion.newString(ClarionString.staticConcat("Direction not supported (",this.moveDirection,")")));
				this.moveDirection.setValue(Event.PAGEDOWN);
				this.takeNextRecord();
			}
		}
	}
	public void scrollEnd(ClarionNumber ev)
	{
		if (ev.equals(Event.SCROLLTOP)) {
			this.onFirstRecord.setValue(Constants.TRUE);
		}
		else {
			this.onLastRecord.setValue(Constants.TRUE);
		}
		this.currentEvent.setValue(ev);
		this.itemsToFill.setValue(1);
		this.viewPosition.setValue("");
		this.reset();
		this.fetch((ev.equals(Event.SCROLLTOP) ? Clarion.newNumber(Constants.FILLFORWARD) : Clarion.newNumber(Constants.FILLBACKWARD)).getNumber());
	}
	public void scrollOne(ClarionNumber ev)
	{
		this.currentEvent.setValue(ev);
		this.itemsToFill.setValue(1);
		this.fetch((ev.equals(Event.SCROLLUP) ? Clarion.newNumber(Constants.FILLBACKWARD) : Clarion.newNumber(Constants.FILLFORWARD)).getNumber());
	}
	public void scrollPage(ClarionNumber ev)
	{
		ClarionNumber li=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		this.currentEvent.setValue(ev);
		this.itemsToFill.setValue(this.vCRPageSize);
		this.fetch((ev.equals(Event.PAGEUP) ? Clarion.newNumber(Constants.FILLBACKWARD) : Clarion.newNumber(Constants.FILLFORWARD)).getNumber());
	}
	public void setRecord()
	{
	}
	public void fetch(ClarionNumber direction)
	{
		ClarionNumber skipFirst=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE);
		ClarionString lastRecordPosition=Clarion.newString(1024);
		lastRecordPosition.setValue("");
		if (this.itemsToFill.compareTo(0)>0) {
			if (this.quickScan.boolValue()) {
				this.primary.setQuickScan(Clarion.newNumber(1));
			}
			if (this.viewPosition.boolValue()) {
				this.view.reset(this.viewPosition);
				skipFirst.setValue(Constants.TRUE);
			}
			else {
				this.viewPosition.setValue(this.view.getPosition());
			}
			lastRecordPosition.setValue(this.viewPosition);
			while (this.itemsToFill.boolValue()) {
				{
					ClarionObject case_1=direction.equals(Constants.FILLFORWARD) ? this.next() : this.previous();
					boolean case_1_break=false;
					if (case_1.equals(Level.NOTIFY)) {
						if (lastRecordPosition.boolValue()) {
							this.view.reset(lastRecordPosition);
						}
						else {
							this.view.reset(this.viewPosition);
						}
						if (!this.next().equals(Level.FATAL)) {
						}
						this.setRecord();
						break;
						// UNREACHABLE! :case_1_break=true;
					}
					if (!case_1_break && case_1.equals(Level.FATAL)) {
						return;
						// UNREACHABLE! :case_1_break=true;
					}
				}
				lastRecordPosition.setValue(this.view.getPosition());
				if (skipFirst.boolValue()) {
					skipFirst.setValue(Constants.FALSE);
					if (this.view.getPosition().equals(this.viewPosition)) {
						continue;
					}
				}
				this.setRecord();
				this.viewPosition.setValue(this.view.getPosition());
				this.itemsToFill.decrement(1);
			}
			if (this.quickScan.boolValue()) {
				this.primary.setQuickScan(Clarion.newNumber(0));
			}
			this.saveRequired.setValue(Constants.TRUE);
		}
	}
	public void updateResets()
	{
		this.sort.resets.get().assignRightToLeft();
	}
	public void setAlerts()
	{
	}
	public void updateWindow()
	{
		if (!(this.sort.locator.get()==null)) {
			this.sort.locator.get().updateWindow();
		}
		this.checkBorders();
		this.updateButtons();
		if (!(this.toolbar==null)) {
			this.toolbar.displayButtons();
		}
		this.updateViewRecord();
	}
	public void updateToolbarButtons()
	{
		if (this.vCRNewRecord.boolValue()) {
			this.toolbarItem.insertButton.setValue(this.vCRNewRecord);
			this.toolbarItem.deleteButton.setValue(0);
			this.toolbarItem.changeButton.setValue(0);
			this.toolbarItem.selectButton.setValue(0);
		}
		else {
			if (this.vCRInsert.boolValue()) {
				this.toolbarItem.insertButton.setValue(this.vCRInsert);
			}
			if (this.vCRDelete.boolValue()) {
				this.toolbarItem.deleteButton.setValue(this.vCRDelete);
			}
			if (this.vCRChange.boolValue()) {
				this.toolbarItem.changeButton.setValue(this.vCRChange);
			}
			if (this.vCRView.boolValue()) {
				this.toolbarItem.selectButton.setValue(this.vCRView);
			}
		}
		this.toolbar.setTarget(this.vCRGroup.like());
	}
	public void updateViewRecord()
	{
		ClarionString pos=Clarion.newString(1024);
		ClarionNumber rc=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		if (this.viewPosition.boolValue()) {
			this.view.watch();
			this.view.reget(this.viewPosition);
			rc.setValue(CError.errorCode());
			if (rc.equals(Constants.NODRIVERSUPPORT)) {
				this.viewPosition.setValue(this.view.getPosition());
				this.view.reset(this.viewPosition);
				this.view.watch();
				this.view.next();
				rc.setValue(CError.errorCode());
				this.view.reset(this.viewPosition);
			}
		}
	}
	public ClarionNumber initSort(ClarionNumber b)
	{
		ClarionNumber rVal=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE);
		if (this.setSort(b.like()).boolValue()) {
			if (!(this.sort.locator.get()==null)) {
				this.sort.locator.get().set();
			}
			rVal.setValue(1);
		}
		return rVal.like();
	}
	public ClarionNumber setSort(ClarionNumber b,ClarionNumber force)
	{
		ClarionNumber rVal=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE);
		rVal.setValue(this.initSort(b.like()));
		if (this.applyRange().boolValue() || rVal.boolValue() || force.boolValue()) {
			this.applyOrder();
			this.applyFilter();
			this.view.reset(this.viewPosition);
			rVal.setValue(1);
		}
		return rVal.like();
	}
	public ClarionNumber resetSort(ClarionNumber force)
	{
		ClarionNumber rVal=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE);
		rVal.setValue(this.setSort(Clarion.newNumber(this.sort.getPointer()),force.like()));
		if (rVal.boolValue() || force.boolValue()) {
			this.checkBorders();
		}
		return rVal.like();
	}
	public void updateButtons()
	{
		if (this.onFirstRecord.boolValue() || this.window.request.equals(Constants.INSERTRECORD)) {
			CWin.disable(this.vCRUp.intValue());
			CWin.disable(this.vCRPageUp.intValue());
			CWin.disable(this.vCRTop.intValue());
		}
		else {
			CWin.enable(this.vCRUp.intValue());
			CWin.enable(this.vCRPageUp.intValue());
			CWin.enable(this.vCRTop.intValue());
		}
		if (this.onLastRecord.boolValue() || this.window.request.equals(Constants.INSERTRECORD)) {
			CWin.disable(this.vCRDown.intValue());
			CWin.disable(this.vCRPageDown.intValue());
			CWin.disable(this.vCRBottom.intValue());
		}
		else {
			CWin.enable(this.vCRDown.intValue());
			CWin.enable(this.vCRPageDown.intValue());
			CWin.enable(this.vCRBottom.intValue());
		}
		if (this.vCRNewRecord.boolValue()) {
			if (this.vCRRequest.boolValue()) {
				CWin.hide(this.vCRRequest.intValue());
			}
		}
		if (!this.window.request.equals(Constants.INSERTRECORD) && this.noRecords.boolValue()) {
			if (this.window.okControl.boolValue()) {
				CWin.disable(this.window.okControl.intValue());
			}
		}
		else {
			if (this.window.okControl.boolValue()) {
				CWin.enable(this.window.okControl.intValue());
			}
		}
	}
	public void kill()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		if (!(this.sort==null)) {
			for (i.setValue(1);i.compareTo(this.sort.records())<=0;i.increment(1)) {
				this.sort.get(i);
				if (!(this.sort.thumb.get()==null)) {
					this.sort.thumb.get().kill();
				}
				if (!(this.sort.resets.get()==null)) {
					this.sort.resets.get().kill();
					//this.sort.resets.get();
				}
			}
		}
		this.window.removeItem(this.formvcrwindowcomponent());
		super.kill();
		//this.sort;
		//this.toolbarItem;
	}
	public void checkBorders()
	{
		ClarionNumber skipFirst=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE);
		ClarionString lastRecordPosition=Clarion.newString(1024);
		ClarionNumber direction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber lIndex=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (this.quickScan.boolValue()) {
			this.primary.setQuickScan(Clarion.newNumber(1));
		}
		if (this.noRecords.boolValue()) {
			this.view.set(0);
			this.view.next();
			if (!(CError.errorCode()!=0)) {
				this.noRecords.setValue(Constants.FALSE);
			}
			else {
				this.noRecords.setValue(Constants.TRUE);
			}
		}
		this.onFirstRecord.setValue(Constants.TRUE);
		this.onLastRecord.setValue(Constants.TRUE);
		this.viewPosition.setValue(this.view.getPosition());
		if (!this.viewPosition.boolValue()) {
			this.noRecords.setValue(Constants.TRUE);
			this.onFirstRecord.setValue(Constants.TRUE);
			this.onLastRecord.setValue(Constants.TRUE);
			return;
		}
		this.saveBuffers();
		this.view.reset(this.viewPosition);
		skipFirst.setValue(Constants.TRUE);
		lastRecordPosition.setValue(this.viewPosition);
		for (lIndex.setValue(1);lIndex.compareTo(2)<=0;lIndex.increment(1)) {
			while (true) {
				direction.setValue(lIndex.equals(1) ? Clarion.newNumber(Constants.FILLFORWARD) : Clarion.newNumber(Constants.FILLBACKWARD));
				{
					ClarionObject case_1=direction.equals(Constants.FILLFORWARD) ? this.next() : this.previous();
					boolean case_1_break=false;
					if (case_1.equals(Level.NOTIFY)) {
						if (direction.equals(Constants.FILLFORWARD)) {
							this.onLastRecord.setValue(Constants.TRUE);
						}
						else {
							this.onFirstRecord.setValue(Constants.TRUE);
							if (this.onLastRecord.boolValue()) {
								if (skipFirst.boolValue()) {
									this.noRecords.setValue(Constants.TRUE);
								}
							}
						}
						break;
						// UNREACHABLE! :case_1_break=true;
					}
					if (!case_1_break && case_1.equals(Level.FATAL)) {
						this.onFirstRecord.setValue(Constants.TRUE);
						this.onLastRecord.setValue(Constants.TRUE);
						this.noRecords.setValue(Constants.TRUE);
						return;
						// UNREACHABLE! :case_1_break=true;
					}
				}
				if (skipFirst.boolValue()) {
					skipFirst.setValue(Constants.FALSE);
					continue;
				}
				if (direction.equals(Constants.FILLFORWARD)) {
					this.onLastRecord.setValue(Constants.FALSE);
				}
				else {
					this.onFirstRecord.setValue(Constants.FALSE);
				}
				break;
			}
			this.view.reset(lastRecordPosition);
			skipFirst.setValue(Constants.TRUE);
		}
		if (!this.next().equals(Level.FATAL)) {
		}
		this.restoreBuffers();
		if (this.quickScan.boolValue()) {
			this.primary.setQuickScan(Clarion.newNumber(0));
		}
	}
	public ClarionNumber getActionAllowed(ClarionNumber p0)
	{
		return getActionAllowed(p0,Clarion.newNumber(0));
	}
	public ClarionNumber getActionAllowed(ClarionNumber e,ClarionNumber pActionRequested)
	{
		if (this.noRecords.boolValue() && !(e.equals(Event.ACCEPTED) && pActionRequested.equals(Constants.INSERTRECORD))) {
			return Clarion.newNumber(Constants.FALSE);
		}
		{
			ClarionNumber case_1=e;
			boolean case_1_break=false;
			if (case_1.equals(Event.SCROLLUP)) {
				if (this.vCRUp.boolValue() && Clarion.getControl(this.vCRUp).getProperty(Prop.DISABLE).equals(Constants.FALSE) && Clarion.getControl(this.vCRUp).getProperty(Prop.HIDE).equals(Constants.FALSE)) {
					return Clarion.newNumber(Constants.TRUE);
				}
				else {
					return Clarion.newNumber(Constants.FALSE);
				}
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Event.SCROLLDOWN)) {
				if (this.vCRDown.boolValue() && Clarion.getControl(this.vCRDown).getProperty(Prop.DISABLE).equals(Constants.FALSE) && Clarion.getControl(this.vCRDown).getProperty(Prop.HIDE).equals(Constants.FALSE)) {
					return Clarion.newNumber(Constants.TRUE);
				}
				else {
					return Clarion.newNumber(Constants.FALSE);
				}
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Event.PAGEUP)) {
				if (this.vCRPageUp.boolValue() && Clarion.getControl(this.vCRPageUp).getProperty(Prop.DISABLE).equals(Constants.FALSE) && Clarion.getControl(this.vCRPageUp).getProperty(Prop.HIDE).equals(Constants.FALSE)) {
					return Clarion.newNumber(Constants.TRUE);
				}
				else {
					return Clarion.newNumber(Constants.FALSE);
				}
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Event.PAGEDOWN)) {
				if (this.vCRPageDown.boolValue() && Clarion.getControl(this.vCRPageDown).getProperty(Prop.DISABLE).equals(Constants.FALSE) && Clarion.getControl(this.vCRPageDown).getProperty(Prop.HIDE).equals(Constants.FALSE)) {
					return Clarion.newNumber(Constants.TRUE);
				}
				else {
					return Clarion.newNumber(Constants.FALSE);
				}
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Event.SCROLLTOP)) {
				if (this.vCRTop.boolValue() && Clarion.getControl(this.vCRTop).getProperty(Prop.DISABLE).equals(Constants.FALSE) && Clarion.getControl(this.vCRTop).getProperty(Prop.HIDE).equals(Constants.FALSE)) {
					return Clarion.newNumber(Constants.TRUE);
				}
				else {
					return Clarion.newNumber(Constants.FALSE);
				}
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Event.SCROLLBOTTOM)) {
				if (this.vCRBottom.boolValue() && Clarion.getControl(this.vCRBottom).getProperty(Prop.DISABLE).equals(Constants.FALSE) && Clarion.getControl(this.vCRBottom).getProperty(Prop.HIDE).equals(Constants.FALSE)) {
					return Clarion.newNumber(Constants.TRUE);
				}
				else {
					return Clarion.newNumber(Constants.FALSE);
				}
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Event.ACCEPTED)) {
				{
					ClarionNumber case_2=pActionRequested;
					boolean case_2_break=false;
					if (case_2.equals(Constants.INSERTRECORD)) {
						if (this.vCRInsert.boolValue() && Clarion.getControl(this.vCRInsert).getProperty(Prop.DISABLE).equals(Constants.FALSE) && Clarion.getControl(this.vCRInsert).getProperty(Prop.HIDE).equals(Constants.FALSE)) {
							return Clarion.newNumber(Constants.TRUE);
						}
						else {
							if (this.vCRNewRecord.boolValue() && Clarion.getControl(this.vCRNewRecord).getProperty(Prop.DISABLE).equals(Constants.FALSE) && Clarion.getControl(this.vCRNewRecord).getProperty(Prop.HIDE).equals(Constants.FALSE)) {
								return Clarion.newNumber(Constants.TRUE);
							}
							else {
								return Clarion.newNumber(Constants.FALSE);
							}
						}
						// UNREACHABLE! :case_2_break=true;
					}
					if (!case_2_break && case_2.equals(Constants.CHANGERECORD)) {
						if (this.vCRChange.boolValue() && Clarion.getControl(this.vCRChange).getProperty(Prop.DISABLE).equals(Constants.FALSE) && Clarion.getControl(this.vCRChange).getProperty(Prop.HIDE).equals(Constants.FALSE)) {
							return Clarion.newNumber(Constants.TRUE);
						}
						else {
							if (this.vCRNewRecord.boolValue() && Clarion.getControl(this.vCRNewRecord).getProperty(Prop.DISABLE).equals(Constants.FALSE) && Clarion.getControl(this.vCRNewRecord).getProperty(Prop.HIDE).equals(Constants.FALSE)) {
								return Clarion.newNumber(Constants.TRUE);
							}
							else {
								return Clarion.newNumber(Constants.FALSE);
							}
						}
						// UNREACHABLE! :case_2_break=true;
					}
					if (!case_2_break && case_2.equals(Constants.DELETERECORD)) {
						if (this.vCRDelete.boolValue() && Clarion.getControl(this.vCRDelete).getProperty(Prop.DISABLE).equals(Constants.FALSE) && Clarion.getControl(this.vCRDelete).getProperty(Prop.HIDE).equals(Constants.FALSE)) {
							if (this.vCRNewRecord.boolValue() && Clarion.getControl(this.vCRNewRecord).getProperty(Prop.DISABLE).equals(Constants.FALSE) && Clarion.getControl(this.vCRNewRecord).getProperty(Prop.HIDE).equals(Constants.FALSE)) {
								return Clarion.newNumber(Constants.FALSE);
							}
							else {
								return Clarion.newNumber(Constants.TRUE);
							}
						}
						else {
							return Clarion.newNumber(Constants.FALSE);
						}
						// UNREACHABLE! :case_2_break=true;
					}
					if (!case_2_break && case_2.equals(Constants.VIEWRECORD)) {
						if (this.vCRView.boolValue() && Clarion.getControl(this.vCRView).getProperty(Prop.DISABLE).equals(Constants.FALSE) && Clarion.getControl(this.vCRView).getProperty(Prop.HIDE).equals(Constants.FALSE)) {
							if (this.vCRNewRecord.boolValue() && Clarion.getControl(this.vCRNewRecord).getProperty(Prop.DISABLE).equals(Constants.FALSE) && Clarion.getControl(this.vCRNewRecord).getProperty(Prop.HIDE).equals(Constants.FALSE)) {
								return Clarion.newNumber(Constants.FALSE);
							}
							else {
								return Clarion.newNumber(Constants.TRUE);
							}
						}
						else {
							return Clarion.newNumber(Constants.FALSE);
						}
						// UNREACHABLE! :case_2_break=true;
					}
					if (!case_2_break) {
						return Clarion.newNumber(Constants.FALSE);
					}
				}
				case_1_break=true;
			}
			if (!case_1_break) {
				return Clarion.newNumber(Constants.FALSE);
			}
		}
		return Clarion.newNumber();
	}
	public ClarionNumber getAction()
	{
		return this.window.request.like();
	}
}
