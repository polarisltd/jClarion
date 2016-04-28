package clarion.abbrowse;

import clarion.Browseeditqueue;
import clarion.Browsequeue;
import clarion.Browsesortorder;
import clarion.Ilistcontrol;
import clarion.Processorqueue;
import clarion.Recordprocessor;
import clarion.Windowcomponent;
import clarion.abbrowse.Browseeipmanager;
import clarion.abbrowse.Locatorclass;
import clarion.abbrowse.Standardbehavior;
import clarion.abbrowse.Stepclass;
import clarion.abbrowse.equates.Mconstants;
import clarion.abeip.Editclass;
import clarion.abfile.Relationmanager;
import clarion.abfile.Viewmanager;
import clarion.abpopup.Popupclass;
import clarion.abquery.Queryclass_4;
import clarion.abtoolba.Toolbarclass;
import clarion.abtoolba.Toolbarlistboxclass;
import clarion.abutil.Fieldpairsclass;
import clarion.abwindow.Windowmanager;
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

@SuppressWarnings("all")
public class Browseclass extends Viewmanager
{
	public ClarionNumber activeinvisible=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber allowunfilled=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber arrowaction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber askprocedure=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public Standardbehavior behavior=null;
	public ClarionNumber buffer=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber changecontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber currentchoice=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber currentevent=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber deletecontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public Browseeipmanager eip=null;
	public Browseeditqueue editlist=null;
	public ClarionNumber enteraction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Fieldpairsclass fields=null;
	public ClarionNumber fileloaded=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber focuslossaction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber freeeip=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber hasthumb=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber hideselect=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Ilistcontrol ilc=null;
	public ClarionNumber insertcontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber itemstofill=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber lastchoice=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber lastitems=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public Browsequeue listqueue=null;
	public ClarionNumber loadpending=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber loaded=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber needrefresh=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Popupclass popup=null;
	public ClarionNumber prevchoice=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber printcontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber printprocedure=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public Processorqueue processors=null;
	public Queryclass_4 query=null;
	public ClarionNumber querycontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber queryresult=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber queryshared=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber quickscan=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber recordstatus=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber retainrow=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber selectcontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber selectwholerecord=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber selecting=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Browsesortorder sort=null;
	public ClarionNumber startatcurrent=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber tabaction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber toolcontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public Toolbarclass toolbar=null;
	public Toolbarlistboxclass toolbaritem=null;
	public ClarionNumber viewcontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public Windowmanager window=null;

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
			_owner.resetsort(force.like());
		}
		public ClarionNumber resetrequired()
		{
			return _owner.applyrange();
		}
		public void setalerts()
		{
			_owner.setalerts();
		}
		public ClarionNumber takeevent()
		{
			_owner.takeevent();
			return Clarion.newNumber(Level.BENIGN);
		}
		public void update()
		{
			_owner.updateviewrecord();
		}
		public void updatewindow()
		{
			_owner.updatewindow();
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
		activeinvisible=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		allowunfilled=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		arrowaction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		askprocedure=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		behavior=null;
		buffer=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		changecontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		currentchoice=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		currentevent=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		deletecontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		eip=null;
		editlist=null;
		enteraction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		fields=null;
		fileloaded=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		focuslossaction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		freeeip=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		hasthumb=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		hideselect=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ilc=null;
		insertcontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		itemstofill=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		lastchoice=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		lastitems=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		listqueue=null;
		loadpending=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		loaded=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		needrefresh=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		popup=null;
		prevchoice=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		printcontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		printprocedure=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		processors=null;
		query=null;
		querycontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		queryresult=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		queryshared=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		quickscan=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		recordstatus=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		retainrow=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		selectcontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		selectwholerecord=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		selecting=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		sort=null;
		startatcurrent=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		tabaction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		toolcontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		toolbar=null;
		toolbaritem=null;
		viewcontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		window=null;
	}

	public void addeditcontrol(Editclass p0,ClarionNumber p1)
	{
		addeditcontrol(p0,p1,Clarion.newNumber(0));
	}
	public void addeditcontrol(ClarionNumber p1)
	{
		addeditcontrol((Editclass)null,p1);
	}
	public void addeditcontrol(Editclass ec,ClarionNumber id,ClarionNumber free)
	{
		this.checkeip();
		this.eip.addcontrol(ec,id.like(),free.like());
	}
	public void addfield(ClarionObject fromfile,ClarionObject fromqueue)
	{
		this.fields.addpair(fromfile,fromqueue);
	}
	public void addfield(ClarionNumber fromfile,ClarionNumber fromqueue)
	{
		this.fields.addpair(fromfile,fromqueue);
	}
	public void addfield(ClarionString fromfile,ClarionString fromqueue)
	{
		this.fields.addpair(fromfile,fromqueue);
	}
	public void additem(Recordprocessor rp)
	{
		CRun._assert(!(this.processors==null),"Object not initialized");
		this.processors.p.set(rp);
		this.processors.add();
	}
	public void addlocator(Locatorclass l)
	{
		this.sort.locator.set(l);
		this.sort.put();
	}
	public void addresetfield(ClarionObject left)
	{
		CRun._assert(!(this.sort.resets.get()==null));
		this.sort.resets.get().additem(left);
	}
	public void addresetfield(ClarionString left)
	{
		CRun._assert(!(this.sort.resets.get()==null));
		this.sort.resets.get().additem(left);
	}
	public ClarionNumber addsortorder(Stepclass p0)
	{
		return addsortorder(p0,(ClarionKey)null);
	}
	public ClarionNumber addsortorder()
	{
		return addsortorder((Stepclass)null);
	}
	public ClarionNumber addsortorder(Stepclass th,ClarionKey k)
	{
		ClarionNumber snum=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.sort.clear();
		snum.setValue(super.addsortorder(k));
		this.sort.thumb.set(th);
		this.sort.resets.set(new Fieldpairsclass());
		this.sort.resets.get().init();
		this.sort.put();
		CRun._assert(!(CError.errorCode()!=0));
		return snum.like();
	}
	public void addtoolbartarget(Toolbarclass t)
	{
		this.toolbar=t;
		this.toolbaritem=new Toolbarlistboxclass();
		this.toolbaritem.browse=this;
		t.addtarget(this.toolbaritem,this.ilc.getcontrol());
		this.updatetoolbarbuttons();
	}
	public ClarionNumber applyrange()
	{
		ClarionNumber rval=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber li=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		li.setValue(this.ilc.getitems());
		if (!this.lastitems.equals(li) && li.compareTo(0)>=0) {
			if (this.fileloaded.boolValue()) {
				this.lastitems.clear(1);
			}
			else {
				this.lastitems.setValue(li);
				rval.setValue(1);
			}
		}
		if (rval.boolValue() || super.applyrange().boolValue() || !this.sort.resets.get().equal().boolValue()) {
			this.loadpending.setValue(1);
			rval.setValue(1);
		}
		return rval.like();
	}
	public ClarionNumber ask(ClarionNumber req)
	{
		ClarionNumber response=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		while (true) {
			this.window.vcrrequest.setValue(Vcr.NONE);
			if (CWin.keyCode()==Constants.MOUSERIGHTUP) {
				CWin.setKeyCode(0);
			}
			if (this.askprocedure.boolValue()) {
				if (req.equals(Constants.INSERTRECORD)) {
					if (this.primerecord().boolValue()) {
						return Clarion.newNumber(Constants.REQUESTCANCELLED);
					}
				}
				response.setValue(this.window.run(this.askprocedure.like(),req.like()));
				this.resetfromask(req,response);
			}
			else {
				response.setValue(this.askrecord(req.like()));
			}
			if (this.window.vcrrequest.equals(Vcr.NONE)) break;
		}
		return response.like();
	}
	public ClarionNumber askrecord(ClarionNumber req)
	{
		this.checkeip();
		return this.eip.run(req.like());
	}
	public void checkeip()
	{
		if (this.eip==null) {
			this.eip=new Browseeipmanager();
			this.freeeip.setValue(1);
		}
		this.eip.arrow=this.arrowaction;
		this.eip.bc=this;
		this.eip.enter=this.enteraction;
		this.eip.eq=this.editlist;
		this.eip.errors=this.window.errors;
		this.eip.fields=this.fields;
		this.eip.focusloss=this.focuslossaction;
		this.eip.listcontrol.setValue(this.ilc.getcontrol());
		this.eip.tab=this.tabaction;
		this.eip.vcrrequest=this.window.vcrrequest;
	}
	public void fetch(ClarionNumber direction)
	{
		ClarionNumber skipfirst=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE);
		if (this.quickscan.boolValue() && this.itemstofill.compareTo(1)>0) {
			this.primary.setquickscan(Clarion.newNumber(1));
		}
		if (this.listqueue.records().boolValue()) {
			this.listqueue.fetch((direction.equals(Constants.FILLFORWARD) ? this.listqueue.records() : Clarion.newNumber(1)).getNumber());
			this.view.reset(this.listqueue.getviewposition());
			skipfirst.setValue(1);
		}
		while (this.itemstofill.boolValue()) {
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
			if (skipfirst.boolValue()) {
				skipfirst.setValue(Constants.FALSE);
				if (this.view.getPosition().equals(this.listqueue.getviewposition())) {
					continue;
				}
			}
			if (this.listqueue.records().equals(this.lastitems)) {
				this.listqueue.fetch((direction.equals(Constants.FILLFORWARD) ? Clarion.newNumber(1) : this.listqueue.records()).getNumber());
				this.listqueue.delete();
			}
			this.setqueuerecord();
			if (direction.equals(Constants.FILLFORWARD)) {
				this.listqueue.insert();
			}
			else {
				this.listqueue.insert(Clarion.newNumber(1));
			}
			this.itemstofill.decrement(1);
		}
		if (this.quickscan.boolValue()) {
			this.primary.setquickscan(Clarion.newNumber(0));
		}
	}
	public void init(ClarionNumber listbox,ClarionString posit,ClarionView v,ClarionQueue q,Relationmanager f,Windowmanager wm)
	{
		this.behavior=new Standardbehavior();
		this.behavior.init(q,posit,listbox.like());
		this.init(this.behavior.ilistcontrol(),v,this.behavior.browsequeue(),f,wm);
	}
	public void init(Ilistcontrol li,ClarionView v,Browsequeue lq,Relationmanager f,Windowmanager wm)
	{
		this.prevchoice.setValue(0);
		this.window=wm;
		this.listqueue=lq;
		this.ilc=li;
		this.sort=new Browsesortorder();
		this.fields=new Fieldpairsclass();
		this.fields.init();
		this.processors=new Processorqueue();
		this.popup=new Popupclass();
		this.editlist=new Browseeditqueue();
		this.retainrow.setValue(1);
		CRun._assert(!(this.popup==null));
		this.popup.init();
		super.init(v,f,this.sort);
		this.window.additem(this);
		if (this.selecting.boolValue()) {
			this.primary.me.usefile(Clarion.newNumber(Usetype.RETURNS));
			this.buffer.setValue(this.primary.me.savebuffer());
		}
	}
	public ClarionNumber initsort(ClarionNumber b)
	{
		ClarionNumber rval=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE);
		if (this.setsort(b.like()).boolValue()) {
			if (!(this.sort.locator.get()==null)) {
				this.sort.locator.get().set();
			}
			rval.setValue(1);
		}
		return rval.like();
	}
	public void kill()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		if (!(this.sort==null)) {
			final int loop_1=this.sort.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
				this.sort.get(i);
				if (!(this.sort.thumb.get()==null)) {
					this.sort.thumb.get().kill();
				}
				this.sort.resets.get().kill();
				//this.sort.resets.get();
			}
		}
		this.window.removeitem(this.windowcomponent());
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
		//this.toolbaritem;
		if (!(this.query==null)) {
			this.query.kill();
		}
		if (this.freeeip.boolValue()) {
			//this.eip;
			this.freeeip.setValue(0);
		}
		if (!(this.editlist==null)) {
			final int loop_2=this.editlist.records();for (i.setValue(1);i.compareTo(loop_2)<=0;i.increment(1)) {
				this.editlist.get(i);
				if (this.editlist.freeup.boolValue()) {
					//this.editlist.control.get();
				}
			}
			//this.editlist;
		}
		if (!(this.behavior==null)) {
			this.listqueue=null;
			this.ilc=null;
			//this.behavior;
		}
		final int loop_3=this.processors.records();for (i.setValue(1);i.compareTo(loop_3)<=0;i.increment(1)) {
			this.processors.get(i);
			this.processors.p.get().takeclose();
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
				this.updateresets();
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Level.FATAL)) {
				CWin.post(Event.CLOSEWINDOW);
				case_1_break=true;
			}
		}
		return res.like();
	}
	public ClarionNumber notifyupdateerror()
	{
		this.primary.me._throw(Clarion.newNumber(Msg.ABORTREADING));
		return Clarion.newNumber(Constants.TRUE);
	}
	public void postnewselection()
	{
		if (!this.prevchoice.equals(0) || !this.currentchoice.equals(0) || CWin.keyCode()==Constants.MOUSERIGHTUP) {
			this.prevchoice.setValue(this.currentchoice);
			this.ilc.setchoice(this.currentchoice.like());
			CWin.post(Event.NEWSELECTION,this.ilc.getcontrol().intValue());
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
				this.updateresets();
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
		ClarionNumber rval=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		rval.setValue(this.listqueue.records().boolValue() ? 1 : 0);
		if (!(this.sort.locator.get()==null)) {
			this.sort.locator.get().setenabled(rval.like());
		}
		if (!rval.boolValue()) {
			this.currentchoice.setValue(0);
		}
		return this.listqueue.records();
	}
	public void resetfields()
	{
		this.fields.kill();
		this.fields.init();
	}
	public void resetfromask(ClarionNumber request,ClarionNumber response)
	{
		if (response.equals(Constants.REQUESTCOMPLETED)) {
			this.view.flush();
			if (request.equals(Constants.DELETERECORD)) {
				this.listqueue.delete();
				this.resetqueue(Clarion.newNumber(Reset.QUEUE));
			}
			else {
				this.resetfromfile();
			}
		}
		else {
			this.resetqueue(Clarion.newNumber(Reset.QUEUE));
		}
		if (this.window.vcrrequest.equals(Vcr.INSERT) || this.window.vcrrequest.equals(Vcr.FORWARD) && request.equals(Constants.INSERTRECORD)) {
			request.setValue(Constants.INSERTRECORD);
			this.primary.me.file.get(Clarion.newString(String.valueOf(0)),null);
			this.primary.me.file.clear();
		}
		else {
			this.takevcrscroll(this.window.vcrrequest.like());
		}
		if (this.window.vcrrequest.equals(Vcr.NONE)) {
			this.resetfromview();
			this.updatewindow();
			this.postnewselection();
			CWin.select(this.ilc.getcontrol().intValue());
		}
	}
	public void resetfrombuffer()
	{
		if (this.sort.mainkey.get()==null) {
			this.reset(Clarion.newNumber(1));
		}
		else {
			this.reset(this.primary.me.getcomponents(this.sort.mainkey.get()));
		}
		this.resetqueue(Clarion.newNumber(Reset.DONE));
		this.updatewindow();
	}
	public void resetfromfile()
	{
		this.view.reset(this.primary.me.file);
		CRun._assert(!(CError.errorCode()!=0));
		this.resetqueue(Clarion.newNumber(Reset.DONE));
	}
	public void resetfromview()
	{
		CWin.setCursor(Cursor.WAIT);
		this.resetthumblimits();
		CWin.setCursor(null);
	}
	public void resetqueue(ClarionNumber refreshmode)
	{
		ClarionNumber highlightrequired=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber topmargin=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionString highlightedposition=Clarion.newString(1024);
		ClarionNumber fromtop=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber eofhit=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (!this.activeinvisible.boolValue() && !this.ilc.getvisible().boolValue()) {
			this.loadpending.setValue(1);
			return;
		}
		this.loaded.setValue(1);
		this.loadpending.setValue(0);
		CWin.setCursor(Cursor.WAIT);
		if (!this.currentchoice.boolValue()) {
			this.currentchoice.setValue(1);
		}
		if (refreshmode.equals(Reset.DONE)) {
			if (this.retainrow.boolValue()) {
				topmargin.setValue(this.currentchoice.subtract(1));
			}
		}
		else {
			if (this.listqueue.records().boolValue()) {
				this.listqueue.fetch(this.currentchoice.like());
				if (CError.errorCode()!=0) {
					this.listqueue.fetch(this.listqueue.records());
				}
				highlightedposition.setValue(this.listqueue.getviewposition());
				this.listqueue.fetch(Clarion.newNumber(1));
				this.view.reset(this.listqueue.getviewposition());
			}
			else {
				fromtop.setValue(1);
				this.reset();
			}
		}
		if (this.retainrow.boolValue()) {
			highlightrequired.setValue(this.currentchoice);
		}
		this.listqueue.free();
		this.itemstofill.setValue(this.lastitems.subtract(topmargin));
		this.fetch(Clarion.newNumber(Constants.FILLFORWARD));
		eofhit.setValue(this.itemstofill.boolValue() ? 1 : 0);
		if (!highlightedposition.boolValue() && this.listqueue.records().boolValue()) {
			this.listqueue.fetch(Clarion.newNumber(1));
			highlightedposition.setValue(this.listqueue.getviewposition());
		}
		resetqueue_resetcurrentchoice(highlightedposition,topmargin,highlightrequired);
		if (!this.listqueue.records().boolValue()) {
			this.reset();
		}
		this.itemstofill.setValue(this.allowunfilled.equals(0) ? this.lastitems.subtract(this.listqueue.records()) : Clarion.newNumber(0));
		if (!fromtop.boolValue() && (this.itemstofill.boolValue() || topmargin.compareTo(0)>0)) {
			this.itemstofill.setValue(this.itemstofill.compareTo(topmargin)>0 ? this.itemstofill : topmargin);
			this.fetch(Clarion.newNumber(Constants.FILLBACKWARD));
			if (!highlightedposition.boolValue() && this.listqueue.records().boolValue()) {
				this.listqueue.fetch(this.listqueue.records());
				highlightedposition.setValue(this.listqueue.getviewposition());
			}
			resetqueue_resetcurrentchoice(highlightedposition,topmargin,highlightrequired);
		}
		if (this.retainrow.boolValue() && (topmargin.compareTo(0)<0 || this.listqueue.records().compareTo(this.lastitems)<0 && !eofhit.boolValue())) {
			this.itemstofill.setValue(topmargin.negate().compareTo(this.lastitems.subtract(this.listqueue.records()))>0 ? topmargin.negate() : this.lastitems.subtract(this.listqueue.records()));
			this.fetch(Clarion.newNumber(Constants.FILLFORWARD));
			resetqueue_resetcurrentchoice(highlightedposition,topmargin,highlightrequired);
		}
		while (this.listqueue.records().compareTo(this.lastitems)>0) {
			if (topmargin.compareTo(0)<0) {
				this.listqueue.fetch(Clarion.newNumber(1));
				this.listqueue.delete();
				topmargin.increment(1);
				this.currentchoice.decrement(1);
			}
			else {
				this.listqueue.fetch(this.listqueue.records());
				this.listqueue.delete();
			}
		}
		if (!this.currentchoice.boolValue()) {
			this.currentchoice.setValue(1);
		}
		if (this.records().boolValue()) {
			this.updatebuffer();
		}
		else {
			this.primary.me.file.clear();
		}
		CWin.setCursor(null);
	}
	public void resetqueue_resetcurrentchoice(ClarionString highlightedposition,ClarionNumber topmargin,ClarionNumber highlightrequired)
	{
		if (highlightedposition.boolValue()) {
			final ClarionNumber loop_1=this.listqueue.records();for (this.currentchoice.setValue(1);this.currentchoice.compareTo(loop_1)<=0;this.currentchoice.increment(1)) {
				this.listqueue.fetch(this.currentchoice.like());
				if (this.listqueue.getviewposition().equals(highlightedposition)) break;
			}
			if (this.currentchoice.compareTo(this.listqueue.records())>0) {
				this.currentchoice.setValue(0);
			}
		}
		else {
			this.currentchoice.setValue(1);
		}
		if (this.retainrow.boolValue()) {
			topmargin.setValue(highlightrequired.subtract(this.currentchoice));
		}
	}
	public void resetresets()
	{
		this.sort.resets.get().assignlefttoright();
	}
	public ClarionNumber resetsort(ClarionNumber force)
	{
		return this.setsort(Clarion.newNumber(this.sort.getPointer()),force.like());
	}
	public void resetthumblimits()
	{
		ClarionAny highvalue=Clarion.newAny();
		if (this.sort.thumb.get()==null || !this.sort.thumb.get().setlimitneeded().boolValue() || !this.allowunfilled.boolValue() && this.ilc.getitems().compareTo(this.listqueue.records())>0) {
			return;
		}
		this.reset();
		if (this.previous().boolValue()) {
			return;
		}
		highvalue.setValue(this.sort.freeelement);
		this.reset();
		if (this.next().boolValue()) {
			return;
		}
		this.sort.thumb.get().setlimit(this.sort.freeelement.like(),highvalue.like());
	}
	public void scrollend(ClarionNumber ev)
	{
		this.currentevent.setValue(ev);
		if (!this.fileloaded.boolValue()) {
			this.listqueue.free();
			this.reset();
			this.itemstofill.setValue(this.ilc.getitems());
			this.fetch((ev.equals(Event.SCROLLTOP) ? Clarion.newNumber(Constants.FILLFORWARD) : Clarion.newNumber(Constants.FILLBACKWARD)).getNumber());
		}
		this.currentchoice.setValue(ev.equals(Event.SCROLLTOP) ? Clarion.newNumber(1) : this.listqueue.records());
	}
	public void scrollone(ClarionNumber ev)
	{
		this.currentevent.setValue(ev);
		if (ev.equals(Event.SCROLLUP) && this.currentchoice.compareTo(1)>0) {
			this.currentchoice.decrement(1);
		}
		else if (ev.equals(Event.SCROLLDOWN) && this.currentchoice.compareTo(this.listqueue.records())<0) {
			this.currentchoice.increment(1);
		}
		else if (!this.fileloaded.boolValue()) {
			this.itemstofill.setValue(1);
			this.fetch((ev.equals(Event.SCROLLUP) ? Clarion.newNumber(1) : Clarion.newNumber(2)).getNumber());
		}
	}
	public void scrollpage(ClarionNumber ev)
	{
		ClarionNumber li=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		this.currentevent.setValue(ev);
		li.setValue(this.ilc.getitems());
		if (!this.fileloaded.boolValue()) {
			this.itemstofill.setValue(li);
			this.fetch((ev.equals(Event.PAGEUP) ? Clarion.newNumber(1) : Clarion.newNumber(2)).getNumber());
			li.setValue(this.itemstofill);
		}
		if (ev.equals(Event.PAGEUP)) {
			this.currentchoice.decrement(li);
			if (this.currentchoice.compareTo(1)<0) {
				this.currentchoice.setValue(1);
			}
		}
		else {
			this.currentchoice.increment(li);
			if (this.currentchoice.compareTo(this.listqueue.records())>0) {
				this.currentchoice.setValue(this.listqueue.records());
			}
		}
	}
	public void setalerts()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		Clarion.getControl(this.ilc.getcontrol()).setProperty(Prop.ALRT,Constants.MOUSELEFT2INDEX,Constants.MOUSELEFT2);
		Clarion.getControl(this.ilc.getcontrol()).setProperty(Prop.ALRT,Mconstants.MOUSERIGHTINDEX,Constants.MOUSERIGHTUP);
		this.hasthumb.setValue(Clarion.getControl(this.ilc.getcontrol()).getProperty(Prop.VSCROLL).boolValue() ? 1 : 0);
		Clarion.getControl(this.ilc.getcontrol()).setProperty(Prop.VSCROLL,0);
		final int loop_1=this.sort.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.sort.get(i);
			if (!(this.sort.locator.get()==null)) {
				this.sort.locator.get().setalerts(this.ilc.getcontrol());
			}
		}
		if (this.insertcontrol.boolValue()) {
			Clarion.getControl(this.ilc.getcontrol()).setProperty(Prop.ALRT,255,Constants.INSERTKEY);
			this.popup.additemmimic(Clarion.newString(Mconstants.DEFAULTINSERTNAME),this.insertcontrol.like(),Clarion.newString(ClarionString.staticConcat("!",Mconstants.DEFAULTINSERTNAME)));
		}
		if (this.changecontrol.boolValue()) {
			Clarion.getControl(this.ilc.getcontrol()).setProperty(Prop.ALRT,253,Constants.CTRLENTER);
			this.popup.additemmimic(Clarion.newString(Mconstants.DEFAULTCHANGENAME),this.changecontrol.like(),Clarion.newString(ClarionString.staticConcat("!",Mconstants.DEFAULTCHANGENAME)));
		}
		if (this.deletecontrol.boolValue()) {
			Clarion.getControl(this.ilc.getcontrol()).setProperty(Prop.ALRT,254,Constants.DELETEKEY);
			this.popup.additemmimic(Clarion.newString(Mconstants.DEFAULTDELETENAME),this.deletecontrol.like(),Clarion.newString(ClarionString.staticConcat("!",Mconstants.DEFAULTDELETENAME)));
		}
		if (this.viewcontrol.boolValue()) {
			Clarion.getControl(this.ilc.getcontrol()).setProperty(Prop.ALRT,255,Constants.SHIFTENTER);
			this.popup.additemmimic(Clarion.newString(Mconstants.DEFAULTVIEWNAME),this.viewcontrol.like(),Clarion.newString(ClarionString.staticConcat("!",Mconstants.DEFAULTVIEWNAME)));
		}
		if (this.printcontrol.boolValue()) {
			this.popup.additemmimic(Clarion.newString(Mconstants.DEFAULTPRINTNAME),this.printcontrol.like(),Clarion.newString(ClarionString.staticConcat("!",Mconstants.DEFAULTPRINTNAME)));
		}
		if (this.querycontrol.boolValue()) {
			if (this.query.qksupport.boolValue() && !(this.popup==null)) {
				this.query.setquickpopup(this.popup,this.querycontrol.like());
			}
			if (this.popup.getitems().boolValue()) {
				this.popup.additem(Clarion.newString("-"),Clarion.newString("Separator2"),this.popup.getitems().getString(),Clarion.newNumber(1));
			}
			this.popup.additemmimic(Clarion.newString(Mconstants.DEFAULTQUERYNAME),this.querycontrol.like(),Clarion.newString(ClarionString.staticConcat("!",Mconstants.DEFAULTQUERYNAME)));
		}
		if (this.selectcontrol.boolValue() && this.selecting.boolValue()) {
			this.popup.additemmimic(Clarion.newString(Mconstants.DEFAULTSELECTNAME),this.selectcontrol.like(),Clarion.newString(ClarionString.staticConcat("!",Mconstants.DEFAULTSELECTNAME)));
		}
		if (this.toolcontrol.boolValue()) {
			this.popup.additem(Clarion.newString("-"));
			this.popup.settoolbox(this.popup.additemmimic(Clarion.newString(Mconstants.DEFAULTTOOLNAME),this.toolcontrol.like(),Clarion.newString(ClarionString.staticConcat("!",Mconstants.DEFAULTTOOLNAME))),Clarion.newNumber(0));
		}
	}
	public void setqueuerecord()
	{
		this.fields.assignlefttoright();
		this.listqueue.setviewposition(this.view.getPosition());
	}
	public ClarionNumber setsort(ClarionNumber b,ClarionNumber force)
	{
		ClarionNumber rval=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE);
		rval.setValue(this.initsort(b.like()));
		if (this.applyrange().boolValue() || rval.boolValue() || force.boolValue() || !this.loaded.boolValue() || this.loadpending.boolValue()) {
			this.resetresets();
			this.applyorder();
			this.applyfilter();
			if ((this.selecting.boolValue() || this.startatcurrent.boolValue()) && !this.loaded.boolValue()) {
				this.reset(this.getfreeelementposition());
				this.resetqueue(Clarion.newNumber(Reset.DONE));
			}
			else if (this.listqueue.records().boolValue()) {
				this.view.reset(this.listqueue.getviewposition());
				this.resetqueue(Clarion.newNumber(Reset.DONE));
			}
			else {
				this.resetqueue(Clarion.newNumber(Reset.QUEUE));
			}
			if (!this.loadpending.boolValue()) {
				this.postnewselection();
				this.resetfromview();
				rval.setValue(1);
			}
		}
		this.updatebuffer();
		return rval.like();
	}
	public void takeacceptedlocator()
	{
		if (!(this.sort.locator.get()==null) && Clarion.newNumber(CWin.accepted()).equals(this.sort.locator.get().control)) {
			if (this.sort.locator.get().takeaccepted().boolValue()) {
				this.reset(this.getfreeelementposition());
				CWin.select(this.ilc.getcontrol().intValue());
				this.resetqueue(Clarion.newNumber(Reset.DONE));
				this.sort.locator.get().reset();
				this.updatewindow();
				this.postnewselection();
			}
		}
	}
	public void takechoicechanged()
	{
		if (!(this.sort.locator.get()==null)) {
			this.sort.locator.get().set();
		}
		this.postnewselection();
		if (this.sort.thumb.get()==null) {
			this.updatethumbfixed();
		}
		this.updatebuffer();
	}
	public void takeevent()
	{
		ClarionNumber vsp=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		{
			int case_1=CWin.field();
			boolean case_1_break=false;
			if (case_1==0) {
				this.currentchoice.setValue(this.ilc.choice());
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.ilc.getcontrol())) {
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
						this.takescroll();
						case_2_break=true;
					}
					case_2_match=false;
					if (!case_2_break && case_2==Event.SCROLLDRAG) {
						vsp.setValue(Clarion.getControl(this.ilc.getcontrol()).getProperty(Prop.VSCROLLPOS));
						if (vsp.compareTo(1)<=0) {
							CWin.post(Event.SCROLLTOP,this.ilc.getcontrol().intValue());
						}
						else if (vsp.equals(100)) {
							CWin.post(Event.SCROLLBOTTOM,this.ilc.getcontrol().intValue());
						}
						else {
							if (!(this.sort.freeelement.getValue()==null) && !(this.sort.thumb.get()==null)) {
								this.sort.freeelement.setValue(this.sort.thumb.get().getvalue(vsp.like()));
								this.resetfrombuffer();
							}
							else if (this.fileloaded.boolValue()) {
								this.currentchoice.setValue(vsp.divide(100).multiply(this.listqueue.records()));
								this.takechoicechanged();
							}
							else if (vsp.compareTo(50)<0) {
								CWin.post(Event.PAGEUP,this.ilc.getcontrol().intValue());
							}
							else if (vsp.compareTo(50)>0) {
								CWin.post(Event.PAGEDOWN,this.ilc.getcontrol().intValue());
							}
						}
						case_2_break=true;
					}
					case_2_match=false;
					if (!case_2_break && case_2==Event.ALERTKEY) {
						this.takekey();
						case_2_break=true;
					}
					case_2_match=false;
					if (!case_2_break && case_2==Event.NEWSELECTION) {
						this.takenewselection();
						case_2_break=true;
					}
					case_2_match=false;
					if (!case_2_break && case_2==Event.LOCATE) {
						this.takelocate();
						case_2_break=true;
					}
				}
				case_1_break=true;
			}
		}
		if (this.querycontrol.boolValue() && Clarion.newNumber(CWin.field()).equals(this.querycontrol)) {
			if (CWin.event()==Event.NEWSELECTION) {
				CRun._assert(!(this.query==null));
				if (this.query.take(this.popup).boolValue()) {
					this.takelocate();
				}
			}
		}
		this.needrefresh.setValue(Constants.FALSE);
		{
			int case_3=CWin.accepted();
			boolean case_3_break=false;
			if (case_3==0) {
				case_3_break=true;
			}
			if (!case_3_break && Clarion.newNumber(case_3).equals(this.deletecontrol)) {
				this.window.update();
				if (!this.needrefresh.boolValue()) {
					this.ask(Clarion.newNumber(Constants.DELETERECORD));
				}
				case_3_break=true;
			}
			if (!case_3_break && Clarion.newNumber(case_3).equals(this.changecontrol)) {
				this.window.update();
				if (!this.needrefresh.boolValue()) {
					this.ask(Clarion.newNumber(Constants.CHANGERECORD));
				}
				case_3_break=true;
			}
			if (!case_3_break && Clarion.newNumber(case_3).equals(this.insertcontrol)) {
				this.window.update();
				if (!this.needrefresh.boolValue()) {
					this.ask(Clarion.newNumber(Constants.INSERTRECORD));
				}
				case_3_break=true;
			}
			if (!case_3_break && Clarion.newNumber(case_3).equals(this.viewcontrol)) {
				this.window.update();
				if (!this.needrefresh.boolValue()) {
					this.ask(Clarion.newNumber(Constants.VIEWRECORD));
				}
				case_3_break=true;
			}
			if (!case_3_break && Clarion.newNumber(case_3).equals(this.selectcontrol)) {
				this.window.response.setValue(Constants.REQUESTCOMPLETED);
				CWin.post(Event.CLOSEWINDOW);
				case_3_break=true;
			}
			if (!case_3_break && Clarion.newNumber(case_3).equals(this.printcontrol)) {
				this.updateviewrecord();
				if (!this.needrefresh.boolValue()) {
					this.window.run(this.printprocedure.like(),Clarion.newNumber(Constants.PROCESSRECORD));
					this.updatebuffer();
				}
				case_3_break=true;
			}
			if (!case_3_break && Clarion.newNumber(case_3).equals(this.querycontrol)) {
				this.query.qkcurrentquery.clear();
				this.takelocate();
				case_3_break=true;
			}
			if (!case_3_break && Clarion.newNumber(case_3).equals(this.toolcontrol)) {
				this.popup.toolbox(Clarion.newString("Browse Actions"));
				case_3_break=true;
			}
			if (!case_3_break) {
				this.takeacceptedlocator();
			}
		}
		if (this.needrefresh.boolValue()) {
			this.resetqueue(Clarion.newNumber(Reset.DONE));
			this.needrefresh.setValue(Constants.FALSE);
		}
		else if (CWin.event()==Event.CLOSEWINDOW && this.selecting.boolValue()) {
			if (this.window.response.equals(Constants.REQUESTCOMPLETED)) {
				this.primary.me.restorebuffer(this.buffer,Clarion.newNumber(0));
				if (this.selectwholerecord.boolValue()) {
					this.updateviewrecord();
				}
				else {
					this.updatebuffer();
				}
			}
			else {
				this.primary.me.restorebuffer(this.buffer);
			}
		}
	}
	public ClarionNumber takekey()
	{
		if (CWin.keyCode()==Constants.MOUSERIGHTUP) {
			if (Clarion.getControl(this.ilc.getcontrol()).getProperty(Proplist.MOUSEDOWNROW).compareTo(0)>0) {
				this.currentchoice.setValue(Clarion.getControl(this.ilc.getcontrol()).getProperty(Proplist.MOUSEDOWNROW));
			}
			this.postnewselection();
		}
		else {
			if (this.listqueue.records().boolValue()) {
				{
					int case_1=CWin.keyCode();
					boolean case_1_break=false;
					if (case_1==Constants.INSERTKEY) {
						try {
							takekey_checkinsert();
						} catch (ClarionRoutineResult _crr) {
							return (ClarionNumber)_crr.getResult();
						}
						case_1_break=true;
					}
					if (!case_1_break && case_1==Constants.DELETEKEY) {
						if (this.deletecontrol.boolValue()) {
							CWin.post(Event.ACCEPTED,this.deletecontrol.intValue());
							try {
								takekey_handledout();
							} catch (ClarionRoutineResult _crr) {
								return (ClarionNumber)_crr.getResult();
							}
						}
						case_1_break=true;
					}
					if (!case_1_break && case_1==Constants.CTRLENTER) {
						try {
							takekey_checkchange();
						} catch (ClarionRoutineResult _crr) {
							return (ClarionNumber)_crr.getResult();
						}
						case_1_break=true;
					}
					if (!case_1_break && case_1==Constants.SHIFTENTER) {
						try {
							takekey_checkview();
						} catch (ClarionRoutineResult _crr) {
							return (ClarionNumber)_crr.getResult();
						}
						case_1_break=true;
					}
					if (!case_1_break && case_1==Constants.MOUSELEFT2) {
						if (this.selecting.boolValue()) {
							if (this.selectcontrol.boolValue()) {
								CWin.post(Event.ACCEPTED,this.selectcontrol.intValue());
								try {
									takekey_handledout();
								} catch (ClarionRoutineResult _crr) {
									return (ClarionNumber)_crr.getResult();
								}
							}
						}
						else {
							try {
								takekey_checkchange();
							} catch (ClarionRoutineResult _crr) {
								return (ClarionNumber)_crr.getResult();
							}
						}
						case_1_break=true;
					}
					if (!case_1_break) {
						try {
							takekey_checklocator();
						} catch (ClarionRoutineResult _crr) {
							return (ClarionNumber)_crr.getResult();
						}
					}
				}
			}
			else {
				try {
					takekey_checklocator();
				} catch (ClarionRoutineResult _crr) {
					return (ClarionNumber)_crr.getResult();
				}
				try {
					takekey_checkinsert();
				} catch (ClarionRoutineResult _crr) {
					return (ClarionNumber)_crr.getResult();
				}
			}
		}
		return Clarion.newNumber(0);
	}
	public void takekey_checkchange() throws ClarionRoutineResult
	{
		if (this.changecontrol.boolValue()) {
			CWin.post(Event.ACCEPTED,this.changecontrol.intValue());
			this.updatebuffer();
			takekey_handledout();
		}
	}
	public void takekey_checkinsert() throws ClarionRoutineResult
	{
		if (this.insertcontrol.boolValue() && CWin.keyCode()==Constants.INSERTKEY) {
			CWin.post(Event.ACCEPTED,this.insertcontrol.intValue());
			takekey_handledout();
		}
	}
	public void takekey_checklocator() throws ClarionRoutineResult
	{
		if (!(this.sort.locator.get()==null)) {
			if (this.sort.locator.get().takekey().boolValue()) {
				this.reset(this.getfreeelementposition());
				this.resetqueue(Clarion.newNumber(Reset.DONE));
				takekey_handledout();
			}
			else {
				if (this.listqueue.records().boolValue()) {
					takekey_handledout();
				}
			}
		}
	}
	public void takekey_handledout() throws ClarionRoutineResult
	{
		this.updatewindow();
		this.postnewselection();
		throw new ClarionRoutineResult(Clarion.newNumber(1));
	}
	public void takekey_checkview() throws ClarionRoutineResult
	{
		if (this.viewcontrol.boolValue()) {
			CWin.post(Event.ACCEPTED,this.viewcontrol.intValue());
			this.updatebuffer();
			takekey_handledout();
		}
	}
	public void takelocate()
	{
		ClarionNumber cursort=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		if (!(this.query==null)) {
			if (this.query.ask().boolValue()) {
				takelocate_ss(cursort,i);
			}
			if (this.query.qksupport.boolValue() && !(this.popup==null)) {
				this.query.setquickpopup(this.popup,this.querycontrol.like());
			}
		}
	}
	public void takelocate_ss(ClarionNumber cursort,ClarionNumber i)
	{
		if (this.queryshared.boolValue()) {
			cursort.setValue(this.sort.getPointer());
			final int loop_1=this.sort.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
				super.setsort(i.like());
				takelocate_sf();
			}
			super.setsort(cursort.like());
		}
		else {
			takelocate_sf();
		}
		this.resetsort(Clarion.newNumber(1));
	}
	public void takelocate_sf()
	{
		this.setfilter(this.query.getfilter(),Clarion.newString("9 - QBE"));
		if (this.queryresult.boolValue()) {
			Clarion.getControl(this.queryresult).setProperty(Prop.TEXT,this.query.getfilter());
		}
	}
	public void takenewselection()
	{
		if (this.listqueue.records().boolValue()) {
			this.currentchoice.setValue(this.ilc.choice());
			this.lastchoice.setValue(this.currentchoice);
		}
		this.updatebuffer();
		if (CWin.keyCode()==Constants.MOUSERIGHTUP) {
			this.popup.ask();
		}
		else {
			this.window.reset();
		}
	}
	public void takescroll()
	{
		takescroll(Clarion.newNumber(0));
	}
	public void takescroll(ClarionNumber e)
	{
		if (!e.boolValue()) {
			e.setValue(CWin.event());
		}
		if (this.listqueue.records().boolValue()) {
			{
				ClarionNumber case_1=e;
				boolean case_1_break=false;
				boolean case_1_match=false;
				case_1_match=false;
				if (case_1.equals(Event.SCROLLUP)) {
					case_1_match=true;
				}
				if (case_1_match || case_1.equals(Event.SCROLLDOWN)) {
					this.scrollone(e.like());
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1.equals(Event.PAGEUP)) {
					case_1_match=true;
				}
				if (case_1_match || case_1.equals(Event.PAGEDOWN)) {
					this.scrollpage(e.like());
					case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1.equals(Event.SCROLLTOP)) {
					case_1_match=true;
				}
				if (case_1_match || case_1.equals(Event.SCROLLBOTTOM)) {
					this.scrollend(e.like());
					case_1_break=true;
				}
			}
			this.takechoicechanged();
		}
	}
	public void takevcrscroll()
	{
		takevcrscroll(Clarion.newNumber(0));
	}
	public void takevcrscroll(ClarionNumber vcr)
	{
		{
			ClarionNumber case_1=vcr;
			boolean case_1_break=false;
			if (case_1.equals(Vcr.FORWARD)) {
				this.takescroll(Clarion.newNumber(Event.SCROLLDOWN));
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Vcr.BACKWARD)) {
				this.takescroll(Clarion.newNumber(Event.SCROLLUP));
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Vcr.PAGEFORWARD)) {
				this.takescroll(Clarion.newNumber(Event.PAGEDOWN));
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Vcr.PAGEBACKWARD)) {
				this.takescroll(Clarion.newNumber(Event.PAGEUP));
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Vcr.FIRST)) {
				this.takescroll(Clarion.newNumber(Event.SCROLLTOP));
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Vcr.LAST)) {
				this.takescroll(Clarion.newNumber(Event.SCROLLBOTTOM));
				case_1_break=true;
			}
			if (!case_1_break) {
				return;
			}
		}
		this.window.reset();
		this.window.update();
	}
	public void updatebuffer()
	{
		if (this.listqueue.records().boolValue()) {
			this.listqueue.fetch(this.currentchoice.like());
			this.fields.assignrighttoleft();
		}
		else {
			this.fields.clearleft();
		}
	}
	//public void updatequery(Queryclass_4 p0) // %%%%% this method should be in child class e.g. Brw1
	//public void updatequery(Queryclass_4 qc,ClarionNumber caseless) // %%%%% this method should be in child class e.g. Brw1
	
	public void updateresets()
	{
		this.sort.resets.get().assignrighttoleft();
	}
	public void updatethumb()
	{
		if (this.hasthumb.boolValue() && (this.listqueue.records().compareTo(this.ilc.getitems())>=0 || this.allowunfilled.boolValue())) {
			Clarion.getControl(this.ilc.getcontrol()).setProperty(Prop.VSCROLL,Constants.TRUE);
			if (this.sort.thumb.get()==null || this.sort.freeelement.getValue()==null) {
				this.updatethumbfixed();
			}
			else if (this.loaded.boolValue() && !this.loadpending.boolValue()) {
				this.updatebuffer();
				Clarion.getControl(this.ilc.getcontrol()).setProperty(Prop.VSCROLLPOS,this.sort.thumb.get().getpercentile(this.sort.freeelement.like()));
			}
		}
		else {
			Clarion.getControl(this.ilc.getcontrol()).setProperty(Prop.VSCROLL,Constants.FALSE);
		}
	}
	public void updatethumbfixed()
	{
		ClarionNumber pos=Clarion.newNumber(50).setEncoding(ClarionNumber.BYTE);
		if (this.fileloaded.boolValue()) {
			pos.setValue(this.currentchoice.divide(this.listqueue.records()).multiply(100));
		}
		else {
			if (this.itemstofill.boolValue()) {
				{
					ClarionNumber case_1=this.currentevent;
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
						if (this.currentchoice.equals(this.listqueue.records())) {
							pos.setValue(100);
						}
						case_1_break=true;
					}
					if (!case_1_break) {
						if (this.currentchoice.equals(1)) {
							pos.setValue(0);
						}
					}
				}
			}
		}
		Clarion.getControl(this.ilc.getcontrol()).setClonedProperty(Prop.VSCROLLPOS,pos);
	}
	public void updatetoolbarbuttons()
	{
		if (this.insertcontrol.boolValue()) {
			this.toolbaritem.insertbutton.setValue(this.insertcontrol);
		}
		if (this.deletecontrol.boolValue()) {
			this.toolbaritem.deletebutton.setValue(this.deletecontrol);
		}
		if (this.changecontrol.boolValue()) {
			this.toolbaritem.changebutton.setValue(this.changecontrol);
		}
		if (this.selectcontrol.boolValue()) {
			this.toolbaritem.selectbutton.setValue(this.selectcontrol);
		}
		if (this.querycontrol.boolValue()) {
			this.toolbaritem.locatebutton.setValue(this.querycontrol);
		}
		this.toolbar.settarget(this.ilc.getcontrol());
	}
	public void updateviewrecord()
	{
		if (this.listqueue.records().boolValue()) {
			this.currentchoice.setValue(this.ilc.choice());
			this.listqueue.fetch(this.currentchoice.like());
			this.view.watch();
			this.view.reget(this.listqueue.getviewposition());
			if (CError.errorCode()!=0) {
				this.needrefresh.setValue(this.notifyupdateerror());
			}
		}
	}
	public void updatewindow()
	{
		if (!(this.sort.locator.get()==null)) {
			this.sort.locator.get().updatewindow();
		}
		if (this.records().boolValue()) {
			if (this.changecontrol.boolValue()) {
				CWin.enable(this.changecontrol.intValue());
			}
			if (this.deletecontrol.boolValue()) {
				CWin.enable(this.deletecontrol.intValue());
			}
			if (this.printcontrol.boolValue()) {
				CWin.enable(this.printcontrol.intValue());
			}
		}
		else {
			if (this.changecontrol.boolValue()) {
				CWin.disable(this.changecontrol.intValue());
			}
			if (this.deletecontrol.boolValue()) {
				CWin.disable(this.deletecontrol.intValue());
			}
			if (this.printcontrol.boolValue()) {
				CWin.disable(this.printcontrol.intValue());
			}
		}
		if (this.selectcontrol.boolValue()) {
			if (this.selecting.boolValue()) {
				if (this.records().boolValue() && this.window.request.equals(Constants.SELECTRECORD)) {
					CWin.enable(this.selectcontrol.intValue());
					Clarion.getControl(this.selectcontrol).setProperty(Prop.DEFAULT,1);
				}
				else {
					CWin.disable(this.selectcontrol.intValue());
				}
			}
			else if (this.hideselect.boolValue()) {
				CWin.disable(this.selectcontrol.intValue());
				CWin.hide(this.selectcontrol.intValue());
			}
		}
		this.updatethumb();
		if (!(this.toolbar==null)) {
			this.toolbar.displaybuttons();
		}
		CWin.display(this.ilc.getcontrol().intValue());
		this.ilc.setchoice(this.currentchoice.like());
	}
}
