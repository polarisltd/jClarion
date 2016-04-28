package clarion;

import clarion.Stepclass;
import clarion.equates.Scrollsort;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionReal;
import org.jclarion.clarion.ClarionString;

public class Steprealclass extends Stepclass
{
	public ClarionReal low;
	public ClarionReal high;
	public Steprealclass()
	{
		low=Clarion.newReal();
		high=Clarion.newReal();
	}

	public ClarionNumber getPercentile(ClarionObject value)
	{
		ClarionNumber r=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (this.low.equals(this.high)) {
			return Clarion.newNumber(50);
		}
		r.setValue(value.subtract(this.low).multiply(100).divide(this.high.subtract(this.low)));
		if ((this.controls.intValue() & Scrollsort.DESCENDING)!=0) {
			r.setValue(Clarion.newNumber(100).subtract(r));
		}
		return (r.equals(0) ? Clarion.newNumber(1) : r).getNumber();
	}
	public ClarionString getValue(ClarionNumber p)
	{
		if ((this.controls.intValue() & Scrollsort.DESCENDING)!=0) {
			p.setValue(Clarion.newNumber(100).subtract(p));
		}
		return this.low.add(this.high.subtract(this.low).multiply(p).divide(100)).getString();
	}
	public void setLimit(ClarionObject low,ClarionObject high)
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
