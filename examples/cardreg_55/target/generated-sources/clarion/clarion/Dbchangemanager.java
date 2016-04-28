package clarion;

import clarion.Bufferedpairsclass;
import clarion.Dbnamequeue;
import clarion.Dbtriggerqueue;
import clarion.Fieldpairsclass;
import clarion.Idbchangeaudit;
import clarion.equates.Constants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;

public class Dbchangemanager
{
	public Dbtriggerqueue triggerQueue;
	public Dbnamequeue nameQueue;
	public Idbchangeaudit dbChangeAudit;
	public Dbchangemanager()
	{
		triggerQueue=null;
		nameQueue=null;
		dbChangeAudit=null;
	}

	public void addItem(ClarionObject left,ClarionString name,ClarionString fileName)
	{
		if (this.setThread(fileName.like()).boolValue()) {
			this.triggerQueue.bfp.get().addItem(left);
			this.nameQueue.fileName.setValue(fileName);
			this.nameQueue.fieldName.setValue(name);
			this.nameQueue.get(this.nameQueue.ORDER().ascend(this.nameQueue.fileName).ascend(this.nameQueue.fieldName));
			if (CError.errorCode()!=0) {
				this.nameQueue.ptr.setValue(this.triggerQueue.bfp.get().list.records());
				this.nameQueue.add();
			}
		}
	}
	public void addThread(ClarionString fileName)
	{
		this.triggerQueue.id.setValue(CRun.getThreadID());
		this.triggerQueue.bfp.set(new Bufferedpairsclass());
		this.triggerQueue.bfp.get().init();
		this.triggerQueue.add();
	}
	public void checkChanges(ClarionString fileName,ClarionFile file)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		this.dbChangeAudit.beforeChange(fileName.like(),this.triggerQueue.bfp.get());
		if (this.setThread(fileName.like()).boolValue()) {
			for (i.setValue(1);i.compareTo(this.triggerQueue.bfp.get().list.records())<=0;i.increment(1)) {
				this.triggerQueue.bfp.get().list.get(i);
				this.checkPair(this.triggerQueue.bfp.get());
			}
		}
		this.dbChangeAudit.onChange(fileName.like(),file);
	}
	public void checkPair(Fieldpairsclass fp)
	{
		if (!fp.list.left.equals(fp.list.right)) {
			this.nameQueue.ptr.setValue(this.triggerQueue.bfp.get().list.getPointer());
			this.nameQueue.get(this.nameQueue.ORDER().ascend(this.nameQueue.ptr));
			this.dbChangeAudit.changeField(fp.list.left,fp.list.right,this.nameQueue.fieldName.like(),this.nameQueue.fileName.like());
		}
	}
	public ClarionNumber equal(ClarionString fileName)
	{
		if (this.setThread(fileName.like()).boolValue()) {
			return this.triggerQueue.bfp.get().equal();
		}
		else {
			return Clarion.newNumber(Constants.TRUE);
		}
	}
	public void init(Idbchangeaudit iDbC)
	{
		this.dbChangeAudit=iDbC;
		this.triggerQueue=new Dbtriggerqueue();
		this.nameQueue=new Dbnamequeue();
	}
	public void kill()
	{
		while (true) {
			this.triggerQueue.get(1);
			if (CError.errorCode()!=0) {
				break;
			}
			this.triggerQueue.bfp.get().kill();
			//this.triggerQueue.bfp.get();
			this.triggerQueue.delete();
		}
		//this.triggerQueue;
		this.nameQueue.free();
		//this.nameQueue;
	}
	public void update(ClarionString fileName)
	{
		if (this.setThread(fileName.like()).boolValue()) {
			this.triggerQueue.bfp.get().assignLeftToRight();
		}
	}
	public ClarionNumber setThread(ClarionString fileName)
	{
		this.triggerQueue.id.setValue(CRun.getThreadID());
		this.triggerQueue.fileName.setValue(fileName);
		this.triggerQueue.get(this.triggerQueue.ORDER().ascend(this.triggerQueue.id).ascend(this.triggerQueue.fileName));
		if (CError.errorCode()!=0) {
			return Clarion.newNumber(Constants.FALSE);
		}
		else {
			return Clarion.newNumber(Constants.TRUE);
		}
	}
}
