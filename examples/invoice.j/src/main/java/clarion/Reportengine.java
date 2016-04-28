package clarion;

import clarion.equates.File;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.view.ClarionView;

public class Reportengine
{
	public ClarionString reportName;
	public ClarionReport report;
	public ClarionView view;
	public ClarionNumber pagesToPreview;
	public ClarionNumber handle;
	public Reportengine()
	{
		reportName=Clarion.newString(File.MAXFILEPATH);
		report=null;
		view=null;
		pagesToPreview=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		handle=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		construct();
	}

	public ClarionNumber loadReportLibrary(ClarionString p0)
	{
		return loadReportLibrary(p0,(ClarionString)null);
	}
	public ClarionNumber loadReportLibrary(ClarionString txrname,ClarionString password)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber printReport(ClarionString rptname)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void unloadReportLibrary()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void setPreview()
	{
		setPreview(Clarion.newNumber(-1));
	}
	public void setPreview(ClarionNumber numpages)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void construct(){} // %%%%%%%%%%%%%%%% missing method
	public void desttruct(){} 
	
}