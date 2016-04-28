package clarion.abreport;

import clarion.abpopup.Popupclass;
import clarion.abreport.Pagemanagerclass;
import clarion.abreport.Zoomitemqueue;
import clarion.abutil.Iniclass;
import clarion.abwindow.Windowmanager;
import clarion.equates.Constants;
import clarion.invoi002.Previewqueue;
import clarion.invoi002.Savesizetype;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;

@SuppressWarnings("all")
public class Printpreviewclass_1 extends Windowmanager
{
	public ClarionNumber allowuserzoom=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber confirmpages=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber currentpage=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber firstpage=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public Previewqueue imagequeue=null;
	public Iniclass inimgr=null;
	public ClarionNumber initzoom=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber maximize=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionArray<ClarionNumber> muse=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).dim(32);
	public Pagemanagerclass pagemanager=null;
	public ClarionNumber pagesacross=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber pagesdown=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionString pagestoprint=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
	public Popupclass popup=null;
	public ClarionWindow previewwindow=null;
	public ClarionNumber printok=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Savesizetype savesize=new Savesizetype();
	public ClarionNumber thumbnailspresent=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber userpercentile=Clarion.newNumber(0).setEncoding(ClarionNumber.USHORT);
	public ClarionNumber windowposset=Clarion.newNumber(Constants.FALSE).setEncoding(ClarionNumber.BYTE);
	public ClarionNumber windowsizeset=Clarion.newNumber(Constants.FALSE).setEncoding(ClarionNumber.BYTE);
	public ClarionNumber winheight=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber winwidth=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber winxpos=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionNumber winypos=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public Zoomitemqueue zoomqueue=null;
	public ClarionNumber zoomindex=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString zoomlist=Clarion.newString(16);
	public ClarionNumber prtprevTbarzoom=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber prtprevTbarprint=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber prtprevTbarexit=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber prtprevMenupages=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber prtprevMenuprint=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber prtprevMenuexit=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber prtprevZoomlist=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber prtprevZoomprompt=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber prtprevPageprompt=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber prtprevCurrentpage=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber prtprevPagesacross=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber prtprevPagesdown=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber prtprevNext=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber prtprevPrevious=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber prtprevJump=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber prtprevChangedisplay=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber prtprevViewmenu=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber prtprevZoommenu=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public Printpreviewclass_1()
	{
		allowuserzoom=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		confirmpages=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		currentpage=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		firstpage=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		imagequeue=null;
		inimgr=null;
		initzoom=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		maximize=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		muse=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).dim(32);
		pagemanager=null;
		pagesacross=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		pagesdown=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		pagestoprint=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
		popup=null;
		previewwindow=null;
		printok=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		savesize=new Savesizetype();
		thumbnailspresent=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		userpercentile=Clarion.newNumber(0).setEncoding(ClarionNumber.USHORT);
		windowposset=Clarion.newNumber(Constants.FALSE).setEncoding(ClarionNumber.BYTE);
		windowsizeset=Clarion.newNumber(Constants.FALSE).setEncoding(ClarionNumber.BYTE);
		winheight=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		winwidth=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		winxpos=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		winypos=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		zoomqueue=null;
		zoomindex=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		zoomlist=Clarion.newString(16);
		prtprevTbarzoom=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtprevTbarprint=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtprevTbarexit=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtprevMenupages=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtprevMenuprint=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtprevMenuexit=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtprevZoomlist=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtprevZoomprompt=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtprevPageprompt=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtprevCurrentpage=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtprevPagesacross=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtprevPagesdown=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtprevNext=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtprevPrevious=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtprevJump=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtprevChangedisplay=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtprevViewmenu=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtprevZoommenu=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	}

	public ClarionNumber askpage()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber askprintpages()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void askthumbnails()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void configmenuchecks()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber deleteimagequeue(ClarionNumber idx)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber display(ClarionNumber p0,ClarionNumber p1,ClarionNumber p2)
	{
		return display(p0,p1,p2,Clarion.newNumber(1));
	}
	public ClarionNumber display(ClarionNumber p0,ClarionNumber p1)
	{
		return display(p0,p1,Clarion.newNumber(1));
	}
	public ClarionNumber display(ClarionNumber p0)
	{
		return display(p0,Clarion.newNumber(1));
	}
	public ClarionNumber display()
	{
		return display(Clarion.newNumber(0));
	}
	public ClarionNumber display(ClarionNumber initzoomfactor,ClarionNumber initcurrentpage,ClarionNumber initpagesacross,ClarionNumber initpagesdown)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void drawpage()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void init(Previewqueue imagequeue)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber inpagelist(ClarionNumber pagenumber)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber kill()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void newzoom()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void open()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void resetuserzoom()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void setdefaultpages()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void setinimanager(Iniclass ini)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void setposition(ClarionNumber p0,ClarionNumber p1,ClarionNumber p2)
	{
		setposition(p0,p1,p2,(ClarionNumber)null);
	}
	public void setposition(ClarionNumber p0,ClarionNumber p1)
	{
		setposition(p0,p1,(ClarionNumber)null);
	}
	public void setposition(ClarionNumber p0)
	{
		setposition(p0,(ClarionNumber)null);
	}
	public void setposition()
	{
		setposition((ClarionNumber)null);
	}
	public void setposition(ClarionNumber xpos,ClarionNumber ypos,ClarionNumber width,ClarionNumber height)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void setzoompercentile(ClarionNumber percentile)
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public void syncimagequeue()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber takeaccepted()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber takeevent()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber takewindowevent()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
	public ClarionNumber takefieldevent()
	{
		throw new RuntimeException("Procedure/Method not defined");
	}
}
