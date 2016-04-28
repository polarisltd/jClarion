package clarion.abbrowse;

import clarion.Cstringlist;
import clarion.abbrowse.Stepclass;
import clarion.equates.Scrollsort;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;

@SuppressWarnings("all")
public class Stepcustomclass extends Stepclass
{
	public Cstringlist entries=null;
	public Stepcustomclass()
	{
		entries=null;
	}

	public void additem(ClarionString s)
	{
		CRun._assert(!(this.entries==null));
		this.entries.item.set(Clarion.newString(s.len()+1).setEncoding(ClarionString.CSTRING));
		this.entries.item.get().setValue(s);
		this.entries.add();
	}
	public ClarionNumber getpercentile(ClarionObject value)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		final int loop_1=this.entries.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.entries.get(i);
			if ((this.controls.intValue() & Scrollsort.CASESENSITIVE)!=0) {
				if (this.entries.item.get().compareTo(value)<0) {
					break;
				}
			}
			else {
				if (this.entries.item.get().compareTo(value.getString().upper())<0) {
					break;
				}
			}
		}
		i.setValue(i.subtract(1).multiply(100).divide(this.entries.records()));
		if ((this.controls.intValue() & Scrollsort.DESCENDING)!=0) {
			i.setValue(Clarion.newNumber(100).subtract(i));
		}
		return (i.equals(0) ? Clarion.newNumber(1) : i).getNumber();
	}
	public ClarionString getvalue(ClarionNumber p)
	{
		if ((this.controls.intValue() & Scrollsort.DESCENDING)!=0) {
			p.setValue(Clarion.newNumber(100).subtract(p));
		}
		this.entries.get(p.multiply(this.entries.records()).divide(100));
		CRun._assert(!(CError.errorCode()!=0));
		return this.entries.item.get().like();
	}
	public void init(ClarionNumber controls)
	{
		super.init(controls.like());
		this.entries=new Cstringlist();
	}
	public void kill()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		final int loop_1=this.entries.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.entries.get(i);
			//this.entries.item.get();
		}
		//this.entries;
	}
}
