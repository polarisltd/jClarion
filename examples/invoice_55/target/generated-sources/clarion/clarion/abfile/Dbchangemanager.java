package clarion.abfile;

import clarion.Dbnamequeue;
import clarion.Dbtriggerqueue;
import clarion.Idbchangeaudit;
import clarion.abutil.Bufferedpairsclass;
import clarion.abutil.Fieldpairsclass;
import clarion.equates.Constants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;

@SuppressWarnings("all")
public class Dbchangemanager
{
	public Dbtriggerqueue triggerqueue=null;
	public Dbnamequeue namequeue=null;
	public Idbchangeaudit dbchangeaudit=null;
	public Dbchangemanager()
	{
		triggerqueue=null;
		namequeue=null;
		dbchangeaudit=null;
	}

	public void additem(ClarionObject left,ClarionString name,ClarionString filename)
	{
		if (this.setthread(filename.like()).boolValue()) {
			this.triggerqueue.bfp.get().additem(left);
			this.namequeue.filename.setValue(filename);
			this.namequeue.fieldname.setValue(name);
			this.namequeue.get(this.namequeue.ORDER().ascend(this.namequeue.filename).ascend(this.namequeue.fieldname));
			if (CError.errorCode()!=0) {
				this.namequeue.ptr.setValue(this.triggerqueue.bfp.get().list.records());
				this.namequeue.add();
			}
		}
	}
	public void addthread(ClarionString filename)
	{
		this.triggerqueue.id.setValue(CRun.getThreadID());
		this.triggerqueue.bfp.set(new Bufferedpairsclass());
		this.triggerqueue.bfp.get().init();
		this.triggerqueue.add();
	}
	public void checkchanges(ClarionString filename,ClarionFile file)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		this.dbchangeaudit.beforechange(filename.like(),this.triggerqueue.bfp.get());
		if (this.setthread(filename.like()).boolValue()) {
			final int loop_1=this.triggerqueue.bfp.get().list.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
				this.triggerqueue.bfp.get().list.get(i);
				this.checkpair(this.triggerqueue.bfp.get());
			}
		}
		this.dbchangeaudit.onchange(filename.like(),file);
	}
	public void checkpair(Fieldpairsclass fp)
	{
		if (!fp.list.left.equals(fp.list.right)) {
			this.namequeue.ptr.setValue(this.triggerqueue.bfp.get().list.getPointer());
			this.namequeue.get(this.namequeue.ORDER().ascend(this.namequeue.ptr));
			this.dbchangeaudit.changefield(fp.list.left,fp.list.right,this.namequeue.fieldname.like(),this.namequeue.filename.like());
		}
	}
	public ClarionNumber equal(ClarionString filename)
	{
		if (this.setthread(filename.like()).boolValue()) {
			return this.triggerqueue.bfp.get().equal();
		}
		else {
			return Clarion.newNumber(Constants.TRUE);
		}
	}
	public void init(Idbchangeaudit idbc)
	{
		this.dbchangeaudit=idbc;
		this.triggerqueue=new Dbtriggerqueue();
		this.namequeue=new Dbnamequeue();
	}
	public void kill()
	{
		while (true) {
			this.triggerqueue.get(1);
			if (CError.errorCode()!=0) {
				break;
			}
			this.triggerqueue.bfp.get().kill();
			//this.triggerqueue.bfp.get();
			this.triggerqueue.delete();
		}
		//this.triggerqueue;
		this.namequeue.free();
		//this.namequeue;
	}
	public void update(ClarionString filename)
	{
		if (this.setthread(filename.like()).boolValue()) {
			this.triggerqueue.bfp.get().assignlefttoright();
		}
	}
	public ClarionNumber setthread(ClarionString filename)
	{
		this.triggerqueue.id.setValue(CRun.getThreadID());
		this.triggerqueue.filename.setValue(filename);
		this.triggerqueue.get(this.triggerqueue.ORDER().ascend(this.triggerqueue.id).ascend(this.triggerqueue.filename));
		if (CError.errorCode()!=0) {
			return Clarion.newNumber(Constants.FALSE);
		}
		else {
			return Clarion.newNumber(Constants.TRUE);
		}
	}
}
