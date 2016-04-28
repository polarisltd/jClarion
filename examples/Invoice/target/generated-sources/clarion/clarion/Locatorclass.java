package clarion;

import clarion.Browseclass;
import clarion.Viewmanager;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;

public class Locatorclass
{
	public Viewmanager viewManager;
	public Browseclass browseManager;
	public ClarionNumber control;
	public ClarionAny freeElement;
	public ClarionNumber noCase;
	public Locatorclass()
	{
		viewManager=null;
		browseManager=null;
		control=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		freeElement=Clarion.newAny();
		noCase=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	}

	public void destruct()
	{
		this.freeElement.setReferenceValue(null);
	}
	public ClarionString getShadow()
	{
		return Clarion.newString("");
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
		this.freeElement.setReferenceValue(free);
		this.control.setValue(control);
		this.noCase.setValue(noCase);
	}
	public void init(ClarionNumber p0,ClarionObject p1,Viewmanager p3)
	{
		init(p0,p1,Clarion.newNumber(0),p3);
	}
	public void init(ClarionObject p1,Viewmanager p3)
	{
		init(Clarion.newNumber(0),p1,p3);
	}
	public void init(ClarionNumber control,ClarionObject free,ClarionNumber noCase,Viewmanager vm)
	{
		this.viewManager=vm;
		this.init(control.like(),free,noCase.like());
	}
	public void init(ClarionNumber p0,ClarionObject p1,Browseclass p3)
	{
		init(p0,p1,Clarion.newNumber(0),p3);
	}
	public void init(ClarionObject p1,Browseclass p3)
	{
		init(Clarion.newNumber(0),p1,p3);
	}
	public void init(ClarionNumber control,ClarionObject free,ClarionNumber noCase,Browseclass bc)
	{
		this.viewManager=bc;
		this.browseManager=bc;
		this.init(control.like(),free,noCase.like());
	}
	public void reset()
	{
	}
	public void set()
	{
		this.freeElement.setValue("");
	}
	public void setLocatorField(ClarionObject free)
	{
		this.freeElement.setReferenceValue(free);
		this.freeElement.setValue("");
		this.setShadow(Clarion.newString(""));
	}
	public void setAlerts(ClarionNumber s)
	{
	}
	public void setEnabled(ClarionNumber e)
	{
		if (this.control.boolValue()) {
			Clarion.getControl(this.control).setProperty(Prop.DISABLE,e.equals(0) ? 1 : 0);
		}
	}
	public void setShadow(ClarionString s)
	{
	}
	public ClarionNumber takeAccepted()
	{
		return Clarion.newNumber(0);
	}
	public ClarionNumber takeKey()
	{
		return Clarion.newNumber(0);
	}
	public void updateWindow()
	{
		this.set();
	}
}
