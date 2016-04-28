package clarion.abutil;

import clarion.Bufferedpairsqueue;
import clarion.Fieldpairsqueue;
import clarion.abutil.Fieldpairsclass;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.CRun;

@SuppressWarnings("all")
public class Bufferedpairsclass extends Fieldpairsclass
{
	public Bufferedpairsqueue reallist=null;
	public Bufferedpairsclass()
	{
		reallist=null;
	}

	public void addpair(ClarionObject left,ClarionObject right)
	{
		ClarionAny temp=Clarion.newAny();
		CRun._assert(!(this.list==null));
		this.list.clear();
		this.list.left.setReferenceValue(left);
		this.list.right.setReferenceValue(right);
		temp.setValue(right);
		right.clear();
		this.reallist.buffer.setValue(right);
		right.setValue(temp);
		this.list.add();
	}
	public void assignbuffertoleft()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		final int loop_1=this.list.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.list.get(i);
			this.list.left.setValue(this.reallist.buffer);
			this.reallist.put();
		}
	}
	public void assignbuffertoright()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		final int loop_1=this.list.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.list.get(i);
			this.list.right.setValue(this.reallist.buffer);
			this.reallist.put();
		}
	}
	public void assignlefttobuffer()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		final int loop_1=this.list.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.list.get(i);
			this.reallist.buffer.setValue(this.list.left);
			this.reallist.put();
		}
	}
	public void assignrighttobuffer()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		final int loop_1=this.list.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.list.get(i);
			this.reallist.buffer.setValue(this.list.right);
			this.reallist.put();
		}
	}
	public ClarionNumber equalleftbuffer()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		final int loop_1=this.list.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.list.get(i);
			if (!this.reallist.left.equals(this.reallist.buffer)) {
				return Clarion.newNumber(0);
			}
		}
		return Clarion.newNumber(1);
	}
	public ClarionNumber equalrightbuffer()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		final int loop_1=this.list.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.list.get(i);
			if (!this.reallist.right.equals(this.reallist.buffer)) {
				return Clarion.newNumber(0);
			}
		}
		return Clarion.newNumber(1);
	}
	public void init()
	{
		this.kill();
		this.reallist=new Bufferedpairsqueue();
		this.list=(Fieldpairsqueue)CMemory.castTo(this.reallist,Fieldpairsqueue.class);
	}
	public void kill()
	{
		if (!(this.reallist==null)) {
			this.reallist.get(1);
			while (!(CError.errorCode()!=0)) {
				this.reallist.left.setReferenceValue(null);
				this.reallist.right.setReferenceValue(null);
				this.reallist.buffer.setReferenceValue(null);
				this.reallist.get(this.reallist.getPointer()+1);
			}
			//this.reallist;
		}
		this.list=(Fieldpairsqueue)CMemory.castTo(this.reallist,Fieldpairsqueue.class);
	}
}
