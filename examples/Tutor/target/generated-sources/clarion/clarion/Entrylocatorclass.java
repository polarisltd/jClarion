package clarion;

import clarion.Locatorclass;
import clarion.equates.Constants;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CWin;

public class Entrylocatorclass extends Locatorclass
{
	public ClarionString shadow;
	public Entrylocatorclass()
	{
		shadow=Clarion.newString(40).setEncoding(ClarionString.CSTRING);
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
		this.shadow.clear();
		super.init(control.like(),free,noCase.like());
		Clarion.getControl(this.control).setProperty(Prop.USE,this.shadow);
	}
	public ClarionString getShadow()
	{
		return this.shadow.like();
	}
	public void set()
	{
		this.shadow.clear();
		Clarion.getControl(this.control).setProperty(Prop.USE,this.shadow);
		super.set();
		this.update();
	}
	public void setShadow(ClarionString s)
	{
		this.shadow.setValue(s);
	}
	public ClarionNumber takeAccepted()
	{
		ClarionNumber eAsc=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (!(this.viewManager==null)) {
			eAsc.setValue(this.viewManager.getFieldAscending(this.freeElement));
		}
		else {
			eAsc.setValue(Constants.TRUE);
		}
		CWin.update(this.control.intValue());
		if (!eAsc.boolValue()) {
			this.freeElement.setValue(this.shadow.concat(ClarionString.chr(254)));
		}
		else {
			this.freeElement.setValue(this.shadow);
		}
		if (this.freeElement.boolValue()) {
			return Clarion.newNumber(1);
		}
		else {
			return Clarion.newNumber(0);
		}
	}
	public ClarionNumber takeKey()
	{
		if (CWin.keyChar()!=0 && Clarion.getControl(this.control).getProperty(Prop.ENABLED).boolValue()) {
			CWin.select(this.control.intValue());
			CWin.forwardKey(this.control.intValue());
		}
		return Clarion.newNumber(0);
	}
	public void update()
	{
		ClarionNumber eAsc=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (!(this.viewManager==null)) {
			eAsc.setValue(this.viewManager.getFieldAscending(this.freeElement));
		}
		else {
			eAsc.setValue(Constants.TRUE);
		}
		if (!eAsc.boolValue()) {
			this.freeElement.setValue(ClarionString.staticConcat(this.noCase.intValue()==1 ?this.shadow.upper().quote():this.shadow.quote(),ClarionString.chr(254)));
		}
		else {
			this.freeElement.setValue(this.noCase.intValue()==1 ?this.shadow.upper().quote():this.shadow.quote());
		}
		this.updateWindow();
	}
	public void updateWindow()
	{
		CWin.display(this.control.intValue());
	}
}
