package clarion;

import clarion.Toolbartarget;
import clarion.Toolbartargetqueue;
import clarion.Windowmanager;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;

public class Toolbarclass
{
	public Toolbartargetqueue list;
	public Toolbarclass()
	{
		list=null;
	}

	public void addTarget(Toolbartarget t,ClarionNumber id)
	{
		CRun._assert(!(this.list==null));
		this.list.id.setValue(id);
		this.list.item.set(t);
		this.list.item.get().control.setValue(id);
		this.list.add(this.list.ORDER().ascend(this.list.id));
	}
	public void displayButtons()
	{
		CRun._assert(!(this.list==null) && this.list.id.boolValue());
		this.list.item.get().displayButtons();
	}
	public void init()
	{
		this.list=new Toolbartargetqueue();
		this.list.id.setValue(0);
	}
	public void kill()
	{
		//this.list;
	}
	public void setTarget()
	{
		setTarget(Clarion.newNumber(0));
	}
	public void setTarget(ClarionNumber id)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber hit=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		CRun._assert(!(this.list==null));
		if (id.boolValue()) {
			this.list.id.setValue(id);
			this.list.get(this.list.ORDER().ascend(this.list.id));
			CRun._assert(!(CError.errorCode()!=0));
			this.list.item.get().takeToolbar();
		}
		else {
			for (i.setValue(1);i.compareTo(this.list.records())<=0;i.increment(1)) {
				this.list.get(i);
				if (this.list.item.get().tryTakeToolbar().boolValue()) {
					hit.setValue(i);
				}
			}
			if (hit.boolValue()) {
				this.list.get(hit);
			}
		}
	}
	public void takeEvent(Windowmanager p1)
	{
		takeEvent((ClarionNumber)null,p1);
	}
	public void takeEvent(ClarionNumber vcr,Windowmanager wm)
	{
		CRun._assert(!(this.list==null));
		if (this.list.records()!=0) {
			this.list.item.get().takeEvent(vcr,wm);
		}
	}
}
