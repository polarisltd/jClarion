package clarion.abdrops;

import clarion.abdrops.Filedropclass;
import clarion.aberror.Errorclass;
import clarion.abfile.Relationmanager;
import clarion.abwindow.Windowmanager;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Filedropcomboclass extends Filedropclass
{
	public ClarionNumber askprocedure=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionAny usefield=Clarion.newAny();
	public ClarionNumber buttonfield=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber entryfield=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber entrycompletion=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber removeduplicatesflag=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Errorclass errmgr=null;
	public ClarionNumber autoaddflag=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber casesensitiveflag=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber syncronizeviewflag=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString promptcaption=Clarion.newString(80).setEncoding(ClarionString.PSTRING);
	public ClarionString prompttext=Clarion.newString(256).setEncoding(ClarionString.PSTRING);
	public ClarionNumber econ=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Filedropcomboclass()
	{
		askprocedure=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		usefield=Clarion.newAny();
		buttonfield=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		entryfield=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		entrycompletion=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		removeduplicatesflag=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		errmgr=null;
		autoaddflag=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		casesensitiveflag=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		syncronizeviewflag=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		promptcaption=Clarion.newString(80).setEncoding(ClarionString.PSTRING);
		prompttext=Clarion.newString(256).setEncoding(ClarionString.PSTRING);
		econ=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	}

	public ClarionNumber addrecord()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber ask()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber buffermatches()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber getqueuematch(ClarionString lookfor)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void init(ClarionObject p0,ClarionNumber p1,ClarionString p2,ClarionView p3,ClarionQueue p4,Relationmanager p5,Windowmanager p6,Errorclass p7,ClarionNumber p8,ClarionNumber p9)
	{
		init(p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,Clarion.newNumber(0));
	}
	public void init(ClarionObject p0,ClarionNumber p1,ClarionString p2,ClarionView p3,ClarionQueue p4,Relationmanager p5,Windowmanager p6,Errorclass p7,ClarionNumber p8)
	{
		init(p0,p1,p2,p3,p4,p5,p6,p7,p8,Clarion.newNumber(1));
	}
	public void init(ClarionObject p0,ClarionNumber p1,ClarionString p2,ClarionView p3,ClarionQueue p4,Relationmanager p5,Windowmanager p6,Errorclass p7)
	{
		init(p0,p1,p2,p3,p4,p5,p6,p7,Clarion.newNumber(1));
	}
	public void init(ClarionObject usefield,ClarionNumber listbox,ClarionString pos,ClarionView v,ClarionQueue q,Relationmanager rm,Windowmanager wm,Errorclass ec,ClarionNumber autoadd,ClarionNumber autosync,ClarionNumber cased)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void kill()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber keyvalid()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber resetqueue()
	{
		return resetqueue(Clarion.newNumber(0));
	}
	public ClarionNumber resetqueue(ClarionNumber force)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void resetfromlist()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void takeaccepted()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void takenewselection()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void takenewselection(ClarionNumber field)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void takeevent()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber uniqueposition()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
}
