package clarion.abbrowse;

import clarion.abbrowse.Stepclass;
import clarion.equates.Scrollsort;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Steplongclass extends Stepclass
{
	public ClarionNumber low=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber high=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public Steplongclass()
	{
		low=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		high=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	}

	public ClarionNumber getpercentile(ClarionObject value)
	{
		ClarionNumber r=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (this.low.equals(this.high)) {
			return Clarion.newNumber(50);
		}
		r.setValue(value.subtract(this.low).multiply(Clarion.newNumber(100).divide(this.high.subtract(this.low))));
		if ((this.controls.intValue() & Scrollsort.DESCENDING)!=0) {
			r.setValue(Clarion.newNumber(100).subtract(r));
		}
		return (r.equals(0) ? Clarion.newNumber(1) : r).getNumber();
	}
	public ClarionString getvalue(ClarionNumber p)
	{
		if ((this.controls.intValue() & Scrollsort.DESCENDING)!=0) {
			p.setValue(Clarion.newNumber(100).subtract(p));
		}
		return this.low.add(this.high.subtract(this.low).multiply(p.divide(100))).getString();
	}
	public void setlimit(ClarionObject low,ClarionObject high)
	{
		if ((this.controls.intValue() & Scrollsort.DESCENDING)!=0) {
			this.low.setValue(high);
			this.high.setValue(low);
		}
		else {
			this.low.setValue(low);
			this.high.setValue(high);
		}
	}
}
