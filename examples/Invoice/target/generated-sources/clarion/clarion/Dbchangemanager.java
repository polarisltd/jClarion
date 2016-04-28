package clarion;

import clarion.Bufferedpairsclass;
import clarion.Criticalprocedure;
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
import org.jclarion.clarion.runtime.concurrent.ICriticalSection;

public class Dbchangemanager
{
	public Dbtriggerqueue triggerQueue;
	public Dbnamequeue nameQueue;
	public Idbchangeaudit dbChangeAudit;
	public ICriticalSection crit;
	public ClarionNumber inited;
	public Dbchangemanager()
	{
		triggerQueue=null;
		nameQueue=null;
		dbChangeAudit=null;
		crit=null;
		inited=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		construct();
	}

	public void addItem(ClarionObject left,ClarionString name,ClarionString filename)
	{
		Criticalprocedure cp=new Criticalprocedure();
		try {
			cp.init(this.crit);
			if (this.setThread(filename.like()).boolValue()) {
				this.triggerQueue.bfp.get().addItem(left);
				this.nameQueue.filename.setValue(filename);
				this.nameQueue.fieldName.setValue(name);
				this.nameQueue.get(this.nameQueue.ORDER().ascend(this.nameQueue.filename).ascend(this.nameQueue.fieldName));
				if (CError.errorCode()!=0) {
					this.nameQueue.ptr.setValue(this.triggerQueue.bfp.get().list.records());
					this.nameQueue.add();
				}
			}
		} finally {
			cp.destruct();
		}
	}
	public void addThread(ClarionString filename)
	{
		Criticalprocedure cp=new Criticalprocedure();
		try {
			cp.init(this.crit);
			this.triggerQueue.id.setValue(CRun.getThreadID());
			this.triggerQueue.bfp.set(new Bufferedpairsclass());
			this.triggerQueue.bfp.get().init();
			this.triggerQueue.add();
		} finally {
			cp.destruct();
		}
	}
	public void checkChanges(ClarionString filename,ClarionFile file)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		Criticalprocedure cp=new Criticalprocedure();
		try {
			cp.init(this.crit);
			this.dbChangeAudit.beforeChange(filename.like(),this.triggerQueue.bfp.get());
			if (this.setThread(filename.like()).boolValue()) {
				for (i.setValue(1);i.compareTo(this.triggerQueue.bfp.get().list.records())<=0;i.increment(1)) {
					this.triggerQueue.bfp.get().list.get(i);
					this.checkPair(this.triggerQueue.bfp.get());
				}
			}
			this.dbChangeAudit.onChange(filename.like(),file);
		} finally {
			cp.destruct();
		}
	}
	public void checkPair(Fieldpairsclass fp)
	{
		Criticalprocedure cp=new Criticalprocedure();
		try {
			cp.init(this.crit);
			if (!fp.list.left.equals(fp.list.right)) {
				this.nameQueue.ptr.setValue(this.triggerQueue.bfp.get().list.getPointer());
				this.nameQueue.get(this.nameQueue.ORDER().ascend(this.nameQueue.ptr));
				this.dbChangeAudit.changeField(fp.list.left,fp.list.right,this.nameQueue.fieldName.like(),this.nameQueue.filename.like());
			}
		} finally {
			cp.destruct();
		}
	}
	public ClarionNumber equal(ClarionString filename)
	{
		Criticalprocedure cp=new Criticalprocedure();
		try {
			cp.init(this.crit);
			if (this.setThread(filename.like()).boolValue()) {
				return this.triggerQueue.bfp.get().equal();
			}
			else {
				return Clarion.newNumber(Constants.TRUE);
			}
		} finally {
			cp.destruct();
		}
	}
	public void init(Idbchangeaudit iDbC)
	{
		this.crit=new ICriticalSection();
		this.dbChangeAudit=iDbC;
		this.triggerQueue=new Dbtriggerqueue();
		this.nameQueue=new Dbnamequeue();
		this.inited.setValue(Constants.TRUE);
	}
	public void kill()
	{
		if (this.inited.boolValue()) {
			this.inited.setValue(Constants.FALSE);
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
			this.crit.Kill();
		}
	}
	public void update(ClarionString filename)
	{
		Criticalprocedure cp=new Criticalprocedure();
		try {
			cp.init(this.crit);
			if (this.setThread(filename.like()).boolValue()) {
				this.triggerQueue.bfp.get().assignLeftToRight();
			}
		} finally {
			cp.destruct();
		}
	}
	public ClarionNumber setThread(ClarionString filename)
	{
		Criticalprocedure cp=new Criticalprocedure();
		try {
			cp.init(this.crit);
			this.triggerQueue.id.setValue(CRun.getThreadID());
			this.triggerQueue.filename.setValue(filename);
			this.triggerQueue.get(this.triggerQueue.ORDER().ascend(this.triggerQueue.id).ascend(this.triggerQueue.filename));
			if (CError.errorCode()!=0) {
				return Clarion.newNumber(Constants.FALSE);
			}
			else {
				return Clarion.newNumber(Constants.TRUE);
			}
		} finally {
			cp.destruct();
		}
	}
	public void construct()
	{
	}
	public void destruct()
	{
		this.kill();
	}
}
