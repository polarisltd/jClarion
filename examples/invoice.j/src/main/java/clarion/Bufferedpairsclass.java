package clarion;

import clarion.Bufferedpairsqueue;
import clarion.Fieldpairsclass;
import clarion.Fieldpairsqueue;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.CRun;

public class Bufferedpairsclass extends Fieldpairsclass
{
	public Bufferedpairsqueue realList;
	public Bufferedpairsclass()
	{
		realList=null;
	}

	public void addPair(ClarionObject left,ClarionObject right)
	{
		ClarionAny temp=Clarion.newAny();
		CRun._assert(!(this.list==null));
		this.list.clear();
		this.list.left.setReferenceValue(left);
		this.list.right.setReferenceValue(right);
		temp.setValue(right);
		right.clear();
		this.realList.buffer.setValue(right);
		right.setValue(temp);
		this.list.add();
	}
	public void assignBufferToLeft()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		for (i.setValue(1);i.compareTo(this.list.records())<=0;i.increment(1)) {
			this.list.get(i);
			this.list.left.setValue(this.realList.buffer);
			this.realList.put();
		}
	}
	public void assignBufferToRight()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		for (i.setValue(1);i.compareTo(this.list.records())<=0;i.increment(1)) {
			this.list.get(i);
			this.list.right.setValue(this.realList.buffer);
			this.realList.put();
		}
	}
	public void assignLeftToBuffer()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		for (i.setValue(1);i.compareTo(this.list.records())<=0;i.increment(1)) {
			this.list.get(i);
			this.realList.buffer.setValue(this.list.left);
			this.realList.put();
		}
	}
	public void assignRightToBuffer()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		for (i.setValue(1);i.compareTo(this.list.records())<=0;i.increment(1)) {
			this.list.get(i);
			this.realList.buffer.setValue(this.list.right);
			this.realList.put();
		}
	}
	public ClarionNumber equalLeftBuffer()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		for (i.setValue(1);i.compareTo(this.list.records())<=0;i.increment(1)) {
			this.list.get(i);
			if (!this.realList.left.equals(this.realList.buffer)) {
				return Clarion.newNumber(0);
			}
		}
		return Clarion.newNumber(1);
	}
	public ClarionNumber equalRightBuffer()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		for (i.setValue(1);i.compareTo(this.list.records())<=0;i.increment(1)) {
			this.list.get(i);
			if (!this.realList.right.equals(this.realList.buffer)) {
				return Clarion.newNumber(0);
			}
		}
		return Clarion.newNumber(1);
	}
	public void init()
	{
		this.kill();
		this.realList=new Bufferedpairsqueue();
		this.list=(Fieldpairsqueue)CMemory.castTo(this.realList,Fieldpairsqueue.class);
	}
	public void kill()
	{
		if (!(this.realList==null)) {
			this.realList.get(1);
			while (!(CError.errorCode()!=0)) {
				this.realList.left.setReferenceValue(null);
				this.realList.right.setReferenceValue(null);
				this.realList.buffer.setReferenceValue(null);
				this.realList.get(this.realList.getPointer()+1);
			}
			//this.realList;
		}
		this.list=(Fieldpairsqueue)CMemory.castTo(this.realList,Fieldpairsqueue.class);
	}
}
