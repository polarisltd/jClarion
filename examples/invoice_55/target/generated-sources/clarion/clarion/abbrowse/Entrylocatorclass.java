package clarion.abbrowse;

import clarion.abbrowse.Browseclass;
import clarion.abbrowse.Locatorclass;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Entrylocatorclass extends Locatorclass
{
	public ClarionString shadow=Clarion.newString(40).setEncoding(ClarionString.CSTRING);
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
	public void init(ClarionNumber control,ClarionObject free,ClarionNumber nocase,Browseclass vm)
	{
		super.init(control.like(),free,nocase.like(),vm);
		Clarion.getControl(control).setProperty(Prop.USE,this.shadow);
	}
	public ClarionString getshadow()
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
	public void setshadow(ClarionString s)
	{
		this.shadow.setValue(s);
	}
	public ClarionNumber takeaccepted()
	{
		CWin.update(this.control.intValue());
		this.freeelement.setValue(this.shadow);
		if (this.freeelement.boolValue()) {
			return Clarion.newNumber(1);
		}
		else {
			return Clarion.newNumber(0);
		}
	}
	public ClarionNumber takekey()
	{
		if (CWin.keyChar()!=0 && Clarion.getControl(this.control).getProperty(Prop.ENABLED).boolValue()) {
			CWin.select(this.control.intValue());
			CWin.forwardKey(this.control.intValue());
		}
		return Clarion.newNumber(0);
	}
	public void update()
	{
		this.freeelement.setValue(this.nocase.intValue()==1 ?this.shadow.upper():this.shadow);
		this.updatewindow();
	}
	public void updatewindow()
	{
		CWin.display(this.control.intValue());
	}
}
