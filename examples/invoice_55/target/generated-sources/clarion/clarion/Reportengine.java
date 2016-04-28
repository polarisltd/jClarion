package clarion;

import clarion.equates.File;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Reportengine
{
	public ClarionString reportname=Clarion.newString(File.MAXFILEPATH);
	public ClarionReport report=null;
	public ClarionView view=null;
	public ClarionNumber pagestopreview=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber handle=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public Reportengine()
	{
		reportname=Clarion.newString(File.MAXFILEPATH);
		report=null;
		view=null;
		pagestopreview=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		handle=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		if (this.getClass()==Reportengine.class) construct();
	}

	public ClarionNumber loadreportlibrary(ClarionString p0)
	{
		return loadreportlibrary(p0,(ClarionString)null);
	}
	public ClarionNumber loadreportlibrary(ClarionString txrname,ClarionString password)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber printreport(ClarionString rptname)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void unloadreportlibrary()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void setvariable(ClarionString varname,ClarionString value)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void setpreview()
	{
		setpreview(Clarion.newNumber(-1));
	}
	public void setpreview(ClarionNumber numpages)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void setprinter(ClarionString printdef)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void setpagerange(ClarionNumber p0)
	{
		setpagerange(p0,Clarion.newNumber(-1));
	}
	public void setpagerange()
	{
		setpagerange(Clarion.newNumber(-1));
	}
	public void setpagerange(ClarionNumber frompage,ClarionNumber topage)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void setnumberofcopies(ClarionNumber numcopies)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void setnextpagenumber(ClarionNumber pagenum)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber getnextpagenumber()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber printhook()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber reset()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber next()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void printaction()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void endreport()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionFile attachopenfile(ClarionString label)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber resolvevariablefilename(ClarionString vname,ClarionString value)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber readreportlibrary(ClarionString buffer,ClarionNumber count)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void setreportfilter(ClarionString report,ClarionString filter)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void setreportorder(ClarionString report,ClarionString order)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void setopenmode(ClarionNumber mode)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber getopenmode()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void construct()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void destruct()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
}
