package clarion;

import clarion.Printpreviewclass;
import clarion.Zoompresets;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;

public class Abreport
{
	public static Zoompresets zoomPresets;

	public static ClarionNumber idx2Percentile(Printpreviewclass self,ClarionNumber index)
	{
		if (index.boolValue()) {
			self.zoomQueue.get(index);
			CRun._assert(!(CError.errorCode()!=0));
			return self.zoomQueue.percentile.like();
		}
		else {
			return self.userPercentile.like();
		}
	}
	public static ClarionNumber percentile2Idx(Printpreviewclass self,ClarionNumber percentile)
	{
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		for (c.setValue(1);c.compareTo(self.zoomQueue.records())<=0;c.increment(1)) {
			self.zoomQueue.get(c);
			CRun._assert(!(CError.errorCode()!=0));
			if (self.zoomQueue.percentile.equals(percentile)) {
				return c.like();
			}
		}
		return Clarion.newNumber(self.zoomQueue.records()+1);
	}
}
