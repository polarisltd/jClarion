package clarion.abquery;

import clarion.Sectorqueue;
import clarion.aberror.Errorclass;
import clarion.abpopup.Popupclass;
import clarion.abquery.Fieldqueue;
import clarion.abquery.Popupqueue;
import clarion.abquery.Queryvisual_4;
import clarion.abutil.Iniclass;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;

@SuppressWarnings("all")
public class Queryclass_4
{
	public Errorclass errors=null;
	public Fieldqueue fields=null;
	public ClarionString family=null;
	public Iniclass inimgr=null;
	public Popupqueue popuplist=null;
	public ClarionNumber qksupport=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString qkicon=Clarion.newString(255).setEncoding(ClarionString.CSTRING);
	public ClarionString qkmenuicon=Clarion.newString(255).setEncoding(ClarionString.CSTRING);
	public ClarionNumber qksubmenupos=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionString qkcurrentquery=Clarion.newString(100).setEncoding(ClarionString.CSTRING);
	public ClarionWindow parentwindow=null;
	public ClarionWindow window=null;
	public Queryvisual_4 win=null;
	public Queryclass_4()
	{
		errors=null;
		fields=null;
		family=null;
		inimgr=null;
		popuplist=null;
		qksupport=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		qkicon=Clarion.newString(255).setEncoding(ClarionString.CSTRING);
		qkmenuicon=Clarion.newString(255).setEncoding(ClarionString.CSTRING);
		qksubmenupos=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		qkcurrentquery=Clarion.newString(100).setEncoding(ClarionString.CSTRING);
		parentwindow=null;
		window=null;
		win=null;
	}

	public void additem(ClarionString p0,ClarionString p1,ClarionString p2)
	{
		additem(p0,p1,p2,Clarion.newNumber(1));
	}
	public void additem(ClarionString p0,ClarionString p1)
	{
		additem(p0,p1,(ClarionString)null);
	}
	public void additem(ClarionString fieldname,ClarionString title,ClarionString picture,ClarionNumber forceeditpicture)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber ask()
	{
		return ask(Clarion.newNumber(1));
	}
	public ClarionNumber ask(ClarionNumber uselast)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void findname(ClarionString nme)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionString getname(ClarionString title)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionString getfilter()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber getlimit(ClarionString p0,ClarionString p1,ClarionNumber p2)
	{
		return getlimit(p0,p1,p2,Clarion.newNumber(0));
	}
	public ClarionNumber getlimit(ClarionString value,ClarionString operator,ClarionNumber caseless,ClarionNumber high)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void getlimit(ClarionString fieldname,ClarionString value,ClarionString operator,ClarionNumber caseless)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void getlimit(ClarionString fieldname,ClarionString low,ClarionString high,ClarionString eq)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber getlimit(ClarionString p0,ClarionString p1,ClarionNumber p2,ClarionString p4)
	{
		return getlimit(p0,p1,p2,Clarion.newNumber(0),p4);
	}
	public ClarionNumber getlimit(ClarionString value,ClarionString operator,ClarionNumber caseless,ClarionNumber high,ClarionString picture)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void getlimit(ClarionString fieldname,ClarionString value,ClarionString operator,ClarionNumber caseless,ClarionString picture)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void init()
	{
		init((Queryvisual_4)null);
	}
	public void init(Queryvisual_4 q)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void init(Queryvisual_4 q,Iniclass inimgr,ClarionString family,Errorclass e)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void kill()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionString quote(ClarionString txt)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void reset()
	{
		reset((ClarionString)null);
	}
	public void reset(ClarionString fieldname)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void setlimit(ClarionString p0,ClarionString p1,ClarionString p2)
	{
		setlimit(p0,p1,p2,(ClarionString)null);
	}
	public void setlimit(ClarionString p0,ClarionString p1)
	{
		setlimit(p0,p1,(ClarionString)null);
	}
	public void setlimit(ClarionString p0)
	{
		setlimit(p0,(ClarionString)null);
	}
	public void setlimit(ClarionString fieldname,ClarionString low,ClarionString high,ClarionString eq)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void setquickpopup(Popupclass popup,ClarionNumber querycontrol)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void save(ClarionString queryname)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber take(Popupclass popup)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void restore(ClarionString queryname)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void delete(ClarionString queryname)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void getqueries(Sectorqueue qq)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void clearquery()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
}
