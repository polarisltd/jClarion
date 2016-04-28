package clarion.abfile;

import clarion.aberror.Errorclass;
import clarion.abfile.Abfile;
import clarion.abfile.Filemanager;
import clarion.abfile.Mygrp;
import clarion.equates.Level;
import clarion.equates.Usetype;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;

@SuppressWarnings("all")
public class Filesmanager
{
	public Errorclass errs=null;
	public Filesmanager()
	{
		errs=null;
		if (this.getClass()==Filesmanager.class) construct();
	}

	public void addfilemapping(Filemanager fm)
	{
		this.errs=fm.errors;
		Abfile.filemapping.filelabel.setValue(this.getfileid(fm.file));
		Abfile.filemapping.get(Abfile.filemapping.ORDER().ascend(Abfile.filemapping.filelabel));
		Abfile.filemapping.filelabel.setValue(this.getfileid(fm.file));
		Abfile.filemapping.filemanager.set(fm);
		Abfile.filemapping.add(Abfile.filemapping.ORDER().ascend(Abfile.filemapping.filelabel));
	}
	public void construct()
	{
	}
	public void destruct()
	{
	}
	public ClarionNumber findrecord(Filemanager fm)
	{
		ClarionNumber fid=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber th=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		Abfile.statusq.sort(Abfile.statusq.ORDER().ascend(Abfile.statusq.thread).ascend(Abfile.statusq.id).ascend(Abfile.statusq.scopelevel));
		fid.setValue(this.getfileid(fm.file));
		Abfile.statusq.id.setValue(fid);
		th.setValue(CRun.getThreadID());
		Abfile.statusq.thread.setValue(th);
		Abfile.statusq.scopelevel.setValue(1);
		Abfile.statusq.get(Abfile.statusq.ORDER().ascend(Abfile.statusq.thread).ascend(Abfile.statusq.id).ascend(Abfile.statusq.scopelevel));
		if (CError.errorCode()!=0) {
			return Clarion.newNumber(Level.NOTIFY);
		}
		while (Abfile.statusq.thread.equals(th) && Abfile.statusq.id.equals(fid)) {
			Abfile.statusq.get(Abfile.statusq.getPointer()+1);
			if (CError.errorCode()!=0) {
				Abfile.statusq.get(Abfile.statusq.getPointer());
				return Clarion.newNumber(Level.BENIGN);
			}
		}
		Abfile.statusq.get(Abfile.statusq.getPointer()-1);
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber getfileid(ClarionFile thisfile)
	{
		Mygrp mygrp=new Mygrp();
		ClarionNumber myhash=Clarion.newNumber().setEncoding(ClarionNumber.LONG).setOver(mygrp);
		mygrp.fr.set(thisfile);
		return myhash.like();
	}
	public void getfilemapping(ClarionNumber filelabel)
	{
		Abfile.filemapping.filelabel.setValue(filelabel);
		Abfile.filemapping.get(Abfile.filemapping.ORDER().ascend(Abfile.filemapping.filelabel));
	}
	public void noteclose(Filemanager fm)
	{
		if (!this.findrecord(fm).boolValue() && Abfile.statusq.proc.equals(this.errs.getprocedurename())) {
			if (Abfile.statusq.nestedopen.boolValue()) {
				Abfile.statusq.nestedopen.decrement(1);
				Abfile.statusq.put();
			}
			else {
				if (Abfile.statusq.hold.boolValue()) {
					fm.restorefile(Abfile.statusq.hold,Clarion.newNumber(Abfile.statusq.ustat.compareTo(Usetype.RETURNS)<0 ? 1 : 0));
				}
				Abfile.statusq.delete();
			}
		}
	}
	public void noteopen(Filemanager fm)
	{
		if (!this.findrecord(fm).boolValue() && Abfile.statusq.proc.equals(this.errs.getprocedurename())) {
			Abfile.statusq.nestedopen.increment(1);
			Abfile.statusq.put();
		}
	}
	public void noteusage(Filemanager fm,ClarionNumber level)
	{
		if (this.findrecord(fm).boolValue()) {
			Abfile.statusq.scopelevel.setValue(0);
			noteusage_addq(level);
		}
		else if (Abfile.statusq.proc.equals(this.errs.getprocedurename())) {
			if (level.compareTo(Abfile.statusq.ustat)>0) {
				Abfile.statusq.ustat.setValue(level);
				Abfile.statusq.put();
			}
		}
		else {
			noteusage_addq(level);
			if (level.compareTo(Usetype.RETURNS)<0 && !Abfile.statusq.hold.boolValue()) {
				Abfile.statusq.hold.setValue(fm.savefile());
				Abfile.statusq.put();
			}
		}
	}
	public void noteusage_addq(ClarionNumber level)
	{
		Abfile.statusq.proc.setValue(this.errs.getprocedurename());
		Abfile.statusq.ustat.setValue(level);
		Abfile.statusq.scopelevel.increment(1);
		Abfile.statusq.hold.setValue(0);
		Abfile.statusq.nestedopen.setValue(0);
		Abfile.statusq.add();
	}
	public void removefilemapping(ClarionNumber filelabel)
	{
		this.getfilemapping(filelabel.like());
		Abfile.filemapping.delete();
	}
	public void removefilemapping(Filemanager fm)
	{
		this.removefilemapping(Abfile.filesmanager.getfileid(fm.file));
	}
	public void trace(ClarionString s)
	{
	}
}
