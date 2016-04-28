package clarion.abutil;

import clarion.Fieldpairsqueue;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;

@SuppressWarnings("all")
public class Fieldpairsclass
{
	public Fieldpairsqueue list=null;
	public Fieldpairsclass()
	{
		list=null;
	}

	public void addpair(ClarionObject left,ClarionObject right)
	{
		CRun._assert(!(this.list==null));
		this.list.clear();
		this.list.left.setReferenceValue(left);
		this.list.right.setReferenceValue(right);
		this.list.add();
	}
	public void additem(ClarionObject left)
	{
		CRun._assert(!(this.list==null));
		this.list.clear();
		this.list.left.setReferenceValue(left);
		this.list.right.setValue(left);
		this.list.add();
	}
	public void assignlefttoright()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		final int loop_1=this.list.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.list.get(i);
			this.list.right.setValue(this.list.left);
			this.list.put();
		}
	}
	public void assignrighttoleft()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		final int loop_1=this.list.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.list.get(i);
			this.list.left.setValue(this.list.right);
			this.list.put();
		}
	}
	public void clearleft()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		final int loop_1=this.list.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.list.get(i);
			this.list.left.clear();
		}
	}
	public void clearright()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		final int loop_1=this.list.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.list.get(i);
			this.list.right.clear();
		}
	}
	public ClarionNumber equal()
	{
		return this.equalleftright();
	}
	public ClarionNumber equalleftright()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		final int loop_1=this.list.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.list.get(i);
			if (!this.list.left.equals(this.list.right)) {
				return Clarion.newNumber(0);
			}
		}
		return Clarion.newNumber(1);
	}
	public void kill()
	{
		if (!(this.list==null)) {
			this.list.get(1);
			while (!(CError.errorCode()!=0)) {
				this.list.left.setReferenceValue(null);
				this.list.right.setReferenceValue(null);
				this.list.get(this.list.getPointer()+1);
			}
			//this.list;
		}
	}
	public void init()
	{
		this.kill();
		this.list=new Fieldpairsqueue();
	}
}
