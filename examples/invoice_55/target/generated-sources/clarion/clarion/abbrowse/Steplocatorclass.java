package clarion.abbrowse;

import clarion.abbrowse.Locatorclass;
import clarion.equates.Event;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Steplocatorclass extends Locatorclass
{
	public Steplocatorclass()
	{
	}

	public void set()
	{
	}
	public ClarionNumber takekey()
	{
		ClarionNumber key=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber handled=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE);
		key.setValue(CWin.keyChar());
		if (key.boolValue()) {
			if (this.viewmanager.listqueue.records().boolValue()) {
				handled.setValue(1);
				this.viewmanager.scrollone(Clarion.newNumber(Event.SCROLLDOWN));
				this.viewmanager.updatebuffer();
			}
			if (this.nocase.boolValue() && !this.freeelement.getString().sub(1,1).upper().equals(ClarionString.chr(key.intValue()).upper()) || !this.nocase.boolValue() && !this.freeelement.getString().sub(1,1).equals(ClarionString.chr(key.intValue()))) {
				this.freeelement.setValue(ClarionString.chr(key.intValue()));
				handled.setValue(1);
			}
		}
		return handled.like();
	}
}
