package clarion.abwindow;

import clarion.Windowcomponent;
import clarion.abbrowse.Browseclass;
import clarion.aberror.Errorclass;
import clarion.abfile.Filemanager;
import clarion.abfile.Relationmanager;
import clarion.abresize.Windowresizeclass;
import clarion.abtoolba.Toolbarclass;
import clarion.abtoolba.Toolbarupdateclass;
import clarion.abutil.Translatorclass;
import clarion.abwindow.Buttonlist;
import clarion.abwindow.Componentlist;
import clarion.abwindow.Filelist;
import clarion.abwindow.Historylist;
import clarion.equates.Button;
import clarion.equates.Cancel;
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
import org.jclarion.clarion.ClarionGroup;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionRoutineResult;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CExpression;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Windowmanager
{
	public ClarionNumber autorefresh=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber autotoolbar=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Buttonlist buttons=null;
	public Componentlist cl=null;
	public ClarionNumber cancelaction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber changeaction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber dead=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber deleteaction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Errorclass errors=null;
	public Filelist files=null;
	public ClarionNumber filesopened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber firstfield=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber forcedreset=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Historylist history=null;
	public ClarionNumber historykey=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber inited=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber insertaction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString lastinsertedposition=Clarion.newString(1024);
	public ClarionNumber okcontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber opened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber originalrequest=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Relationmanager primary=null;
	public ClarionNumber request=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber resetongainfocus=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Windowresizeclass resize=null;
	public ClarionNumber response=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber saved=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public Toolbarclass toolbar=null;
	public Translatorclass translator=null;
	public ClarionNumber vcrrequest=null;
	public Windowmanager()
	{
		autorefresh=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		autotoolbar=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		buttons=null;
		cl=null;
		cancelaction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		changeaction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		dead=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		deleteaction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		errors=null;
		files=null;
		filesopened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		firstfield=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		forcedreset=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		history=null;
		historykey=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		inited=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		insertaction=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		lastinsertedposition=Clarion.newString(1024);
		okcontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		opened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		originalrequest=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		primary=null;
		request=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		resetongainfocus=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		resize=null;
		response=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		saved=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		toolbar=null;
		translator=null;
		vcrrequest=null;
	}

	public void addhistoryfield(ClarionNumber control,ClarionNumber field)
	{
		this.history.control.setValue(control);
		this.history.fieldno.setValue(field);
		this.history.add(this.history.ORDER().ascend(this.history.control));
	}
	public void addhistoryfile(ClarionGroup fb,ClarionGroup sb)
	{
		if (this.history==null) {
			this.history=new Historylist();
		}
		this.history.frecord.set(fb);
		this.history.srecord.set(sb);
	}
	public void additem(Browseclass bc)
	{
		this.additem(bc.windowcomponent());
		if (this.request.equals(Constants.SELECTRECORD)) {
			bc.selecting.setValue(1);
		}
	}
	public void additem(ClarionNumber control,ClarionNumber action)
	{
		CRun._assert(!(this.buttons==null));
		this.buttons.control.setValue(control);
		this.buttons.action.setValue(action);
		this.buttons.add();
	}
	public void additem(Toolbarclass tc)
	{
		this.toolbar=tc;
		tc.init();
	}
	public void additem(Toolbarupdateclass tf)
	{
		CRun._assert(!(this.toolbar==null));
		if (this.historykey.boolValue()) {
			tf.history.setValue(1);
		}
		tf.request.setValue(this.originalrequest);
		tf.displaybuttons();
		this.toolbar.addtarget(tf,Clarion.newNumber(-1));
		this.toolbar.settarget(Clarion.newNumber(-1));
	}
	public void additem(Translatorclass t)
	{
		this.translator=t;
	}
	public void additem(Windowcomponent wc)
	{
		CRun._assert(!(this.cl==null));
		this.cl.wc.set(wc);
		this.cl.add();
		CRun._assert(!(CError.errorCode()!=0));
	}
	public void additem(Windowresizeclass rc)
	{
		this.resize=rc;
	}
	public void addupdatefile(Filemanager fm)
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
		this.lastinsertedposition.clear();
		while (Clarion.getWindowTarget().accept()) {
			{
				ClarionNumber case_1=this.takeevent();
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
	public void removeitem(Windowcomponent wc)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		final int loop_1=this.cl.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.cl.get(i);
			if (this.cl.wc.get()==wc) {
				this.cl.delete();
			}
		}
	}
	public ClarionNumber init()
	{
		this.originalrequest.setValue(this.request);
		this.cl=new Componentlist();
		this.buttons=new Buttonlist();
		CExpression.pushBind(1!=0);
		if (CWin.keyCode()==Constants.MOUSERIGHT || CWin.keyCode()==Constants.MOUSERIGHTUP) {
			CWin.setKeyCode(0);
		}
		this.insertaction.setValue(Insert.CALLER);
		this.deleteaction.setValue(Delete.WARN);
		this.changeaction.setValue(1);
		this.cancelaction.setValue(Cancel.SAVE+Cancel.QUERY);
		this.autotoolbar.setValue(1);
		this.autorefresh.setValue(1);
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
		//this.history;
		if (!(this.files==null)) {
			final int loop_1=this.files.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
				this.files.get(i);
				this.files.manager.get().restorebuffer(this.files.saved,Clarion.newNumber(0));
			}
		}
		//this.files;
		if (!(this.primary==null)) {
			this.primary.me.restorebuffer(this.saved,Clarion.newNumber(0));
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
			this.translator.translatewindow();
		}
		this.reset();
		this.inited.setValue(this.inited.intValue() | 1);
	}
	public void postcompleted()
	{
		if (this.originalrequest.equals(Constants.CHANGERECORD) || this.originalrequest.equals(Constants.INSERTRECORD)) {
			CWin.select();
		}
		else {
			CWin.post(Event.COMPLETED);
		}
	}
	public void primefields()
	{
	}
	public ClarionNumber primeupdate()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber rval=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		CRun._assert(!(this.primary==null));
		this.primary.me.usefile(Clarion.newNumber(Usetype.RETURNS));
		this.primary.save();
		if (!(this.files==null)) {
			final int loop_1=this.files.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
				this.files.get(i);
				this.files.saved.setValue(this.files.manager.get().savebuffer());
				this.files.put();
			}
		}
		{
			ClarionNumber case_1=this.request;
			boolean case_1_break=false;
			if (case_1.equals(Constants.INSERTRECORD)) {
				if (this.insertaction.boolValue()) {
					this.response.setValue(Constants.REQUESTCOMPLETED);
					this.primefields();
					if (this.response.equals(Constants.REQUESTCANCELLED)) {
						rval.setValue(Level.FATAL);
					}
					else {
						this.response.setValue(Constants.REQUESTCANCELLED);
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.DELETERECORD)) {
				{
					ClarionNumber case_2=this.deleteaction;
					boolean case_2_match=false;
					case_2_match=false;
					if (case_2.equals(Delete.WARN)) {
						case_2_match=true;
					}
					if (case_2_match || case_2.equals(Delete.AUTO)) {
						this.response.setValue(this.primary.delete(Clarion.newNumber(this.deleteaction.equals(Delete.WARN) ? 1 : 0)));
						this.response.setValue(this.response.equals(Level.BENIGN) ? Clarion.newNumber(Constants.REQUESTCOMPLETED) : Clarion.newNumber(Constants.REQUESTCANCELLED));
						rval.setValue(Level.FATAL);
					}
				}
				case_1_break=true;
			}
		}
		this.saved.setValue(this.primary.me.savebuffer());
		return rval.like();
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
		force.increment(this.forcedreset);
		this.forcedreset.setValue(0);
		this.resetbuffers(force.like());
		final int loop_1=this.cl.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.cl.get(i);
			this.cl.wc.get().updatewindow();
		}
		CWin.display();
	}
	public void resetbuffers()
	{
		resetbuffers(Clarion.newNumber(0));
	}
	public void resetbuffers(ClarionNumber force)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		final int loop_1=this.cl.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.cl.get(i);
			this.cl.wc.get().reset(force.like());
		}
	}
	public void restorefield(ClarionNumber control)
	{
		ClarionAny left=Clarion.newAny();
		if (!(this.history==null)) {
			this.history.control.setValue(control);
			this.history.get(this.history.ORDER().ascend(this.history.control));
			if (!(CError.errorCode()!=0)) {
				left.setReferenceValue(this.history.frecord.get().what(this.history.fieldno.intValue()));
				left.setValue(this.history.srecord.get().what(this.history.fieldno.intValue()));
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
	public void savehistory()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionGroup rem=null;
		if (!(this.history==null)) {
			final int loop_1=this.history.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
				this.history.get(i);
				if (!(this.history.frecord.get()==rem)) {
					this.history.srecord.get().setValue(this.history.frecord.get().getString());
					rem=this.history.frecord.get();
				}
			}
		}
	}
	public void setalerts()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		final int loop_1=this.cl.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.cl.get(i);
			this.cl.wc.get().setalerts();
		}
		if (!(this.history==null)) {
			final int loop_2=this.history.records();for (i.setValue(1);i.compareTo(loop_2)<=0;i.increment(1)) {
				this.history.get(i);
				Clarion.getControl(this.history.control).setClonedProperty(Prop.ALRT,255,this.historykey);
			}
		}
	}
	public void setresponse(ClarionNumber response)
	{
		this.response.setValue(response);
		CWin.post(Event.CLOSEWINDOW);
		if (response.equals(Constants.REQUESTCANCELLED) && !(this.toolbar==null)) {
			this.vcrrequest.setValue(Vcr.NONE);
		}
	}
	public ClarionNumber takeaccepted()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber a=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		a.setValue(CWin.accepted());
		if (!(this.toolbar==null)) {
			this.toolbar.takeevent(this.vcrrequest,this);
			if (a.equals(Toolbar.HISTORY)) {
				this.restorefield(Clarion.newNumber(CWin.focus()));
			}
		}
		final int loop_1=this.buttons.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.buttons.get(i);
			if (this.buttons.control.equals(a)) {
				this.setresponse(this.buttons.action.like());
				return Clarion.newNumber(Level.NOTIFY);
			}
		}
		if (this.okcontrol.boolValue() && this.okcontrol.equals(a)) {
			this.postcompleted();
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber takecompleted()
	{
		this.savehistory();
		{
			ClarionNumber case_1=this.request;
			boolean case_1_break=false;
			if (case_1.equals(Constants.INSERTRECORD)) {
				try {
					takecompleted_insertaction();
				} catch (ClarionRoutineResult _crr) {
					return (ClarionNumber)_crr.getResult();
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.CHANGERECORD)) {
				takecompleted_changeaction();
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.DELETERECORD)) {
				takecompleted_deleteaction();
				case_1_break=true;
			}
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public void takecompleted_changeaction()
	{
		ClarionNumber unchanged=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber error=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		while (true) {
			this.response.setValue(Constants.REQUESTCANCELLED);
			CWin.setCursor(Cursor.WAIT);
			unchanged.setValue(this.primary.me.equalbuffer(this.saved));
			if (unchanged.boolValue()) {
				error.setValue(0);
			}
			else {
				error.setValue(this.primary.update(Clarion.newNumber(this.historykey.boolValue() ? 1 : 0)));
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
							CWin.post(Event.CLOSEWINDOW);
							break;
							// UNREACHABLE! :case_1_break=true;
						}
					}
				}
				CWin.display();
				CWin.select(this.firstfield.intValue());
			}
			else {
				if (!unchanged.boolValue() || !(this.toolbar==null) && this.vcrrequest.equals(Vcr.NONE)) {
					this.response.setValue(Constants.REQUESTCOMPLETED);
				}
				CWin.post(Event.CLOSEWINDOW);
			}
			if (1!=0) break;
		}
	}
	public void takecompleted_deleteaction()
	{
		while (true) {
			this.response.setValue(Constants.REQUESTCANCELLED);
			CWin.setCursor(Cursor.WAIT);
			if (this.primary.delete(Clarion.newNumber(this.deleteaction.equals(Delete.WARN) ? 1 : 0)).boolValue()) {
				CWin.setCursor(null);
				{
					ClarionNumber case_1=this.errors.message(Clarion.newNumber(Msg.RETRYDELETE),Clarion.newNumber(Button.YES+Button.NO+Button.CANCEL),Clarion.newNumber(Button.CANCEL));
					boolean case_1_break=false;
					if (case_1.equals(Button.YES)) {
						continue;
						// UNREACHABLE! :case_1_break=true;
					}
					if (!case_1_break && case_1.equals(Button.NO)) {
						CWin.post(Event.CLOSEWINDOW);
						break;
						// UNREACHABLE! :case_1_break=true;
					}
					if (!case_1_break && case_1.equals(Button.CANCEL)) {
						CWin.display();
						CWin.select(this.firstfield.intValue());
						break;
						// UNREACHABLE! :case_1_break=true;
					}
				}
			}
			else {
				CWin.setCursor(null);
				this.setresponse(Clarion.newNumber(Constants.REQUESTCOMPLETED));
				break;
			}
			if (0!=0) break;
		}
	}
	public void takecompleted_insertaction() throws ClarionRoutineResult
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		if (this.primary.me.insert().equals(Level.BENIGN)) {
			{
				ClarionNumber case_1=this.insertaction;
				boolean case_1_break=false;
				boolean case_1_match=false;
				case_1_match=false;
				if (case_1.equals(Insert.CALLER)) {
					this.setresponse(Clarion.newNumber(Constants.REQUESTCOMPLETED));
					throw new ClarionRoutineResult(Clarion.newNumber(Level.BENIGN));
					// UNREACHABLE! :case_1_break=true;
				}
				case_1_match=false;
				if (!case_1_break && case_1.equals(Insert.QUERY)) {
					if (!this.errors._throw(Clarion.newNumber(Msg.ADDANOTHER)).equals(Level.BENIGN)) {
						this.setresponse(Clarion.newNumber(Constants.REQUESTCOMPLETED));
						throw new ClarionRoutineResult(Clarion.newNumber(Level.BENIGN));
					}
					case_1_match=true;
				}
				if (case_1_match || case_1.equals(Insert.BATCH)) {
					this.lastinsertedposition.setValue(this.primary.me.position());
					if (!(this.files==null)) {
						final int loop_1=this.files.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
							this.files.get(i);
							this.files.manager.get().restorebuffer(this.files.saved);
							this.files.saved.setValue(this.files.manager.get().savebuffer());
							this.files.put();
						}
					}
					this.primary.me.restorebuffer(this.saved);
					this.primary.me.usefile(Clarion.newNumber(Usetype.RETURNS));
					if (this.primary.me.primeautoinc().boolValue()) {
						CWin.post(Event.CLOSEWINDOW);
					}
					else {
						this.primefields();
						this.response.setValue(Constants.REQUESTCANCELLED);
					}
					this.saved.setValue(this.primary.me.savebuffer());
					CWin.display();
					CWin.select(this.firstfield.intValue());
					throw new ClarionRoutineResult(Clarion.newNumber(Level.NOTIFY));
					// UNREACHABLE! :case_1_break=true;
				}
			}
		}
		else {
			CWin.select(this.firstfield.intValue());
			throw new ClarionRoutineResult(Clarion.newNumber(Level.NOTIFY));
		}
	}
	public ClarionNumber takecloseevent()
	{
		if (!this.response.equals(Constants.REQUESTCOMPLETED) && !(this.primary==null)) {
			if (!this.cancelaction.equals(Cancel.CANCEL) && (this.request.equals(Constants.INSERTRECORD) || this.request.equals(Constants.CHANGERECORD))) {
				if (!this.primary.me.equalbuffer(this.saved).boolValue()) {
					if ((this.cancelaction.intValue() & Cancel.SAVE)!=0) {
						if ((this.cancelaction.intValue() & Cancel.QUERY)!=0) {
							{
								ClarionNumber case_1=this.errors.message(Clarion.newNumber(Msg.SAVERECORD),Clarion.newNumber(Button.YES+Button.NO+Button.CANCEL),Clarion.newNumber(Button.CANCEL));
								boolean case_1_break=false;
								if (case_1.equals(Button.YES)) {
									CWin.post(Event.ACCEPTED,this.okcontrol.intValue());
									return Clarion.newNumber(Level.NOTIFY);
									// UNREACHABLE! :case_1_break=true;
								}
								if (!case_1_break && case_1.equals(Button.CANCEL)) {
									CWin.select(this.firstfield.intValue());
									return Clarion.newNumber(Level.NOTIFY);
									// UNREACHABLE! :case_1_break=true;
								}
							}
						}
						else {
							CWin.post(Event.ACCEPTED,this.okcontrol.intValue());
							return Clarion.newNumber(Level.NOTIFY);
						}
					}
					else {
						if (this.errors._throw(Clarion.newNumber(Msg.CONFIRMCANCEL)).equals(Level.CANCEL)) {
							CWin.select(this.firstfield.intValue());
							return Clarion.newNumber(Level.NOTIFY);
						}
					}
				}
			}
			if (this.originalrequest.equals(Constants.INSERTRECORD) && this.response.equals(Constants.REQUESTCANCELLED)) {
				if (this.primary.cancelautoinc().boolValue()) {
					CWin.select(this.firstfield.intValue());
					return Clarion.newNumber(Level.NOTIFY);
				}
			}
			if (this.lastinsertedposition.boolValue()) {
				this.response.setValue(Constants.REQUESTCOMPLETED);
				this.primary.me.tryreget(this.lastinsertedposition.like());
			}
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber takeevent()
	{
		ClarionNumber rval=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		if (!(CWin.field()!=0)) {
			rval.setValue(this.takewindowevent());
			if (rval.boolValue()) {
				return rval.like();
			}
		}
		{
			int case_1=CWin.event();
			boolean case_1_break=false;
			if (case_1==Event.ACCEPTED) {
				rval.setValue(this.takeaccepted());
				case_1_break=true;
			}
			if (!case_1_break && case_1==Event.REJECTED) {
				rval.setValue(this.takerejected());
				case_1_break=true;
			}
			if (!case_1_break && case_1==Event.SELECTED) {
				rval.setValue(this.takeselected());
				case_1_break=true;
			}
			if (!case_1_break && case_1==Event.NEWSELECTION) {
				rval.setValue(this.takenewselection());
				case_1_break=true;
			}
			if (!case_1_break && case_1==Event.ALERTKEY) {
				if (this.historykey.boolValue() && Clarion.newNumber(CWin.keyCode()).equals(this.historykey)) {
					this.restorefield(Clarion.newNumber(CWin.focus()));
				}
				case_1_break=true;
			}
		}
		if (rval.boolValue()) {
			return rval.like();
		}
		if (CWin.field()!=0) {
			rval.setValue(this.takefieldevent());
			if (rval.boolValue()) {
				return rval.like();
			}
		}
		final int loop_1=this.cl.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.cl.get(i);
			rval.setValue(this.cl.wc.get().takeevent());
			if (rval.boolValue()) {
				return rval.like();
			}
		}
		if (this.autorefresh.boolValue()) {
			final int loop_2=this.cl.records();for (i.setValue(1);i.compareTo(loop_2)<=0;i.increment(1)) {
				this.cl.get(i);
				if (this.cl.wc.get().resetrequired().boolValue()) {
					this.reset();
					break;
				}
			}
		}
		return rval.like();
	}
	public ClarionNumber takefieldevent()
	{
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber takenewselection()
	{
		if (Clarion.getControl(CWin.field()).getProperty(Prop.TYPE).equals(Create.SHEET)) {
			this.reset();
			if (this.autotoolbar.boolValue() && !(this.toolbar==null)) {
				this.toolbar.settarget();
			}
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber takerejected()
	{
		CWin.beep();
		CWin.display(CWin.field());
		CWin.select(CWin.field());
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber takeselected()
	{
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber takewindowevent()
	{
		ClarionNumber rval=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		{
			int case_1=CWin.event();
			boolean case_1_break=false;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1==Event.OPENWINDOW) {
				if (!((this.inited.intValue() & 1)!=0)) {
					this.open();
				}
				if (this.firstfield.boolValue()) {
					CWin.select(this.firstfield.intValue());
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1==Event.LOSEFOCUS) {
				if (this.resetongainfocus.boolValue()) {
					this.forcedreset.setValue(1);
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
				rval.setValue(this.takecompleted());
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1==Event.CLOSEWINDOW) {
				case_1_match=true;
			}
			if (case_1_match || case_1==Event.CLOSEDOWN) {
				rval.setValue(this.takecloseevent());
				case_1_break=true;
			}
		}
		return rval.like();
	}
	public void update()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		final int loop_1=this.cl.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.cl.get(i);
			this.cl.wc.get().update();
		}
	}
}
