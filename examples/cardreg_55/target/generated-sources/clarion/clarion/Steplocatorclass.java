package clarion;

import clarion.Locatorclass;
import clarion.equates.Event;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CWin;

public class Steplocatorclass extends Locatorclass
{
	public Steplocatorclass()
	{
	}

	public void set()
	{
	}
	public ClarionNumber takeKey()
	{
		ClarionNumber key=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber handled=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE);
		key.setValue(CWin.keyChar());
		if (key.boolValue()) {
			if (this.viewManager.listQueue.records().boolValue()) {
				handled.setValue(1);
				this.viewManager.scrollOne(Clarion.newNumber(Event.SCROLLDOWN));
				this.viewManager.updateBuffer();
			}
			if (this.noCase.boolValue() && !this.freeElement.getString().sub(1,1).upper().equals(ClarionString.chr(key.intValue()).upper()) || !this.noCase.boolValue() && !this.freeElement.getString().sub(1,1).equals(ClarionString.chr(key.intValue()))) {
				this.freeElement.setValue(ClarionString.chr(key.intValue()));
				handled.setValue(1);
			}
		}
		return handled.like();
	}
}
