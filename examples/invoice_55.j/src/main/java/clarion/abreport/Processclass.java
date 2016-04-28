package clarion.abreport;

import clarion.abbrowse.Stepclass;
import clarion.abfile.Relationmanager;
import clarion.abfile.Viewmanager;
import clarion.abquery.Queryclass_1;
import clarion.abreport.Childlist;
import clarion.equates.Constants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Processclass extends Viewmanager
{
	public ClarionNumber bytesread=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber filesize=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber childread=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Childlist children=null;
	public ClarionNumber percentile=null;
	public ClarionNumber ptext=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public Queryclass_1 query=null;
	public ClarionNumber recordsprocessed=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber recordstoprocess=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public Stepclass stepmgr=null;
	public ClarionAny valuefield=Clarion.newAny();
	public ClarionNumber casesensitivevalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Processclass()
	{
		bytesread=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		filesize=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		childread=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		children=null;
		percentile=null;
		ptext=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		query=null;
		recordsprocessed=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		recordstoprocess=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		stepmgr=null;
		valuefield=Clarion.newAny();
		casesensitivevalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	}

	public ClarionNumber additem(Viewmanager vm)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void init(ClarionView p0,Relationmanager p1,ClarionNumber p2,ClarionNumber p3)
	{
		init(p0,p1,p2,p3,Clarion.newNumber(0));
	}
	public void init(ClarionView p0,Relationmanager p1,ClarionNumber p2)
	{
		init(p0,p1,p2,(ClarionNumber)null);
	}
	public void init(ClarionView p0,Relationmanager p1)
	{
		init(p0,p1,Clarion.newNumber(0));
	}
	public void init(ClarionView v,Relationmanager rm,ClarionNumber progresstext,ClarionNumber percentprogress,ClarionNumber guessrecords)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void init(ClarionView p0,Relationmanager p1,ClarionNumber p2,Stepclass p4,ClarionObject p5)
	{
		init(p0,p1,p2,(ClarionNumber)null,p4,p5);
	}
	public void init(ClarionView p0,Relationmanager p1,Stepclass p4,ClarionObject p5)
	{
		init(p0,p1,Clarion.newNumber(0),p4,p5);
	}
	public void init(ClarionView v,Relationmanager rm,ClarionNumber progresstext,ClarionNumber percentprogress,Stepclass sc,ClarionObject valuefield)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void kill()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber next()
	{
		return next(Clarion.newNumber(Constants.TRUE));
	}
	public ClarionNumber next(ClarionNumber processrecords)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void reset()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void setprogresslimits()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void setprogresslimits(ClarionString low,ClarionString high)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void takeaccepted()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void takelocate()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber takerecord()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void updatedisplay()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
}
