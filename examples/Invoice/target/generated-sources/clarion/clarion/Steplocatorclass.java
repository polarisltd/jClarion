package clarion;

import clarion.Locatorclass;
import clarion.equates.Event;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CWin;

public class Steplocatorclass extends Locatorclass
{
	public Steplocatorclass()
	{
	}

	public void init(ClarionNumber p0,ClarionObject p1)
	{
		init(p0,p1,Clarion.newNumber(0));
	}
	public void init(ClarionObject p1)
	{
		init(Clarion.newNumber(0),p1);
	}
	public void init(ClarionNumber control,ClarionObject free,ClarionNumber noCase)
	{
		super.init(control.like(),free,noCase.like());
	}
	public void set()
	{
	}
	public ClarionNumber takeKey()
	{
		ClarionNumber key=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber handled=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE);
		ClarionNumber eAsc=Clarion.newNumber(0).setEncoding(ClarionNumber.BYTE);
		key.setValue(CWin.keyChar());
		if (key.boolValue()) {
			if (this.browseManager.listQueue.records().boolValue()) {
				handled.setValue(1);
				this.browseManager.scrollOne(Clarion.newNumber(Event.SCROLLDOWN));
				this.browseManager.updateBuffer();
			}
			if (this.noCase.boolValue() && !this.freeElement.getString().sub(1,1).upper().equals(ClarionString.chr(key.intValue()).upper()) || !this.noCase.boolValue() && !this.freeElement.getString().sub(1,1).equals(ClarionString.chr(key.intValue()))) {
				eAsc.setValue(this.viewManager.getFieldAscending(this.freeElement));
				if (this.noCase.boolValue()) {
					if (!eAsc.boolValue()) {
						this.freeElement.setValue(ClarionString.chr(key.intValue()).upper().concat(ClarionString.chr(254)));
					}
					else {
						this.freeElement.setValue(ClarionString.chr(key.intValue()).upper());
					}
				}
				else {
					if (!eAsc.boolValue()) {
						this.freeElement.setValue(ClarionString.chr(key.intValue()).concat(ClarionString.chr(254)));
					}
					else {
						this.freeElement.setValue(ClarionString.chr(key.intValue()));
					}
				}
				handled.setValue(1);
			}
		}
		return handled.like();
	}
}
