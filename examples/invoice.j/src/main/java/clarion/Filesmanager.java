package clarion;

import clarion.Errorclass;
import clarion.Filemanager;
import clarion.Filemapping_t;
import clarion.Statusq_t;
import clarion.equates.Level;
import clarion.equates.Usetype;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.ref.RefVariable;

public class Filesmanager extends org.jclarion.clarion.AbstractThreaded
{
	public RefVariable<Errorclass> errs;
	public RefVariable<Filemapping_t> fileMapping;
	public RefVariable<Statusq_t> statusQ;
	public Filesmanager()
	{
		errs=new RefVariable<Errorclass>(null);
		fileMapping=new RefVariable<Filemapping_t>(null);
		statusQ=new RefVariable<Statusq_t>(null);
		construct();
	}
	public void initThread() {
		super.initThread();
		errs.setThread();
		fileMapping.setThread();
		statusQ.setThread();
		CRun.addInitThreadHook(new Runnable() { public void run() { construct(); } });
	}
	protected void lock(Filesmanager base,Thread thread)
	{
		super.lock(base,thread);
		this.errs=(RefVariable<Errorclass>)this.errs.getLockedObject(thread);
		this.fileMapping=(RefVariable<Filemapping_t>)this.fileMapping.getLockedObject(thread);
		this.statusQ=(RefVariable<Statusq_t>)this.statusQ.getLockedObject(thread);
	}
	public Object getLockedObject(Thread thread)
	{
		Filesmanager result=new Filesmanager();
		result.lock(this,thread);
		return result;
	}

	public void construct()
	{
		this.fileMapping.set(new Filemapping_t());
		this.statusQ.set(new Statusq_t());
	}
	public void destruct()
	{
		//this.statusQ.get();
		//this.fileMapping.get();
	}
	public void addFileMapping(Filemanager fm)
	{
		this.errs.set(fm.errors);
		this.fileMapping.get().fileLabel.setValue(this.getFileID(fm.file));
		this.fileMapping.get().get(this.fileMapping.get().ORDER().ascend(this.fileMapping.get().fileLabel));
		this.fileMapping.get().fileLabel.setValue(this.getFileID(fm.file));
		this.fileMapping.get().fileManager.set(fm);
		this.fileMapping.get().add(this.fileMapping.get().ORDER().ascend(this.fileMapping.get().fileLabel));
	}
	public ClarionNumber findRecord(Filemanager fm)
	{
		ClarionNumber fid=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber th=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		th.setValue(CRun.getThreadID());
		this.statusQ.get().sort(this.statusQ.get().ORDER().ascend(this.statusQ.get().thread).ascend(this.statusQ.get().id).ascend(this.statusQ.get().scopeLevel));
		fid.setValue(this.getFileID(fm.file));
		this.statusQ.get().id.setValue(fid);
		this.statusQ.get().thread.setValue(CRun.getThreadID());
		this.statusQ.get().scopeLevel.setValue(1);
		this.statusQ.get().get(this.statusQ.get().ORDER().ascend(this.statusQ.get().thread).ascend(this.statusQ.get().id).ascend(this.statusQ.get().scopeLevel));
		if (CError.errorCode()!=0) {
			return Clarion.newNumber(Level.NOTIFY);
		}
		while (this.statusQ.get().thread.equals(CRun.getThreadID()) && this.statusQ.get().id.equals(fid)) {
			this.statusQ.get().get(this.statusQ.get().getPointer()+1);
			if (CError.errorCode()!=0) {
				this.statusQ.get().get(this.statusQ.get().getPointer());
				return Clarion.newNumber(Level.BENIGN);
			}
		}
		this.statusQ.get().get(this.statusQ.get().getPointer()-1);
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber getFileID(ClarionFile thisFile)
	{
		return Clarion.newNumber(CMemory.instance(thisFile,CRun.getThreadID()));
	}
	public Filemanager getFileMapping(ClarionNumber fileLabel)
	{
		this.fileMapping.get().fileLabel.setValue(fileLabel);
		this.fileMapping.get().get(this.fileMapping.get().ORDER().ascend(this.fileMapping.get().fileLabel));
		if (!(CError.errorCode()!=0)) {
			return this.fileMapping.get().fileManager.get();
		}
		return null;
	}
	public void noteClose(Filemanager fm)
	{
		if (!this.findRecord(fm).boolValue() && this.statusQ.get().proc.equals(this.errs.get().getProcedureName())) {
			if (this.statusQ.get().nestedOpen.boolValue()) {
				this.statusQ.get().nestedOpen.decrement(1);
				this.statusQ.get().put();
			}
			else {
				if (this.statusQ.get().hold.boolValue()) {
					fm.restoreFile(this.statusQ.get().hold,Clarion.newNumber(this.statusQ.get().uStat.compareTo(Usetype.RETURNS)<0 ? 1 : 0));
				}
				this.statusQ.get().delete();
			}
		}
	}
	public void noteOpen(Filemanager fm)
	{
		if (!this.findRecord(fm).boolValue() && this.statusQ.get().proc.equals(this.errs.get().getProcedureName())) {
			this.statusQ.get().nestedOpen.increment(1);
			this.statusQ.get().put();
		}
	}
	public void noteUsage(Filemanager fm,ClarionNumber level)
	{
		if (this.findRecord(fm).boolValue()) {
			this.statusQ.get().scopeLevel.setValue(0);
			noteUsage_AddQ(level);
		}
		else if (this.statusQ.get().proc.equals(this.errs.get().getProcedureName())) {
			if (level.compareTo(this.statusQ.get().uStat)>0) {
				this.statusQ.get().uStat.setValue(level);
				this.statusQ.get().put();
			}
		}
		else {
			noteUsage_AddQ(level);
			if (level.compareTo(Usetype.RETURNS)<0 && !this.statusQ.get().hold.boolValue()) {
				this.statusQ.get().hold.setValue(fm.saveFile());
				this.statusQ.get().put();
			}
		}
	}
	public void noteUsage_AddQ(ClarionNumber level)
	{
		this.statusQ.get().thread.setValue(CRun.getThreadID());
		this.statusQ.get().proc.setValue(this.errs.get().getProcedureName());
		this.statusQ.get().uStat.setValue(level);
		this.statusQ.get().scopeLevel.increment(1);
		this.statusQ.get().hold.setValue(0);
		this.statusQ.get().nestedOpen.setValue(0);
		this.statusQ.get().add();
	}
	public void removeFileMapping(ClarionNumber fileLabel)
	{
		if (!(this.getFileMapping(fileLabel.like())==null)) {
			this.fileMapping.get().delete();
		}
	}
	public void removeFileMapping(Filemanager fm)
	{
		this.removeFileMapping(this.getFileID(fm.file));
	}
	public void trace(ClarionString s)
	{
	}
}
