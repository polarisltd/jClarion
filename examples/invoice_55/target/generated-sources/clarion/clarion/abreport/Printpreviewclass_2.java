package clarion.abreport;

import clarion.abpopup.Popupclass;
import clarion.abreport.Abreport;
import clarion.abreport.Jumpwindow;
import clarion.abreport.Pagemanagerclass;
import clarion.abreport.Previewqueue;
import clarion.abreport.Previewwindow;
import clarion.abreport.Savesizetype;
import clarion.abreport.Selectwindow;
import clarion.abreport.Window;
import clarion.abreport.Zoomitemqueue;
import clarion.abreport.equates.Mconstants;
import clarion.abutil.Constantclass;
import clarion.abutil.Iniclass;
import clarion.abwindow.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Consttype;
import clarion.equates.Create;
import clarion.equates.Cursor;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.equates.Term;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CFile;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Printpreviewclass_2 extends Windowmanager
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
	public Printpreviewclass_2()
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
		ClarionNumber jumppage=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber rval=Clarion.newNumber(Constants.FALSE).setEncoding(ClarionNumber.BYTE);
		Jumpwindow jumpwindow=new Jumpwindow(jumppage);
		try {
			jumppage.setValue(this.currentpage);
			jumpwindow.open();
			if (!(this.translator==null)) {
				this.translator.translatewindow(jumpwindow);
			}
			while (Clarion.getWindowTarget().accept()) {
				{
					int case_1=CWin.event();
					boolean case_1_break=false;
					if (case_1==Event.OPENWINDOW) {
						Clarion.getControl(jumpwindow._jumppage).setProperty(Prop.RANGEHIGH,this.imagequeue.records());
						case_1_break=true;
					}
					if (!case_1_break && case_1==Event.ACCEPTED) {
						{
							int case_2=CWin.accepted();
							boolean case_2_break=false;
							if (case_2==jumpwindow._okbutton) {
								if (!jumppage.equals(this.currentpage)) {
									rval.setValue(Constants.TRUE);
									this.currentpage.setValue(jumppage);
								}
								CWin.post(Event.CLOSEWINDOW);
								case_2_break=true;
							}
							if (!case_2_break && case_2==jumpwindow._cancelbutton) {
								CWin.post(Event.CLOSEWINDOW);
								case_2_break=true;
							}
						}
						case_1_break=true;
					}
				}
				Clarion.getWindowTarget().consumeAccept();
			}
			jumpwindow.close();
			return rval.like();
		} finally {
			jumpwindow.close();
		}
	}
	public ClarionNumber askprintpages()
	{
		ClarionString preserve=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
		Window window=new Window(this);
		ClarionNumber rval=Clarion.newNumber(Constants.FALSE).setEncoding(ClarionNumber.BYTE);
		try {
			preserve.setValue(this.pagestoprint);
			window.open();
			while (Clarion.getWindowTarget().accept()) {
				{
					int case_1=CWin.event();
					boolean case_1_break=false;
					if (case_1==Event.ACCEPTED) {
						{
							int case_2=CWin.accepted();
							boolean case_2_break=false;
							if (case_2==window._cancel) {
								this.pagestoprint.setValue(preserve);
								CWin.post(Event.CLOSEWINDOW);
								case_2_break=true;
							}
							if (!case_2_break && case_2==window._ok) {
								rval.setValue(Constants.TRUE);
								CWin.post(Event.CLOSEWINDOW);
								case_2_break=true;
							}
							if (!case_2_break && case_2==window._reset) {
								this.setdefaultpages();
								CWin.select(window._pagestoprint);
								case_2_break=true;
							}
						}
						case_1_break=true;
					}
					if (!case_1_break && case_1==Event.OPENWINDOW) {
						if (!(this.inimgr==null)) {
							this.inimgr.fetch(Clarion.newString("_PreviewAskPagesWindow_"),window);
						}
						case_1_break=true;
					}
					if (!case_1_break && case_1==Event.CLOSEWINDOW) {
						if (!(this.inimgr==null)) {
							this.inimgr.update(Clarion.newString("_PreviewAskPagesWindow_"),window);
						}
						case_1_break=true;
					}
				}
				Clarion.getWindowTarget().consumeAccept();
			}
			window.close();
			return rval.like();
		} finally {
			window.close();
		}
	}
	public void askthumbnails()
	{
		Selectwindow selectwindow=new Selectwindow(this);
		try {
			selectwindow.open();
			if (!(this.translator==null)) {
				this.translator.translatewindow(selectwindow);
			}
			while (Clarion.getWindowTarget().accept()) {
				{
					int case_1=CWin.event();
					if (case_1==Event.ACCEPTED) {
						{
							int case_2=CWin.field();
							if (case_2==selectwindow._ok) {
								if (this.pagesacross.multiply(this.pagesdown).compareTo(this.imagequeue.records())>0) {
									CWin.select(selectwindow._pagesacross);
								}
								else {
									CWin.post(Event.CLOSEWINDOW);
								}
							}
						}
					}
				}
				Clarion.getWindowTarget().consumeAccept();
			}
			selectwindow.close();
		} finally {
			selectwindow.close();
		}
	}
	public void configmenuchecks()
	{
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		final int loop_1=this.zoomqueue.records();for (c.setValue(1);c.compareTo(loop_1)<=0;c.increment(1)) {
			this.popup.setitemcheck(Clarion.newString(ClarionString.staticConcat("ZoomItem",c)),Clarion.newNumber(c.equals(this.zoomindex) ? 1 : 0));
			this.muse.get(c.intValue()).setValue(c.equals(this.zoomindex) ? 1 : 0);
		}
		CWin.display(Mconstants.ZOOMITEM+1,Mconstants.ZOOMITEM+this.zoomqueue.records());
	}
	public ClarionNumber deleteimagequeue(ClarionNumber i)
	{
		if (!Clarion.newNumber(this.imagequeue.getPointer()).equals(i)) {
			this.imagequeue.get(i);
			if (CError.errorCode()!=0) {
				return Clarion.newNumber(Constants.FALSE);
			}
		}
		CFile.deleteFile(this.imagequeue.filename.toString());
		this.imagequeue.delete();
		return Clarion.newNumber(Constants.TRUE);
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
	public ClarionNumber display(ClarionNumber initzoom,ClarionNumber initcurrentpage,ClarionNumber initpagesacross,ClarionNumber initpagesdown)
	{
		Previewwindow previewwindow=new Previewwindow(this);
		try {
			this.printok.setValue(Constants.FALSE);
			if (this.imagequeue.records()!=0) {
				this.initzoom.setValue(initzoom.equals(0) ? Clarion.newNumber(Mconstants.DEFAULTZOOM) : initzoom);
				this.firstpage.setValue(initcurrentpage);
				this.currentpage.setValue(initcurrentpage);
				this.pagesacross.setValue(initpagesacross);
				this.pagesdown.setValue(initpagesdown);
				this.setdefaultpages();
				previewwindow.open();
				if (this.maximize.boolValue()) {
					previewwindow.setProperty(Prop.MAXIMIZE,Constants.TRUE);
				}
				CWin.setCursor(Cursor.WAIT);
				if (!(this.translator==null)) {
					this.translator.translatewindow(previewwindow);
				}
				this.previewwindow=previewwindow;
				this.prtprevTbarzoom.setValue(previewwindow._tbarzoom);
				this.prtprevTbarprint.setValue(previewwindow._tbarprint);
				this.prtprevTbarexit.setValue(previewwindow._tbarexit);
				this.prtprevMenupages.setValue(previewwindow._pagestoprint);
				this.prtprevMenuprint.setValue(previewwindow._print);
				this.prtprevMenuexit.setValue(previewwindow._exit);
				this.prtprevZoomlist.setValue(previewwindow._zoomlist);
				this.prtprevZoomprompt.setValue(previewwindow._zoomprompt);
				this.prtprevPageprompt.setValue(previewwindow._pageprompt);
				this.prtprevCurrentpage.setValue(previewwindow._currentpage);
				this.prtprevPagesacross.setValue(previewwindow._pagesacross);
				this.prtprevPagesdown.setValue(previewwindow._pagesdown);
				this.prtprevNext.setValue(previewwindow._next);
				this.prtprevPrevious.setValue(previewwindow._previous);
				this.prtprevJump.setValue(previewwindow._jump);
				this.prtprevChangedisplay.setValue(previewwindow._changedisplay);
				this.prtprevViewmenu.setValue(previewwindow._viewmenu);
				this.prtprevZoommenu.setValue(previewwindow._zoommenu);
				this.ask();
				previewwindow.close();
			}
			if (this.printok.boolValue()) {
				this.syncimagequeue();
			}
			return this.printok.like();
		} finally {
			previewwindow.close();
		}
	}
	public void drawpage()
	{
		if (Abreport.idx2percentile(this,this.zoomindex.like()).equals(Mconstants.NOZOOM)) {
			drawpage_drawthumbnails();
		}
		else {
			if (CWin.event()!=Event.SIZED) {
				this.pagemanager.delete();
				if (!this.pagemanager.exists(this.currentpage.like()).boolValue()) {
					drawpage_addnewpagemanager();
				}
			}
			this.pagemanager.draw(this.currentpage.like(),Abreport.idx2percentile(this,this.zoomindex.like()));
		}
		if (CWin.event()!=Event.SIZED) {
			this.pagemanager.highlight(this.currentpage.like());
		}
	}
	public void drawpage_addnewpagemanager()
	{
		Pagemanagerclass oldroot=null;
		this.imagequeue.get(this.currentpage);
		CRun._assert(!(CError.errorCode()!=0));
		oldroot=this.pagemanager;
		this.pagemanager=new Pagemanagerclass();
		this.pagemanager.init(this,this.currentpage.like(),Clarion.newNumber(Mconstants.BASEFEQ).add(this.currentpage.multiply(2).subtract(2)).getNumber(),this.imagequeue.filename);
		this.pagemanager.neighbour=oldroot;
	}
	public void drawpage_drawthumbnails()
	{
		ClarionNumber txpos=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber typos=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber twidth=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber theight=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber trow=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber tcol=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber savepage=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		if (CWin.event()!=Event.SIZED) {
			final int loop_1=this.imagequeue.records();for (savepage.setValue(1);savepage.compareTo(loop_1)<=0;savepage.increment(1)) {
				if (!CRun.inRange(savepage,this.firstpage,this.firstpage.add(this.pagesacross.multiply(this.pagesdown)).subtract(1)) && this.pagemanager.exists(savepage.like()).boolValue()) {
					this.pagemanager.delete(savepage.like());
				}
			}
		}
		savepage.setValue(this.currentpage);
		this.currentpage.setValue(this.firstpage);
		twidth.setValue(this.previewwindow.getProperty(Prop.CLIENTWIDTH).subtract(this.pagesacross.add(1).multiply(Mconstants.MINXSEPERATION)).divide(this.pagesacross));
		theight.setValue(this.previewwindow.getProperty(Prop.CLIENTHEIGHT).subtract(this.pagesdown.add(1).multiply(Mconstants.MINYSEPERATION)).divide(this.pagesdown));
		typos.setValue(Mconstants.MINYSEPERATION);
		this.thumbnailspresent.setValue(0);
		final ClarionNumber loop_3=this.pagesdown.like();for (trow.setValue(1);trow.compareTo(loop_3)<=0;trow.increment(1)) {
			txpos.setValue(Mconstants.MINXSEPERATION);
			final ClarionNumber loop_2=this.pagesacross.like();for (tcol.setValue(1);tcol.compareTo(loop_2)<=0;tcol.increment(1)) {
				if (this.currentpage.compareTo(this.imagequeue.records())<=0) {
					if (!this.pagemanager.exists(this.currentpage.like()).boolValue()) {
						drawpage_addnewpagemanager();
					}
					this.pagemanager.setposition(this.currentpage.like(),txpos.like(),typos.like(),twidth.like(),theight.like());
					this.pagemanager.draw(this.currentpage.like(),Clarion.newNumber(Mconstants.NOZOOM));
					this.thumbnailspresent.increment(1);
				}
				txpos.increment(Clarion.newNumber(Mconstants.MINXSEPERATION).add(this.pagemanager.getprop(this.currentpage.like(),Clarion.newNumber(Prop.WIDTH))));
				theight.setValue(this.pagemanager.getprop(this.currentpage.like(),Clarion.newNumber(Prop.HEIGHT)));
				this.currentpage.increment(1);
			}
			typos.increment(Clarion.newNumber(Mconstants.MINYSEPERATION).add(theight));
		}
		this.currentpage.setValue(savepage);
		this.pagemanager.highlight(this.currentpage.like());
	}
	public void init(Previewqueue imagequeue)
	{
		Constantclass cnst=new Constantclass();
		super.init();
		this.imagequeue=imagequeue;
		CRun._assert(!(this.imagequeue==null));
		this.zoomqueue=new Zoomitemqueue();
		this.popup=new Popupclass();
		this.popup.init();
		cnst.init(Clarion.newNumber(Term.BYTE));
		cnst.additem(Clarion.newNumber(Consttype.PSTRING),this.zoomqueue.menutext);
		cnst.additem(Clarion.newNumber(Consttype.PSTRING),this.zoomqueue.statustext);
		cnst.additem(Clarion.newNumber(Consttype.SHORT),this.zoomqueue.percentile);
		cnst.set(Abreport.zoompresets.getString());
		while (cnst.next().equals(Level.BENIGN)) {
			this.zoomqueue.add();
			CRun._assert(!(CError.errorCode()!=0));
			this.popup.additem(Clarion.newString(ClarionString.staticConcat("-",this.zoomqueue.menutext)),Clarion.newString(ClarionString.staticConcat("ZoomItem",this.zoomqueue.records())));
		}
		cnst.kill();
	}
	public ClarionNumber inpagelist(ClarionNumber pagen)
	{
		ClarionNumber i=Clarion.newNumber(1).setEncoding(ClarionNumber.LONG);
		ClarionNumber j=Clarion.newNumber(0).setEncoding(ClarionNumber.LONG);
		ClarionString itm=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
		ClarionNumber lo=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber hi=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber s=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		if (this.pagestoprint.boolValue()) {
			while (true) {
				if (i.equals(this.pagestoprint.len())) {
					itm.setValue(this.pagestoprint.stringAt(j.add(1),i));
				}
				else if (this.pagestoprint.stringAt(i).equals(",")) {
					itm.setValue(this.pagestoprint.stringAt(j.add(1),i.subtract(1)));
					j.setValue(i);
				}
				s.setValue(itm.inString("-",1,1));
				if (s.boolValue()) {
					lo.setValue(itm.sub(1,s.subtract(1).intValue()));
					hi.setValue(itm.sub(s.add(1).intValue(),Clarion.newNumber(itm.len()).subtract(s).intValue()));
					if (lo.compareTo(0)>0 && hi.compareTo(0)>0 && lo.compareTo(hi)<=0 && CRun.inRange(pagen,lo,hi)) {
						return Clarion.newNumber(Constants.TRUE);
					}
				}
				else if (itm.isNumeric() && pagen.equals(itm)) {
					return Clarion.newNumber(Constants.TRUE);
				}
				i.increment(1);
				if (!(i.compareTo(this.pagestoprint.len())<=0)) break;
			}
		}
		return Clarion.newNumber(Constants.FALSE);
	}
	public ClarionNumber kill()
	{
		if (!(this.popup==null)) {
			this.popup.kill();
			//this.popup;
		}
		//this.zoomqueue;
		return super.kill();
	}
	public void newzoom()
	{
		this.resetuserzoom();
		this.drawpage();
		this.configmenuchecks();
	}
	public void open()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		if (!(this.windowposset.boolValue() && this.windowsizeset.boolValue())) {
			if (this.savesize.set.boolValue()) {
				CWin.setPosition(0,this.savesize.xpos.intValue(),this.savesize.ypos.intValue(),this.savesize.width.intValue(),this.savesize.height.intValue());
			}
			else if (!(this.inimgr==null)) {
				this.inimgr.fetch(Clarion.newString("_PreviewWindow_"),this.previewwindow);
			}
		}
		else if (this.windowposset.boolValue() && this.windowsizeset.boolValue()) {
			CWin.setPosition(0,this.winxpos.intValue(),this.winypos.intValue(),this.winwidth.intValue(),this.winheight.intValue());
		}
		else if (this.windowposset.boolValue()) {
			CWin.setPosition(0,this.winxpos.intValue(),this.winypos.intValue(),null,null);
		}
		else if (this.windowsizeset.boolValue()) {
			CWin.setPosition(0,null,null,this.winwidth.intValue(),this.winheight.intValue());
		}
		this.imagequeue.get(1);
		CRun._assert(!(CError.errorCode()!=0));
		this.pagemanager=new Pagemanagerclass();
		this.pagemanager.init(this,Clarion.newNumber(1),Clarion.newNumber(Mconstants.BASEFEQ),this.imagequeue.filename);
		if (this.imagequeue.records()>1) {
			CWin.enable(this.prtprevViewmenu.intValue());
			Clarion.getControl(this.prtprevCurrentpage).setProperty(Prop.RANGEHIGH,this.imagequeue.records());
			Clarion.getControl(this.prtprevCurrentpage).setProperty(Prop.MSG,ClarionString.staticConcat(Mconstants.ENTERSTR," ",this.imagequeue.records()));
		}
		else {
			CWin.disable(this.prtprevCurrentpage.intValue(),this.prtprevPagesdown.intValue());
		}
		final int loop_1=this.zoomqueue.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.zoomqueue.get(i);
			CRun._assert(!(CError.errorCode()!=0));
			CWin.createControl(Clarion.newNumber(Mconstants.ZOOMITEM).add(i).intValue(),Create.ITEM,this.prtprevZoommenu.intValue(),i.intValue());
			Clarion.getControl(Clarion.newNumber(Mconstants.ZOOMITEM).add(i)).setProperty(Prop.USE,this.muse.get(i.intValue()));
			Clarion.getControl(Clarion.newNumber(Mconstants.ZOOMITEM).add(i)).setProperty(Prop.TEXT,this.zoomqueue.menutext.sub(1,this.zoomqueue.menutext.len()));
			Clarion.getControl(Clarion.newNumber(Mconstants.ZOOMITEM).add(i)).setProperty(Prop.CHECK,Constants.TRUE);
			this.muse.get(i.intValue()).setValue(i.equals(Mconstants.DEFAULTZOOM) ? 1 : 0);
			this.popup.additemevent(Clarion.newString(ClarionString.staticConcat("ZoomItem",i)),Clarion.newNumber(Event.ACCEPTED),Clarion.newNumber(Mconstants.ZOOMITEM).add(i).getNumber());
			Clarion.getControl(this.prtprevZoomlist).setProperty(Prop.FROM,Clarion.getControl(this.prtprevZoomlist).getProperty(Prop.FROM).getString().clip().concat(this.zoomqueue.menutext.clip(),i.compareTo(this.zoomqueue.records())<0 ? Clarion.newString("|") : Clarion.newString("")));
		}
		if (this.allowuserzoom.boolValue()) {
			this.resetuserzoom();
			CWin.unhide(this.prtprevZoomlist.intValue());
			CWin.unhide(this.prtprevZoomprompt.intValue());
		}
		this.zoomindex.setValue(Abreport.percentile2idx(this,this.initzoom.like()));
		if (this.zoomindex.compareTo(this.zoomqueue.records())>0) {
			CRun._assert(this.allowuserzoom.boolValue());
			this.zoomindex.setValue(0);
			this.userpercentile.setValue(this.initzoom);
		}
		if (!(this.translator==null)) {
			this.popup.settranslator(this.translator);
		}
		this.newzoom();
		CWin.setCursor(null);
	}
	public void resetuserzoom()
	{
		if (this.allowuserzoom.boolValue()) {
			if (this.zoomindex.boolValue()) {
				this.zoomqueue.get(this.zoomindex);
				CRun._assert(!(CError.errorCode()!=0));
				this.zoomlist.setValue(this.zoomqueue.menutext);
			}
			else {
				this.zoomlist.setValue(this.zoomlist.clip().concat(Mconstants.PCZOOM));
			}
			CWin.display(this.prtprevZoomlist.intValue());
		}
	}
	public void setdefaultpages()
	{
		this.pagestoprint.setValue(ClarionString.staticConcat("1-",this.imagequeue.records()));
	}
	public void setinimanager(Iniclass ini)
	{
		CRun._assert(!(ini==null));
		this.inimgr=ini;
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
	public void setposition(ClarionNumber x,ClarionNumber y,ClarionNumber wid,ClarionNumber hgt)
	{
		if (!(x==null) && !(y==null)) {
			this.windowposset.setValue(Constants.TRUE);
			this.winxpos.setValue(x);
			this.winypos.setValue(y);
		}
		if (!(wid==null) && !(hgt==null)) {
			this.windowsizeset.setValue(Constants.TRUE);
			this.winwidth.setValue(wid);
			this.winheight.setValue(hgt);
		}
	}
	public void setzoompercentile(ClarionNumber percentile)
	{
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		this.zoomindex.setValue(0);
		final int loop_1=this.zoomqueue.records();for (c.setValue(1);c.compareTo(loop_1)<=0;c.increment(1)) {
			this.zoomqueue.get(c);
			CRun._assert(!(CError.errorCode()!=0));
			if (this.zoomqueue.percentile.equals(percentile)) {
				this.zoomindex.setValue(c);
				this.userpercentile.setValue(0);
			}
			if (!!this.zoomindex.boolValue()) break;
		}
		if (!this.zoomindex.boolValue()) {
			CRun._assert(this.allowuserzoom.boolValue());
			this.userpercentile.setValue(percentile);
		}
	}
	public void syncimagequeue()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		for (i.setValue(this.imagequeue.records());i.compareTo(1)>=0;i.increment(-1)) {
			if (!this.inpagelist(i.like()).boolValue()) {
				this.deleteimagequeue(i.like());
			}
		}
	}
	public ClarionNumber takeaccepted()
	{
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		if (super.takeaccepted().boolValue()) {
			return Clarion.newNumber(Level.NOTIFY);
		}
		{
			int case_1=CWin.field();
			boolean case_1_break=false;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1>=Mconstants.ZOOMITEM+1 && case_1<=Mconstants.ZOOMITEM+this.zoomqueue.records()) {
				i.setValue(this.zoomindex);
				this.zoomindex.setValue(CWin.accepted()-(Mconstants.ZOOMITEM+1)+1);
				if (!this.zoomindex.equals(i)) {
					this.newzoom();
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.prtprevTbarzoom)) {
				this.configmenuchecks();
				this.popup.ask();
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.prtprevMenupages)) {
				this.askprintpages();
				this.drawpage();
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.prtprevMenuprint)) {
				case_1_match=true;
			}
			if (case_1_match || Clarion.newNumber(case_1).equals(this.prtprevTbarprint)) {
				this.printok.setValue(this.confirmpages.equals(Constants.TRUE) ? this.askprintpages() : Clarion.newNumber(Constants.TRUE));
				CWin.post(Event.CLOSEWINDOW);
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.prtprevMenuexit)) {
				case_1_match=true;
			}
			if (case_1_match || Clarion.newNumber(case_1).equals(this.prtprevTbarexit)) {
				CWin.post(Event.CLOSEWINDOW);
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.prtprevZoomlist)) {
				i.setValue(Constants.FALSE);
				final int loop_1=this.zoomqueue.records();for (c.setValue(1);c.compareTo(loop_1)<=0;c.increment(1)) {
					this.zoomqueue.get(c);
					CRun._assert(!(CError.errorCode()!=0));
					if (this.zoomqueue.menutext.equals(this.zoomlist)) {
						i.setValue(Constants.TRUE);
					}
					if (!!i.boolValue()) break;
				}
				if (i.boolValue()) {
					CWin.post(Event.ACCEPTED,Mconstants.ZOOMITEM+CWin.choice(this.prtprevZoomlist.intValue()));
					return Clarion.newNumber(Level.NOTIFY);
				}
				else {
					this.zoomlist.setValue(this.zoomlist.getDecimal().abs());
					this.zoomindex.setValue(0);
					this.userpercentile.setValue(this.zoomlist);
					this.newzoom();
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.prtprevCurrentpage)) {
				if (!CRun.inRange(this.currentpage.subtract(this.firstpage).add(1),Clarion.newNumber(1),this.pagesacross.multiply(this.pagesdown))) {
					this.firstpage.setValue(this.currentpage);
					while (this.firstpage.add(this.pagesacross.multiply(this.pagesdown)).subtract(1).compareTo(this.imagequeue.records())>0) {
						this.firstpage.decrement(1);
						if (!(this.firstpage.compareTo(1)>0)) break;
					}
					this.drawpage();
				}
				else {
					if (!this.pagemanager.exists(this.currentpage.like()).boolValue()) {
						this.drawpage();
					}
					else {
						this.pagemanager.highlight(this.currentpage.like());
					}
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.prtprevPagesacross)) {
				case_1_match=true;
			}
			if (case_1_match || Clarion.newNumber(case_1).equals(this.prtprevPagesdown)) {
				i.setValue(Constants.TRUE);
				while (this.firstpage.add(this.pagesacross.multiply(this.pagesdown)).subtract(1).compareTo(this.imagequeue.records())>0) {
					this.pagesacross.decrement(Clarion.newNumber(CWin.accepted()).equals(this.prtprevPagesacross) ? 1 : 0);
					this.pagesdown.decrement(Clarion.newNumber(CWin.accepted()).equals(this.prtprevPagesdown) ? 1 : 0);
					i.setValue(Constants.FALSE);
					if (!(this.pagesacross.compareTo(1)>0 && this.pagesdown.compareTo(1)>0)) break;
				}
				if (i.boolValue()) {
					this.drawpage();
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.prtprevNext)) {
				case_1_match=true;
			}
			if (case_1_match || Clarion.newNumber(case_1).equals(this.prtprevPrevious)) {
				this.currentpage.increment(Clarion.newNumber(CWin.accepted()).equals(this.prtprevNext) ? Clarion.newNumber(1) : Clarion.newNumber(-1));
				CWin.post(Event.ACCEPTED,this.prtprevCurrentpage.intValue());
				return Clarion.newNumber(Level.NOTIFY);
				// UNREACHABLE! :case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.prtprevJump)) {
				if (this.askpage().boolValue()) {
					CWin.post(Event.ACCEPTED,this.prtprevCurrentpage.intValue());
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.prtprevChangedisplay)) {
				this.askthumbnails();
				this.currentpage.setValue(1);
				this.drawpage();
				case_1_break=true;
			}
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber takeevent()
	{
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber cx=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber cy=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber mx=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber my=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		if (super.takeevent().boolValue()) {
			return Clarion.newNumber(Level.NOTIFY);
		}
		{
			int case_1=CWin.event();
			boolean case_1_break=false;
			if (case_1==Event.CLOSEWINDOW) {
				if (!(this.inimgr==null)) {
					this.inimgr.update(Clarion.newString("_PreviewWindow_"),this.previewwindow);
				}
				this.pagemanager.kill();
				//this.pagemanager;
				case_1_break=true;
			}
			if (!case_1_break && case_1==Event.SIZED) {
				this.savesize.set.setValue(Constants.TRUE);
				CWin.getPosition(0,this.savesize.xpos,this.savesize.ypos,this.savesize.width,this.savesize.height);
				this.drawpage();
				case_1_break=true;
			}
			if (!case_1_break && case_1==Event.ALERTKEY) {
				{
					int case_2=CWin.keyCode();
					boolean case_2_break=false;
					if (case_2==Constants.PGUPKEY) {
						if (this.currentpage.compareTo(1)>0 && !Clarion.getControl(this.prtprevPrevious).getProperty(Prop.DISABLE).boolValue()) {
							CWin.post(Event.ACCEPTED,this.prtprevPrevious.intValue());
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==Constants.PGDNKEY) {
						if (this.currentpage.compareTo(this.imagequeue.records())<0 && !Clarion.getControl(this.prtprevNext).getProperty(Prop.DISABLE).boolValue()) {
							CWin.post(Event.ACCEPTED,this.prtprevNext.intValue());
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==Constants.MOUSELEFT) {
						takeevent_getcoord(mx,my,c);
						if (c.boolValue()) {
							this.currentpage.setValue(c);
							if (Abreport.idx2percentile(this,this.zoomindex.like()).equals(Mconstants.NOZOOM)) {
								if (Abreport.percentile2idx(this,Clarion.newNumber(Mconstants.PAGEWIDTH)).compareTo(this.zoomqueue.records())<=0) {
									this.zoomindex.setValue(Abreport.percentile2idx(this,Clarion.newNumber(Mconstants.PAGEWIDTH)));
									this.pagemanager.setcentre(c.like(),Clarion.newNumber(0),my.subtract(this.pagemanager.getprop(c.like(),Clarion.newNumber(Prop.YPOS))).divide(this.pagemanager.getprop(c.like(),Clarion.newNumber(Prop.HEIGHT))).multiply(100).getNumber());
									this.newzoom();
								}
							}
							else {
								if (Abreport.percentile2idx(this,Clarion.newNumber(Mconstants.NOZOOM)).compareTo(this.zoomqueue.records())<=0) {
									this.zoomindex.setValue(Abreport.percentile2idx(this,Clarion.newNumber(Mconstants.NOZOOM)));
									this.newzoom();
								}
							}
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==Constants.MOUSERIGHTUP) {
						takeevent_getcoord(mx,my,c);
						if (c.boolValue()) {
							if (Abreport.idx2percentile(this,this.zoomindex.like()).equals(Mconstants.NOZOOM)) {
								cx.setValue(mx.subtract(this.pagemanager.getprop(c.like(),Clarion.newNumber(Prop.XPOS))).divide(this.pagemanager.getprop(c.like(),Clarion.newNumber(Prop.WIDTH))).multiply(100));
								cy.setValue(my.subtract(this.pagemanager.getprop(c.like(),Clarion.newNumber(Prop.YPOS))).divide(this.pagemanager.getprop(c.like(),Clarion.newNumber(Prop.HEIGHT))).multiply(100));
							}
							else {
								if (this.pagemanager.getprop(c.like(),Clarion.newNumber(Prop.VSCROLL)).boolValue()) {
									i.setValue(this.pagemanager.getprop(c.like(),Clarion.newNumber(Prop.VSCROLLPOS)).multiply(this.pagemanager.getprop(c.like(),Clarion.newNumber(Prop.MAXHEIGHT)).subtract(this.pagemanager.getprop(c.like(),Clarion.newNumber(Prop.HEIGHT))).divide(255)));
									cy.setValue(Clarion.newNumber(100).multiply(i.add(my).divide(this.pagemanager.getprop(c.like(),Clarion.newNumber(Prop.MAXHEIGHT)))));
								}
								else {
									cy.setValue(my.divide(this.pagemanager.getprop(c.like(),Clarion.newNumber(Prop.HEIGHT))).multiply(100));
								}
								if (this.pagemanager.getprop(c.like(),Clarion.newNumber(Prop.HSCROLL)).boolValue()) {
									i.setValue(this.pagemanager.getprop(c.like(),Clarion.newNumber(Prop.HSCROLLPOS)).multiply(this.pagemanager.getprop(c.like(),Clarion.newNumber(Prop.MAXWIDTH)).subtract(this.pagemanager.getprop(c.like(),Clarion.newNumber(Prop.WIDTH))).divide(255)));
									cx.setValue(Clarion.newNumber(100).multiply(i.add(mx).divide(this.pagemanager.getprop(c.like(),Clarion.newNumber(Prop.MAXWIDTH)))));
								}
								else {
									cx.setValue(mx.divide(this.pagemanager.getprop(c.like(),Clarion.newNumber(Prop.WIDTH))).multiply(100));
								}
							}
							this.pagemanager.setcentre(c.like(),cx.like(),cy.like());
							if (this.popup.ask().boolValue()) {
								this.currentpage.setValue(c);
							}
							else {
								this.pagemanager.setcentre(c.like(),Clarion.newNumber(0),Clarion.newNumber(0));
							}
						}
						case_2_break=true;
					}
				}
				case_1_break=true;
			}
		}
		takeevent_displaywindow();
		return Clarion.newNumber(Level.BENIGN);
	}
	public void takeevent_displaywindow()
	{
		this.configmenuchecks();
		Clarion.getControl(this.prtprevPrevious).setProperty(Prop.DISABLE,this.currentpage.equals(1) ? 1 : 0);
		Clarion.getControl(this.prtprevNext).setProperty(Prop.DISABLE,this.currentpage.equals(this.imagequeue.records()) ? 1 : 0);
		Clarion.getControl(this.prtprevJump).setProperty(Prop.DISABLE,this.imagequeue.records()==1 ? 1 : 0);
		Clarion.getControl(this.prtprevChangedisplay).setProperty(Prop.DISABLE,Clarion.getControl(this.prtprevJump).getProperty(Prop.DISABLE));
		if (this.imagequeue.records()==1) {
			CWin.disable(this.prtprevPageprompt.intValue(),this.prtprevPagesdown.intValue());
		}
		else {
			if (Abreport.idx2percentile(this,this.zoomindex.like()).equals(Mconstants.NOZOOM)) {
				CWin.enable(this.prtprevPagesacross.intValue(),this.prtprevPagesdown.intValue());
			}
			else {
				CWin.disable(this.prtprevPagesacross.intValue(),this.prtprevPagesdown.intValue());
			}
		}
		CWin.display(this.prtprevCurrentpage.intValue(),this.prtprevPagesdown.intValue());
		if (Abreport.idx2percentile(this,this.zoomindex.like()).equals(Mconstants.NOZOOM)) {
			Clarion.getControl(this.prtprevChangedisplay).setProperty(Prop.DISABLE,this.imagequeue.records()<=1 ? 1 : 0);
		}
		else {
			CWin.disable(this.prtprevChangedisplay.intValue());
		}
		this.previewwindow.setProperty(Prop.STATUSTEXT,3,this.zoomindex.equals(0) ? Clarion.newString(ClarionString.staticConcat(Mconstants.SBZOOM," ",this.userpercentile,"%")) : this.zoomqueue.statustext);
		if (Abreport.idx2percentile(this,this.zoomindex.like()).equals(Mconstants.NOZOOM)) {
			this.previewwindow.setProperty(Prop.STATUSTEXT,2,ClarionString.staticConcat(Mconstants.PAGESTR," ",this.thumbnailspresent.compareTo(1)>0 ? Clarion.newString(this.firstpage.concat("-",this.firstpage.add(this.thumbnailspresent).subtract(1)," ",Mconstants.OFSTR)) : Clarion.newString(this.currentpage.concat(" ",Mconstants.OFSTR))," ",this.imagequeue.records()));
		}
		else {
			this.previewwindow.setProperty(Prop.STATUSTEXT,2,ClarionString.staticConcat(Mconstants.PAGESTR," ",this.currentpage," ",Mconstants.OFSTR," ",this.imagequeue.records()));
		}
		CWin.display(this.prtprevNext.intValue(),this.prtprevChangedisplay.intValue());
	}
	public void takeevent_getcoord(ClarionNumber mx,ClarionNumber my,ClarionNumber c)
	{
		mx.setValue(CWin.getMouseX());
		my.setValue(CWin.getMouseY());
		c.setValue(this.pagemanager.coordcontained(mx.like(),my.like()));
	}
	public ClarionNumber takewindowevent()
	{
		return (CWin.event()==Event.GAINFOCUS ? Clarion.newNumber(Level.BENIGN) : super.takewindowevent()).getNumber();
	}
	public ClarionNumber takefieldevent()
	{
		{
			int case_1=CWin.event();
			if (case_1==Event.NEWSELECTION) {
				if (CRun.inlist(String.valueOf(CWin.field()),new ClarionString[] {this.prtprevCurrentpage.getString(),this.prtprevPagesacross.getString(),this.prtprevPagesdown.getString()}).boolValue()) {
					CWin.post(Event.ACCEPTED,CWin.field());
					return Clarion.newNumber(Level.NOTIFY);
				}
			}
		}
		return Clarion.newNumber(Level.BENIGN);
	}
}
