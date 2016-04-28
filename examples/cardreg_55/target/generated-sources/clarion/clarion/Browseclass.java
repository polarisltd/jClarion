package clarion;

import clarion.Browseeditqueue;
import clarion.Browseeipmanager;
import clarion.Browsequeue;
import clarion.Browsesortorder;
import clarion.Editclass;
import clarion.Fieldpairsclass;
import clarion.Ilistcontrol;
import clarion.Locatorclass;
import clarion.Popupclass;
import clarion.Processorqueue;
import clarion.Queryclass;
import clarion.Recordprocessor;
import clarion.Relationmanager;
import clarion.Standardbehavior;
import clarion.Stepclass;
import clarion.Toolbarclass;
import clarion.Toolbarlistboxclass;
import clarion.Viewmanager;
import clarion.Windowcomponent;
import clarion.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Cursor;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Msg;
import clarion.equates.Prop;
import clarion.equates.Proplist;
import clarion.equates.Reset;
import clarion.equates.Usetype;
import clarion.equates.Vcr;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionRoutineResult;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.view.ClarionView;

public class Browseclass extends Viewmanager
{
	public ClarionNumber activeInvisible;
	public ClarionNumber allowUnfilled;
	public ClarionNumber arrowAction;
	public ClarionNumber askProcedure;
	public Standardbehavior behavior;
	public ClarionNumber buffer;
	public ClarionNumber changeControl;
	public ClarionNumber currentChoice;
	public ClarionNumber currentEvent;
	public ClarionNumber deleteControl;
	public Browseeipmanager eip;
	public Browseeditqueue editList;
	public ClarionNumber enterAction;
	public Fieldpairsclass fields;
	public ClarionNumber fileLoaded;
	public ClarionNumber focusLossAction;
	public ClarionNumber freeEIP;
	public ClarionNumber hasThumb;
	public ClarionNumber hideSelect;
	public Ilistcontrol ilc;
	public ClarionNumber insertControl;
	public ClarionNumber itemsToFill;
	public ClarionNumber lastChoice;
	public ClarionNumber lastItems;
	public Browsequeue listQueue;
	public ClarionNumber loadPending;
	public ClarionNumber loaded;
	public ClarionNumber needRefresh;
	public Popupclass popup;
	public ClarionNumber prevChoice;
	public ClarionNumber printControl;
	public ClarionNumber printProcedure;
	public Processorqueue processors;
	public Queryclass query;
	public ClarionNumber queryControl;
	public ClarionNumber queryResult;
	public ClarionNumber queryShared;
	public ClarionNumber quickScan;
	public ClarionNumber recordStatus;
	public ClarionNumber retainRow;
	public ClarionNumber selectControl;
	public ClarionNumber selectWholeRecord;
	public ClarionNumber selecting;
	public Browsesortorder sort;
	public ClarionNumber startAtCurrent;
	public ClarionNumber tabAction;
	public ClarionNumber toolControl;
	public Toolbarclass toolbar;
	public Toolbarlistboxclass toolbarItem;
	public ClarionNumber viewControl;
	public Windowmanager window;

	private static class _Windowcomponent_Impl extends Windowcomponent
	{
		private Browseclass _owner;
		public _Windowcomponent_Impl(Browseclass _owner)
		{
			this._owner=_owner;
		}
		public void kill()
		{
			_owner.kill();
		}
		public void reset(ClarionNumber force)
		{
			_owner.resetSort(force.like());
		}
		public ClarionNumber resetRequired()
		{
			return _owner.applyRange();
		}
		public void setAlerts()
		{
			_owner.setAlerts();
		}
		public ClarionNumber takeEvent()
		{
			_owner.takeEvent();
			return Clarion.newNumber(Level.BENIGN);
		}
		public void update()
		{
			_owner.updateViewRecord();
		}
		public void updateWindow()
		{
			_owner.updateWindow();
		}
	}
	private Windowcomponent _Windowcomponent_inst;
	public Windowcomponent windowcomponent()
	{
		if (_Windowcomponent_inst==null) _Windowcomponent_inst=new _Windowcomponent_Impl(this);
		return _Windowcomponent_inst;
	}
	public Browseclass()
	{
		activeInvisible=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		allowUnfilled=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		arrowAction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		askProcedure=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		behavior=null;
		buffer=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		changeControl=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		currentChoice=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		currentEvent=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		deleteControl=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		eip=null;
		editList=null;
		enterAction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		fields=null;
		fileLoaded=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		focusLossAction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		freeEIP=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		hasThumb=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		hideSelect=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ilc=null;
		insertControl=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		itemsToFill=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		lastChoice=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		lastItems=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		listQueue=null;
		loadPending=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		loaded=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		needRefresh=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		popup=null;
		prevChoice=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		printControl=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		printProcedure=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		processors=null;
		query=null;
		queryControl=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		queryResult=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		queryShared=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		quickScan=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		recordStatus=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		retainRow=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		selectControl=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		selectWholeRecord=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		selecting=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		sort=null;
		startAtCurrent=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		tabAction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		toolControl=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		toolbar=null;
		toolbarItem=null;
		viewControl=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		window=null;
	}

	public void addEditControl(Editclass p0,ClarionNumber p1)
	{
		addEditControl(p0,p1,Clarion.newNumber(0));
	}
	public void addEditControl(ClarionNumber p1)
	{
		addEditControl((Editclass)null,p1);
	}
	public void addEditControl(Editclass ec,ClarionNumber id,ClarionNumber free)
	{
		this.checkEIP();
		this.eip.addControl(ec,id.like(),free.like());
	}
	public void addField(ClarionObject fromFile,ClarionObject fromQueue)
	{
		this.fields.addPair(fromFile,fromQueue);
	}
	public void addField(ClarionNumber fromFile,ClarionNumber fromQueue)
	{
		this.fields.addPair(fromFile,fromQueue);
	}
	public void addField(ClarionString fromFile,ClarionString fromQueue)
	{
		this.fields.addPair(fromFile,fromQueue);
	}
	public void addItem(Recordprocessor rp)
	{
		CRun._assert(!(this.processors==null),"Object not initialized");
		this.processors.p.set(rp);
		this.processors.add();
	}
	public void addLocator(Locatorclass l)
	{
		this.sort.locator.set(l);
		this.sort.put();
	}
	public void addResetField(ClarionObject left)
	{
		CRun._assert(!(this.sort.resets.get()==null));
		this.sort.resets.get().addItem(left);
	}
	public void addResetField(ClarionString left)
	{
		CRun._assert(!(this.sort.resets.get()==null));
		this.sort.resets.get().addItem(left);
	}
	public ClarionNumber addSortOrder(Stepclass p0)
	{
		return addSortOrder(p0,(ClarionKey)null);
	}
	public ClarionNumber addSortOrder()
	{
		return addSortOrder((Stepclass)null);
	}
	public ClarionNumber addSortOrder(Stepclass th,ClarionKey k)
	{
		ClarionNumber sNum=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.sort.clear();
		sNum.setValue(super.addSortOrder(k));
		this.sort.thumb.set(th);
		this.sort.resets.set(new Fieldpairsclass());
		this.sort.resets.get().init();
		this.sort.put();
		CRun._assert(!(CError.errorCode()!=0));
		return sNum.like();
	}
	public void addToolbarTarget(Toolbarclass t)
	{
		this.toolbar=t;
		this.toolbarItem=new Toolbarlistboxclass();
		this.toolbarItem.browse=this;
		t.addTarget(this.toolbarItem,this.ilc.getControl());
		this.updateToolbarButtons();
	}
	public ClarionNumber applyRange()
	{
		ClarionNumber rVal=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber li=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		li.setValue(this.ilc.getItems());
		if (!this.lastItems.equals(li) && li.compareTo(0)>=0) {
			if (this.fileLoaded.boolValue()) {
				this.lastItems.clear(1);
			}
			else {
				this.lastItems.setValue(li);
				rVal.setValue(1);
			}
		}
		if (rVal.boolValue() || super.applyRange().boolValue() || !this.sort.resets.get().equal().boolValue()) {
			this.loadPending.setValue(1);
			rVal.setValue(1);
		}
		return rVal.like();
	}
	public ClarionNumber ask(ClarionNumber req)
	{
		ClarionNumber response=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		while (true) {
			this.window.vCRRequest.setValue(Vcr.NONE);
			if (CWin.keyCode()==Constants.MOUSERIGHTUP) {
				CWin.setKeyCode(0);
			}
			if (this.askProcedure.boolValue()) {
				if (req.equals(Constants.INSERTRECORD)) {
					if (this.primeRecord().boolValue()) {
						return Clarion.newNumber(Constants.REQUESTCANCELLED);
					}
				}
				response.setValue(this.window.run(this.askProcedure.like(),req.like()));
				this.resetFromAsk(req,response);
			}
			else {
				response.setValue(this.askRecord(req.like()));
			}
			if (this.window.vCRRequest.equals(Vcr.NONE)) break;
		}
		return response.like();
	}
	public ClarionNumber askRecord(ClarionNumber req)
	{
		this.checkEIP();
		return this.eip.run(req.like());
	}
	public void checkEIP()
	{
		if (this.eip==null) {
			this.eip=new Browseeipmanager();
			this.freeEIP.setValue(1);
		}
		this.eip.arrow=this.arrowAction;
		this.eip.bc=this;
		this.eip.enter=this.enterAction;
		this.eip.eq=this.editList;
		this.eip.errors=this.window.errors;
		this.eip.fields=this.fields;
		this.eip.focusLoss=this.focusLossAction;
		this.eip.listControl.setValue(this.ilc.getControl());
		this.eip.tab=this.tabAction;
		this.eip.vCRRequest=this.window.vCRRequest;
	}
	public void fetch(ClarionNumber direction)
	{
		ClarionNumber skipFirst=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE);
		if (this.quickScan.boolValue() && this.itemsToFill.compareTo(1)>0) {
			this.primary.setQuickScan(Clarion.newNumber(1));
		}
		if (this.listQueue.records().boolValue()) {
			this.listQueue.fetch((direction.equals(Constants.FILLFORWARD) ? this.listQueue.records() : Clarion.newNumber(1)).getNumber());
			this.view.reset(this.listQueue.getViewPosition());
			skipFirst.setValue(1);
		}
		while (this.itemsToFill.boolValue()) {
			{
				ClarionObject case_1=direction.equals(Constants.FILLFORWARD) ? this.next() : this.previous();
				boolean case_1_break=false;
				if (case_1.equals(Level.NOTIFY)) {
					break;
					// UNREACHABLE! :case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Level.FATAL)) {
					return;
					// UNREACHABLE! :case_1_break=true;
				}
			}
			if (skipFirst.boolValue()) {
				skipFirst.setValue(Constants.FALSE);
				if (this.view.getPosition().equals(this.listQueue.getViewPosition())) {
					continue;
				}
			}
			if (this.listQueue.records().equals(this.lastItems)) {
				this.listQueue.fetch((direction.equals(Constants.FILLFORWARD) ? Clarion.newNumber(1) : this.listQueue.records()).getNumber());
				this.listQueue.delete();
			}
			this.setQueueRecord();
			if (direction.equals(Constants.FILLFORWARD)) {
				this.listQueue.insert();
			}
			else {
				this.listQueue.insert(Clarion.newNumber(1));
			}
			this.itemsToFill.decrement(1);
		}
		if (this.quickScan.boolValue()) {
			this.primary.setQuickScan(Clarion.newNumber(0));
		}
	}
	public void init(ClarionNumber listBox,ClarionString posit,ClarionView v,ClarionQueue q,Relationmanager f,Windowmanager wm)
	{
		this.behavior=new Standardbehavior();
		this.behavior.init(q,posit,listBox.like());
		this.init(this.behavior.ilistcontrol(),v,this.behavior.browsequeue(),f,wm);
	}
	public void init(Ilistcontrol li,ClarionView v,Browsequeue lq,Relationmanager f,Windowmanager wm)
	{
		this.prevChoice.setValue(0);
		this.window=wm;
		this.listQueue=lq;
		this.ilc=li;
		this.sort=new Browsesortorder();
		this.fields=new Fieldpairsclass();
		this.fields.init();
		this.processors=new Processorqueue();
		this.popup=new Popupclass();
		this.editList=new Browseeditqueue();
		this.retainRow.setValue(1);
		CRun._assert(!(this.popup==null));
		this.popup.init();
		super.init(v,f,this.sort);
		this.window.addItem(this);
		if (this.selecting.boolValue()) {
			this.primary.me.useFile(Clarion.newNumber(Usetype.RETURNS));
			this.buffer.setValue(this.primary.me.saveBuffer());
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
	public void kill()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		if (!(this.sort==null)) {
			for (i.setValue(1);i.compareTo(this.sort.records())<=0;i.increment(1)) {
				this.sort.get(i);
				if (!(this.sort.thumb.get()==null)) {
					this.sort.thumb.get().kill();
				}
				this.sort.resets.get().kill();
				//this.sort.resets.get();
			}
		}
		this.window.removeItem(this.windowcomponent());
		super.kill();
		//this.sort;
		if (!(this.fields==null)) {
			this.fields.kill();
			//this.fields;
		}
		if (!(this.popup==null)) {
			this.popup.kill();
			//this.popup;
		}
		//this.toolbarItem;
		if (!(this.query==null)) {
			this.query.kill();
		}
		if (this.freeEIP.boolValue()) {
			//this.eip;
			this.freeEIP.setValue(0);
		}
		if (!(this.editList==null)) {
			for (i.setValue(1);i.compareTo(this.editList.records())<=0;i.increment(1)) {
				this.editList.get(i);
				if (this.editList.freeUp.boolValue()) {
					//this.editList.control.get();
				}
			}
			//this.editList;
		}
		if (!(this.behavior==null)) {
			this.listQueue=null;
			this.ilc=null;
			//this.behavior;
		}
		for (i.setValue(1);i.compareTo(this.processors.records())<=0;i.increment(1)) {
			this.processors.get(i);
			this.processors.p.get().takeClose();
		}
		//this.processors;
	}
	public ClarionNumber next()
	{
		ClarionNumber res=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		res.setValue(super.next());
		{
			ClarionNumber case_1=res;
			boolean case_1_break=false;
			if (case_1.equals(Level.NOTIFY)) {
				this.updateResets();
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Level.FATAL)) {
				CWin.post(Event.CLOSEWINDOW);
				case_1_break=true;
			}
		}
		return res.like();
	}
	public ClarionNumber notifyUpdateError()
	{
		this.primary.me._throw(Clarion.newNumber(Msg.ABORTREADING));
		return Clarion.newNumber(Constants.TRUE);
	}
	public void postNewSelection()
	{
		if (!this.prevChoice.equals(0) || !this.currentChoice.equals(0) || CWin.keyCode()==Constants.MOUSERIGHTUP) {
			this.prevChoice.setValue(this.currentChoice);
			this.ilc.setChoice(this.currentChoice.like());
			CWin.post(Event.NEWSELECTION,this.ilc.getControl().intValue());
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
				this.updateResets();
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Level.FATAL)) {
				CWin.post(Event.CLOSEWINDOW);
				case_1_break=true;
			}
		}
		return res.like();
	}
	public ClarionNumber records()
	{
		ClarionNumber rVal=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		rVal.setValue(this.listQueue.records().boolValue() ? 1 : 0);
		if (!(this.sort.locator.get()==null)) {
			this.sort.locator.get().setEnabled(rVal.like());
		}
		if (!rVal.boolValue()) {
			this.currentChoice.setValue(0);
		}
		return this.listQueue.records();
	}
	public void resetFields()
	{
		this.fields.kill();
		this.fields.init();
	}
	public void resetFromAsk(ClarionNumber request,ClarionNumber response)
	{
		if (response.equals(Constants.REQUESTCOMPLETED)) {
			this.view.flush();
			if (request.equals(Constants.DELETERECORD)) {
				this.listQueue.delete();
				this.resetQueue(Clarion.newNumber(Reset.QUEUE));
			}
			else {
				this.resetFromFile();
			}
		}
		else {
			this.resetQueue(Clarion.newNumber(Reset.QUEUE));
		}
		if (this.window.vCRRequest.equals(Vcr.INSERT) || this.window.vCRRequest.equals(Vcr.FORWARD) && request.equals(Constants.INSERTRECORD)) {
			request.setValue(Constants.INSERTRECORD);
			this.primary.me.file.get(Clarion.newString(String.valueOf(0)),null);
			this.primary.me.file.clear();
		}
		else {
			this.takeVCRScroll(this.window.vCRRequest.like());
		}
		if (this.window.vCRRequest.equals(Vcr.NONE)) {
			this.resetFromView();
			this.updateWindow();
			this.postNewSelection();
			CWin.select(this.ilc.getControl().intValue());
		}
	}
	public void resetFromBuffer()
	{
		if (this.sort.mainKey.get()==null) {
			this.reset(Clarion.newNumber(1));
		}
		else {
			this.reset(this.primary.me.getComponents(this.sort.mainKey.get()));
		}
		this.resetQueue(Clarion.newNumber(Reset.DONE));
		this.updateWindow();
	}
	public void resetFromFile()
	{
		this.view.reset(this.primary.me.file);
		CRun._assert(!(CError.errorCode()!=0));
		this.resetQueue(Clarion.newNumber(Reset.DONE));
	}
	public void resetFromView()
	{
		CWin.setCursor(Cursor.WAIT);
		this.resetThumbLimits();
		CWin.setCursor(null);
	}
	public void resetQueue(ClarionNumber refreshMode)
	{
		ClarionNumber highlightRequired=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber topMargin=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionString highlightedPosition=Clarion.newString(1024);
		ClarionNumber fromTop=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber eofHit=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (!this.activeInvisible.boolValue() && !this.ilc.getVisible().boolValue()) {
			this.loadPending.setValue(1);
			return;
		}
		this.loaded.setValue(1);
		this.loadPending.setValue(0);
		CWin.setCursor(Cursor.WAIT);
		if (!this.currentChoice.boolValue()) {
			this.currentChoice.setValue(1);
		}
		if (refreshMode.equals(Reset.DONE)) {
			if (this.retainRow.boolValue()) {
				topMargin.setValue(this.currentChoice.subtract(1));
			}
		}
		else {
			if (this.listQueue.records().boolValue()) {
				this.listQueue.fetch(this.currentChoice.like());
				if (CError.errorCode()!=0) {
					this.listQueue.fetch(this.listQueue.records());
				}
				highlightedPosition.setValue(this.listQueue.getViewPosition());
				this.listQueue.fetch(Clarion.newNumber(1));
				this.view.reset(this.listQueue.getViewPosition());
			}
			else {
				fromTop.setValue(1);
				this.reset();
			}
		}
		if (this.retainRow.boolValue()) {
			highlightRequired.setValue(this.currentChoice);
		}
		this.listQueue.free();
		this.itemsToFill.setValue(this.lastItems.subtract(topMargin));
		this.fetch(Clarion.newNumber(Constants.FILLFORWARD));
		eofHit.setValue(this.itemsToFill.boolValue() ? 1 : 0);
		if (!highlightedPosition.boolValue() && this.listQueue.records().boolValue()) {
			this.listQueue.fetch(Clarion.newNumber(1));
			highlightedPosition.setValue(this.listQueue.getViewPosition());
		}
		resetQueue_ResetCurrentChoice(highlightedPosition,topMargin,highlightRequired);
		if (!this.listQueue.records().boolValue()) {
			this.reset();
		}
		this.itemsToFill.setValue(this.allowUnfilled.equals(0) ? this.lastItems.subtract(this.listQueue.records()) : Clarion.newNumber(0));
		if (!fromTop.boolValue() && (this.itemsToFill.boolValue() || topMargin.compareTo(0)>0)) {
			this.itemsToFill.setValue(this.itemsToFill.compareTo(topMargin)>0 ? this.itemsToFill : topMargin);
			this.fetch(Clarion.newNumber(Constants.FILLBACKWARD));
			if (!highlightedPosition.boolValue() && this.listQueue.records().boolValue()) {
				this.listQueue.fetch(this.listQueue.records());
				highlightedPosition.setValue(this.listQueue.getViewPosition());
			}
			resetQueue_ResetCurrentChoice(highlightedPosition,topMargin,highlightRequired);
		}
		if (this.retainRow.boolValue() && (topMargin.compareTo(0)<0 || this.listQueue.records().compareTo(this.lastItems)<0 && !eofHit.boolValue())) {
			this.itemsToFill.setValue(topMargin.negate().compareTo(this.lastItems.subtract(this.listQueue.records()))>0 ? topMargin.negate() : this.lastItems.subtract(this.listQueue.records()));
			this.fetch(Clarion.newNumber(Constants.FILLFORWARD));
			resetQueue_ResetCurrentChoice(highlightedPosition,topMargin,highlightRequired);
		}
		while (this.listQueue.records().compareTo(this.lastItems)>0) {
			if (topMargin.compareTo(0)<0) {
				this.listQueue.fetch(Clarion.newNumber(1));
				this.listQueue.delete();
				topMargin.increment(1);
				this.currentChoice.decrement(1);
			}
			else {
				this.listQueue.fetch(this.listQueue.records());
				this.listQueue.delete();
			}
		}
		if (!this.currentChoice.boolValue()) {
			this.currentChoice.setValue(1);
		}
		if (this.records().boolValue()) {
			this.updateBuffer();
		}
		else {
			this.primary.me.file.clear();
		}
		CWin.setCursor(null);
	}
	public void resetQueue_ResetCurrentChoice(ClarionString highlightedPosition,ClarionNumber topMargin,ClarionNumber highlightRequired)
	{
		if (highlightedPosition.boolValue()) {
			for (this.currentChoice.setValue(1);this.currentChoice.compareTo(this.listQueue.records())<=0;this.currentChoice.increment(1)) {
				this.listQueue.fetch(this.currentChoice.like());
				if (this.listQueue.getViewPosition().equals(highlightedPosition)) break;
			}
			if (this.currentChoice.compareTo(this.listQueue.records())>0) {
				this.currentChoice.setValue(0);
			}
		}
		else {
			this.currentChoice.setValue(1);
		}
		if (this.retainRow.boolValue()) {
			topMargin.setValue(highlightRequired.subtract(this.currentChoice));
		}
	}
	public void resetResets()
	{
		this.sort.resets.get().assignLeftToRight();
	}
	public ClarionNumber resetSort(ClarionNumber force)
	{
		return this.setSort(Clarion.newNumber(this.sort.getPointer()),force.like());
	}
	public void resetThumbLimits()
	{
		ClarionAny highValue=Clarion.newAny();
		if (this.sort.thumb.get()==null || !this.sort.thumb.get().setLimitNeeded().boolValue() || !this.allowUnfilled.boolValue() && this.ilc.getItems().compareTo(this.listQueue.records())>0) {
			return;
		}
		this.reset();
		if (this.previous().boolValue()) {
			return;
		}
		highValue.setValue(this.sort.freeElement);
		this.reset();
		if (this.next().boolValue()) {
			return;
		}
		this.sort.thumb.get().setLimit(this.sort.freeElement.like(),highValue.like());
	}
	public void scrollEnd(ClarionNumber ev)
	{
		this.currentEvent.setValue(ev);
		if (!this.fileLoaded.boolValue()) {
			this.listQueue.free();
			this.reset();
			this.itemsToFill.setValue(this.ilc.getItems());
			this.fetch((ev.equals(Event.SCROLLTOP) ? Clarion.newNumber(Constants.FILLFORWARD) : Clarion.newNumber(Constants.FILLBACKWARD)).getNumber());
		}
		this.currentChoice.setValue(ev.equals(Event.SCROLLTOP) ? Clarion.newNumber(1) : this.listQueue.records());
	}
	public void scrollOne(ClarionNumber ev)
	{
		this.currentEvent.setValue(ev);
		if (ev.equals(Event.SCROLLUP) && this.currentChoice.compareTo(1)>0) {
			this.currentChoice.decrement(1);
		}
		else if (ev.equals(Event.SCROLLDOWN) && this.currentChoice.compareTo(this.listQueue.records())<0) {
			this.currentChoice.increment(1);
		}
		else if (!this.fileLoaded.boolValue()) {
			this.itemsToFill.setValue(1);
			this.fetch((ev.equals(Event.SCROLLUP) ? Clarion.newNumber(1) : Clarion.newNumber(2)).getNumber());
		}
	}
	public void scrollPage(ClarionNumber ev)
	{
		ClarionNumber li=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		this.currentEvent.setValue(ev);
		li.setValue(this.ilc.getItems());
		if (!this.fileLoaded.boolValue()) {
			this.itemsToFill.setValue(li);
			this.fetch((ev.equals(Event.PAGEUP) ? Clarion.newNumber(1) : Clarion.newNumber(2)).getNumber());
			li.setValue(this.itemsToFill);
		}
		if (ev.equals(Event.PAGEUP)) {
			this.currentChoice.decrement(li);
			if (this.currentChoice.compareTo(1)<0) {
				this.currentChoice.setValue(1);
			}
		}
		else {
			this.currentChoice.increment(li);
			if (this.currentChoice.compareTo(this.listQueue.records())>0) {
				this.currentChoice.setValue(this.listQueue.records());
			}
		}
	}
	public void setAlerts()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Clarion.getControl(this.ilc.getControl()).setProperty(Prop.ALRT,Constants.MOUSELEFT2INDEX,Constants.MOUSELEFT2);
		Clarion.getControl(this.ilc.getControl()).setProperty(Prop.ALRT,Constants.MOUSERIGHTINDEX,Constants.MOUSERIGHTUP);
		this.hasThumb.setValue(Clarion.getControl(this.ilc.getControl()).getProperty(Prop.VSCROLL).boolValue() ? 1 : 0);
		Clarion.getControl(this.ilc.getControl()).setProperty(Prop.VSCROLL,0);
		for (i.setValue(1);i.compareTo(this.sort.records())<=0;i.increment(1)) {
			this.sort.get(i);
			if (!(this.sort.locator.get()==null)) {
				this.sort.locator.get().setAlerts(this.ilc.getControl());
			}
		}
		if (this.insertControl.boolValue()) {
			Clarion.getControl(this.ilc.getControl()).setProperty(Prop.ALRT,255,Constants.INSERTKEY);
			this.popup.addItemMimic(Clarion.newString(Constants.DEFAULTINSERTNAME),this.insertControl.like(),Clarion.newString(ClarionString.staticConcat("!",Constants.DEFAULTINSERTNAME)));
		}
		if (this.changeControl.boolValue()) {
			Clarion.getControl(this.ilc.getControl()).setProperty(Prop.ALRT,253,Constants.CTRLENTER);
			this.popup.addItemMimic(Clarion.newString(Constants.DEFAULTCHANGENAME),this.changeControl.like(),Clarion.newString(ClarionString.staticConcat("!",Constants.DEFAULTCHANGENAME)));
		}
		if (this.deleteControl.boolValue()) {
			Clarion.getControl(this.ilc.getControl()).setProperty(Prop.ALRT,254,Constants.DELETEKEY);
			this.popup.addItemMimic(Clarion.newString(Constants.DEFAULTDELETENAME),this.deleteControl.like(),Clarion.newString(ClarionString.staticConcat("!",Constants.DEFAULTDELETENAME)));
		}
		if (this.viewControl.boolValue()) {
			Clarion.getControl(this.ilc.getControl()).setProperty(Prop.ALRT,255,Constants.SHIFTENTER);
			this.popup.addItemMimic(Clarion.newString(Constants.DEFAULTVIEWNAME),this.viewControl.like(),Clarion.newString(ClarionString.staticConcat("!",Constants.DEFAULTVIEWNAME)));
		}
		if (this.printControl.boolValue()) {
			this.popup.addItemMimic(Clarion.newString(Constants.DEFAULTPRINTNAME),this.printControl.like(),Clarion.newString(ClarionString.staticConcat("!",Constants.DEFAULTPRINTNAME)));
		}
		if (this.queryControl.boolValue()) {
			if (this.query.qkSupport.boolValue() && !(this.popup==null)) {
				this.query.setQuickPopup(this.popup,this.queryControl.like());
			}
			if (this.popup.getItems().boolValue()) {
				this.popup.addItem(Clarion.newString("-"),Clarion.newString("Separator2"),this.popup.getItems().getString(),Clarion.newNumber(1));
			}
			this.popup.addItemMimic(Clarion.newString(Constants.DEFAULTQUERYNAME),this.queryControl.like(),Clarion.newString(ClarionString.staticConcat("!",Constants.DEFAULTQUERYNAME)));
		}
		if (this.selectControl.boolValue() && this.selecting.boolValue()) {
			this.popup.addItemMimic(Clarion.newString(Constants.DEFAULTSELECTNAME),this.selectControl.like(),Clarion.newString(ClarionString.staticConcat("!",Constants.DEFAULTSELECTNAME)));
		}
		if (this.toolControl.boolValue()) {
			this.popup.addItem(Clarion.newString("-"));
			this.popup.setToolbox(this.popup.addItemMimic(Clarion.newString(Constants.DEFAULTTOOLNAME),this.toolControl.like(),Clarion.newString(ClarionString.staticConcat("!",Constants.DEFAULTTOOLNAME))),Clarion.newNumber(0));
		}
	}
	public void setQueueRecord()
	{
		this.fields.assignLeftToRight();
		this.listQueue.setViewPosition(this.view.getPosition());
	}
	public ClarionNumber setSort(ClarionNumber b,ClarionNumber force)
	{
		ClarionNumber rVal=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE);
		rVal.setValue(this.initSort(b.like()));
		if (this.applyRange().boolValue() || rVal.boolValue() || force.boolValue() || !this.loaded.boolValue() || this.loadPending.boolValue()) {
			this.resetResets();
			this.applyOrder();
			this.applyFilter();
			if ((this.selecting.boolValue() || this.startAtCurrent.boolValue()) && !this.loaded.boolValue()) {
				this.reset(this.getFreeElementPosition());
				this.resetQueue(Clarion.newNumber(Reset.DONE));
			}
			else if (this.listQueue.records().boolValue()) {
				this.view.reset(this.listQueue.getViewPosition());
				this.resetQueue(Clarion.newNumber(Reset.DONE));
			}
			else {
				this.resetQueue(Clarion.newNumber(Reset.QUEUE));
			}
			if (!this.loadPending.boolValue()) {
				this.postNewSelection();
				this.resetFromView();
				rVal.setValue(1);
			}
		}
		this.updateBuffer();
		return rVal.like();
	}
	public void takeAcceptedLocator()
	{
		if (!(this.sort.locator.get()==null) && Clarion.newNumber(CWin.accepted()).equals(this.sort.locator.get().control)) {
			if (this.sort.locator.get().takeAccepted().boolValue()) {
				this.reset(this.getFreeElementPosition());
				CWin.select(this.ilc.getControl().intValue());
				this.resetQueue(Clarion.newNumber(Reset.DONE));
				this.sort.locator.get().reset();
				this.updateWindow();
				this.postNewSelection();
			}
		}
	}
	public void takeChoiceChanged()
	{
		if (!(this.sort.locator.get()==null)) {
			this.sort.locator.get().set();
		}
		this.postNewSelection();
		if (this.sort.thumb.get()==null) {
			this.updateThumbFixed();
		}
		this.updateBuffer();
	}
	public void takeEvent()
	{
		ClarionNumber vsp=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		{
			int case_1=CWin.field();
			boolean case_1_break=false;
			if (case_1==0) {
				this.currentChoice.setValue(this.ilc.choice());
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.ilc.getControl())) {
				{
					int case_2=CWin.event();
					boolean case_2_break=false;
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
						case_2_break=true;
					}
					case_2_match=false;
					if (!case_2_break && case_2==Event.SCROLLDRAG) {
						vsp.setValue(Clarion.getControl(this.ilc.getControl()).getProperty(Prop.VSCROLLPOS));
						if (vsp.compareTo(1)<=0) {
							CWin.post(Event.SCROLLTOP,this.ilc.getControl().intValue());
						}
						else if (vsp.equals(100)) {
							CWin.post(Event.SCROLLBOTTOM,this.ilc.getControl().intValue());
						}
						else {
							if (!(this.sort.freeElement.getValue()==null) && !(this.sort.thumb.get()==null)) {
								this.sort.freeElement.setValue(this.sort.thumb.get().getValue(vsp.like()));
								this.resetFromBuffer();
							}
							else if (this.fileLoaded.boolValue()) {
								this.currentChoice.setValue(vsp.divide(100).multiply(this.listQueue.records()));
								this.takeChoiceChanged();
							}
							else if (vsp.compareTo(50)<0) {
								CWin.post(Event.PAGEUP,this.ilc.getControl().intValue());
							}
							else if (vsp.compareTo(50)>0) {
								CWin.post(Event.PAGEDOWN,this.ilc.getControl().intValue());
							}
						}
						case_2_break=true;
					}
					case_2_match=false;
					if (!case_2_break && case_2==Event.ALERTKEY) {
						this.takeKey();
						case_2_break=true;
					}
					case_2_match=false;
					if (!case_2_break && case_2==Event.NEWSELECTION) {
						this.takeNewSelection();
						case_2_break=true;
					}
					case_2_match=false;
					if (!case_2_break && case_2==Event.LOCATE) {
						this.takeLocate();
						case_2_break=true;
					}
				}
				case_1_break=true;
			}
		}
		if (this.queryControl.boolValue() && Clarion.newNumber(CWin.field()).equals(this.queryControl)) {
			if (CWin.event()==Event.NEWSELECTION) {
				CRun._assert(!(this.query==null));
				if (this.query.take(this.popup).boolValue()) {
					this.takeLocate();
				}
			}
		}
		this.needRefresh.setValue(Constants.FALSE);
		{
			int case_3=CWin.accepted();
			boolean case_3_break=false;
			if (case_3==0) {
				case_3_break=true;
			}
			if (!case_3_break && Clarion.newNumber(case_3).equals(this.deleteControl)) {
				this.window.update();
				if (!this.needRefresh.boolValue()) {
					this.ask(Clarion.newNumber(Constants.DELETERECORD));
				}
				case_3_break=true;
			}
			if (!case_3_break && Clarion.newNumber(case_3).equals(this.changeControl)) {
				this.window.update();
				if (!this.needRefresh.boolValue()) {
					this.ask(Clarion.newNumber(Constants.CHANGERECORD));
				}
				case_3_break=true;
			}
			if (!case_3_break && Clarion.newNumber(case_3).equals(this.insertControl)) {
				this.window.update();
				if (!this.needRefresh.boolValue()) {
					this.ask(Clarion.newNumber(Constants.INSERTRECORD));
				}
				case_3_break=true;
			}
			if (!case_3_break && Clarion.newNumber(case_3).equals(this.viewControl)) {
				this.window.update();
				if (!this.needRefresh.boolValue()) {
					this.ask(Clarion.newNumber(Constants.VIEWRECORD));
				}
				case_3_break=true;
			}
			if (!case_3_break && Clarion.newNumber(case_3).equals(this.selectControl)) {
				this.window.response.setValue(Constants.REQUESTCOMPLETED);
				CWin.post(Event.CLOSEWINDOW);
				case_3_break=true;
			}
			if (!case_3_break && Clarion.newNumber(case_3).equals(this.printControl)) {
				this.updateViewRecord();
				if (!this.needRefresh.boolValue()) {
					this.window.run(this.printProcedure.like(),Clarion.newNumber(Constants.PROCESSRECORD));
					this.updateBuffer();
				}
				case_3_break=true;
			}
			if (!case_3_break && Clarion.newNumber(case_3).equals(this.queryControl)) {
				this.query.qkCurrentQuery.clear();
				this.takeLocate();
				case_3_break=true;
			}
			if (!case_3_break && Clarion.newNumber(case_3).equals(this.toolControl)) {
				this.popup.toolbox(Clarion.newString("Browse Actions"));
				case_3_break=true;
			}
			if (!case_3_break) {
				this.takeAcceptedLocator();
			}
		}
		if (this.needRefresh.boolValue()) {
			this.resetQueue(Clarion.newNumber(Reset.DONE));
			this.needRefresh.setValue(Constants.FALSE);
		}
		else if (CWin.event()==Event.CLOSEWINDOW && this.selecting.boolValue()) {
			if (this.window.response.equals(Constants.REQUESTCOMPLETED)) {
				this.primary.me.restoreBuffer(this.buffer,Clarion.newNumber(0));
				if (this.selectWholeRecord.boolValue()) {
					this.updateViewRecord();
				}
				else {
					this.updateBuffer();
				}
			}
			else {
				this.primary.me.restoreBuffer(this.buffer);
			}
		}
	}
	public ClarionNumber takeKey()
	{
		if (CWin.keyCode()==Constants.MOUSERIGHTUP) {
			if (Clarion.getControl(this.ilc.getControl()).getProperty(Proplist.MOUSEDOWNROW).compareTo(0)>0) {
				this.currentChoice.setValue(Clarion.getControl(this.ilc.getControl()).getProperty(Proplist.MOUSEDOWNROW));
			}
			this.postNewSelection();
		}
		else {
			if (this.listQueue.records().boolValue()) {
				{
					int case_1=CWin.keyCode();
					boolean case_1_break=false;
					if (case_1==Constants.INSERTKEY) {
						try {
							takeKey_CheckInsert();
						} catch (ClarionRoutineResult _crr) {
							return (ClarionNumber)_crr.getResult();
						}
						case_1_break=true;
					}
					if (!case_1_break && case_1==Constants.DELETEKEY) {
						if (this.deleteControl.boolValue()) {
							CWin.post(Event.ACCEPTED,this.deleteControl.intValue());
							try {
								takeKey_HandledOut();
							} catch (ClarionRoutineResult _crr) {
								return (ClarionNumber)_crr.getResult();
							}
						}
						case_1_break=true;
					}
					if (!case_1_break && case_1==Constants.CTRLENTER) {
						try {
							takeKey_CheckChange();
						} catch (ClarionRoutineResult _crr) {
							return (ClarionNumber)_crr.getResult();
						}
						case_1_break=true;
					}
					if (!case_1_break && case_1==Constants.SHIFTENTER) {
						try {
							takeKey_CheckView();
						} catch (ClarionRoutineResult _crr) {
							return (ClarionNumber)_crr.getResult();
						}
						case_1_break=true;
					}
					if (!case_1_break && case_1==Constants.MOUSELEFT2) {
						if (this.selecting.boolValue()) {
							if (this.selectControl.boolValue()) {
								CWin.post(Event.ACCEPTED,this.selectControl.intValue());
								try {
									takeKey_HandledOut();
								} catch (ClarionRoutineResult _crr) {
									return (ClarionNumber)_crr.getResult();
								}
							}
						}
						else {
							try {
								takeKey_CheckChange();
							} catch (ClarionRoutineResult _crr) {
								return (ClarionNumber)_crr.getResult();
							}
						}
						case_1_break=true;
					}
					if (!case_1_break) {
						try {
							takeKey_CheckLocator();
						} catch (ClarionRoutineResult _crr) {
							return (ClarionNumber)_crr.getResult();
						}
					}
				}
			}
			else {
				try {
					takeKey_CheckLocator();
				} catch (ClarionRoutineResult _crr) {
					return (ClarionNumber)_crr.getResult();
				}
				try {
					takeKey_CheckInsert();
				} catch (ClarionRoutineResult _crr) {
					return (ClarionNumber)_crr.getResult();
				}
			}
		}
		return Clarion.newNumber(0);
	}
	public void takeKey_CheckChange() throws ClarionRoutineResult
	{
		if (this.changeControl.boolValue()) {
			CWin.post(Event.ACCEPTED,this.changeControl.intValue());
			this.updateBuffer();
			takeKey_HandledOut();
		}
	}
	public void takeKey_CheckInsert() throws ClarionRoutineResult
	{
		if (this.insertControl.boolValue() && CWin.keyCode()==Constants.INSERTKEY) {
			CWin.post(Event.ACCEPTED,this.insertControl.intValue());
			takeKey_HandledOut();
		}
	}
	public void takeKey_CheckLocator() throws ClarionRoutineResult
	{
		if (!(this.sort.locator.get()==null)) {
			if (this.sort.locator.get().takeKey().boolValue()) {
				this.reset(this.getFreeElementPosition());
				this.resetQueue(Clarion.newNumber(Reset.DONE));
				takeKey_HandledOut();
			}
			else {
				if (this.listQueue.records().boolValue()) {
					takeKey_HandledOut();
				}
			}
		}
	}
	public void takeKey_HandledOut() throws ClarionRoutineResult
	{
		this.updateWindow();
		this.postNewSelection();
		throw new ClarionRoutineResult(Clarion.newNumber(1));
	}
	public void takeKey_CheckView() throws ClarionRoutineResult
	{
		if (this.viewControl.boolValue()) {
			CWin.post(Event.ACCEPTED,this.viewControl.intValue());
			this.updateBuffer();
			takeKey_HandledOut();
		}
	}
	public void takeLocate()
	{
		ClarionNumber curSort=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		if (!(this.query==null)) {
			if (this.query.ask().boolValue()) {
				takeLocate_SS(curSort,i);
			}
			if (this.query.qkSupport.boolValue() && !(this.popup==null)) {
				this.query.setQuickPopup(this.popup,this.queryControl.like());
			}
		}
	}
	public void takeLocate_SS(ClarionNumber curSort,ClarionNumber i)
	{
		if (this.queryShared.boolValue()) {
			curSort.setValue(this.sort.getPointer());
			for (i.setValue(1);i.compareTo(this.sort.records())<=0;i.increment(1)) {
				super.setSort(i.like());
				takeLocate_SF();
			}
			super.setSort(curSort.like());
		}
		else {
			takeLocate_SF();
		}
		this.resetSort(Clarion.newNumber(1));
	}
	public void takeLocate_SF()
	{
		this.setFilter(this.query.getFilter(),Clarion.newString("9 - QBE"));
		if (this.queryResult.boolValue()) {
			Clarion.getControl(this.queryResult).setProperty(Prop.TEXT,this.query.getFilter());
		}
	}
	public void takeNewSelection()
	{
		if (this.listQueue.records().boolValue()) {
			this.currentChoice.setValue(this.ilc.choice());
			this.lastChoice.setValue(this.currentChoice);
		}
		this.updateBuffer();
		if (CWin.keyCode()==Constants.MOUSERIGHTUP) {
			this.popup.ask();
		}
		else {
			this.window.reset();
		}
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
		if (this.listQueue.records().boolValue()) {
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
			this.takeChoiceChanged();
		}
	}
	public void takeVCRScroll()
	{
		takeVCRScroll(Clarion.newNumber(0));
	}
	public void takeVCRScroll(ClarionNumber vcr)
	{
		{
			ClarionNumber case_1=vcr;
			boolean case_1_break=false;
			if (case_1.equals(Vcr.FORWARD)) {
				this.takeScroll(Clarion.newNumber(Event.SCROLLDOWN));
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Vcr.BACKWARD)) {
				this.takeScroll(Clarion.newNumber(Event.SCROLLUP));
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Vcr.PAGEFORWARD)) {
				this.takeScroll(Clarion.newNumber(Event.PAGEDOWN));
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Vcr.PAGEBACKWARD)) {
				this.takeScroll(Clarion.newNumber(Event.PAGEUP));
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Vcr.FIRST)) {
				this.takeScroll(Clarion.newNumber(Event.SCROLLTOP));
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Vcr.LAST)) {
				this.takeScroll(Clarion.newNumber(Event.SCROLLBOTTOM));
				case_1_break=true;
			}
			if (!case_1_break) {
				return;
			}
		}
		this.window.reset();
		this.window.update();
	}
	public void updateBuffer()
	{
		if (this.listQueue.records().boolValue()) {
			this.listQueue.fetch(this.currentChoice.like());
			this.fields.assignRightToLeft();
		}
		else {
			this.fields.clearLeft();
		}
	}
	public void updateQuery(Queryclass p0)
	{
		updateQuery(p0,Clarion.newNumber(1));
	}
	public void updateQuery(Queryclass qc,ClarionNumber caseless)
	{
		ClarionNumber i=Clarion.newNumber(1).setEncoding(ClarionNumber.USHORT);
		ClarionString fn=Clarion.newString(100).setEncoding(ClarionString.CSTRING);
		CRun._assert(this.query==null);
		this.query=qc;
		while (Clarion.getControl(this.ilc.getControl()).getProperty(Proplist.EXISTS,i).boolValue()) {
			fn.setValue(this.listQueue.who(Clarion.getControl(this.ilc.getControl()).getProperty(Proplist.FIELDNO,i).getNumber()));
			if (caseless.boolValue()) {
				fn.setValue(ClarionString.staticConcat("UPPER(",fn,")"));
			}
			if (fn.boolValue()) {
				qc.addItem(fn.like(),Clarion.getControl(this.ilc.getControl()).getProperty(Proplist.HEADER,i).getString(),Clarion.getControl(this.ilc.getControl()).getProperty(Proplist.PICTURE,i).getString());
			}
			i.increment(1);
		}
	}
	public void updateResets()
	{
		this.sort.resets.get().assignRightToLeft();
	}
	public void updateThumb()
	{
		if (this.hasThumb.boolValue() && (this.listQueue.records().compareTo(this.ilc.getItems())>=0 || this.allowUnfilled.boolValue())) {
			Clarion.getControl(this.ilc.getControl()).setProperty(Prop.VSCROLL,Constants.TRUE);
			if (this.sort.thumb.get()==null || this.sort.freeElement.getValue()==null) {
				this.updateThumbFixed();
			}
			else if (this.loaded.boolValue() && !this.loadPending.boolValue()) {
				this.updateBuffer();
				Clarion.getControl(this.ilc.getControl()).setProperty(Prop.VSCROLLPOS,this.sort.thumb.get().getPercentile(this.sort.freeElement.like()));
			}
		}
		else {
			Clarion.getControl(this.ilc.getControl()).setProperty(Prop.VSCROLL,Constants.FALSE);
		}
	}
	public void updateThumbFixed()
	{
		ClarionNumber pos=Clarion.newNumber(50).setEncoding(ClarionNumber.BYTE);
		if (this.fileLoaded.boolValue()) {
			pos.setValue(this.currentChoice.divide(this.listQueue.records()).multiply(100));
		}
		else {
			if (this.itemsToFill.boolValue()) {
				{
					ClarionNumber case_1=this.currentEvent;
					boolean case_1_break=false;
					boolean case_1_match=false;
					case_1_match=false;
					if (case_1.equals(Event.SCROLLDOWN)) {
						case_1_match=true;
					}
					if (case_1_match || case_1.equals(Event.PAGEDOWN)) {
						case_1_match=true;
					}
					if (case_1_match || case_1.equals(Event.SCROLLBOTTOM)) {
						if (this.currentChoice.equals(this.listQueue.records())) {
							pos.setValue(100);
						}
						case_1_break=true;
					}
					if (!case_1_break) {
						if (this.currentChoice.equals(1)) {
							pos.setValue(0);
						}
					}
				}
			}
		}
		Clarion.getControl(this.ilc.getControl()).setClonedProperty(Prop.VSCROLLPOS,pos);
	}
	public void updateToolbarButtons()
	{
		if (this.insertControl.boolValue()) {
			this.toolbarItem.insertButton.setValue(this.insertControl);
		}
		if (this.deleteControl.boolValue()) {
			this.toolbarItem.deleteButton.setValue(this.deleteControl);
		}
		if (this.changeControl.boolValue()) {
			this.toolbarItem.changeButton.setValue(this.changeControl);
		}
		if (this.selectControl.boolValue()) {
			this.toolbarItem.selectButton.setValue(this.selectControl);
		}
		if (this.queryControl.boolValue()) {
			this.toolbarItem.locateButton.setValue(this.queryControl);
		}
		this.toolbar.setTarget(this.ilc.getControl());
	}
	public void updateViewRecord()
	{
		if (this.listQueue.records().boolValue()) {
			this.currentChoice.setValue(this.ilc.choice());
			this.listQueue.fetch(this.currentChoice.like());
			this.view.watch();
			this.view.reget(this.listQueue.getViewPosition());
			if (CError.errorCode()!=0) {
				this.needRefresh.setValue(this.notifyUpdateError());
			}
		}
	}
	public void updateWindow()
	{
		if (!(this.sort.locator.get()==null)) {
			this.sort.locator.get().updateWindow();
		}
		if (this.records().boolValue()) {
			if (this.changeControl.boolValue()) {
				CWin.enable(this.changeControl.intValue());
			}
			if (this.deleteControl.boolValue()) {
				CWin.enable(this.deleteControl.intValue());
			}
			if (this.printControl.boolValue()) {
				CWin.enable(this.printControl.intValue());
			}
		}
		else {
			if (this.changeControl.boolValue()) {
				CWin.disable(this.changeControl.intValue());
			}
			if (this.deleteControl.boolValue()) {
				CWin.disable(this.deleteControl.intValue());
			}
			if (this.printControl.boolValue()) {
				CWin.disable(this.printControl.intValue());
			}
		}
		if (this.selectControl.boolValue()) {
			if (this.selecting.boolValue()) {
				if (this.records().boolValue() && this.window.request.equals(Constants.SELECTRECORD)) {
					CWin.enable(this.selectControl.intValue());
					Clarion.getControl(this.selectControl).setProperty(Prop.DEFAULT,1);
				}
				else {
					CWin.disable(this.selectControl.intValue());
				}
			}
			else if (this.hideSelect.boolValue()) {
				CWin.disable(this.selectControl.intValue());
				CWin.hide(this.selectControl.intValue());
			}
		}
		this.updateThumb();
		if (!(this.toolbar==null)) {
			this.toolbar.displayButtons();
		}
		CWin.display(this.ilc.getControl().intValue());
		this.ilc.setChoice(this.currentChoice.like());
	}
}
