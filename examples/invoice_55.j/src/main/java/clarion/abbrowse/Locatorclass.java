package clarion.abbrowse;

import clarion.abbrowse.Browseclass;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public class Locatorclass
{
	public Browseclass viewmanager=null;
	public ClarionNumber control=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionAny freeelement=Clarion.newAny();
	public ClarionNumber nocase=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Locatorclass()
	{
		viewmanager=null;
		control=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		freeelement=Clarion.newAny();
		nocase=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	}

	public void destruct()
	{
		this.freeelement.setReferenceValue(null);
	}
	public ClarionString getshadow()
	{
		return Clarion.newString("");
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
		this.freeelement.setReferenceValue(free);
		this.control.setValue(control);
		this.nocase.setValue(nocase);
		this.viewmanager=vm;
	}
	public void reset()
	{
	}
	public void set()
	{
		this.freeelement.setValue("");
	}
	public void setalerts(ClarionNumber s)
	{
	}
	public void setenabled(ClarionNumber e)
	{
		if (this.control.boolValue()) {
			Clarion.getControl(this.control).setProperty(Prop.DISABLE,e.equals(0) ? 1 : 0);
		}
	}
	public void setshadow(ClarionString s)
	{
	}
	public ClarionNumber takeaccepted()
	{
		return Clarion.newNumber(0);
	}
	public ClarionNumber takekey()
	{
		return Clarion.newNumber(0);
	}
	public void updatewindow()
	{
		this.set();
	}
}
