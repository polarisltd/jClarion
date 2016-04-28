package clarion;

import clarion.Abfile;
import clarion.Errorclass;
import clarion.Filemanager;
import clarion.Mygrp;
import clarion.equates.Level;
import clarion.equates.Usetype;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;

public class Filesmanager
{
	public Errorclass errs;
	public Filesmanager()
	{
		errs=null;
		construct();
	}

	public void addFileMapping(Filemanager fm)
	{
		this.errs=fm.errors;
		Abfile.fileMapping.fileLabel.setValue(this.getFileID(fm.file));
		Abfile.fileMapping.get(Abfile.fileMapping.ORDER().ascend(Abfile.fileMapping.fileLabel));
		Abfile.fileMapping.fileLabel.setValue(this.getFileID(fm.file));
		Abfile.fileMapping.fileManager.set(fm);
		Abfile.fileMapping.add(Abfile.fileMapping.ORDER().ascend(Abfile.fileMapping.fileLabel));
	}
	public void construct()
	{
	}
	public void destruct()
	{
	}
	public ClarionNumber findRecord(Filemanager fm)
	{
		ClarionNumber fid=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber th=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		Abfile.statusQ.sort(Abfile.statusQ.ORDER().ascend(Abfile.statusQ.thread).ascend(Abfile.statusQ.id).ascend(Abfile.statusQ.scopeLevel));
		fid.setValue(this.getFileID(fm.file));
		Abfile.statusQ.id.setValue(fid);
		th.setValue(CRun.getThreadID());
		Abfile.statusQ.thread.setValue(th);
		Abfile.statusQ.scopeLevel.setValue(1);
		Abfile.statusQ.get(Abfile.statusQ.ORDER().ascend(Abfile.statusQ.thread).ascend(Abfile.statusQ.id).ascend(Abfile.statusQ.scopeLevel));
		if (CError.errorCode()!=0) {
			return Clarion.newNumber(Level.NOTIFY);
		}
		while (Abfile.statusQ.thread.equals(th) && Abfile.statusQ.id.equals(fid)) {
			Abfile.statusQ.get(Abfile.statusQ.getPointer()+1);
			if (CError.errorCode()!=0) {
				Abfile.statusQ.get(Abfile.statusQ.getPointer());
				return Clarion.newNumber(Level.BENIGN);
			}
		}
		Abfile.statusQ.get(Abfile.statusQ.getPointer()-1);
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber getFileID(ClarionFile thisFile)
	{
		Mygrp myGrp=new Mygrp();
		ClarionNumber myHash=Clarion.newNumber().setEncoding(ClarionNumber.LONG).setOver(myGrp);
		myGrp.fr.set(thisFile);
		return myHash.like();
	}
	public void getFileMapping(ClarionNumber fileLabel)
	{
		Abfile.fileMapping.fileLabel.setValue(fileLabel);
		Abfile.fileMapping.get(Abfile.fileMapping.ORDER().ascend(Abfile.fileMapping.fileLabel));
	}
	public void noteClose(Filemanager fm)
	{
		if (!this.findRecord(fm).boolValue() && Abfile.statusQ.proc.equals(this.errs.getProcedureName())) {
			if (Abfile.statusQ.nestedOpen.boolValue()) {
				Abfile.statusQ.nestedOpen.decrement(1);
				Abfile.statusQ.put();
			}
			else {
				if (Abfile.statusQ.hold.boolValue()) {
					fm.restoreFile(Abfile.statusQ.hold,Clarion.newNumber(Abfile.statusQ.uStat.compareTo(Usetype.RETURNS)<0 ? 1 : 0));
				}
				Abfile.statusQ.delete();
			}
		}
	}
	public void noteOpen(Filemanager fm)
	{
		if (!this.findRecord(fm).boolValue() && Abfile.statusQ.proc.equals(this.errs.getProcedureName())) {
			Abfile.statusQ.nestedOpen.increment(1);
			Abfile.statusQ.put();
		}
	}
	public void noteUsage(Filemanager fm,ClarionNumber level)
	{
		if (this.findRecord(fm).boolValue()) {
			Abfile.statusQ.scopeLevel.setValue(0);
			noteUsage_AddQ(level);
		}
		else if (Abfile.statusQ.proc.equals(this.errs.getProcedureName())) {
			if (level.compareTo(Abfile.statusQ.uStat)>0) {
				Abfile.statusQ.uStat.setValue(level);
				Abfile.statusQ.put();
			}
		}
		else {
			noteUsage_AddQ(level);
			if (level.compareTo(Usetype.RETURNS)<0 && !Abfile.statusQ.hold.boolValue()) {
				Abfile.statusQ.hold.setValue(fm.saveFile());
				Abfile.statusQ.put();
			}
		}
	}
	public void noteUsage_AddQ(ClarionNumber level)
	{
		Abfile.statusQ.proc.setValue(this.errs.getProcedureName());
		Abfile.statusQ.uStat.setValue(level);
		Abfile.statusQ.scopeLevel.increment(1);
		Abfile.statusQ.hold.setValue(0);
		Abfile.statusQ.nestedOpen.setValue(0);
		Abfile.statusQ.add();
	}
	public void removeFileMapping(ClarionNumber fileLabel)
	{
		this.getFileMapping(fileLabel.like());
		Abfile.fileMapping.delete();
	}
	public void removeFileMapping(Filemanager fm)
	{
		this.removeFileMapping(Abfile.filesManager.getFileID(fm.file));
	}
	public void trace(ClarionString s)
	{
	}
}
