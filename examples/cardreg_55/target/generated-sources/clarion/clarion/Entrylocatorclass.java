package clarion;

import clarion.Browseclass;
import clarion.Locatorclass;
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

	public void init(ClarionNumber p0,ClarionObject p1,ClarionNumber p2)
	{
		init(p0,p1,p2,(Browseclass)null);
	}
	public void init(ClarionNumber p0,ClarionObject p1)
	{
		init(p0,p1,Clarion.newNumber(0));
	}
	public void init(ClarionObject p1)
	{
		init(Clarion.newNumber(0),p1);
	}
	public void init(ClarionNumber control,ClarionObject free,ClarionNumber noCase,Browseclass vm)
	{
		super.init(control.like(),free,noCase.like(),vm);
		Clarion.getControl(control).setProperty(Prop.USE,this.shadow);
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
		CWin.update(this.control.intValue());
		this.freeElement.setValue(this.shadow);
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
		this.freeElement.setValue(this.noCase.intValue()==1 ?this.shadow.upper():this.shadow);
		this.updateWindow();
	}
	public void updateWindow()
	{
		CWin.display(this.control.intValue());
	}
}
