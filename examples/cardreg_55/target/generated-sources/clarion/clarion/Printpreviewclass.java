package clarion;

import clarion.Abreport;
import clarion.Constantclass;
import clarion.Iniclass;
import clarion.JumpWindow;
import clarion.Pagemanagerclass;
import clarion.Popupclass;
import clarion.PreviewWindow;
import clarion.Previewqueue;
import clarion.Savesizetype;
import clarion.SelectWindow;
import clarion.Window_3;
import clarion.Windowmanager;
import clarion.Zoomitemqueue;
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

public class Printpreviewclass extends Windowmanager
{
	public ClarionNumber allowUserZoom;
	public ClarionNumber confirmPages;
	public ClarionNumber currentPage;
	public ClarionNumber firstPage;
	public Previewqueue imageQueue;
	public Iniclass iNIMgr;
	public ClarionNumber initZoom;
	public ClarionNumber maximize;
	public ClarionArray<ClarionNumber> mUse;
	public Pagemanagerclass pageManager;
	public ClarionNumber pagesAcross;
	public ClarionNumber pagesDown;
	public ClarionString pagesToPrint;
	public Popupclass popup;
	public ClarionWindow previewWindow;
	public ClarionNumber printOK;
	public Savesizetype saveSize;
	public ClarionNumber thumbnailsPresent;
	public ClarionNumber userPercentile;
	public ClarionNumber windowPosSet;
	public ClarionNumber windowSizeSet;
	public ClarionNumber winHeight;
	public ClarionNumber winWidth;
	public ClarionNumber winXPos;
	public ClarionNumber winYPos;
	public Zoomitemqueue zoomQueue;
	public ClarionNumber zoomIndex;
	public ClarionString zoomList;
	public ClarionNumber prtPrevTBarZoom;
	public ClarionNumber prtPrevTBarPrint;
	public ClarionNumber prtPrevTBarExit;
	public ClarionNumber prtPrevMenuPages;
	public ClarionNumber prtPrevMenuPrint;
	public ClarionNumber prtPrevMenuExit;
	public ClarionNumber prtPrevZoomList;
	public ClarionNumber prtPrevZoomPrompt;
	public ClarionNumber prtPrevPagePrompt;
	public ClarionNumber prtPrevCurrentPage;
	public ClarionNumber prtPrevPagesAcross;
	public ClarionNumber prtPrevPagesDown;
	public ClarionNumber prtPrevNext;
	public ClarionNumber prtPrevPrevious;
	public ClarionNumber prtPrevJump;
	public ClarionNumber prtPrevChangeDisplay;
	public ClarionNumber prtPrevViewMenu;
	public ClarionNumber prtPrevZoomMenu;
	public Printpreviewclass()
	{
		allowUserZoom=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		confirmPages=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		currentPage=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		firstPage=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		imageQueue=null;
		iNIMgr=null;
		initZoom=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		maximize=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		mUse=Clarion.newNumber().setEncoding(ClarionNumber.BYTE).dim(32);
		pageManager=null;
		pagesAcross=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		pagesDown=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		pagesToPrint=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
		popup=null;
		previewWindow=null;
		printOK=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		saveSize=new Savesizetype();
		thumbnailsPresent=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		userPercentile=Clarion.newNumber(0).setEncoding(ClarionNumber.USHORT);
		windowPosSet=Clarion.newNumber(Constants.FALSE).setEncoding(ClarionNumber.BYTE);
		windowSizeSet=Clarion.newNumber(Constants.FALSE).setEncoding(ClarionNumber.BYTE);
		winHeight=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		winWidth=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		winXPos=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		winYPos=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		zoomQueue=null;
		zoomIndex=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		zoomList=Clarion.newString(16);
		prtPrevTBarZoom=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtPrevTBarPrint=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtPrevTBarExit=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtPrevMenuPages=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtPrevMenuPrint=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtPrevMenuExit=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtPrevZoomList=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtPrevZoomPrompt=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtPrevPagePrompt=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtPrevCurrentPage=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtPrevPagesAcross=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtPrevPagesDown=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtPrevNext=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtPrevPrevious=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtPrevJump=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtPrevChangeDisplay=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtPrevViewMenu=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		prtPrevZoomMenu=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	}

	public ClarionNumber askPage()
	{
		ClarionNumber jumpPage=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber rVal=Clarion.newNumber(Constants.FALSE).setEncoding(ClarionNumber.BYTE);
		JumpWindow jumpWindow=new JumpWindow(jumpPage);
		try {
			jumpPage.setValue(this.currentPage);
			jumpWindow.open();
			if (!(this.translator==null)) {
				this.translator.translateWindow(jumpWindow);
			}
			while (Clarion.getWindowTarget().accept()) {
				{
					int case_1=CWin.event();
					boolean case_1_break=false;
					if (case_1==Event.OPENWINDOW) {
						Clarion.getControl(jumpWindow._jumpPage).setProperty(Prop.RANGEHIGH,this.imageQueue.records());
						case_1_break=true;
					}
					if (!case_1_break && case_1==Event.ACCEPTED) {
						{
							int case_2=CWin.accepted();
							boolean case_2_break=false;
							if (case_2==jumpWindow._okButton) {
								if (!jumpPage.equals(this.currentPage)) {
									rVal.setValue(Constants.TRUE);
									this.currentPage.setValue(jumpPage);
								}
								CWin.post(Event.CLOSEWINDOW);
								case_2_break=true;
							}
							if (!case_2_break && case_2==jumpWindow._cancelButton) {
								CWin.post(Event.CLOSEWINDOW);
								case_2_break=true;
							}
						}
						case_1_break=true;
					}
				}
				Clarion.getWindowTarget().consumeAccept();
			}
			jumpWindow.close();
			return rVal.like();
		} finally {
			jumpWindow.close();
		}
	}
	public ClarionNumber askPrintPages()
	{
		ClarionString preserve=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
		Window_3 window=new Window_3(this);
		ClarionNumber rVal=Clarion.newNumber(Constants.FALSE).setEncoding(ClarionNumber.BYTE);
		try {
			preserve.setValue(this.pagesToPrint);
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
								this.pagesToPrint.setValue(preserve);
								CWin.post(Event.CLOSEWINDOW);
								case_2_break=true;
							}
							if (!case_2_break && case_2==window._ok) {
								rVal.setValue(Constants.TRUE);
								CWin.post(Event.CLOSEWINDOW);
								case_2_break=true;
							}
							if (!case_2_break && case_2==window._reset) {
								this.setDefaultPages();
								CWin.select(window._pagesToPrint);
								case_2_break=true;
							}
						}
						case_1_break=true;
					}
					if (!case_1_break && case_1==Event.OPENWINDOW) {
						if (!(this.iNIMgr==null)) {
							this.iNIMgr.fetch(Clarion.newString("_PreviewAskPagesWindow_"),window);
						}
						case_1_break=true;
					}
					if (!case_1_break && case_1==Event.CLOSEWINDOW) {
						if (!(this.iNIMgr==null)) {
							this.iNIMgr.update(Clarion.newString("_PreviewAskPagesWindow_"),window);
						}
						case_1_break=true;
					}
				}
				Clarion.getWindowTarget().consumeAccept();
			}
			window.close();
			return rVal.like();
		} finally {
			window.close();
		}
	}
	public void askThumbnails()
	{
		SelectWindow selectWindow=new SelectWindow(this);
		try {
			selectWindow.open();
			if (!(this.translator==null)) {
				this.translator.translateWindow(selectWindow);
			}
			while (Clarion.getWindowTarget().accept()) {
				{
					int case_1=CWin.event();
					if (case_1==Event.ACCEPTED) {
						{
							int case_2=CWin.field();
							if (case_2==selectWindow._ok) {
								if (this.pagesAcross.multiply(this.pagesDown).compareTo(this.imageQueue.records())>0) {
									CWin.select(selectWindow._pagesAcross);
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
			selectWindow.close();
		} finally {
			selectWindow.close();
		}
	}
	public void configMenuChecks()
	{
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		for (c.setValue(1);c.compareTo(this.zoomQueue.records())<=0;c.increment(1)) {
			this.popup.setItemCheck(Clarion.newString(ClarionString.staticConcat("ZoomItem",c)),Clarion.newNumber(c.equals(this.zoomIndex) ? 1 : 0));
			this.mUse.get(c.intValue()).setValue(c.equals(this.zoomIndex) ? 1 : 0);
		}
		CWin.display(Constants.ZOOMITEM+1,Constants.ZOOMITEM+this.zoomQueue.records());
	}
	public ClarionNumber deleteImageQueue(ClarionNumber i)
	{
		if (!Clarion.newNumber(this.imageQueue.getPointer()).equals(i)) {
			this.imageQueue.get(i);
			if (CError.errorCode()!=0) {
				return Clarion.newNumber(Constants.FALSE);
			}
		}
		CFile.deleteFile(this.imageQueue.fileName.toString());
		this.imageQueue.delete();
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
	public ClarionNumber display(ClarionNumber initZoom,ClarionNumber initCurrentPage,ClarionNumber initPagesAcross,ClarionNumber initPagesDown)
	{
		PreviewWindow previewWindow=new PreviewWindow(this);
		try {
			this.printOK.setValue(Constants.FALSE);
			if (this.imageQueue.records()!=0) {
				this.initZoom.setValue(initZoom.equals(0) ? Clarion.newNumber(Constants.DEFAULTZOOM) : initZoom);
				this.firstPage.setValue(initCurrentPage);
				this.currentPage.setValue(initCurrentPage);
				this.pagesAcross.setValue(initPagesAcross);
				this.pagesDown.setValue(initPagesDown);
				this.setDefaultPages();
				previewWindow.open();
				if (this.maximize.boolValue()) {
					previewWindow.setProperty(Prop.MAXIMIZE,Constants.TRUE);
				}
				CWin.setCursor(Cursor.WAIT);
				if (!(this.translator==null)) {
					this.translator.translateWindow(previewWindow);
				}
				this.previewWindow=previewWindow;
				this.prtPrevTBarZoom.setValue(previewWindow._tBarZoom);
				this.prtPrevTBarPrint.setValue(previewWindow._tBarPrint);
				this.prtPrevTBarExit.setValue(previewWindow._tBarExit);
				this.prtPrevMenuPages.setValue(previewWindow._pagesToPrint);
				this.prtPrevMenuPrint.setValue(previewWindow._print);
				this.prtPrevMenuExit.setValue(previewWindow._exit);
				this.prtPrevZoomList.setValue(previewWindow._zoomList);
				this.prtPrevZoomPrompt.setValue(previewWindow._zoomPrompt);
				this.prtPrevPagePrompt.setValue(previewWindow._pagePrompt);
				this.prtPrevCurrentPage.setValue(previewWindow._currentPage);
				this.prtPrevPagesAcross.setValue(previewWindow._pagesAcross);
				this.prtPrevPagesDown.setValue(previewWindow._pagesDown);
				this.prtPrevNext.setValue(previewWindow._next);
				this.prtPrevPrevious.setValue(previewWindow._previous);
				this.prtPrevJump.setValue(previewWindow._jump);
				this.prtPrevChangeDisplay.setValue(previewWindow._changeDisplay);
				this.prtPrevViewMenu.setValue(previewWindow._viewMenu);
				this.prtPrevZoomMenu.setValue(previewWindow._zoomMenu);
				this.ask();
				previewWindow.close();
			}
			if (this.printOK.boolValue()) {
				this.syncImageQueue();
			}
			return this.printOK.like();
		} finally {
			previewWindow.close();
		}
	}
	public void drawPage()
	{
		if (Abreport.idx2Percentile(this,this.zoomIndex.like()).equals(Constants.NOZOOM)) {
			drawPage_DrawThumbnails();
		}
		else {
			if (CWin.event()!=Event.SIZED) {
				this.pageManager.delete();
				if (!this.pageManager.exists(this.currentPage.like()).boolValue()) {
					drawPage_AddNewPageManager();
				}
			}
			this.pageManager.draw(this.currentPage.like(),Abreport.idx2Percentile(this,this.zoomIndex.like()));
		}
		if (CWin.event()!=Event.SIZED) {
			this.pageManager.highLight(this.currentPage.like());
		}
	}
	public void drawPage_AddNewPageManager()
	{
		Pagemanagerclass oldRoot=null;
		this.imageQueue.get(this.currentPage);
		CRun._assert(!(CError.errorCode()!=0));
		oldRoot=this.pageManager;
		this.pageManager=new Pagemanagerclass();
		this.pageManager.init(this,this.currentPage.like(),Clarion.newNumber(Constants.BASEFEQ).add(this.currentPage.multiply(2).subtract(2)).getNumber(),this.imageQueue.fileName);
		this.pageManager.neighbour=oldRoot;
	}
	public void drawPage_DrawThumbnails()
	{
		ClarionNumber tXPos=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber tYPos=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber tWidth=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber tHeight=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber tRow=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber tCol=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber savePage=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		if (CWin.event()!=Event.SIZED) {
			for (savePage.setValue(1);savePage.compareTo(this.imageQueue.records())<=0;savePage.increment(1)) {
				if (!CRun.inRange(savePage,this.firstPage,this.firstPage.add(this.pagesAcross.multiply(this.pagesDown)).subtract(1)) && this.pageManager.exists(savePage.like()).boolValue()) {
					this.pageManager.delete(savePage.like());
				}
			}
		}
		savePage.setValue(this.currentPage);
		this.currentPage.setValue(this.firstPage);
		tWidth.setValue(this.previewWindow.getProperty(Prop.CLIENTWIDTH).subtract(this.pagesAcross.add(1).multiply(Constants.MINXSEPERATION)).divide(this.pagesAcross));
		tHeight.setValue(this.previewWindow.getProperty(Prop.CLIENTHEIGHT).subtract(this.pagesDown.add(1).multiply(Constants.MINYSEPERATION)).divide(this.pagesDown));
		tYPos.setValue(Constants.MINYSEPERATION);
		this.thumbnailsPresent.setValue(0);
		for (tRow.setValue(1);tRow.compareTo(this.pagesDown)<=0;tRow.increment(1)) {
			tXPos.setValue(Constants.MINXSEPERATION);
			for (tCol.setValue(1);tCol.compareTo(this.pagesAcross)<=0;tCol.increment(1)) {
				if (this.currentPage.compareTo(this.imageQueue.records())<=0) {
					if (!this.pageManager.exists(this.currentPage.like()).boolValue()) {
						drawPage_AddNewPageManager();
					}
					this.pageManager.setPosition(this.currentPage.like(),tXPos.like(),tYPos.like(),tWidth.like(),tHeight.like());
					this.pageManager.draw(this.currentPage.like(),Clarion.newNumber(Constants.NOZOOM));
					this.thumbnailsPresent.increment(1);
				}
				tXPos.increment(Clarion.newNumber(Constants.MINXSEPERATION).add(this.pageManager.getProp(this.currentPage.like(),Clarion.newNumber(Prop.WIDTH))));
				tHeight.setValue(this.pageManager.getProp(this.currentPage.like(),Clarion.newNumber(Prop.HEIGHT)));
				this.currentPage.increment(1);
			}
			tYPos.increment(Clarion.newNumber(Constants.MINYSEPERATION).add(tHeight));
		}
		this.currentPage.setValue(savePage);
		this.pageManager.highLight(this.currentPage.like());
	}
	public void init(Previewqueue imageQueue)
	{
		Constantclass cnst=new Constantclass();
		super.init();
		this.imageQueue=imageQueue;
		CRun._assert(!(this.imageQueue==null));
		this.zoomQueue=new Zoomitemqueue();
		this.popup=new Popupclass();
		this.popup.init();
		cnst.init(Clarion.newNumber(Term.BYTE));
		cnst.addItem(Clarion.newNumber(Consttype.PSTRING),this.zoomQueue.menuText);
		cnst.addItem(Clarion.newNumber(Consttype.PSTRING),this.zoomQueue.statusText);
		cnst.addItem(Clarion.newNumber(Consttype.SHORT),this.zoomQueue.percentile);
		cnst.set(Abreport.zoomPresets.getString());
		while (cnst.next().equals(Level.BENIGN)) {
			this.zoomQueue.add();
			CRun._assert(!(CError.errorCode()!=0));
			this.popup.addItem(Clarion.newString(ClarionString.staticConcat("-",this.zoomQueue.menuText)),Clarion.newString(ClarionString.staticConcat("ZoomItem",this.zoomQueue.records())));
		}
		cnst.kill();
	}
	public ClarionNumber inPageList(ClarionNumber pageN)
	{
		ClarionNumber i=Clarion.newNumber(1).setEncoding(ClarionNumber.LONG);
		ClarionNumber j=Clarion.newNumber(0).setEncoding(ClarionNumber.LONG);
		ClarionString itm=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
		ClarionNumber lo=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber hi=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber s=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		if (this.pagesToPrint.boolValue()) {
			while (true) {
				if (i.equals(this.pagesToPrint.len())) {
					itm.setValue(this.pagesToPrint.stringAt(j.add(1),i));
				}
				else if (this.pagesToPrint.stringAt(i).equals(",")) {
					itm.setValue(this.pagesToPrint.stringAt(j.add(1),i.subtract(1)));
					j.setValue(i);
				}
				s.setValue(itm.inString("-",1,1));
				if (s.boolValue()) {
					lo.setValue(itm.sub(1,s.subtract(1).intValue()));
					hi.setValue(itm.sub(s.add(1).intValue(),Clarion.newNumber(itm.len()).subtract(s).intValue()));
					if (lo.compareTo(0)>0 && hi.compareTo(0)>0 && lo.compareTo(hi)<=0 && CRun.inRange(pageN,lo,hi)) {
						return Clarion.newNumber(Constants.TRUE);
					}
				}
				else if (itm.isNumeric() && pageN.equals(itm)) {
					return Clarion.newNumber(Constants.TRUE);
				}
				i.increment(1);
				if (!(i.compareTo(this.pagesToPrint.len())<=0)) break;
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
		//this.zoomQueue;
		return super.kill();
	}
	public void newZoom()
	{
		this.resetUserZoom();
		this.drawPage();
		this.configMenuChecks();
	}
	public void open()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		if (!(this.windowPosSet.boolValue() && this.windowSizeSet.boolValue())) {
			if (this.saveSize.set.boolValue()) {
				CWin.setPosition(0,this.saveSize.xPos.intValue(),this.saveSize.yPos.intValue(),this.saveSize.width.intValue(),this.saveSize.height.intValue());
			}
			else if (!(this.iNIMgr==null)) {
				this.iNIMgr.fetch(Clarion.newString("_PreviewWindow_"),this.previewWindow);
			}
		}
		else if (this.windowPosSet.boolValue() && this.windowSizeSet.boolValue()) {
			CWin.setPosition(0,this.winXPos.intValue(),this.winYPos.intValue(),this.winWidth.intValue(),this.winHeight.intValue());
		}
		else if (this.windowPosSet.boolValue()) {
			CWin.setPosition(0,this.winXPos.intValue(),this.winYPos.intValue(),null,null);
		}
		else if (this.windowSizeSet.boolValue()) {
			CWin.setPosition(0,null,null,this.winWidth.intValue(),this.winHeight.intValue());
		}
		this.imageQueue.get(1);
		CRun._assert(!(CError.errorCode()!=0));
		this.pageManager=new Pagemanagerclass();
		this.pageManager.init(this,Clarion.newNumber(1),Clarion.newNumber(Constants.BASEFEQ),this.imageQueue.fileName);
		if (this.imageQueue.records()>1) {
			CWin.enable(this.prtPrevViewMenu.intValue());
			Clarion.getControl(this.prtPrevCurrentPage).setProperty(Prop.RANGEHIGH,this.imageQueue.records());
			Clarion.getControl(this.prtPrevCurrentPage).setProperty(Prop.MSG,ClarionString.staticConcat(Constants.ENTERSTR," ",this.imageQueue.records()));
		}
		else {
			CWin.disable(this.prtPrevCurrentPage.intValue(),this.prtPrevPagesDown.intValue());
		}
		for (i.setValue(1);i.compareTo(this.zoomQueue.records())<=0;i.increment(1)) {
			this.zoomQueue.get(i);
			CRun._assert(!(CError.errorCode()!=0));
			CWin.createControl(Clarion.newNumber(Constants.ZOOMITEM).add(i).intValue(),Create.ITEM,this.prtPrevZoomMenu.intValue(),i.intValue());
			Clarion.getControl(Clarion.newNumber(Constants.ZOOMITEM).add(i)).setProperty(Prop.USE,this.mUse.get(i.intValue()));
			Clarion.getControl(Clarion.newNumber(Constants.ZOOMITEM).add(i)).setProperty(Prop.TEXT,this.zoomQueue.menuText.sub(1,this.zoomQueue.menuText.len()));
			Clarion.getControl(Clarion.newNumber(Constants.ZOOMITEM).add(i)).setProperty(Prop.CHECK,Constants.TRUE);
			this.mUse.get(i.intValue()).setValue(i.equals(Constants.DEFAULTZOOM) ? 1 : 0);
			this.popup.addItemEvent(Clarion.newString(ClarionString.staticConcat("ZoomItem",i)),Clarion.newNumber(Event.ACCEPTED),Clarion.newNumber(Constants.ZOOMITEM).add(i).getNumber());
			Clarion.getControl(this.prtPrevZoomList).setProperty(Prop.FROM,Clarion.getControl(this.prtPrevZoomList).getProperty(Prop.FROM).getString().clip().concat(this.zoomQueue.menuText.clip(),i.compareTo(this.zoomQueue.records())<0 ? Clarion.newString("|") : Clarion.newString("")));
		}
		if (this.allowUserZoom.boolValue()) {
			this.resetUserZoom();
			CWin.unhide(this.prtPrevZoomList.intValue());
			CWin.unhide(this.prtPrevZoomPrompt.intValue());
		}
		this.zoomIndex.setValue(Abreport.percentile2Idx(this,this.initZoom.like()));
		if (this.zoomIndex.compareTo(this.zoomQueue.records())>0) {
			CRun._assert(this.allowUserZoom.boolValue());
			this.zoomIndex.setValue(0);
			this.userPercentile.setValue(this.initZoom);
		}
		if (!(this.translator==null)) {
			this.popup.setTranslator(this.translator);
		}
		this.newZoom();
		CWin.setCursor(null);
	}
	public void resetUserZoom()
	{
		if (this.allowUserZoom.boolValue()) {
			if (this.zoomIndex.boolValue()) {
				this.zoomQueue.get(this.zoomIndex);
				CRun._assert(!(CError.errorCode()!=0));
				this.zoomList.setValue(this.zoomQueue.menuText);
			}
			else {
				this.zoomList.setValue(this.zoomList.clip().concat(Constants.PCZOOM));
			}
			CWin.display(this.prtPrevZoomList.intValue());
		}
	}
	public void setDefaultPages()
	{
		this.pagesToPrint.setValue(ClarionString.staticConcat("1-",this.imageQueue.records()));
	}
	public void setINIManager(Iniclass ini)
	{
		CRun._assert(!(ini==null));
		this.iNIMgr=ini;
	}
	public void setPosition(ClarionNumber p0,ClarionNumber p1,ClarionNumber p2)
	{
		setPosition(p0,p1,p2,(ClarionNumber)null);
	}
	public void setPosition(ClarionNumber p0,ClarionNumber p1)
	{
		setPosition(p0,p1,(ClarionNumber)null);
	}
	public void setPosition(ClarionNumber p0)
	{
		setPosition(p0,(ClarionNumber)null);
	}
	public void setPosition()
	{
		setPosition((ClarionNumber)null);
	}
	public void setPosition(ClarionNumber x,ClarionNumber y,ClarionNumber wid,ClarionNumber hgt)
	{
		if (!(x==null) && !(y==null)) {
			this.windowPosSet.setValue(Constants.TRUE);
			this.winXPos.setValue(x);
			this.winYPos.setValue(y);
		}
		if (!(wid==null) && !(hgt==null)) {
			this.windowSizeSet.setValue(Constants.TRUE);
			this.winWidth.setValue(wid);
			this.winHeight.setValue(hgt);
		}
	}
	public void setZoomPercentile(ClarionNumber percentile)
	{
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		this.zoomIndex.setValue(0);
		for (c.setValue(1);c.compareTo(this.zoomQueue.records())<=0;c.increment(1)) {
			this.zoomQueue.get(c);
			CRun._assert(!(CError.errorCode()!=0));
			if (this.zoomQueue.percentile.equals(percentile)) {
				this.zoomIndex.setValue(c);
				this.userPercentile.setValue(0);
			}
			if (!!this.zoomIndex.boolValue()) break;
		}
		if (!this.zoomIndex.boolValue()) {
			CRun._assert(this.allowUserZoom.boolValue());
			this.userPercentile.setValue(percentile);
		}
	}
	public void syncImageQueue()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		for (i.setValue(this.imageQueue.records());i.compareTo(1)>=0;i.increment(-1)) {
			if (!this.inPageList(i.like()).boolValue()) {
				this.deleteImageQueue(i.like());
			}
		}
	}
	public ClarionNumber takeAccepted()
	{
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		if (super.takeAccepted().boolValue()) {
			return Clarion.newNumber(Level.NOTIFY);
		}
		{
			int case_1=CWin.field();
			boolean case_1_break=false;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1>=Constants.ZOOMITEM+1 && case_1<=Constants.ZOOMITEM+this.zoomQueue.records()) {
				i.setValue(this.zoomIndex);
				this.zoomIndex.setValue(CWin.accepted()-(Constants.ZOOMITEM+1)+1);
				if (!this.zoomIndex.equals(i)) {
					this.newZoom();
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.prtPrevTBarZoom)) {
				this.configMenuChecks();
				this.popup.ask();
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.prtPrevMenuPages)) {
				this.askPrintPages();
				this.drawPage();
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.prtPrevMenuPrint)) {
				case_1_match=true;
			}
			if (case_1_match || Clarion.newNumber(case_1).equals(this.prtPrevTBarPrint)) {
				this.printOK.setValue(this.confirmPages.equals(Constants.TRUE) ? this.askPrintPages() : Clarion.newNumber(Constants.TRUE));
				CWin.post(Event.CLOSEWINDOW);
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.prtPrevMenuExit)) {
				case_1_match=true;
			}
			if (case_1_match || Clarion.newNumber(case_1).equals(this.prtPrevTBarExit)) {
				CWin.post(Event.CLOSEWINDOW);
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.prtPrevZoomList)) {
				i.setValue(Constants.FALSE);
				for (c.setValue(1);c.compareTo(this.zoomQueue.records())<=0;c.increment(1)) {
					this.zoomQueue.get(c);
					CRun._assert(!(CError.errorCode()!=0));
					if (this.zoomQueue.menuText.equals(this.zoomList)) {
						i.setValue(Constants.TRUE);
					}
					if (!!i.boolValue()) break;
				}
				if (i.boolValue()) {
					CWin.post(Event.ACCEPTED,Constants.ZOOMITEM+CWin.choice(this.prtPrevZoomList.intValue()));
					return Clarion.newNumber(Level.NOTIFY);
				}
				else {
					this.zoomList.setValue(this.zoomList.getDecimal().abs());
					this.zoomIndex.setValue(0);
					this.userPercentile.setValue(this.zoomList);
					this.newZoom();
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.prtPrevCurrentPage)) {
				if (!CRun.inRange(this.currentPage.subtract(this.firstPage).add(1),Clarion.newNumber(1),this.pagesAcross.multiply(this.pagesDown))) {
					this.firstPage.setValue(this.currentPage);
					while (this.firstPage.add(this.pagesAcross.multiply(this.pagesDown)).subtract(1).compareTo(this.imageQueue.records())>0) {
						this.firstPage.decrement(1);
						if (!(this.firstPage.compareTo(1)>0)) break;
					}
					this.drawPage();
				}
				else {
					if (!this.pageManager.exists(this.currentPage.like()).boolValue()) {
						this.drawPage();
					}
					else {
						this.pageManager.highLight(this.currentPage.like());
					}
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.prtPrevPagesAcross)) {
				case_1_match=true;
			}
			if (case_1_match || Clarion.newNumber(case_1).equals(this.prtPrevPagesDown)) {
				i.setValue(Constants.TRUE);
				while (this.firstPage.add(this.pagesAcross.multiply(this.pagesDown)).subtract(1).compareTo(this.imageQueue.records())>0) {
					this.pagesAcross.decrement(Clarion.newNumber(CWin.accepted()).equals(this.prtPrevPagesAcross) ? 1 : 0);
					this.pagesDown.decrement(Clarion.newNumber(CWin.accepted()).equals(this.prtPrevPagesDown) ? 1 : 0);
					i.setValue(Constants.FALSE);
					if (!(this.pagesAcross.compareTo(1)>0 && this.pagesDown.compareTo(1)>0)) break;
				}
				if (i.boolValue()) {
					this.drawPage();
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.prtPrevNext)) {
				case_1_match=true;
			}
			if (case_1_match || Clarion.newNumber(case_1).equals(this.prtPrevPrevious)) {
				this.currentPage.increment(Clarion.newNumber(CWin.accepted()).equals(this.prtPrevNext) ? Clarion.newNumber(1) : Clarion.newNumber(-1));
				CWin.post(Event.ACCEPTED,this.prtPrevCurrentPage.intValue());
				return Clarion.newNumber(Level.NOTIFY);
				// UNREACHABLE! :case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.prtPrevJump)) {
				if (this.askPage().boolValue()) {
					CWin.post(Event.ACCEPTED,this.prtPrevCurrentPage.intValue());
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.prtPrevChangeDisplay)) {
				this.askThumbnails();
				this.currentPage.setValue(1);
				this.drawPage();
				case_1_break=true;
			}
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionNumber takeEvent()
	{
		ClarionNumber c=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber cx=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber cy=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber mx=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		ClarionNumber my=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		if (super.takeEvent().boolValue()) {
			return Clarion.newNumber(Level.NOTIFY);
		}
		{
			int case_1=CWin.event();
			boolean case_1_break=false;
			if (case_1==Event.CLOSEWINDOW) {
				if (!(this.iNIMgr==null)) {
					this.iNIMgr.update(Clarion.newString("_PreviewWindow_"),this.previewWindow);
				}
				this.pageManager.kill();
				//this.pageManager;
				case_1_break=true;
			}
			if (!case_1_break && case_1==Event.SIZED) {
				this.saveSize.set.setValue(Constants.TRUE);
				CWin.getPosition(0,this.saveSize.xPos,this.saveSize.yPos,this.saveSize.width,this.saveSize.height);
				this.drawPage();
				case_1_break=true;
			}
			if (!case_1_break && case_1==Event.ALERTKEY) {
				{
					int case_2=CWin.keyCode();
					boolean case_2_break=false;
					if (case_2==Constants.PGUPKEY) {
						if (this.currentPage.compareTo(1)>0 && !Clarion.getControl(this.prtPrevPrevious).getProperty(Prop.DISABLE).boolValue()) {
							CWin.post(Event.ACCEPTED,this.prtPrevPrevious.intValue());
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==Constants.PGDNKEY) {
						if (this.currentPage.compareTo(this.imageQueue.records())<0 && !Clarion.getControl(this.prtPrevNext).getProperty(Prop.DISABLE).boolValue()) {
							CWin.post(Event.ACCEPTED,this.prtPrevNext.intValue());
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==Constants.MOUSELEFT) {
						takeEvent_GetCoord(mx,my,c);
						if (c.boolValue()) {
							this.currentPage.setValue(c);
							if (Abreport.idx2Percentile(this,this.zoomIndex.like()).equals(Constants.NOZOOM)) {
								if (Abreport.percentile2Idx(this,Clarion.newNumber(Constants.PAGEWIDTH)).compareTo(this.zoomQueue.records())<=0) {
									this.zoomIndex.setValue(Abreport.percentile2Idx(this,Clarion.newNumber(Constants.PAGEWIDTH)));
									this.pageManager.setCentre(c.like(),Clarion.newNumber(0),my.subtract(this.pageManager.getProp(c.like(),Clarion.newNumber(Prop.YPOS))).divide(this.pageManager.getProp(c.like(),Clarion.newNumber(Prop.HEIGHT))).multiply(100).getNumber());
									this.newZoom();
								}
							}
							else {
								if (Abreport.percentile2Idx(this,Clarion.newNumber(Constants.NOZOOM)).compareTo(this.zoomQueue.records())<=0) {
									this.zoomIndex.setValue(Abreport.percentile2Idx(this,Clarion.newNumber(Constants.NOZOOM)));
									this.newZoom();
								}
							}
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==Constants.MOUSERIGHTUP) {
						takeEvent_GetCoord(mx,my,c);
						if (c.boolValue()) {
							if (Abreport.idx2Percentile(this,this.zoomIndex.like()).equals(Constants.NOZOOM)) {
								cx.setValue(mx.subtract(this.pageManager.getProp(c.like(),Clarion.newNumber(Prop.XPOS))).divide(this.pageManager.getProp(c.like(),Clarion.newNumber(Prop.WIDTH))).multiply(100));
								cy.setValue(my.subtract(this.pageManager.getProp(c.like(),Clarion.newNumber(Prop.YPOS))).divide(this.pageManager.getProp(c.like(),Clarion.newNumber(Prop.HEIGHT))).multiply(100));
							}
							else {
								if (this.pageManager.getProp(c.like(),Clarion.newNumber(Prop.VSCROLL)).boolValue()) {
									i.setValue(this.pageManager.getProp(c.like(),Clarion.newNumber(Prop.VSCROLLPOS)).multiply(this.pageManager.getProp(c.like(),Clarion.newNumber(Prop.MAXHEIGHT)).subtract(this.pageManager.getProp(c.like(),Clarion.newNumber(Prop.HEIGHT))).divide(255)));
									cy.setValue(Clarion.newNumber(100).multiply(i.add(my).divide(this.pageManager.getProp(c.like(),Clarion.newNumber(Prop.MAXHEIGHT)))));
								}
								else {
									cy.setValue(my.divide(this.pageManager.getProp(c.like(),Clarion.newNumber(Prop.HEIGHT))).multiply(100));
								}
								if (this.pageManager.getProp(c.like(),Clarion.newNumber(Prop.HSCROLL)).boolValue()) {
									i.setValue(this.pageManager.getProp(c.like(),Clarion.newNumber(Prop.HSCROLLPOS)).multiply(this.pageManager.getProp(c.like(),Clarion.newNumber(Prop.MAXWIDTH)).subtract(this.pageManager.getProp(c.like(),Clarion.newNumber(Prop.WIDTH))).divide(255)));
									cx.setValue(Clarion.newNumber(100).multiply(i.add(mx).divide(this.pageManager.getProp(c.like(),Clarion.newNumber(Prop.MAXWIDTH)))));
								}
								else {
									cx.setValue(mx.divide(this.pageManager.getProp(c.like(),Clarion.newNumber(Prop.WIDTH))).multiply(100));
								}
							}
							this.pageManager.setCentre(c.like(),cx.like(),cy.like());
							if (this.popup.ask().boolValue()) {
								this.currentPage.setValue(c);
							}
							else {
								this.pageManager.setCentre(c.like(),Clarion.newNumber(0),Clarion.newNumber(0));
							}
						}
						case_2_break=true;
					}
				}
				case_1_break=true;
			}
		}
		takeEvent_DisplayWindow();
		return Clarion.newNumber(Level.BENIGN);
	}
	public void takeEvent_DisplayWindow()
	{
		this.configMenuChecks();
		Clarion.getControl(this.prtPrevPrevious).setProperty(Prop.DISABLE,this.currentPage.equals(1) ? 1 : 0);
		Clarion.getControl(this.prtPrevNext).setProperty(Prop.DISABLE,this.currentPage.equals(this.imageQueue.records()) ? 1 : 0);
		Clarion.getControl(this.prtPrevJump).setProperty(Prop.DISABLE,this.imageQueue.records()==1 ? 1 : 0);
		Clarion.getControl(this.prtPrevChangeDisplay).setProperty(Prop.DISABLE,Clarion.getControl(this.prtPrevJump).getProperty(Prop.DISABLE));
		if (this.imageQueue.records()==1) {
			CWin.disable(this.prtPrevPagePrompt.intValue(),this.prtPrevPagesDown.intValue());
		}
		else {
			if (Abreport.idx2Percentile(this,this.zoomIndex.like()).equals(Constants.NOZOOM)) {
				CWin.enable(this.prtPrevPagesAcross.intValue(),this.prtPrevPagesDown.intValue());
			}
			else {
				CWin.disable(this.prtPrevPagesAcross.intValue(),this.prtPrevPagesDown.intValue());
			}
		}
		CWin.display(this.prtPrevCurrentPage.intValue(),this.prtPrevPagesDown.intValue());
		if (Abreport.idx2Percentile(this,this.zoomIndex.like()).equals(Constants.NOZOOM)) {
			Clarion.getControl(this.prtPrevChangeDisplay).setProperty(Prop.DISABLE,this.imageQueue.records()<=1 ? 1 : 0);
		}
		else {
			CWin.disable(this.prtPrevChangeDisplay.intValue());
		}
		this.previewWindow.setProperty(Prop.STATUSTEXT,3,this.zoomIndex.equals(0) ? Clarion.newString(ClarionString.staticConcat(Constants.SBZOOM," ",this.userPercentile,"%")) : this.zoomQueue.statusText);
		if (Abreport.idx2Percentile(this,this.zoomIndex.like()).equals(Constants.NOZOOM)) {
			this.previewWindow.setProperty(Prop.STATUSTEXT,2,ClarionString.staticConcat(Constants.PAGESTR," ",this.thumbnailsPresent.compareTo(1)>0 ? Clarion.newString(this.firstPage.concat("-",this.firstPage.add(this.thumbnailsPresent).subtract(1)," ",Constants.OFSTR)) : Clarion.newString(this.currentPage.concat(" ",Constants.OFSTR))," ",this.imageQueue.records()));
		}
		else {
			this.previewWindow.setProperty(Prop.STATUSTEXT,2,ClarionString.staticConcat(Constants.PAGESTR," ",this.currentPage," ",Constants.OFSTR," ",this.imageQueue.records()));
		}
		CWin.display(this.prtPrevNext.intValue(),this.prtPrevChangeDisplay.intValue());
	}
	public void takeEvent_GetCoord(ClarionNumber mx,ClarionNumber my,ClarionNumber c)
	{
		mx.setValue(CWin.getMouseX());
		my.setValue(CWin.getMouseY());
		c.setValue(this.pageManager.coordContained(mx.like(),my.like()));
	}
	public ClarionNumber takeWindowEvent()
	{
		return (CWin.event()==Event.GAINFOCUS ? Clarion.newNumber(Level.BENIGN) : super.takeWindowEvent()).getNumber();
	}
	public ClarionNumber takeFieldEvent()
	{
		{
			int case_1=CWin.event();
			if (case_1==Event.NEWSELECTION) {
				if (CRun.inlist(String.valueOf(CWin.field()),new ClarionString[] {this.prtPrevCurrentPage.getString(),this.prtPrevPagesAcross.getString(),this.prtPrevPagesDown.getString()}).boolValue()) {
					CWin.post(Event.ACCEPTED,CWin.field());
					return Clarion.newNumber(Level.NOTIFY);
				}
			}
		}
		return Clarion.newNumber(Level.BENIGN);
	}
}
