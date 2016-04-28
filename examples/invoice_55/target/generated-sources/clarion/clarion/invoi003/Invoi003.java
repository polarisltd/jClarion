package clarion.invoi003;

import clarion.Main;
import clarion.abbrowse.Stepstringclass;
import clarion.abreport.Printpreviewclass_3;
import clarion.invoi003.ProcessView;
import clarion.invoi003.Progresswindow;
import clarion.invoi003.Report;
import clarion.invoi003.Thisreport;
import clarion.invoi003.Thiswindow;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Invoi003
{

	public static void printselectedcustomer()
	{
		ClarionNumber localrequest=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber filesopened=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber progressThermometer=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionString locCsz=Clarion.newString(45);
		ClarionString locAddress=Clarion.newString(45);
		ClarionView processView=new ProcessView();
		Progresswindow progresswindow=new Progresswindow(progressThermometer);
		Report report=new Report(locAddress,locCsz);
		Thisreport thisreport=new Thisreport(locAddress,locCsz,report);
		Stepstringclass progressmgr=new Stepstringclass();
		Printpreviewclass_3 previewer=new Printpreviewclass_3();
		Thiswindow thiswindow=new Thiswindow(progresswindow,progressmgr,thisreport,processView,progressThermometer,report,previewer);
		try {
			Main.globalresponse.setValue(thiswindow.run());
		} finally {
			progresswindow.close();
			report.close();
		}
	}
	public static ClarionString citystatezip(ClarionString p0,ClarionString p1)
	{
		return citystatezip(p0,p1,(ClarionString)null);
	}
	public static ClarionString citystatezip(ClarionString p0)
	{
		return citystatezip(p0,(ClarionString)null);
	}
	public static ClarionString citystatezip()
	{
		return citystatezip((ClarionString)null);
	}
	public static ClarionString citystatezip(ClarionString locCity,ClarionString locState,ClarionString locZip)
	{
		if (locCity==null || locCity.equals("")) {
			return Clarion.newString(locState.concat("  ",locZip));
		}
		else if (locState==null || locState.equals("")) {
			return Clarion.newString(locCity.clip().concat(",  ",locZip));
		}
		else if (locZip==null || locZip.equals("")) {
			return Clarion.newString(locCity.clip().concat(",  ",locState));
		}
		else {
			return Clarion.newString(locCity.clip().concat(", ",locState,"  ",locZip));
		}
	}
}
