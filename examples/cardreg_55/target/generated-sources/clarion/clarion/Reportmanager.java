package clarion;

import clarion.Previewqueue;
import clarion.Printpreviewclass;
import clarion.Processclass;
import clarion.Processorqueue;
import clarion.Recordprocessor;
import clarion.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Cursor;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Msg;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.ClarionRoutineResult;
import org.jclarion.clarion.runtime.CDate;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

public class Reportmanager extends Windowmanager
{
	public ClarionNumber deferOpenReport;
	public ClarionNumber deferWindow;
	public ClarionNumber keepVisible;
	public ClarionNumber openFailed;
	public Processorqueue processors;
	public Printpreviewclass preview;
	public Previewqueue previewQueue;
	public Processclass process;
	public ClarionNumber recordsPerCycle;
	public ClarionNumber queryControl;
	public ClarionReport report;
	public ClarionNumber skipPreview;
	public ClarionNumber startTime;
	public ClarionNumber timeSlice;
	public ClarionNumber waitCursor;
	public ClarionNumber zoom;
	public Reportmanager()
	{
		deferOpenReport=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		deferWindow=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		keepVisible=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		openFailed=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		processors=null;
		preview=null;
		previewQueue=null;
		process=null;
		recordsPerCycle=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		queryControl=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		report=null;
		skipPreview=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		startTime=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		timeSlice=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		waitCursor=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		zoom=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	}

	public void addItem(Recordprocessor rp)
	{
		CRun._assert(!(this.processors==null),"Object not initialized");
		this.processors.p.set(rp);
		this.processors.add();
	}
	public void ask()
	{
		if (this.deferWindow.boolValue()) {
			if (this.waitCursor.boolValue()) {
				CWin.setCursor(Cursor.WAIT);
			}
			this.startTime.setValue(CDate.clock());
			CWin.hide(0);
		}
		super.ask();
	}
	public void askPreview()
	{
		ClarionNumber doFlush=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		if (!(this.report==null)) {
			if (!(this.preview==null) && this.response.equals(Constants.REQUESTCOMPLETED)) {
				this.report.endPage();
				doFlush.setValue(!this.skipPreview.boolValue() ? this.preview.display(this.zoom.like()) : Clarion.newNumber(Constants.TRUE));
				this.report.setClonedProperty(Prop.FLUSHPREVIEW,doFlush);
				this.preview.imageQueue.free();
			}
		}
	}
	public ClarionNumber next()
	{
		{
			ClarionNumber case_1=this.process.next();
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1.equals(Level.NOTIFY)) {
				if (this.process.recordsProcessed.boolValue()) {
					this.response.setValue(Constants.REQUESTCOMPLETED);
					CWin.post(Event.CLOSEWINDOW);
					return Clarion.newNumber(Level.NOTIFY);
				}
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Level.FATAL)) {
				this.response.setValue(Constants.REQUESTCANCELLED);
				CWin.post(Event.CLOSEWINDOW);
				return Clarion.newNumber(Level.FATAL);
			}
		}
		return Clarion.newNumber(Level.BENIGN);
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
		this.process=pc;
		this.report=r;
		this.preview=pv;
		if (!(this.preview==null)) {
			this.previewQueue=new Previewqueue();
			pv.init(this.previewQueue);
		}
		this.recordsPerCycle.setValue(1);
		this.timeSlice.setValue(100);
		this.processors=new Processorqueue();
	}
	public ClarionNumber kill()
	{
		if (this.dead.boolValue() || this.process==null) {
			return Clarion.newNumber(Level.NOTIFY);
		}
		//this.previewQueue;
		if (!(this.preview==null)) {
			this.preview.kill();
		}
		this.process.kill();
		//this.processors;
		return super.kill();
	}
	public void open()
	{
		super.open();
		if (!this.deferOpenReport.boolValue()) {
			this.openReport();
		}
	}
	public ClarionNumber openReport()
	{
		ClarionNumber rVal=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.process.reset();
		rVal.setValue(this.next());
		this.deferOpenReport.setValue(0);
		if (rVal.boolValue()) {
			this.takeNoRecords();
		}
		else {
			this.openFailed.setValue(0);
			if (!(this.report==null)) {
				this.report.open();
				if (!(this.preview==null)) {
					this.report.setClonedProperty(Prop.PREVIEW,this.previewQueue.fileName);
				}
			}
		}
		return rVal.like();
	}
	public ClarionNumber takeAccepted()
	{
		{
			int case_1=CWin.accepted();
			if (Clarion.newNumber(case_1).equals(this.queryControl)) {
				this.process.takeLocate();
			}
		}
		return super.takeAccepted();
	}
	public ClarionNumber takeCloseEvent()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber rVal=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		if (CWin.event()==Event.CLOSEWINDOW) {
			if (this.waitCursor.boolValue()) {
				CWin.setCursor(null);
			}
			if (!this.keepVisible.boolValue()) {
				CWin.getTarget().setProperty(Prop.HIDE,1);
			}
			for (i.setValue(1);i.compareTo(this.processors.records())<=0;i.increment(1)) {
				this.processors.get(i);
				rVal.setValue(this.processors.p.get().takeClose());
			}
			if (!rVal.boolValue()) {
				this.askPreview();
			}
			if (!(this.report==null)) {
				this.report.close();
			}
		}
		return rVal.like();
	}
	public void takeNoRecords()
	{
		this.errors._throw(Clarion.newNumber(Msg.NORECORDS));
		this.openFailed.setValue(1);
	}
	public ClarionNumber takeRecord()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber rVal=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		rVal.setValue(this.process.takeRecord());
		try {
			takeRecord_CheckState(rVal);
		} catch (ClarionRoutineResult _crr) {
			return (ClarionNumber)_crr.getResult();
		}
		for (i.setValue(1);i.compareTo(this.processors.records())<=0;i.increment(1)) {
			this.processors.get(i);
			rVal.setValue(this.processors.p.get().takeRecord());
			try {
				takeRecord_CheckState(rVal);
			} catch (ClarionRoutineResult _crr) {
				return (ClarionNumber)_crr.getResult();
			}
		}
		if (this.next().boolValue()) {
			CWin.getTarget().setProperty(Prop.TIMER,0);
			return Clarion.newNumber(Level.NOTIFY);
		}
		return rVal.like();
	}
	public void takeRecord_CheckState(ClarionNumber rVal) throws ClarionRoutineResult
	{
		{
			ClarionNumber case_1=rVal;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1.equals(Level.FATAL)) {
				CWin.getTarget().setProperty(Prop.TIMER,0);
				CWin.post(Event.CLOSEWINDOW);
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Level.NOTIFY)) {
				throw new ClarionRoutineResult(Clarion.newNumber(Level.NOTIFY));
			}
		}
	}
	public ClarionNumber takeWindowEvent()
	{
		ClarionNumber startOfCycle=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber startTime=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber timeTaken=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber rVal=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		if (CWin.event()==Event.TIMER) {
			if (this.deferOpenReport.boolValue()) {
				this.openReport();
			}
			if (this.openFailed.boolValue()) {
				return Clarion.newNumber(Level.FATAL);
			}
			startOfCycle.setValue(this.process.recordsProcessed);
			startTime.setValue(CDate.clock());
			if (this.deferWindow.boolValue() && startTime.subtract(this.startTime).compareTo(this.deferWindow.multiply(100))>0) {
				CWin.getTarget().setProperty(Prop.HIDE,0);
				this.deferWindow.setValue(0);
			}
			while (true) {
				while (this.process.recordsProcessed.subtract(startOfCycle).compareTo(this.recordsPerCycle)<0) {
					rVal.setValue(this.takeRecord());
					if (rVal.boolValue()) {
						return rVal.like();
					}
				}
				timeTaken.setValue(Clarion.newNumber(CDate.clock()).subtract(startTime));
				if (Clarion.newNumber(5).multiply(timeTaken).compareTo(this.timeSlice.multiply(4))<0) {
					this.recordsPerCycle.increment(this.recordsPerCycle);
				}
				if (!(Clarion.newNumber(2).multiply(timeTaken).compareTo(this.timeSlice)<0)) break;
			}
			if (Clarion.newNumber(2).multiply(timeTaken).compareTo(this.timeSlice.multiply(3))>0 && this.recordsPerCycle.compareTo(1)>0) {
				this.recordsPerCycle.setValue(this.recordsPerCycle.multiply("0.5"));
			}
		}
		return super.takeWindowEvent();
	}
}
