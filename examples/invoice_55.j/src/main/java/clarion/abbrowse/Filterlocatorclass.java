package clarion.abbrowse;

import clarion.abbrowse.Incrementallocatorclass;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Filterlocatorclass extends Incrementallocatorclass
{
	public ClarionNumber floatright=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Filterlocatorclass()
	{
		floatright=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	}

	public void reset()
	{
	}
	public ClarionNumber takeaccepted()
	{
		CWin.update(this.control.intValue());
		this.shadow.setValue(CWin.contents(this.control.intValue()).clip());
		if (this.freeelement.boolValue()) {
			this.updatewindow();
			return Clarion.newNumber(1);
		}
		else {
			return Clarion.newNumber(0);
		}
	}
	public void updatewindow()
	{
		ClarionString fn=Clarion.newString(100).setEncoding(ClarionString.CSTRING);
		ClarionString sn=Clarion.newString(100).setEncoding(ClarionString.CSTRING);
		CRun._assert(!(this.viewmanager==null));
		fn.setValue(this.viewmanager.getfreeelementname());
		sn.setValue(fn.inString("UPPER(",1,1)==0 ? this.shadow : this.shadow.upper());
		if (this.floatright.boolValue()) {
			this.viewmanager.setfilter((sn.equals("") ? Clarion.newString("") : Clarion.newString(ClarionString.staticConcat("INSTRING('",sn,"',",fn,",1,1) <> 0"))).getString(),Clarion.newString("3 Locator"));
		}
		else {
			this.viewmanager.setfilter(Clarion.newString(ClarionString.staticConcat("SUB(",fn,",1,",this.shadow.len(),") = '",sn,"'")),Clarion.newString("3 Locator"));
		}
		this.viewmanager.applyfilter();
		this.freeelement.setValue(this.shadow);
		CWin.display(this.control.intValue());
	}
}
