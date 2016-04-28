package clarion;

import clarion.Abfile;
import clarion.Bufferedpairsclass;
import clarion.Fieldpairsclass;
import clarion.Filemanager;
import clarion.Relationqueue;
import clarion.equates.Constants;
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

public class Relationmanager
{
	public Filemanager me;
	public Relationqueue relations;
	public Relationmanager aliasFile;
	public ClarionNumber useLogout;
	public ClarionNumber logoutTimeout;
	public ClarionNumber lastTouched;
	public Relationmanager()
	{
		me=null;
		relations=null;
		aliasFile=null;
		useLogout=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		logoutTimeout=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		lastTouched=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	}

	public void addRelation(Relationmanager f)
	{
		this.relations.clear();
		this.relations.file.set(f);
		this.relations.add();
	}
	public void addRelation(Relationmanager f,ClarionNumber update,ClarionNumber delete,ClarionKey his)
	{
		this.addRelation(f);
		this.relations.fields.set(new Bufferedpairsclass());
		this.relations.fields.get().init();
		this.relations.updateMode.setValue(update);
		this.relations.deleteMode.setValue(delete);
		this.relations.hisKey.set(his);
		this.relations.put();
	}
	public void addRelationLink(ClarionObject left,ClarionObject right)
	{
		this.relations.fields.get().addPair(left,right);
	}
	public void addRelationLink(ClarionNumber left,ClarionNumber right)
	{
		this.relations.fields.get().addPair(left,right);
	}
	public void addRelationLink(ClarionString left,ClarionString right)
	{
		this.relations.fields.get().addPair(left,right);
	}
	public ClarionNumber cancelAutoInc()
	{
		return this.me.cancelAutoInc(this);
	}
	public ClarionNumber cascadeUpdates()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		for (i.setValue(1);i.compareTo(this.relations.records())<=0;i.increment(1)) {
			this.relations.get(i);
			if (Abfile.localAction(this.relations.updateMode.like()).boolValue() && !this.relations.fields.get().equalLeftBuffer().boolValue()) {
				if (this.relations.file.get().updateSecondary(this.relations.hisKey.get(),this.relations.fields.get(),this.relations.updateMode.like()).boolValue()) {
					this.relations.fields.get().assignRightToLeft();
					return Clarion.newNumber(Level.NOTIFY);
				}
			}
		}
		if (this.me.tryUpdate().boolValue()) {
			if (this.useLogout.boolValue()) {
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
		return this.openCloseServer(cascading.like(),Clarion.newNumber(0));
	}
	public ClarionNumber delete()
	{
		return delete(Clarion.newNumber(1));
	}
	public ClarionNumber delete(ClarionNumber query)
	{
		ClarionString currentPosition=Clarion.newString(1024);
		ClarionNumber retVal=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber childQuery=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (query.boolValue() && !this.me._throw(Clarion.newNumber(Msg.CONFIRMDELETE)).equals(Level.BENIGN)) {
			return Clarion.newNumber(Level.CANCEL);
		}
		childQuery.setValue(Constants.FALSE);
		while (true) {
			CWin.setCursor(Cursor.WAIT);
			retVal.setValue(Level.BENIGN);
			currentPosition.setValue(this.me.position());
			retVal.setValue(this.open());
			try {
				delete_CheckError(retVal);
			} catch (ClarionRoutineResult _crr) {
				return (ClarionNumber)_crr.getResult();
			}
			if (this.useLogout.boolValue()) {
				retVal.setValue(this.logoutDelete());
				try {
					delete_CheckError(retVal);
				} catch (ClarionRoutineResult _crr) {
					return (ClarionNumber)_crr.getResult();
				}
				ClarionFile.logout(this.logoutTimeout.intValue());
				if (CError.errorCode()!=0) {
					this.me._throw(Clarion.newNumber(Msg.LOGOUTFAILED));
					retVal.setValue(Level.NOTIFY);
					try {
						delete_CheckError(retVal);
					} catch (ClarionRoutineResult _crr) {
						return (ClarionNumber)_crr.getResult();
					}
				}
			}
			this.me.tryReget(currentPosition.like());
			for (i.setValue(1);i.compareTo(this.relations.records())<=0;i.increment(1)) {
				this.relations.get(i);
				if (Abfile.localAction(this.relations.deleteMode.like()).boolValue()) {
					retVal.setValue(this.relations.file.get().deleteSecondary(this.relations.hisKey.get(),this.relations.fields.get(),this.relations.deleteMode.like(),childQuery.like()));
					try {
						delete_CheckError(retVal);
					} catch (ClarionRoutineResult _crr) {
						return (ClarionNumber)_crr.getResult();
					}
				}
			}
			if (!this.me.deleteRecord(Clarion.newNumber(Constants.FALSE)).equals(Level.BENIGN)) {
				if (this.useLogout.boolValue()) {
					ClarionFile.rollback();
				}
				this.me._throw();
				retVal.setValue(Level.NOTIFY);
			}
			else {
				if (this.useLogout.boolValue()) {
					ClarionFile.commit();
				}
			}
			delete_CloseDown();
			if (!(retVal.boolValue() && this.me._throw(Clarion.newNumber(Msg.RETRYDELETE)).equals(Level.BENIGN))) break;
		}
		return retVal.like();
	}
	public void delete_CheckError(ClarionNumber retVal) throws ClarionRoutineResult
	{
		if (retVal.boolValue()) {
			delete_CloseDown();
			throw new ClarionRoutineResult(retVal.like());
		}
	}
	public void delete_CloseDown()
	{
		CWin.setCursor(null);
		this.close();
	}
	public ClarionNumber deleteSecondary(ClarionKey p0,Bufferedpairsclass p1,ClarionNumber p2)
	{
		return deleteSecondary(p0,p1,p2,Clarion.newNumber(1));
	}
	public ClarionNumber deleteSecondary(ClarionKey myKey,Bufferedpairsclass fields,ClarionNumber mode,ClarionNumber query)
	{
		ClarionNumber retVal=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber preserve=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		this.me.useFile();
		preserve.setValue(this.me.saveFile());
		this.me.file.clear();
		fields.assignLeftToRight();
		this.me.clearKey(myKey,Clarion.newNumber(fields.list.records()+1));
		myKey.set(myKey);
		while (true) {
			if (this.me.tryNext().equals(Level.FATAL)) {
				if (this.useLogout.boolValue()) {
					ClarionFile.rollback();
				}
				this.me._throw();
				retVal.setValue(Level.NOTIFY);
				try {
					deleteSecondary_Ret(preserve,retVal);
				} catch (ClarionRoutineResult _crr) {
					return (ClarionNumber)_crr.getResult();
				}
			}
			if (this.me.getEOF().boolValue() || !fields.equalLeftRight().boolValue()) {
				try {
					deleteSecondary_Ret(preserve,retVal);
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
					this.me.setError(Clarion.newNumber(Msg.RESTRICTDELETE));
					if (this.useLogout.boolValue()) {
						ClarionFile.rollback();
					}
					this.me._throw();
					retVal.setValue(Level.NOTIFY);
					try {
						deleteSecondary_Ret(preserve,retVal);
					} catch (ClarionRoutineResult _crr) {
						return (ClarionNumber)_crr.getResult();
					}
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Ri.CLEAR)) {
					this.save();
					fields.clearRight();
					if (this.cascadeUpdates().boolValue()) {
						retVal.setValue(Level.NOTIFY);
						try {
							deleteSecondary_Ret(preserve,retVal);
						} catch (ClarionRoutineResult _crr) {
							return (ClarionNumber)_crr.getResult();
						}
					}
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Ri.CASCADE)) {
					for (i.setValue(1);i.compareTo(this.relations.records())<=0;i.increment(1)) {
						this.relations.get(i);
						if (Abfile.localAction(this.relations.deleteMode.like()).boolValue()) {
							retVal.setValue(this.relations.file.get().deleteSecondary(this.relations.hisKey.get(),this.relations.fields.get(),this.relations.deleteMode.like(),query.like()));
							if (retVal.boolValue()) {
								try {
									deleteSecondary_Ret(preserve,retVal);
								} catch (ClarionRoutineResult _crr) {
									return (ClarionNumber)_crr.getResult();
								}
							}
						}
					}
					if (!this.me.deleteRecord(query.like()).equals(Level.BENIGN)) {
						if (this.useLogout.boolValue()) {
							ClarionFile.rollback();
						}
						this.me._throw();
						retVal.setValue(Level.NOTIFY);
						try {
							deleteSecondary_Ret(preserve,retVal);
						} catch (ClarionRoutineResult _crr) {
							return (ClarionNumber)_crr.getResult();
						}
					}
					case_1_break=true;
				}
				if (!case_1_break) {
					try {
						deleteSecondary_Ret(preserve,retVal);
					} catch (ClarionRoutineResult _crr) {
						return (ClarionNumber)_crr.getResult();
					}
				}
			}
		}
	}
	public void deleteSecondary_Ret(ClarionNumber preserve,ClarionNumber retVal) throws ClarionRoutineResult
	{
		this.me.restoreFile(preserve);
		throw new ClarionRoutineResult(retVal.like());
	}
	public void init(Filemanager p0)
	{
		init(p0,Clarion.newNumber(0));
	}
	public void init(Filemanager f,ClarionNumber log)
	{
		this.me=f;
		this.relations=new Relationqueue();
		this.useLogout.setValue(log);
		this.logoutTimeout.setValue(2);
	}
	public void kill()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		if (!(this.relations==null)) {
			for (i.setValue(1);i.compareTo(this.relations.records())<=0;i.increment(1)) {
				this.relations.get(i);
				if (!(this.relations.fields.get()==null)) {
					this.relations.fields.get().kill();
					//this.relations.fields.get();
				}
			}
			//this.relations;
		}
	}
	public void listLinkingFields(Relationmanager p0,Fieldpairsclass p1)
	{
		listLinkingFields(p0,p1,Clarion.newNumber(0));
	}
	public void listLinkingFields(Relationmanager him,Fieldpairsclass trgt,ClarionNumber rightFirst)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber j=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		for (i.setValue(1);i.compareTo(this.relations.records())<=0;i.increment(1)) {
			this.relations.get(i);
			if (this.relations.file.get()==him) {
				if (this.relations.fields.get()==null) {
					him.listLinkingFields(this,trgt,Clarion.newNumber(1));
					return;
				}
				for (j.setValue(1);j.compareTo(this.relations.fields.get().list.records())<=0;j.increment(1)) {
					this.relations.fields.get().list.get(j);
					if (rightFirst.boolValue()) {
						trgt.addPair(this.relations.fields.get().list.left,this.relations.fields.get().list.right);
					}
					else {
						trgt.addPair(this.relations.fields.get().list.right,this.relations.fields.get().list.left);
					}
				}
				return;
			}
		}
	}
	public ClarionNumber logoutDelete()
	{
		ClarionNumber retVal=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		retVal.setValue(this.logoutPrime());
		if (!retVal.boolValue()) {
			for (i.setValue(1);i.compareTo(this.relations.records())<=0;i.increment(1)) {
				this.relations.get(i);
				if (this.relations.deleteMode.equals(Ri.CASCADE)) {
					retVal.setValue(this.relations.file.get().logoutDelete());
				}
				else if (this.relations.deleteMode.equals(Ri.CLEAR)) {
					retVal.setValue(this.relations.file.get().logoutUpdate());
				}
				if (retVal.boolValue()) break;
			}
		}
		return retVal.like();
	}
	public ClarionNumber logoutPrime()
	{
		ClarionFile fileToLogout=null;
		this.me.useFile();
		if (this.useLogout.boolValue()) {
			fileToLogout=this.me.file;
			if (!(this.me.aliasedFile==null)) {
				if (!this.me.file.getProperty(Prop.DRIVERLOGSOUTALIAS).boolValue()) {
					fileToLogout=this.me.aliasedFile.file;
				}
			}
			if (fileToLogout.getProperty(Prop.LOGOUT).compareTo(1)<0) {
				fileToLogout.setProperty(Prop.LOGOUT,1);
				{
					int case_1=CError.errorCode();
					boolean case_1_break=false;
					if (case_1==0) {
						case_1_break=true;
					}
					if (!case_1_break && case_1==80) {
						this.useLogout.setValue(0);
						case_1_break=true;
					}
					if (!case_1_break) {
						this.me._throw(Clarion.newNumber(Msg.LOGOUTFAILED));
						return Clarion.newNumber(Level.NOTIFY);
					}
				}
			}
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber logoutUpdate()
	{
		ClarionNumber retVal=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		retVal.setValue(this.logoutPrime());
		if (!retVal.boolValue()) {
			for (i.setValue(1);i.compareTo(this.relations.records())<=0;i.increment(1)) {
				this.relations.get(i);
				if (this.relations.updateMode.equals(Ri.CASCADE) || this.relations.updateMode.equals(Ri.CLEAR)) {
					retVal.setValue(this.relations.file.get().logoutUpdate());
				}
				if (retVal.boolValue()) break;
			}
		}
		return retVal.like();
	}
	public ClarionNumber openCloseServer(ClarionNumber p1)
	{
		return openCloseServer(Clarion.newNumber(0),p1);
	}
	public ClarionNumber openCloseServer(ClarionNumber cascading,ClarionNumber opening)
	{
		ClarionNumber i=Clarion.newNumber(1).setEncoding(ClarionNumber.BYTE);
		ClarionNumber res=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (cascading.boolValue()) {
			if (this.lastTouched.equals(Abfile.epoc)) {
				return Clarion.newNumber(Level.BENIGN);
			}
		}
		else {
			Abfile.epoc.increment(1);
		}
		this.lastTouched.setValue(Abfile.epoc);
		if (opening.boolValue()) {
			res.setValue(this.me.open());
			if (!cascading.boolValue()) {
				res.setValue(this.me.useFile());
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
		return this.openCloseServer(cascading.like(),Clarion.newNumber(1));
	}
	public void save()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		for (i.setValue(1);i.compareTo(this.relations.records())<=0;i.increment(1)) {
			this.relations.get(i);
			if (!(this.relations.fields.get()==null)) {
				this.relations.fields.get().assignLeftToBuffer();
			}
		}
	}
	public void setAlias(Relationmanager r)
	{
		this.aliasFile=r;
	}
	public void setQuickScan(ClarionNumber p0)
	{
		setQuickScan(p0,Clarion.newNumber(Propagate.NONE));
	}
	public void setQuickScan(ClarionNumber on,ClarionNumber propagate)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		this.me.file.send(ClarionString.staticConcat("QUICKSCAN=",on.equals(1) ? Clarion.newString("on") : Clarion.newString("off")));
		if (propagate.boolValue()) {
			if ((propagate.intValue() & 0x80)!=0) {
				if (this.lastTouched.equals(Abfile.epoc)) {
					return;
				}
			}
			else {
				Abfile.epoc.increment(1);
				propagate.setValue(propagate.add(0x80));
			}
			this.lastTouched.setValue(Abfile.epoc);
			for (i.setValue(1);i.compareTo(this.relations.records())<=0;i.increment(1)) {
				this.relations.get(i);
				{
					int case_1=propagate.intValue() & 0x7f;
					boolean case_1_break=false;
					if (case_1==Propagate.ONEMANY) {
						if (!(this.relations.hisKey.get()==null)) {
							continue;
						}
						case_1_break=true;
					}
					if (!case_1_break && case_1==Propagate.MANYONE) {
						if (this.relations.hisKey.get()==null) {
							continue;
						}
						case_1_break=true;
					}
				}
				this.relations.file.get().setQuickScan(on.like(),propagate.like());
			}
		}
	}
	public ClarionNumber update()
	{
		return update(Clarion.newNumber(0));
	}
	public ClarionNumber update(ClarionNumber fromForm)
	{
		ClarionNumber retVal=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		retVal.setValue(this.open());
		try {
			update_CheckError(retVal);
		} catch (ClarionRoutineResult _crr) {
			return (ClarionNumber)_crr.getResult();
		}
		if (this.useLogout.boolValue()) {
			retVal.setValue(this.logoutUpdate());
			try {
				update_CheckError(retVal);
			} catch (ClarionRoutineResult _crr) {
				return (ClarionNumber)_crr.getResult();
			}
			ClarionFile.logout(this.logoutTimeout.intValue());
			if (CError.errorCode()!=0) {
				this.me._throw(Clarion.newNumber(Msg.LOGOUTFAILED));
				retVal.setValue(Level.NOTIFY);
				try {
					update_CheckError(retVal);
				} catch (ClarionRoutineResult _crr) {
					return (ClarionNumber)_crr.getResult();
				}
			}
		}
		retVal.setValue(this.me.tryUpdate());
		if (retVal.boolValue()) {
			if (this.useLogout.boolValue()) {
				ClarionFile.rollback();
			}
			if (fromForm.boolValue() && this.me.lastError.equals(Msg.CONCURRENCYFAILED)) {
				this.me.lastError.setValue(Msg.CONCURRENCYFAILEDFROMFORM);
			}
			if (retVal.equals(Level.NOTIFY)) {
				this.me._throw();
			}
			if (this.me.lastError.equals(Msg.CONCURRENCYFAILED) || this.me.lastError.equals(Msg.CONCURRENCYFAILEDFROMFORM)) {
				retVal.setValue(Level.NOTIFY);
			}
			else {
				retVal.setValue(Level.USER);
			}
			try {
				update_CheckError(retVal);
			} catch (ClarionRoutineResult _crr) {
				return (ClarionNumber)_crr.getResult();
			}
		}
		for (i.setValue(1);i.compareTo(this.relations.records())<=0;i.increment(1)) {
			this.relations.get(i);
			if (Abfile.localAction(this.relations.updateMode.like()).boolValue() && !this.relations.fields.get().equalLeftBuffer().boolValue()) {
				retVal.setValue(this.relations.file.get().updateSecondary(this.relations.hisKey.get(),this.relations.fields.get(),this.relations.updateMode.like()));
				if (retVal.boolValue()) {
					this.relations.fields.get().assignRightToLeft();
					try {
						update_CheckError(retVal);
					} catch (ClarionRoutineResult _crr) {
						return (ClarionNumber)_crr.getResult();
					}
				}
			}
		}
		if (this.useLogout.boolValue()) {
			ClarionFile.commit();
		}
		this.close();
		return retVal.like();
	}
	public void update_CheckError(ClarionNumber retVal) throws ClarionRoutineResult
	{
		if (retVal.boolValue()) {
			this.close();
			throw new ClarionRoutineResult(retVal.like());
		}
	}
	public ClarionNumber updateSecondary(ClarionKey myKey,Bufferedpairsclass fields,ClarionNumber mode)
	{
		ClarionNumber retVal=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		ClarionNumber preserve=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		this.me.useFile();
		preserve.setValue(this.me.saveFile());
		this.me.file.clear();
		fields.assignBufferToRight();
		this.me.clearKey(myKey,Clarion.newNumber(fields.list.records()+1));
		myKey.set(myKey);
		while (true) {
			if (this.me.tryNext().equals(Level.FATAL)) {
				if (this.useLogout.boolValue()) {
					ClarionFile.rollback();
				}
				this.me._throw();
				retVal.setValue(Level.NOTIFY);
				try {
					updateSecondary_Ret(preserve,retVal);
				} catch (ClarionRoutineResult _crr) {
					return (ClarionNumber)_crr.getResult();
				}
			}
			if (this.me.getEOF().boolValue() || !fields.equalRightBuffer().boolValue()) {
				try {
					updateSecondary_Ret(preserve,retVal);
				} catch (ClarionRoutineResult _crr) {
					return (ClarionNumber)_crr.getResult();
				}
			}
			this.save();
			{
				ClarionNumber case_1=mode;
				boolean case_1_break=false;
				if (case_1.equals(Ri.RESTRICT)) {
					this.me.setError(Clarion.newNumber(Msg.RESTRICTUPDATE));
					if (this.useLogout.boolValue()) {
						ClarionFile.rollback();
					}
					this.me._throw();
					fields.assignBufferToLeft();
					retVal.setValue(Level.NOTIFY);
					try {
						updateSecondary_Ret(preserve,retVal);
					} catch (ClarionRoutineResult _crr) {
						return (ClarionNumber)_crr.getResult();
					}
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Ri.CLEAR)) {
					fields.clearRight();
					case_1_break=true;
				}
				if (!case_1_break && case_1.equals(Ri.CASCADE)) {
					fields.assignLeftToRight();
					case_1_break=true;
				}
				if (!case_1_break) {
					try {
						updateSecondary_Ret(preserve,retVal);
					} catch (ClarionRoutineResult _crr) {
						return (ClarionNumber)_crr.getResult();
					}
				}
			}
			if (this.cascadeUpdates().boolValue()) {
				retVal.setValue(Level.NOTIFY);
				try {
					updateSecondary_Ret(preserve,retVal);
				} catch (ClarionRoutineResult _crr) {
					return (ClarionNumber)_crr.getResult();
				}
			}
		}
	}
	public void updateSecondary_Ret(ClarionNumber preserve,ClarionNumber retVal) throws ClarionRoutineResult
	{
		this.me.restoreFile(preserve);
		throw new ClarionRoutineResult(retVal.like());
	}
	public ClarionNumber getNbRelations()
	{
		return Clarion.newNumber(this.relations.records());
	}
	public ClarionNumber getNbFiles(Relationmanager parent)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber nbFiles=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		nbFiles.setValue(1);
		for (i.setValue(1);i.compareTo(this.relations.records())<=0;i.increment(1)) {
			this.relations.get(i);
			if (!(this.relations.file.get()==parent)) {
				nbFiles.increment(this.relations.file.get().getNbFiles(this));
			}
		}
		return nbFiles.like();
	}
	public Relationmanager getRelation(ClarionNumber relPos)
	{
		if (relPos.compareTo(1)<0) {
			return null;
		}
		if (relPos.compareTo(this.relations.records())>0) {
			return null;
		}
		this.relations.get(relPos);
		return this.relations.file.get();
	}
	public Relationmanager getRelation(ClarionFile f)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		if (f==null) {
			return null;
		}
		for (i.setValue(1);i.compareTo(this.relations.records())<=0;i.increment(1)) {
			this.relations.get(i);
			if (this.relations.file.get().me.file==f) {
				return this.relations.file.get();
			}
		}
		return null;
	}
	public ClarionNumber getRelationType(ClarionNumber relPos)
	{
		if (relPos.compareTo(1)<0) {
			return Clarion.newNumber(-1);
		}
		if (relPos.compareTo(this.relations.records())>0) {
			return Clarion.newNumber(-1);
		}
		this.relations.get(relPos);
		if (this.relations.hisKey.get()==null) {
			return Clarion.newNumber(0);
		}
		return Clarion.newNumber(1);
	}
}
