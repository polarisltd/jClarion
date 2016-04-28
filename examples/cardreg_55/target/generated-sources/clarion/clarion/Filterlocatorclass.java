package clarion;

import clarion.Incrementallocatorclass;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

public class Filterlocatorclass extends Incrementallocatorclass
{
	public ClarionNumber floatRight;
	public Filterlocatorclass()
	{
		floatRight=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	}

	public void reset()
	{
	}
	public ClarionNumber takeAccepted()
	{
		CWin.update(this.control.intValue());
		this.shadow.setValue(CWin.contents(this.control.intValue()).clip());
		if (this.freeElement.boolValue()) {
			this.updateWindow();
			return Clarion.newNumber(1);
		}
		else {
			return Clarion.newNumber(0);
		}
	}
	public void updateWindow()
	{
		ClarionString fn=Clarion.newString(100).setEncoding(ClarionString.CSTRING);
		ClarionString sn=Clarion.newString(100).setEncoding(ClarionString.CSTRING);
		CRun._assert(!(this.viewManager==null));
		fn.setValue(this.viewManager.getFreeElementName());
		sn.setValue(fn.inString("UPPER(",1,1)==0 ? this.shadow : this.shadow.upper());
		if (this.floatRight.boolValue()) {
			this.viewManager.setFilter((sn.equals("") ? Clarion.newString("") : Clarion.newString(ClarionString.staticConcat("INSTRING('",sn,"',",fn,",1,1) <> 0"))).getString(),Clarion.newString("3 Locator"));
		}
		else {
			this.viewManager.setFilter(Clarion.newString(ClarionString.staticConcat("SUB(",fn,",1,",this.shadow.len(),") = '",sn,"'")),Clarion.newString("3 Locator"));
		}
		this.viewManager.applyFilter();
		this.freeElement.setValue(this.shadow);
		CWin.display(this.control.intValue());
	}
}
