package clarion.abtoolba;

import clarion.abtoolba.Toolbartarget;
import clarion.abtoolba.Toolbartargetqueue;
import clarion.abwindow.Windowmanager;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;

@SuppressWarnings("all")
public class Toolbarclass
{
	public Toolbartargetqueue list=null;
	public Toolbarclass()
	{
		list=null;
	}

	public void addtarget(Toolbartarget t,ClarionNumber id)
	{
		CRun._assert(!(this.list==null));
		this.list.id.setValue(id);
		this.list.item.set(t);
		this.list.item.get().control.setValue(id);
		this.list.add(this.list.ORDER().ascend(this.list.id));
	}
	public void displaybuttons()
	{
		CRun._assert(!(this.list==null) && this.list.id.boolValue());
		this.list.item.get().displaybuttons();
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
	public void settarget()
	{
		settarget(Clarion.newNumber(0));
	}
	public void settarget(ClarionNumber id)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber hit=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		CRun._assert(!(this.list==null));
		if (id.boolValue()) {
			this.list.id.setValue(id);
			this.list.get(this.list.ORDER().ascend(this.list.id));
			CRun._assert(!(CError.errorCode()!=0));
			this.list.item.get().taketoolbar();
		}
		else {
			final int loop_1=this.list.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
				this.list.get(i);
				if (this.list.item.get().trytaketoolbar().boolValue()) {
					hit.setValue(i);
				}
			}
			if (hit.boolValue()) {
				this.list.get(hit);
			}
		}
	}
	public void takeevent(Windowmanager p1)
	{
		takeevent((ClarionNumber)null,p1);
	}
	public void takeevent(ClarionNumber vcr,Windowmanager wm)
	{
		CRun._assert(!(this.list==null));
		if (this.list.records()!=0) {
			this.list.item.get().takeevent(vcr,wm);
		}
	}
}
