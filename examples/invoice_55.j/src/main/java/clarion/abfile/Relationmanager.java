package clarion.abfile;

import clarion.abfile.Abfile;
import clarion.abfile.Filemanager;
import clarion.abfile.Relationqueue;
import clarion.abutil.Bufferedpairsclass;
import clarion.abutil.Fieldpairsclass;
import clarion.equates.Cursor;
import clarion.equates.Level;
import clarion.equates.Msg;
import clarion.equates.Prop;
import clarion.equates.Propagate;
import clarion.equates.Ri;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionKey;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionRoutineResult;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Relationmanager
{
	public Filemanager me=null;
	public Relationqueue relations=null;
	public Relationmanager aliasfile=null;
	public ClarionNumber uselogout=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber lasttouched=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public Relationmanager()
	{
		me=null;
		relations=null;
		aliasfile=null;
		uselogout=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		lasttouched=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	}

	public void addrelation(Relationmanager f)
	{
		this.relations.clear();
		this.relations.file.set(f);
		this.relations.add();
	}
	public void addrelation(Relationmanager f,ClarionNumber update,ClarionNumber delete,ClarionKey his)
	{
		this.addrelation(f);
		this.relations.fields.set(new Bufferedpairsclass());
		this.relations.fields.get().init();
		this.relations.updatemode.setValue(update);
		this.relations.deletemode.setValue(delete);
		this.relations.hiskey.set(his);
		this.relations.put();
	}
	public void addrelationlink(ClarionObject left,ClarionObject right)
	{
		this.relations.fields.get().addpair(left,right);
	}
	public void addrelationlink(ClarionNumber left,ClarionNumber right)
	{
		this.relations.fields.get().addpair(left,right);
	}
	public void addrelationlink(ClarionString left,ClarionString right)
	{
		this.relations.fields.get().addpair(left,right);
	}
	public ClarionNumber cancelautoinc()
	{
		return this.me.cancelautoinc(this);
	}
	public ClarionNumber cascadeupdates()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		final int loop_1=this.relations.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.relations.get(i);
			if (Abfile.localaction(this.relations.updatemode.like()).boolValue() && !this.relations.fields.get().equalleftbuffer().boolValue()) {
				if (this.relations.file.get().updatesecondary(this.relations.hiskey.get(),this.relations.fields.get(),this.relations.updatemode.like()).boolValue()) {
					this.relations.fields.get().assignrighttoleft();
					return Clarion.newNumber(Level.NOTIFY);
				}
			}
		}
		if (this.me.tryupdate().boolValue()) {
			if (this.uselogout.boolValue()) {
				ClarionFile.rollback();
			}
			return this.me._throw();
		}
		else {
			return Clarion.newNumber(Level.BENIGN);
		}
	}
	public ClarionNumber close()
	{
		return close(Clarion.newNumber(0));
	}
	public ClarionNumber close(ClarionNumber cascading)
	{
		return this.opencloseserver(cascading.like(),Clarion.newNumber(0));
	}
	public ClarionNumber delete()
	{
		return delete(Clarion.newNumber(1));
	}
	public ClarionNumber delete(ClarionNumber query)
	{
		ClarionString currentPosition=Clarion.newString(1024);
		ClarionNumber retval=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		if (query.boolValue() && !this.me._throw(Clarion.newNumber(Msg.CONFIRMDELETE)).equals(Level.BENIGN)) {
			return Clarion.newNumber(Level.NOTIFY);
		}
		while (true) {
			CWin.setCursor(Cursor.WAIT);
			retval.setValue(Level.BENIGN);
			currentPosition.setValue(this.me.position());
			retval.setValue(this.open());
			try {
				delete_checkerror(retval);
			} catch (ClarionRoutineResult _crr) {
				return (ClarionNumber)_crr.getResult();
			}
			if (this.uselogout.boolValue()) {
				retval.setValue(this.logoutdelete());
				try {
					delete_checkerror(retval);
				} catch (ClarionRoutineResult _crr) {
					return (ClarionNumber)_crr.getResult();
				}
				ClarionFile.logout(2);
				if (CError.errorCode()!=0) {
					this.me._throw(Clarion.newNumber(Msg.LOGOUTFAILED));
					retval.setValue(Level.NOTIFY);
					try {
						delete_checkerror(retval);
					} catch (ClarionRoutineResult _crr) {
						return (ClarionNumber)_crr.getResult();
					}
				}
			}
			this.me.tryreget(currentPosition.like());
			final int loop_1=this.relations.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
				this.relations.get(i);
				if (Abfile.localaction(this.relations.deletemode.like()).boolValue()) {
					retval.setValue(this.relations.file.get().deletesecondary(this.relations.hiskey.get(),this.relations.fields.get(),this.relations.deletemode.like()));
					try {
						delete_checkerror(retval);
					} catch (ClarionRoutineResult _crr) {
						return (ClarionNumber)_crr.getResult();
					}
				}
			}
			this.me.deleterecord(query.like());
			if (CError.errorCode()!=0) {
				this.me.seterror(Clarion.newNumber(Msg.DELETEFAILED));
				if (this.uselogout.boolValue()) {
					ClarionFile.rollback();
				}
				this.me._throw();
				retval.setValue(Level.NOTIFY);
			}
			else {
				if (this.uselogout.boolValue()) {
					ClarionFile.commit();
				}
			}
			delete_closedown();
			if (!(retval.boolValue() && this.me._throw(Clarion.newNumber(Msg.RETRYDELETE)).equals(Level.BENIGN))) break;
		}
		return retval.like();
	}
	public void delete_checkerror(ClarionNumber retval) throws ClarionRoutineResult
	{
		if (retval.boolValue()) {
			delete_closedown();
			throw new ClarionRoutineResult(retval.like());
		}
	}
	public void delete_closedown()
	{
		CWin.setCursor(null);
		this.close();
	}
	public ClarionNumber deletesecondary(ClarionKey mykey,Bufferedpairsclass fields,ClarionNumber mode)
	{
		ClarionNumber retval=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber preserve=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		this.me.usefile();
		preserve.setValue(this.me.savefile());
		this.me.file.clear();
		fields.assignlefttoright();
		this.me.clearkey(mykey,Clarion.newNumber(fields.list.records()+1));
		mykey.set(mykey);
		while (true) {
			if (this.me.trynext().equals(Level.FATAL)) {
				if (this.uselogout.boolValue()) {
					ClarionFile.rollback();
				}
				this.me._throw();
				retval.setValue(Level.NOTIFY);
				try {
					deletesecondary_ret(preserve,retval);
				} catch (ClarionRoutineResult _crr) {
					return (ClarionNumber)_crr.getResult();
				}
			}
			if (this.me.geteof().boolValue() || !fields.equalleftright().boolValue()) {
				try {
					deletesecondary_ret(preserve,retval);
				} catch (ClarionRoutineResult _crr) {
					return (ClarionNumber)_crr.getResult();
				}
			}
			if (this.me.deleted().boolValue()) {
				continue;
			}
			{
				ClarionNumber case_1=mode;
				boolean case_1_break=false;
				if (case_1.equals(Ri.RESTRICT)) {
					this.me.seterror(Clarion.newNumber(Msg.RESTRICTDELETE));
					if (this.uselogout.boolValue()) {
						ClarionFile.rollback();
					}
					this.me._throw();
					retval.setValue(Level.NOTIFY);
					try {
						deletesecondary_ret(preserve,retval);
					} catch (ClarionRoutineResult _crr) {
						return (ClarionNumber)_crr.getResult();
					}
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Ri.CLEAR)) {
					this.save();
					fields.clearright();
					if (this.cascadeupdates().boolValue()) {
						retval.setValue(Level.NOTIFY);
						try {
							deletesecondary_ret(preserve,retval);
						} catch (ClarionRoutineResult _crr) {
							return (ClarionNumber)_crr.getResult();
						}
					}
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Ri.CASCADE)) {
					final int loop_1=this.relations.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
						this.relations.get(i);
						if (Abfile.localaction(this.relations.deletemode.like()).boolValue()) {
							retval.setValue(this.relations.file.get().deletesecondary(this.relations.hiskey.get(),this.relations.fields.get(),this.relations.deletemode.like()));
							if (retval.boolValue()) {
								try {
									deletesecondary_ret(preserve,retval);
								} catch (ClarionRoutineResult _crr) {
									return (ClarionNumber)_crr.getResult();
								}
							}
						}
					}
					this.me.deleterecord(Clarion.newNumber(1));
					if (CError.errorCode()!=0) {
						this.me.seterror(Clarion.newNumber(Msg.DELETEFAILED));
						if (this.uselogout.boolValue()) {
							ClarionFile.rollback();
						}
						this.me._throw();
						retval.setValue(Level.NOTIFY);
						try {
							deletesecondary_ret(preserve,retval);
						} catch (ClarionRoutineResult _crr) {
							return (ClarionNumber)_crr.getResult();
						}
					}
					case_1_break=true;
				}
				if (!case_1_break) {
					try {
						deletesecondary_ret(preserve,retval);
					} catch (ClarionRoutineResult _crr) {
						return (ClarionNumber)_crr.getResult();
					}
				}
			}
		}
	}
	public void deletesecondary_ret(ClarionNumber preserve,ClarionNumber retval) throws ClarionRoutineResult
	{
		this.me.restorefile(preserve);
		throw new ClarionRoutineResult(retval.like());
	}
	public void init(Filemanager p0)
	{
		init(p0,Clarion.newNumber(0));
	}
	public void init(Filemanager f,ClarionNumber log)
	{
		this.me=f;
		this.relations=new Relationqueue();
		this.uselogout.setValue(log);
	}
	public void kill()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		if (!(this.relations==null)) {
			final int loop_1=this.relations.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
				this.relations.get(i);
				if (!(this.relations.fields.get()==null)) {
					this.relations.fields.get().kill();
					//this.relations.fields.get();
				}
			}
			//this.relations;
		}
	}
	public void listlinkingfields(Relationmanager p0,Fieldpairsclass p1)
	{
		listlinkingfields(p0,p1,Clarion.newNumber(0));
	}
	public void listlinkingfields(Relationmanager him,Fieldpairsclass trgt,ClarionNumber rightfirst)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber j=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		final int loop_2=this.relations.records();for (i.setValue(1);i.compareTo(loop_2)<=0;i.increment(1)) {
			this.relations.get(i);
			if (this.relations.file.get()==him) {
				if (this.relations.fields.get()==null) {
					him.listlinkingfields(this,trgt,Clarion.newNumber(1));
					return;
				}
				final int loop_1=this.relations.fields.get().list.records();for (j.setValue(1);j.compareTo(loop_1)<=0;j.increment(1)) {
					this.relations.fields.get().list.get(j);
					if (rightfirst.boolValue()) {
						trgt.addpair(this.relations.fields.get().list.left,this.relations.fields.get().list.right);
					}
					else {
						trgt.addpair(this.relations.fields.get().list.right,this.relations.fields.get().list.left);
					}
				}
				return;
			}
		}
	}
	public ClarionNumber logoutdelete()
	{
		ClarionNumber retval=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		retval.setValue(this.logoutprime());
		if (!retval.boolValue()) {
			final int loop_1=this.relations.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
				this.relations.get(i);
				if (this.relations.deletemode.equals(Ri.CASCADE)) {
					retval.setValue(this.relations.file.get().logoutdelete());
				}
				else if (this.relations.deletemode.equals(Ri.CLEAR)) {
					retval.setValue(this.relations.file.get().logoutupdate());
				}
				if (retval.boolValue()) break;
			}
		}
		return retval.like();
	}
	public ClarionNumber logoutprime()
	{
		this.me.usefile();
		if (this.uselogout.boolValue()) {
			this.me.file.setProperty(Prop.LOGOUT,1);
			{
				int case_1=CError.errorCode();
				boolean case_1_break=false;
				if (case_1==0) {
					case_1_break=true;
				}
				if (!case_1_break && case_1==80) {
					this.uselogout.setValue(0);
					case_1_break=true;
				}
				if (!case_1_break) {
					this.me._throw(Clarion.newNumber(Msg.LOGOUTFAILED));
					return Clarion.newNumber(Level.NOTIFY);
				}
			}
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber logoutupdate()
	{
		ClarionNumber retval=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		retval.setValue(this.logoutprime());
		if (!retval.boolValue()) {
			final int loop_1=this.relations.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
				this.relations.get(i);
				if (this.relations.updatemode.equals(Ri.CASCADE) || this.relations.updatemode.equals(Ri.CLEAR)) {
					retval.setValue(this.relations.file.get().logoutupdate());
				}
				if (retval.boolValue()) break;
			}
		}
		return retval.like();
	}
	public ClarionNumber opencloseserver(ClarionNumber p1)
	{
		return opencloseserver(Clarion.newNumber(0),p1);
	}
	public ClarionNumber opencloseserver(ClarionNumber cascading,ClarionNumber opening)
	{
		ClarionNumber i=Clarion.newNumber(1).setEncoding(ClarionNumber.BYTE);
		ClarionNumber res=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (cascading.boolValue()) {
			if (this.lasttouched.equals(Abfile.epoc)) {
				return Clarion.newNumber(Level.BENIGN);
			}
		}
		else {
			Abfile.epoc.increment(1);
		}
		this.lasttouched.setValue(Abfile.epoc);
		if (opening.boolValue()) {
			res.setValue(this.me.open());
			if (!cascading.boolValue()) {
				res.setValue(this.me.usefile());
			}
		}
		else {
			res.setValue(this.me.close());
		}
		while (!res.boolValue()) {
			this.relations.get(i);
			if (CError.errorCode()!=0) {
				break;
			}
			if (opening.boolValue()) {
				res.setValue(this.relations.file.get().open(Clarion.newNumber(1)));
			}
			else {
				res.setValue(this.relations.file.get().close(Clarion.newNumber(1)));
			}
			i.increment(1);
		}
		return res.like();
	}
	public ClarionNumber open()
	{
		return open(Clarion.newNumber(0));
	}
	public ClarionNumber open(ClarionNumber cascading)
	{
		return this.opencloseserver(cascading.like(),Clarion.newNumber(1));
	}
	public void save()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		final int loop_1=this.relations.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.relations.get(i);
			if (!(this.relations.fields.get()==null)) {
				this.relations.fields.get().assignlefttobuffer();
			}
		}
	}
	public void setalias(Relationmanager r)
	{
		this.aliasfile=r;
	}
	public void setquickscan(ClarionNumber p0)
	{
		setquickscan(p0,Clarion.newNumber(Propagate.NONE));
	}
	public void setquickscan(ClarionNumber on,ClarionNumber propagate)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		this.me.file.send(ClarionString.staticConcat("QUICKSCAN=",on.equals(1) ? Clarion.newString("on") : Clarion.newString("off")));
		if (propagate.boolValue()) {
			if ((propagate.intValue() & 0x80)!=0) {
				if (this.lasttouched.equals(Abfile.epoc)) {
					return;
				}
			}
			else {
				Abfile.epoc.increment(1);
				propagate.setValue(propagate.add(0x80));
			}
			this.lasttouched.setValue(Abfile.epoc);
			final int loop_1=this.relations.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
				this.relations.get(i);
				{
					int case_1=propagate.intValue() & 0x7f;
					boolean case_1_break=false;
					if (case_1==Propagate.ONEMANY) {
						if (!(this.relations.hiskey.get()==null)) {
							continue;
						}
						case_1_break=true;
					}
					if (!case_1_break && case_1==Propagate.MANYONE) {
						if (this.relations.hiskey.get()==null) {
							continue;
						}
						case_1_break=true;
					}
				}
				this.relations.file.get().setquickscan(on.like(),propagate.like());
			}
		}
	}
	public ClarionNumber update()
	{
		return update(Clarion.newNumber(0));
	}
	public ClarionNumber update(ClarionNumber fromform)
	{
		ClarionNumber retval=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		retval.setValue(this.open());
		try {
			update_checkerror(retval);
		} catch (ClarionRoutineResult _crr) {
			return (ClarionNumber)_crr.getResult();
		}
		if (this.uselogout.boolValue()) {
			retval.setValue(this.logoutupdate());
			try {
				update_checkerror(retval);
			} catch (ClarionRoutineResult _crr) {
				return (ClarionNumber)_crr.getResult();
			}
			ClarionFile.logout(2);
			if (CError.errorCode()!=0) {
				this.me._throw(Clarion.newNumber(Msg.LOGOUTFAILED));
				retval.setValue(Level.NOTIFY);
				try {
					update_checkerror(retval);
				} catch (ClarionRoutineResult _crr) {
					return (ClarionNumber)_crr.getResult();
				}
			}
		}
		retval.setValue(this.me.tryupdate());
		if (retval.boolValue()) {
			if (this.uselogout.boolValue()) {
				ClarionFile.rollback();
			}
			if (fromform.boolValue() && this.me.info.lasterror.equals(Msg.CONCURRENCYFAILED)) {
				this.me.info.lasterror.setValue(Msg.CONCURRENCYFAILEDFROMFORM);
			}
			if (retval.equals(Level.NOTIFY)) {
				this.me._throw();
			}
			if (this.me.info.lasterror.equals(Msg.CONCURRENCYFAILED) || this.me.info.lasterror.equals(Msg.CONCURRENCYFAILEDFROMFORM)) {
				retval.setValue(Level.NOTIFY);
			}
			else {
				retval.setValue(Level.USER);
			}
			try {
				update_checkerror(retval);
			} catch (ClarionRoutineResult _crr) {
				return (ClarionNumber)_crr.getResult();
			}
		}
		final int loop_1=this.relations.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.relations.get(i);
			if (Abfile.localaction(this.relations.updatemode.like()).boolValue() && !this.relations.fields.get().equalleftbuffer().boolValue()) {
				retval.setValue(this.relations.file.get().updatesecondary(this.relations.hiskey.get(),this.relations.fields.get(),this.relations.updatemode.like()));
				if (retval.boolValue()) {
					this.relations.fields.get().assignrighttoleft();
					try {
						update_checkerror(retval);
					} catch (ClarionRoutineResult _crr) {
						return (ClarionNumber)_crr.getResult();
					}
				}
			}
		}
		if (this.uselogout.boolValue()) {
			ClarionFile.commit();
		}
		this.close();
		return retval.like();
	}
	public void update_checkerror(ClarionNumber retval) throws ClarionRoutineResult
	{
		if (retval.boolValue()) {
			this.close();
			throw new ClarionRoutineResult(retval.like());
		}
	}
	public ClarionNumber updatesecondary(ClarionKey mykey,Bufferedpairsclass fields,ClarionNumber mode)
	{
		ClarionNumber retval=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		ClarionNumber preserve=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		this.me.usefile();
		preserve.setValue(this.me.savefile());
		this.me.file.clear();
		fields.assignbuffertoright();
		this.me.clearkey(mykey,Clarion.newNumber(fields.list.records()+1));
		mykey.set(mykey);
		while (true) {
			if (this.me.trynext().equals(Level.FATAL)) {
				if (this.uselogout.boolValue()) {
					ClarionFile.rollback();
				}
				this.me._throw();
				retval.setValue(Level.NOTIFY);
				try {
					updatesecondary_ret(preserve,retval);
				} catch (ClarionRoutineResult _crr) {
					return (ClarionNumber)_crr.getResult();
				}
			}
			if (this.me.geteof().boolValue() || !fields.equalrightbuffer().boolValue()) {
				try {
					updatesecondary_ret(preserve,retval);
				} catch (ClarionRoutineResult _crr) {
					return (ClarionNumber)_crr.getResult();
				}
			}
			this.save();
			{
				ClarionNumber case_1=mode;
				boolean case_1_break=false;
				if (case_1.equals(Ri.RESTRICT)) {
					this.me.seterror(Clarion.newNumber(Msg.RESTRICTUPDATE));
					if (this.uselogout.boolValue()) {
						ClarionFile.rollback();
					}
					this.me._throw();
					fields.assignbuffertoleft();
					retval.setValue(Level.NOTIFY);
					try {
						updatesecondary_ret(preserve,retval);
					} catch (ClarionRoutineResult _crr) {
						return (ClarionNumber)_crr.getResult();
					}
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Ri.CLEAR)) {
					fields.clearright();
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Ri.CASCADE)) {
					fields.assignlefttoright();
					case_1_break=true;
				}
				if (!case_1_break) {
					try {
						updatesecondary_ret(preserve,retval);
					} catch (ClarionRoutineResult _crr) {
						return (ClarionNumber)_crr.getResult();
					}
				}
			}
			if (this.cascadeupdates().boolValue()) {
				retval.setValue(Level.NOTIFY);
				try {
					updatesecondary_ret(preserve,retval);
				} catch (ClarionRoutineResult _crr) {
					return (ClarionNumber)_crr.getResult();
				}
			}
		}
	}
	public void updatesecondary_ret(ClarionNumber preserve,ClarionNumber retval) throws ClarionRoutineResult
	{
		this.me.restorefile(preserve);
		throw new ClarionRoutineResult(retval.like());
	}
	public ClarionNumber getnbrelations()
	{
		return Clarion.newNumber(this.relations.records());
	}
	public ClarionNumber getnbfiles(Relationmanager parent)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber nbfiles=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		nbfiles.setValue(1);
		final int loop_1=this.relations.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.relations.get(i);
			if (!(this.relations.file.get()==parent)) {
				nbfiles.increment(this.relations.file.get().getnbfiles(this));
			}
		}
		return nbfiles.like();
	}
	public Relationmanager getrelation(ClarionNumber relpos)
	{
		if (relpos.compareTo(1)<0) {
			return null;
		}
		if (relpos.compareTo(this.relations.records())>0) {
			return null;
		}
		this.relations.get(relpos);
		return this.relations.file.get();
	}
	public Relationmanager getrelation(ClarionFile f)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		if (f==null) {
			return null;
		}
		final int loop_1=this.relations.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.relations.get(i);
			if (this.relations.file.get().me.file==f) {
				return this.relations.file.get();
			}
		}
		return null;
	}
	public ClarionNumber getrelationtype(ClarionNumber relpos)
	{
		if (relpos.compareTo(1)<0) {
			return Clarion.newNumber(-1);
		}
		if (relpos.compareTo(this.relations.records())>0) {
			return Clarion.newNumber(-1);
		}
		this.relations.get(relpos);
		if (this.relations.hiskey.get()==null) {
			return Clarion.newNumber(0);
		}
		return Clarion.newNumber(1);
	}
}
