package clarion.abreport;

import clarion.Main;
import clarion.abreport.Printpreviewclass_3;
import clarion.abreport.Zoompresets;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;

@SuppressWarnings("all")
public class Abreport
{
	public static Zoompresets zoompresets;
	static {
		Main.__register_init(new Runnable() { public void run() { __static_init(); } });
		__static_init();
	}

	public static void __static_init() {
		zoompresets=new Zoompresets();
	}


	public static ClarionNumber idx2percentile(Printpreviewclass_3 self,ClarionNumber index)
	{
		if (index.boolValue()) {
			self.zoomqueue.get(index);
			CRun._assert(!(CError.errorCode()!=0));
			return self.zoomqueue.percentile.like();
		}
		else {
			return self.userpercentile.like();
		}
	}
	public static ClarionNumber percentile2idx(Printpreviewclass_3 self,ClarionNumber percentile)
	{
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		final int loop_1=self.zoomqueue.records();for (c.setValue(1);c.compareTo(loop_1)<=0;c.increment(1)) {
			self.zoomqueue.get(c);
			CRun._assert(!(CError.errorCode()!=0));
			if (self.zoomqueue.percentile.equals(percentile)) {
				return c.like();
			}
		}
		return Clarion.newNumber(self.zoomqueue.records()+1);
	}
}
