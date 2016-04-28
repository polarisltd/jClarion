package clarion;

import clarion.Fieldpairsqueue;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;

public class Fieldpairsclass
{
	public Fieldpairsqueue list;
	public Fieldpairsclass()
	{
		list=null;
	}

	public void addPair(ClarionObject left,ClarionObject right)
	{
		CRun._assert(!(this.list==null));
		this.list.clear();
		this.list.left.setReferenceValue(left);
		this.list.right.setReferenceValue(right);
		this.list.add();
	}
	public void addItem(ClarionObject left)
	{
		CRun._assert(!(this.list==null));
		this.list.clear();
		this.list.left.setReferenceValue(left);
		this.list.right.setValue(left);
		this.list.add();
	}
	public void assignLeftToRight()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		for (i.setValue(1);i.compareTo(this.list.records())<=0;i.increment(1)) {
			this.list.get(i);
			this.list.right.setValue(this.list.left);
			this.list.put();
		}
	}
	public void assignRightToLeft()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		for (i.setValue(1);i.compareTo(this.list.records())<=0;i.increment(1)) {
			this.list.get(i);
			this.list.left.setValue(this.list.right);
			this.list.put();
		}
	}
	public void clearLeft()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		for (i.setValue(1);i.compareTo(this.list.records())<=0;i.increment(1)) {
			this.list.get(i);
			this.list.left.clear();
		}
	}
	public void clearRight()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		for (i.setValue(1);i.compareTo(this.list.records())<=0;i.increment(1)) {
			this.list.get(i);
			this.list.right.clear();
		}
	}
	public ClarionNumber equal()
	{
		return this.equalLeftRight();
	}
	public ClarionNumber equalLeftRight()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		for (i.setValue(1);i.compareTo(this.list.records())<=0;i.increment(1)) {
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
