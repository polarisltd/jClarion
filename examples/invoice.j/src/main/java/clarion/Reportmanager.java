package clarion;

import clarion.Breakmanagerclass;
import clarion.Ireportgenerator;
import clarion.Printpreviewclass;
import clarion.Printpreviewfilequeue;
import clarion.Processclass;
import clarion.Processorqueue;
import clarion.Recordprocessor;
import clarion.Reportattributemanager;
import clarion.Reporttargetselectorclass;
import clarion.Windowmanager;
import clarion.Wmfdocumentparser;
import clarion.equates.Constants;
import clarion.equates.Cursor;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Msg;
import clarion.equates.Prop;
import clarion.equates.Propprint;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionReport;
import org.jclarion.clarion.ClarionRoutineResult;
import org.jclarion.clarion.runtime.CDate;
import org.jclarion.clarion.runtime.CError;
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
	public Printpreviewfilequeue previewQueue;
	public Printpreviewfilequeue outputFileQueue;
	public Processclass process;
	public Reportattributemanager attribute;
	public Ireportgenerator reportTarget;
	public Reporttargetselectorclass targetSelector;
	public ClarionNumber targetSelectorCreated;
	public Breakmanagerclass breakMan;
	public ClarionNumber recordsPerCycle;
	public ClarionNumber queryControl;
	public ClarionReport report;
	public ClarionNumber skipPreview;
	public ClarionNumber startTime;
	public ClarionNumber timeSlice;
	public ClarionNumber waitCursor;
	public Wmfdocumentparser wMFParser;
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
		outputFileQueue=null;
		process=null;
		attribute=null;
		reportTarget=null;
		targetSelector=null;
		targetSelectorCreated=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		breakMan=null;
		recordsPerCycle=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		queryControl=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		report=null;
		skipPreview=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		startTime=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		timeSlice=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		waitCursor=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		wMFParser=null;
		zoom=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	}

	public void addItem(Recordprocessor rp)
	{
		CRun._assert(!(this.processors==null),"Object not initialized");
		this.processors.p.set(rp);
		this.processors.add();
	}
	public void addItem(Reporttargetselectorclass pTargetSelector)
	{
		if (this.targetSelectorCreated.equals(Constants.FALSE)) {
			this.targetSelector=pTargetSelector;
		}
	}
	public void addItem(Breakmanagerclass pBreakMan)
	{
		this.breakMan=pBreakMan;
	}
	public void setReportTarget(Ireportgenerator pReportTarget)
	{
		this.reportTarget=pReportTarget;
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
		if (!(this.report==null) && this.response.equals(Constants.REQUESTCOMPLETED) && !this.openFailed.boolValue()) {
			if (this.endReport().equals(Level.BENIGN)) {
				if (!(this.preview==null)) {
					if ((!this.skipPreview.boolValue() ? this.preview.display(this.zoom.like()) : Clarion.newNumber(Constants.TRUE)).boolValue()) {
						this.printReport();
					}
					else {
						this.cancelPrintReport();
					}
					this.preview.imageQueue.free();
				}
				else {
					this.printReport();
					this.previewQueue.free();
				}
			}
			else if (!(this.preview==null)) {
				this.preview.imageQueue.free();
			}
			else {
				this.previewQueue.free();
			}
		}
	}
	public ClarionNumber endReport()
	{
		if (!(this.breakMan==null)) {
			this.breakMan.askBreak(Clarion.newNumber(Constants.TRUE));
		}
		this.report.endPage();
		return Clarion.newNumber(Level.BENIGN);
	}
	public void printReport()
	{
		ClarionNumber rt=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber lIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		if (!(this.reportTarget==null)) {
			if (this.previewQueue.records()!=0) {
				if (this.reportTarget.supportResultQueue().equals(Constants.TRUE)) {
					this.reportTarget.setResultQueue(this.outputFileQueue);
				}
				if (this.reportTarget.askProperties(Clarion.newNumber(Constants.FALSE)).equals(Level.BENIGN)) {
					this.wMFParser.init(this.previewQueue,this.reportTarget,this.errors);
					if (this.wMFParser.generateReport().equals(Level.BENIGN)) {
						if (this.reportTarget.supportResultQueue().equals(Constants.TRUE)) {
							rt.setValue(this.processResultFiles(this.outputFileQueue));
						}
					}
				}
			}
		}
		else {
			this.outputFileQueue.free();
			for (lIndex.setValue(1);lIndex.compareTo(this.previewQueue.records())<=0;lIndex.increment(1)) {
				this.previewQueue.get(lIndex);
				if (!(CError.errorCode()!=0)) {
					this.outputFileQueue.filename.setValue(this.previewQueue.filename);
					this.outputFileQueue.add();
				}
			}
			if (this.processResultFiles(this.outputFileQueue).equals(Level.BENIGN)) {
				this.report.setProperty(Prop.FLUSHPREVIEW,Constants.TRUE);
			}
			else {
				this.report.setProperty(Prop.FLUSHPREVIEW,Constants.FALSE);
			}
		}
	}
	public void cancelPrintReport()
	{
		this.report.setProperty(Prop.FLUSHPREVIEW,Constants.FALSE);
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
		this.wMFParser=new Wmfdocumentparser();
		this.outputFileQueue=new Printpreviewfilequeue();
		if (this.targetSelector==null) {
			this.targetSelectorCreated.setValue(Constants.TRUE);
			this.targetSelector=new Reporttargetselectorclass();
		}
		else {
			this.targetSelectorCreated.setValue(Constants.FALSE);
		}
		this.previewQueue=new Printpreviewfilequeue();
		if (!(this.preview==null)) {
			pv.init(this.previewQueue,this.targetSelector,this.wMFParser);
			pv.errors=this.errors;
		}
		this.recordsPerCycle.setValue(1);
		this.timeSlice.setValue(100);
		this.processors=new Processorqueue();
		this.attribute=new Reportattributemanager();
		if (!(this.breakMan==null)) {
			this.breakMan.reset();
		}
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
		if (!(this.outputFileQueue==null)) {
			this.outputFileQueue.free();
			//this.outputFileQueue;
		}
		this.process.kill();
		//this.processors;
		//this.wMFParser;
		this.attribute.destruct();
		if (this.targetSelectorCreated.equals(Constants.TRUE)) {
			this.targetSelector.destruct();
		}
		return super.kill();
	}
	public void open()
	{
		super.open();
		if (!this.deferOpenReport.boolValue()) {
			this.openReport();
			if (!this.openFailed.boolValue()) {
				if (this.report.getProperty(Propprint.EXTEND).equals(1)) {
					this.setStaticControlsAttributes();
				}
			}
		}
	}
	public ClarionNumber openReport()
	{
		ClarionNumber rVal=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.process.reset();
		rVal.setValue(this.next());
		this.deferOpenReport.setValue(0);
		if (rVal.boolValue()) {
			this.openFailed.setValue(1);
			this.takeNoRecords();
		}
		else {
			this.openFailed.setValue(0);
			if (!(this.report==null)) {
				this.report.open();
				if (!(this.attribute==null)) {
					this.attribute.init(this.report);
				}
				if (!(this.preview==null)) {
					this.report.setClonedProperty(Prop.PREVIEW,this.previewQueue.filename);
				}
			}
		}
		return rVal.like();
	}
	public ClarionNumber processResultFiles(Printpreviewfilequeue outputFile)
	{
		return Clarion.newNumber(Level.BENIGN);
	}
	public void setStaticControlsAttributes()
	{
	}
	public void setDynamicControlsAttributes()
	{
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
		ClarionNumber rVal2=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		if (CWin.event()==Event.CLOSEWINDOW) {
			if (this.waitCursor.boolValue()) {
				CWin.setCursor(null);
			}
			if (!this.keepVisible.boolValue()) {
				CWin.getTarget().setProperty(Prop.HIDE,1);
			}
			for (i.setValue(1);i.compareTo(this.processors.records())<=0;i.increment(1)) {
				this.processors.get(i);
				rVal2.setValue(this.processors.p.get().takeClose());
				if (!rVal2.equals(Level.BENIGN)) {
					rVal.setValue(rVal2);
				}
			}
			if (rVal.equals(Level.BENIGN) && !this.openFailed.boolValue()) {
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
	}
	public ClarionNumber takeRecord()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber rVal=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		if (!(this.breakMan==null)) {
			this.breakMan.askBreak();
		}
		if (this.report.getProperty(Propprint.EXTEND).equals(1)) {
			this.setDynamicControlsAttributes();
		}
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
				if (!this.openFailed.boolValue()) {
					if (this.report.getProperty(Propprint.EXTEND).equals(1)) {
						this.setStaticControlsAttributes();
					}
				}
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
