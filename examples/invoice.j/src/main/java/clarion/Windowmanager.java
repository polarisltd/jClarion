package clarion;

import clarion.Browseclass;
import clarion.Buttonlist;
import clarion.Componentlist;
import clarion.Errorclass;
import clarion.Filelist;
import clarion.Filemanager;
import clarion.Formvcrclass;
import clarion.Formvcrwindowcomponent;
import clarion.Historylist;
import clarion.Relationmanager;
import clarion.Toolbarclass;
import clarion.Toolbarupdateclass;
import clarion.Translatorclass;
import clarion.Windowcomponent;
import clarion.Windowresizeclass;
import clarion.equates.Button;
import clarion.equates.Cancel;
import clarion.equates.Change;
import clarion.equates.Constants;
import clarion.equates.Create;
import clarion.equates.Cursor;
import clarion.equates.Delete;
import clarion.equates.Event;
import clarion.equates.Insert;
import clarion.equates.Level;
import clarion.equates.Msg;
import clarion.equates.Prop;
import clarion.equates.Toolbar;
import clarion.equates.Usetype;
import clarion.equates.Vcr;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionBool;
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CExpression;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

public class Windowmanager
{
	public ClarionNumber autoRefresh;
	public ClarionNumber autoToolbar;
	public Buttonlist buttons;
	public Componentlist cl;
	public ClarionNumber cancelAction;
	public ClarionNumber changeAction;
	public ClarionNumber dead;
	public ClarionNumber deleteAction;
	public ClarionNumber batchProcessing;
	public Errorclass errors;
	public Filelist files;
	public ClarionNumber filesOpened;
	public ClarionNumber firstField;
	public ClarionNumber forcedReset;
	public Historylist history;
	public ClarionNumber historyKey;
	public ClarionNumber inited;
	public ClarionNumber insertAction;
	public ClarionString lastInsertedPosition;
	public ClarionNumber okControl;
	public ClarionNumber saveControl;
	public ClarionNumber disableCancelButton;
	public ClarionNumber opened;
	public ClarionNumber originalRequest;
	public ClarionNumber recordSaved;
	public ClarionNumber beforeSaveRequest;
	public Relationmanager primary;
	public ClarionNumber request;
	public ClarionNumber resetOnGainFocus;
	public Windowresizeclass resize;
	public ClarionNumber response;
	public ClarionNumber saved;
	public Formvcrclass formVCR;
	public Toolbarclass toolbar;
	public Translatorclass translator;
	public ClarionNumber vCRRequest;
	public Windowmanager()
	{
		autoRefresh=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		autoToolbar=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		buttons=null;
		cl=null;
		cancelAction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		changeAction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		dead=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		deleteAction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		batchProcessing=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		errors=null;
		files=null;
		filesOpened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		firstField=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		forcedReset=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		history=null;
		historyKey=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		inited=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		insertAction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		lastInsertedPosition=Clarion.newString(1024);
		okControl=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		saveControl=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		disableCancelButton=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		opened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		originalRequest=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		recordSaved=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		beforeSaveRequest=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		primary=null;
		request=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		resetOnGainFocus=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		resize=null;
		response=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		saved=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		formVCR=null;
		toolbar=null;
		translator=null;
		vCRRequest=null;
	}

	public void enableCancelControls()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		if (this.disableCancelButton.boolValue()) {
			for (i.setValue(1);i.compareTo(this.buttons.records())<=0;i.increment(1)) {
				this.buttons.get(i);
				if (this.buttons.action.equals(Constants.REQUESTCANCELLED)) {
					this.takeDisableButton(this.buttons.control.like(),Clarion.newNumber(Constants.FALSE));
				}
			}
		}
	}
	public void disableCancelControls()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		if (this.disableCancelButton.boolValue()) {
			for (i.setValue(1);i.compareTo(this.buttons.records())<=0;i.increment(1)) {
				this.buttons.get(i);
				if (this.buttons.action.equals(Constants.REQUESTCANCELLED)) {
					this.takeDisableButton(this.buttons.control.like(),Clarion.newNumber(Constants.TRUE));
				}
			}
		}
	}
	public void addHistoryField(ClarionNumber control,ClarionNumber field)
	{
		this.history.control.setValue(control);
		this.history.fieldNo.setValue(field);
		this.history.add(this.history.ORDER().ascend(this.history.control));
	}
	public void addHistoryFile(ClarionGroup fb,ClarionGroup sb)
	{
		if (this.history==null) {
			this.history=new Historylist();
		}
		this.history.fRecord.set(fb);
		this.history.sRecord.set(sb);
	}
	public void addItem(Browseclass bc)
	{
		this.addItem(bc.windowcomponent());
		if (this.request.equals(Constants.SELECTRECORD)) {
			bc.selecting.setValue(1);
		}
	}
	public void addItem(ClarionNumber control,ClarionNumber action)
	{
		CRun._assert(!(this.buttons==null));
		this.buttons.control.setValue(control);
		this.buttons.action.setValue(action);
		this.buttons.add();
	}
	public void addItem(Toolbarclass tc)
	{
		this.toolbar=tc;
		tc.init();
	}
	public void addItem(Toolbarupdateclass tf)
	{
		CRun._assert(!(this.toolbar==null));
		if (this.historyKey.boolValue()) {
			tf.history.setValue(1);
		}
		tf.request.setValue(this.originalRequest);
		tf.displayButtons();
		this.toolbar.addTarget(tf,Clarion.newNumber(-1));
		this.toolbar.setTarget(Clarion.newNumber(-1));
	}
	public void addItem(Translatorclass t)
	{
		this.translator=t;
	}
	public void addItem(Windowcomponent wc)
	{
		CRun._assert(!(this.cl==null));
		this.cl.type.setValue(Constants.WC_STANDARD);
		this.cl.wc.set(wc);
		this.cl.add();
		CRun._assert(!(CError.errorCode()!=0));
	}
	public void addItem(Formvcrwindowcomponent wc)
	{
		CRun._assert(!(this.cl==null));
		this.cl.type.setValue(Constants.WC_FORMVCR);
		this.cl.wc.set(wc);
		this.cl.add();
		CRun._assert(!(CError.errorCode()!=0));
	}
	public void addItem(Windowresizeclass rc)
	{
		this.resize=rc;
	}
	public void addUpdateFile(Filemanager fm)
	{
		if (this.files==null) {
			this.files=new Filelist();
		}
		this.files.clear();
		this.files.manager.set(fm);
		this.files.add();
	}
	public void ask()
	{
		if (this.dead.boolValue()) {
			return;
		}
		this.lastInsertedPosition.clear();
		while (Clarion.getWindowTarget().accept()) {
			{
				ClarionNumber case_1=this.takeEvent();
				boolean case_1_break=false;
				if (case_1.equals(Level.FATAL)) {
					break;
					// UNREACHABLE! :case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Level.NOTIFY)) {
					continue;
					// UNREACHABLE! :case_1_break=true;
				}
			}
			Clarion.getWindowTarget().consumeAccept();
		}
	}
	public void removeItem(Windowcomponent wc)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		for (i.setValue(1);i.compareTo(this.cl.records())<=0;i.increment(1)) {
			this.cl.get(i);
			if (this.cl.wc.get()==wc) {
				this.cl.delete();
			}
		}
	}
	public ClarionNumber init()
	{
		this.originalRequest.setValue(this.request);
		this.cl=new Componentlist();
		this.buttons=new Buttonlist();
		CExpression.pushBind(1!=0);
		if (CWin.keyCode()==Constants.MOUSERIGHT || CWin.keyCode()==Constants.MOUSERIGHTUP) {
			CWin.setKeyCode(0);
		}
		this.insertAction.setValue(Insert.CALLER);
		this.deleteAction.setValue(Delete.WARN);
		this.changeAction.setValue(Change.CALLER);
		this.cancelAction.setValue(Cancel.SAVE+Cancel.QUERY);
		this.autoToolbar.setValue(1);
		this.autoRefresh.setValue(1);
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber kill()
	{
		Windowcomponent cur=null;
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		if (this.dead.boolValue() || this.cl==null) {
			return Clarion.newNumber(Level.NOTIFY);
		}
		while (this.cl.records()!=0) {
			this.cl.get(1);
			cur=this.cl.wc.get();
			this.cl.delete();
			cur.kill();
		}
		//this.cl;
		//this.buttons;
		if (!(this.history==null)) {
			//this.history;
			this.history=null;
		}
		if (!(this.files==null)) {
			for (i.setValue(1);i.compareTo(this.files.records())<=0;i.increment(1)) {
				this.files.get(i);
				this.files.manager.get().restoreBuffer(this.files.saved,Clarion.newNumber(0));
			}
		}
		//this.files;
		if (!(this.primary==null)) {
			this.primary.me.restoreBuffer(this.saved,Clarion.newNumber(0));
		}
		if (!(this.toolbar==null)) {
			this.toolbar.kill();
		}
		if (!(this.resize==null)) {
			this.resize.kill();
		}
		this.dead.setValue(1);
		CExpression.popBind();
		return Clarion.newNumber(Level.BENIGN);
	}
	public void open()
	{
		if (!(this.translator==null)) {
			this.translator.translateWindow();
		}
		this.reset();
		this.inited.setValue(this.inited.intValue() | 1);
	}
	public void postCompleted()
	{
		if (this.originalRequest.equals(Constants.CHANGERECORD) || this.originalRequest.equals(Constants.INSERTRECORD) || this.originalRequest.equals(Constants.VIEWRECORD)) {
			if (this.originalRequest.equals(Constants.VIEWRECORD) && !this.batchProcessing.boolValue()) {
				CWin.post(Event.COMPLETED);
			}
			CWin.select();
		}
		else {
			if (!this.batchProcessing.boolValue()) {
				CWin.post(Event.COMPLETED);
			}
			else {
				CWin.select();
			}
		}
	}
	public void primeFields()
	{
	}
	public ClarionNumber primeUpdate()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber rVal=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		CRun._assert(!(this.primary==null));
		this.primary.me.useFile(Clarion.newNumber(Usetype.RETURNS));
		this.primary.save();
		if (!(this.files==null)) {
			for (i.setValue(1);i.compareTo(this.files.records())<=0;i.increment(1)) {
				this.files.get(i);
				this.files.saved.setValue(this.files.manager.get().saveBuffer());
				this.files.put();
			}
		}
		{
			ClarionNumber case_1=this.request;
			boolean case_1_break=false;
			if (case_1.equals(Constants.INSERTRECORD)) {
				if (this.insertAction.boolValue()) {
					this.response.setValue(Constants.REQUESTCOMPLETED);
					this.primeFields();
					if (this.response.equals(Constants.REQUESTCANCELLED)) {
						rVal.setValue(Level.FATAL);
					}
					else {
						this.response.setValue(Constants.REQUESTCANCELLED);
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.DELETERECORD)) {
				{
					ClarionNumber case_2=this.deleteAction;
					boolean case_2_match=false;
					case_2_match=false;
					if (case_2.equals(Delete.WARN)) {
						case_2_match=true;
					}
					if (case_2_match || case_2.equals(Delete.AUTO)) {
						this.response.setValue(this.primary.delete(Clarion.newNumber(this.deleteAction.equals(Delete.WARN) ? 1 : 0)));
						this.response.setValue(this.response.equals(Level.BENIGN) ? Clarion.newNumber(Constants.REQUESTCOMPLETED) : Clarion.newNumber(Constants.REQUESTCANCELLED));
						rVal.setValue(Level.FATAL);
					}
				}
				case_1_break=true;
			}
		}
		this.saved.setValue(this.primary.me.saveBuffer());
		return rVal.like();
	}
	public void reset()
	{
		reset(Clarion.newNumber(0));
	}
	public void reset(ClarionNumber force)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		if (Clarion.getControl(0).getProperty(Prop.ACCEPTALL).boolValue()) {
			return;
		}
		force.increment(this.forcedReset);
		this.forcedReset.setValue(0);
		this.resetBuffers(force.like());
		for (i.setValue(1);i.compareTo(this.cl.records())<=0;i.increment(1)) {
			this.cl.get(i);
			this.cl.wc.get().updateWindow();
		}
		CWin.display();
	}
	public void resetBuffers()
	{
		resetBuffers(Clarion.newNumber(0));
	}
	public void resetBuffers(ClarionNumber force)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		for (i.setValue(1);i.compareTo(this.cl.records())<=0;i.increment(1)) {
			this.cl.get(i);
			{
				ClarionNumber case_1=this.cl.type;
				boolean case_1_break=false;
				if (case_1.equals(Constants.WC_STANDARD)) {
					resetBuffers_Standard(force);
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Constants.WC_FORMVCR)) {
					resetBuffers_FormVCR(force);
					case_1_break=true;
				}
			}
		}
	}
	public void resetBuffers_Standard(ClarionNumber force)
	{
		this.cl.wc.get().reset(force.like());
	}
	public void resetBuffers_FormVCR(ClarionNumber force)
	{
		Formvcrwindowcomponent fvwc=null;
		fvwc=(Formvcrwindowcomponent)CMemory.resolveAddress(CMemory.address(this.cl.wc.get()));
		if (fvwc.primaryBufferRestoreRequired().boolValue()) {
			this.primary.me.restoreBuffer(this.saved);
			fvwc.primaryBufferRestored();
			force.setValue(Constants.TRUE);
		}
		fvwc.reset(force.like());
		if (fvwc.primaryBufferSaveRequired().boolValue()) {
			this.saved.setValue(this.primary.me.saveBuffer());
			fvwc.primaryBufferSaved();
		}
	}
	public void restoreField(ClarionNumber control)
	{
		ClarionAny left=Clarion.newAny();
		if (!(this.history==null)) {
			this.history.control.setValue(control);
			this.history.get(this.history.ORDER().ascend(this.history.control));
			if (!(CError.errorCode()!=0)) {
				left.setReferenceValue(this.history.fRecord.get().what(this.history.fieldNo.intValue()));
				left.setValue(this.history.sRecord.get().what(this.history.fieldNo.intValue()));
				CWin.display(this.history.control.intValue());
			}
		}
	}
	public ClarionNumber run()
	{
		if (!this.init().boolValue()) {
			this.ask();
		}
		this.kill();
		return (this.response.equals(0) ? Clarion.newNumber(Constants.REQUESTCANCELLED) : this.response).getNumber();
	}
	public ClarionNumber run(ClarionNumber number,ClarionNumber request)
	{
		return Clarion.newNumber(Constants.REQUESTCANCELLED);
	}
	public void saveHistory()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionGroup rem=null;
		if (!(this.history==null)) {
			for (i.setValue(1);i.compareTo(this.history.records())<=0;i.increment(1)) {
				this.history.get(i);
				if (!(this.history.fRecord.get()==rem)) {
					this.history.sRecord.get().setValue(this.history.fRecord.get().getString());
					rem=this.history.fRecord.get();
				}
			}
		}
	}
	public void setAlerts()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		for (i.setValue(1);i.compareTo(this.cl.records())<=0;i.increment(1)) {
			this.cl.get(i);
			this.cl.wc.get().setAlerts();
		}
		if (!(this.history==null)) {
			for (i.setValue(1);i.compareTo(this.history.records())<=0;i.increment(1)) {
				this.history.get(i);
				Clarion.getControl(this.history.control).setClonedProperty(Prop.ALRT,255,this.historyKey);
			}
		}
	}
	public void setResponse(ClarionNumber response)
	{
		this.response.setValue(response);
		CWin.post(Event.CLOSEWINDOW);
		if (response.equals(Constants.REQUESTCANCELLED) && !(this.toolbar==null)) {
			this.vCRRequest.setValue(Vcr.NONE);
		}
	}
	public ClarionNumber takeAccepted()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber a=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		a.setValue(CWin.accepted());
		if (!(this.toolbar==null)) {
			this.toolbar.takeEvent(this.vCRRequest,this);
			if (a.equals(Toolbar.HISTORY)) {
				this.restoreField(Clarion.newNumber(CWin.focus()));
			}
		}
		for (i.setValue(1);i.compareTo(this.buttons.records())<=0;i.increment(1)) {
			this.buttons.get(i);
			if (this.buttons.control.equals(a)) {
				this.setResponse(this.buttons.action.like());
				return Clarion.newNumber(Level.NOTIFY);
			}
		}
		if (this.okControl.boolValue() && this.okControl.equals(a)) {
			this.postCompleted();
		}
		if (this.saveControl.boolValue() && this.saveControl.equals(a)) {
			if (!this.request.equals(Constants.VIEWRECORD)) {
				this.beforeSaveRequest.setValue(this.request);
				this.request.setValue(Constants.SAVERECORD);
				this.postCompleted();
			}
			else {
				return Clarion.newNumber(Level.NOTIFY);
			}
		}
		this.enableCancelControls();
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber takeCompleted()
	{
		this.saveHistory();
		{
			ClarionNumber case_1=this.request;
			boolean case_1_break=false;
			if (case_1.equals(Constants.INSERTRECORD)) {
				return this.insertAction();
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.CHANGERECORD)) {
				return this.changeAction();
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.DELETERECORD)) {
				return this.deleteAction();
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.SAVERECORD)) {
				{
					ClarionNumber case_2=this.originalRequest;
					boolean case_2_break=false;
					if (case_2.equals(Constants.INSERTRECORD)) {
						return this.saveOnInsertAction();
						// UNREACHABLE! :case_2_break=true;
					}
					if (!case_2_break && case_2.equals(Constants.CHANGERECORD)) {
						return this.saveOnChangeAction();
						// UNREACHABLE! :case_2_break=true;
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.VIEWRECORD)) {
				if (!this.batchProcessing.boolValue()) {
					return Clarion.newNumber(Level.BENIGN);
				}
				else {
					if (!(this.formVCR==null)) {
						this.formVCR.takeNextRecord();
						this.saved.setValue(this.primary.me.saveBuffer());
						CWin.display();
						CWin.select(this.firstField.intValue());
						return Clarion.newNumber(Level.NOTIFY);
					}
				}
				case_1_break=true;
			}
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber takeCloseEvent()
	{
		if (!this.response.equals(Constants.REQUESTCOMPLETED) && !(this.primary==null)) {
			if (!this.cancelAction.equals(Cancel.CANCEL) && (this.request.equals(Constants.INSERTRECORD) || this.request.equals(Constants.CHANGERECORD))) {
				if (!this.primary.me.equalBuffer(this.saved).boolValue()) {
					if ((this.cancelAction.intValue() & Cancel.SAVE)!=0) {
						if ((this.cancelAction.intValue() & Cancel.QUERY)!=0) {
							{
								ClarionNumber case_1=this.errors.message(Clarion.newNumber(Msg.SAVERECORD),Clarion.newNumber(Button.YES+Button.NO+Button.CANCEL),Clarion.newNumber(Button.CANCEL));
								boolean case_1_break=false;
								if (case_1.equals(Button.YES)) {
									CWin.post(Event.ACCEPTED,this.okControl.intValue());
									return Clarion.newNumber(Level.NOTIFY);
									// UNREACHABLE! :case_1_break=true;
								}
								if (!case_1_break && case_1.equals(Button.CANCEL)) {
									CWin.select(this.firstField.intValue());
									return Clarion.newNumber(Level.NOTIFY);
									// UNREACHABLE! :case_1_break=true;
								}
							}
						}
						else {
							CWin.post(Event.ACCEPTED,this.okControl.intValue());
							return Clarion.newNumber(Level.NOTIFY);
						}
					}
					else {
						if (this.errors._throw(Clarion.newNumber(Msg.CONFIRMCANCEL)).equals(Level.CANCEL)) {
							CWin.select(this.firstField.intValue());
							return Clarion.newNumber(Level.NOTIFY);
						}
					}
				}
			}
			if (this.originalRequest.equals(Constants.INSERTRECORD) && this.response.equals(Constants.REQUESTCANCELLED)) {
				if (this.primary.cancelAutoInc().boolValue()) {
					CWin.select(this.firstField.intValue());
					return Clarion.newNumber(Level.NOTIFY);
				}
			}
			if (this.lastInsertedPosition.boolValue()) {
				this.response.setValue(Constants.REQUESTCOMPLETED);
				this.primary.me.tryReget(this.lastInsertedPosition.like());
			}
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber takeEvent()
	{
		ClarionNumber rVal=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		if (!(CWin.field()!=0)) {
			rVal.setValue(this.takeWindowEvent());
			if (rVal.boolValue()) {
				return rVal.like();
			}
		}
		{
			int case_1=CWin.event();
			boolean case_1_break=false;
			if (case_1==Event.ACCEPTED) {
				rVal.setValue(this.takeAccepted());
				case_1_break=true;
			}
			if (!case_1_break && case_1==Event.REJECTED) {
				rVal.setValue(this.takeRejected());
				case_1_break=true;
			}
			if (!case_1_break && case_1==Event.SELECTED) {
				rVal.setValue(this.takeSelected());
				case_1_break=true;
			}
			if (!case_1_break && case_1==Event.NEWSELECTION) {
				rVal.setValue(this.takeNewSelection());
				case_1_break=true;
			}
			if (!case_1_break && case_1==Event.ALERTKEY) {
				if (this.historyKey.boolValue() && Clarion.newNumber(CWin.keyCode()).equals(this.historyKey)) {
					this.restoreField(Clarion.newNumber(CWin.focus()));
				}
				case_1_break=true;
			}
		}
		if (rVal.boolValue()) {
			return rVal.like();
		}
		if (CWin.field()!=0) {
			rVal.setValue(this.takeFieldEvent());
			if (rVal.boolValue()) {
				return rVal.like();
			}
		}
		for (i.setValue(1);i.compareTo(this.cl.records())<=0;i.increment(1)) {
			this.cl.get(i);
			rVal.setValue(this.cl.wc.get().takeEvent());
			if (rVal.boolValue()) {
				return rVal.like();
			}
		}
		if (this.autoRefresh.boolValue()) {
			for (i.setValue(1);i.compareTo(this.cl.records())<=0;i.increment(1)) {
				this.cl.get(i);
				if (this.cl.wc.get().resetRequired().boolValue()) {
					this.reset();
					break;
				}
			}
		}
		return rVal.like();
	}
	public ClarionNumber takeFieldEvent()
	{
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber takeNewSelection()
	{
		if (Clarion.getControl(CWin.field()).getProperty(Prop.TYPE).equals(Create.SHEET)) {
			this.reset();
			if (this.autoToolbar.boolValue() && !(this.toolbar==null)) {
				this.toolbar.setTarget();
			}
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber takeRejected()
	{
		CWin.beep();
		CWin.display(CWin.field());
		CWin.select(CWin.field());
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber takeSelected()
	{
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber takeWindowEvent()
	{
		ClarionNumber rVal=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		{
			int case_1=CWin.event();
			boolean case_1_break=false;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1==Event.OPENWINDOW) {
				if (!((this.inited.intValue() & 1)!=0)) {
					this.open();
				}
				if (this.firstField.boolValue()) {
					CWin.select(this.firstField.intValue());
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1==Event.LOSEFOCUS) {
				if (this.resetOnGainFocus.boolValue()) {
					this.forcedReset.setValue(1);
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1==Event.GAINFOCUS) {
				if ((this.inited.intValue() & 1)!=0) {
					this.reset();
				}
				else {
					this.open();
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1==Event.SIZED) {
				if ((this.inited.intValue() & 2)!=0) {
					this.reset();
				}
				else {
					this.inited.setValue(this.inited.intValue() | 2);
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1==Event.COMPLETED) {
				rVal.setValue(this.takeCompleted());
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1==Event.CLOSEWINDOW) {
				case_1_match=true;
			}
			if (case_1_match || case_1==Event.CLOSEDOWN) {
				rVal.setValue(this.takeCloseEvent());
				case_1_break=true;
			}
		}
		return rVal.like();
	}
	public void update()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		for (i.setValue(1);i.compareTo(this.cl.records())<=0;i.increment(1)) {
			this.cl.get(i);
			this.cl.wc.get().update();
		}
	}
	public void takeDisableButton(ClarionNumber control,ClarionNumber makeDisable)
	{
		if (control.boolValue()) {
			if (makeDisable.boolValue()) {
				CWin.disable(control.intValue());
			}
			else {
				CWin.enable(control.intValue());
			}
		}
	}
	public ClarionNumber insertAction()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		if (this.primary.me.insert().equals(Level.BENIGN)) {
			if (!this.batchProcessing.boolValue()) {
				if (this.insertAction.equals(Insert.CALLER)) {
					this.setResponse(Clarion.newNumber(Constants.REQUESTCOMPLETED));
					return Clarion.newNumber(Level.BENIGN);
				}
				if (this.insertAction.equals(Insert.QUERY)) {
					if (!this.errors._throw(Clarion.newNumber(Msg.ADDANOTHER)).equals(Level.BENIGN)) {
						this.setResponse(Clarion.newNumber(Constants.REQUESTCOMPLETED));
						return Clarion.newNumber(Level.BENIGN);
					}
				}
			}
			if (this.insertAction.equals(Insert.QUERY) || this.insertAction.equals(Insert.BATCH) || this.batchProcessing.boolValue()) {
				this.lastInsertedPosition.setValue(this.primary.me.position());
				if (!(this.files==null)) {
					for (i.setValue(1);i.compareTo(this.files.records())<=0;i.increment(1)) {
						this.files.get(i);
						this.files.manager.get().restoreBuffer(this.files.saved);
						this.files.saved.setValue(this.files.manager.get().saveBuffer());
						this.files.put();
					}
				}
				this.primary.me.restoreBuffer(this.saved);
				this.primary.me.useFile(Clarion.newNumber(Usetype.RETURNS));
				if (this.primary.me.primeAutoInc().boolValue()) {
					CWin.post(Event.CLOSEWINDOW);
				}
				else {
					this.primeFields();
					this.response.setValue(Constants.REQUESTCANCELLED);
				}
				this.saved.setValue(this.primary.me.saveBuffer());
				CWin.display();
				CWin.select(this.firstField.intValue());
				return Clarion.newNumber(Level.NOTIFY);
			}
		}
		else {
			CWin.select(this.firstField.intValue());
			return Clarion.newNumber(Level.NOTIFY);
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber changeAction()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionBool unChanged=Clarion.newBool();
		ClarionBool error=Clarion.newBool();
		while (true) {
			this.response.setValue(Constants.REQUESTCANCELLED);
			CWin.setCursor(Cursor.WAIT);
			unChanged.setValue(this.primary.me.equalBuffer(this.saved));
			if (unChanged.boolValue()) {
				error.setValue(0);
			}
			else {
				error.setValue(this.primary.update(Clarion.newNumber(this.historyKey.boolValue() ? 1 : 0)));
			}
			CWin.setCursor(null);
			if (error.boolValue()) {
				if (error.equals(Level.USER)) {
					{
						ClarionNumber case_1=this.errors.message(Clarion.newNumber(Msg.RETRYSAVE),Clarion.newNumber(Button.YES+Button.NO+Button.CANCEL),Clarion.newNumber(Button.CANCEL));
						boolean case_1_break=false;
						if (case_1.equals(Button.YES)) {
							continue;
							// UNREACHABLE! :case_1_break=true;
						}
						if (!case_1_break && case_1.equals(Button.NO)) {
							if (!this.originalRequest.equals(Constants.INSERTRECORD)) {
								CWin.post(Event.CLOSEWINDOW);
							}
							break;
							// UNREACHABLE! :case_1_break=true;
						}
					}
				}
				CWin.display();
				CWin.select(this.firstField.intValue());
			}
			else {
				if (!unChanged.boolValue() || !(this.toolbar==null) && this.vCRRequest.equals(Vcr.NONE)) {
					this.response.setValue(Constants.REQUESTCOMPLETED);
				}
				if (this.originalRequest.equals(Constants.CHANGERECORD)) {
					if (!this.batchProcessing.boolValue()) {
						{
							ClarionNumber case_2=this.changeAction;
							boolean case_2_break=false;
							if (case_2.equals(Change.CALLER)) {
								CWin.post(Event.CLOSEWINDOW);
								case_2_break=true;
							}
							if (!case_2_break && case_2.equals(Change.BATCH)) {
								case_2_break=true;
							}
						}
					}
					else {
						if (!(this.formVCR==null)) {
							this.formVCR.takeNextRecord();
							this.saved.setValue(this.primary.me.saveBuffer());
							CWin.display();
							CWin.select(this.firstField.intValue());
							return Clarion.newNumber(Level.NOTIFY);
						}
					}
				}
			}
			if (1!=0) break;
		}
		if (error.boolValue()) {
			return Clarion.newNumber(Level.NOTIFY);
		}
		if (this.originalRequest.equals(Constants.INSERTRECORD) && this.response.equals(Constants.REQUESTCOMPLETED)) {
			this.enableCancelControls();
			this.request.setValue(Constants.INSERTRECORD);
			if (this.insertAction.equals(Insert.BATCH)) {
				this.lastInsertedPosition.setValue(this.primary.me.position());
				if (!(this.files==null)) {
					for (i.setValue(1);i.compareTo(this.files.records())<=0;i.increment(1)) {
						this.files.get(i);
						this.files.manager.get().restoreBuffer(this.files.saved);
						this.files.saved.setValue(this.files.manager.get().saveBuffer());
						this.files.put();
					}
				}
				this.primary.me.useFile(Clarion.newNumber(Usetype.RETURNS));
				if (this.primary.me.primeAutoInc().boolValue()) {
					CWin.post(Event.CLOSEWINDOW);
				}
				else {
					this.primeFields();
					this.response.setValue(Constants.REQUESTCANCELLED);
				}
				this.saved.setValue(this.primary.me.saveBuffer());
				CWin.display();
				CWin.select(this.firstField.intValue());
				return Clarion.newNumber(Level.NOTIFY);
			}
			else {
				if (!this.batchProcessing.boolValue()) {
					if (this.changeAction.equals(Change.CALLER)) {
						CWin.post(Event.CLOSEWINDOW);
					}
				}
			}
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber deleteAction()
	{
		ClarionNumber rc=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		while (true) {
			this.response.setValue(Constants.REQUESTCANCELLED);
			CWin.setCursor(Cursor.WAIT);
			rc.setValue(this.primary.delete(Clarion.newNumber(this.deleteAction.equals(Delete.WARN) ? 1 : 0)));
			CWin.setCursor(null);
			if (!rc.equals(Level.BENIGN) && !rc.equals(Level.CANCEL)) {
				{
					ClarionNumber case_1=this.errors.message(Clarion.newNumber(Msg.RETRYDELETE),Clarion.newNumber(Button.YES+Button.NO+Button.CANCEL),Clarion.newNumber(Button.CANCEL));
					boolean case_1_break=false;
					if (case_1.equals(Button.YES)) {
						continue;
						// UNREACHABLE! :case_1_break=true;
					}
					if (!case_1_break && case_1.equals(Button.NO)) {
						if (!this.batchProcessing.boolValue()) {
							CWin.post(Event.CLOSEWINDOW);
						}
						break;
						// UNREACHABLE! :case_1_break=true;
					}
					if (!case_1_break && case_1.equals(Button.CANCEL)) {
						CWin.display();
						CWin.select(this.firstField.intValue());
						break;
						// UNREACHABLE! :case_1_break=true;
					}
				}
			}
			else {
				if (!this.batchProcessing.boolValue()) {
					this.setResponse(Clarion.newNumber(Constants.REQUESTCOMPLETED));
					break;
				}
				else {
					if (!(this.formVCR==null)) {
						this.formVCR.takeNextRecord();
						this.saved.setValue(this.primary.me.saveBuffer());
						CWin.display();
						CWin.select(this.firstField.intValue());
						return Clarion.newNumber(Level.NOTIFY);
					}
				}
			}
			if (0!=0) break;
		}
		if (this.batchProcessing.boolValue()) {
			this.saved.setValue(this.primary.me.saveBuffer());
			CWin.display();
			CWin.select(this.firstField.intValue());
			return Clarion.newNumber(Level.NOTIFY);
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber saveOnChangeAction()
	{
		ClarionBool unChanged=Clarion.newBool();
		ClarionBool error=Clarion.newBool();
		while (true) {
			this.response.setValue(Constants.REQUESTCANCELLED);
			CWin.setCursor(Cursor.WAIT);
			unChanged.setValue(this.primary.me.equalBuffer(this.saved));
			if (unChanged.boolValue()) {
				error.setValue(0);
			}
			else {
				error.setValue(this.primary.update(Clarion.newNumber(this.historyKey.boolValue() ? 1 : 0)));
			}
			CWin.setCursor(null);
			if (error.boolValue()) {
				if (error.equals(Level.USER)) {
					{
						ClarionNumber case_1=this.errors.message(Clarion.newNumber(Msg.RETRYSAVE),Clarion.newNumber(Button.YES+Button.NO+Button.CANCEL),Clarion.newNumber(Button.CANCEL));
						boolean case_1_break=false;
						if (case_1.equals(Button.YES)) {
							continue;
							// UNREACHABLE! :case_1_break=true;
						}
						if (!case_1_break && case_1.equals(Button.NO)) {
							break;
							// UNREACHABLE! :case_1_break=true;
						}
					}
				}
				CWin.display();
				CWin.select(this.firstField.intValue());
			}
			else {
				break;
			}
			if (1!=0) break;
		}
		if (!error.boolValue()) {
			this.saved.setValue(this.primary.me.saveBuffer());
			this.disableCancelControls();
		}
		this.request.setValue(Constants.CHANGERECORD);
		return Clarion.newNumber(Level.NOTIFY);
	}
	public ClarionNumber saveOnInsertAction()
	{
		ClarionNumber unChanged=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (this.beforeSaveRequest.equals(Constants.INSERTRECORD)) {
			if (!this.primary.me.insert().equals(Level.BENIGN)) {
				this.request.setValue(Constants.INSERTRECORD);
			}
			else {
				this.request.setValue(Constants.CHANGERECORD);
				CWin.select(this.firstField.intValue());
				this.saved.setValue(this.primary.me.saveBuffer());
				this.disableCancelControls();
			}
		}
		else {
			this.request.setValue(Constants.CHANGERECORD);
			unChanged.setValue(this.primary.me.equalBuffer(this.saved));
			if (!unChanged.boolValue()) {
				return this.saveOnChangeAction();
			}
		}
		return Clarion.newNumber(Level.NOTIFY);
	}
}
