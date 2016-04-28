package clarion.abreport;

import clarion.Processorqueue;
import clarion.Recordprocessor;
import clarion.abreport.Printpreviewclass;
import clarion.abreport.Processclass;
import clarion.abwindow.Windowmanager;
import clarion.invoi001.Previewqueue;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionReport;

@SuppressWarnings("all")
public class Reportmanager extends Windowmanager
{
	public ClarionNumber deferopenreport=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber deferwindow=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber keepvisible=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber openfailed=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Processorqueue processors=null;
	public Printpreviewclass preview=null;
	public Previewqueue previewqueue=null;
	public Processclass process=null;
	public ClarionNumber recordspercycle=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber querycontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionReport report=null;
	public ClarionNumber skippreview=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber starttime=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber timeslice=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber waitcursor=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber zoom=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public Reportmanager()
	{
		deferopenreport=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		deferwindow=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		keepvisible=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		openfailed=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		processors=null;
		preview=null;
		previewqueue=null;
		process=null;
		recordspercycle=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		querycontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		report=null;
		skippreview=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		starttime=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		timeslice=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		waitcursor=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		zoom=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	}

	public void additem(Recordprocessor rc)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void ask()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void askpreview()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber next()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void init(Processclass p0,ClarionReport p1)
	{
		init(p0,p1,(Printpreviewclass)null);
	}
	public void init(Processclass p0)
	{
		init(p0,(ClarionReport)null);
	}
	public void init(Processclass pc,ClarionReport r,Printpreviewclass pv)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber kill()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void open()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber openreport()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber takeaccepted()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber takecloseevent()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void takenorecords()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber takerecord()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber takewindowevent()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
}
