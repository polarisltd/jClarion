package clarion;

import clarion.Entrylocatorclass;
import clarion.equates.Constants;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CWin;

public class Incrementallocatorclass extends Entrylocatorclass
{
	public Incrementallocatorclass()
	{
	}

	public void setAlerts(ClarionNumber s)
	{
		Clarion.getControl(s).setProperty(Prop.ALRT,250,Constants.BSKEY);
		Clarion.getControl(s).setProperty(Prop.ALRT,251,Constants.SPACEKEY);
	}
	public ClarionNumber takeKey()
	{
		ClarionNumber key=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		key.setValue(CWin.keyChar());
		if (CWin.keyCode()==Constants.BSKEY) {
			if (this.shadow.len()!=0) {
				this.shadow.setValue(this.shadow.stringAt(1,this.shadow.len()-1));
			}
			this.update();
			return Clarion.newNumber(1);
		}
		else if (CWin.keyCode()==Constants.SPACEKEY || key.boolValue()) {
			this.shadow.setValue(this.shadow.concat(CWin.keyCode()==Constants.SPACEKEY ? Clarion.newString(" ") : ClarionString.chr(key.intValue())));
			this.update();
			return Clarion.newNumber(1);
		}
		return Clarion.newNumber(0);
	}
}
