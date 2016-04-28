package clarion.abreport;

import clarion.Processorqueue;
import clarion.Recordprocessor;
import clarion.abreport.Previewqueue;
import clarion.abreport.Printpreviewclass_2;
import clarion.abreport.Processclass_2;
import clarion.abwindow.Windowmanager;
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

@SuppressWarnings("all")
public class Reportmanager_2 extends Windowmanager
{
	public ClarionNumber deferopenreport=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber deferwindow=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber keepvisible=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber openfailed=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Processorqueue processors=null;
	public Printpreviewclass_2 preview=null;
	public Previewqueue previewqueue=null;
	public Processclass_2 process=null;
	public ClarionNumber recordspercycle=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber querycontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionReport report=null;
	public ClarionNumber skippreview=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber starttime=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber timeslice=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionNumber waitcursor=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber zoom=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public Reportmanager_2()
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

	public void additem(Recordprocessor rp)
	{
		CRun._assert(!(this.processors==null),"Object not initialized");
		this.processors.p.set(rp);
		this.processors.add();
	}
	public void ask()
	{
		if (this.deferwindow.boolValue()) {
			if (this.waitcursor.boolValue()) {
				CWin.setCursor(Cursor.WAIT);
			}
			this.starttime.setValue(CDate.clock());
			CWin.hide(0);
		}
		super.ask();
	}
	public void askpreview()
	{
		ClarionNumber doflush=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		if (!(this.report==null)) {
			if (!(this.preview==null) && this.response.equals(Constants.REQUESTCOMPLETED)) {
				this.report.endPage();
				doflush.setValue(!this.skippreview.boolValue() ? this.preview.display(this.zoom.like()) : Clarion.newNumber(Constants.TRUE));
				this.report.setClonedProperty(Prop.FLUSHPREVIEW,doflush);
				this.preview.imagequeue.free();
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
				if (this.process.recordsprocessed.boolValue()) {
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
	public void init(Processclass_2 p0,ClarionReport p1)
	{
		init(p0,p1,(Printpreviewclass_2)null);
	}
	public void init(Processclass_2 p0)
	{
		init(p0,(ClarionReport)null);
	}
	public void init(Processclass_2 pc,ClarionReport r,Printpreviewclass_2 pv)
	{
		this.process=pc;
		this.report=r;
		this.preview=pv;
		if (!(this.preview==null)) {
			this.previewqueue=new Previewqueue();
			pv.init(this.previewqueue);
		}
		this.recordspercycle.setValue(1);
		this.timeslice.setValue(100);
		this.processors=new Processorqueue();
	}
	public ClarionNumber kill()
	{
		if (this.dead.boolValue() || this.process==null) {
			return Clarion.newNumber(Level.NOTIFY);
		}
		//this.previewqueue;
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
		if (!this.deferopenreport.boolValue()) {
			this.openreport();
		}
	}
	public ClarionNumber openreport()
	{
		ClarionNumber rval=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.process.reset();
		rval.setValue(this.next());
		this.deferopenreport.setValue(0);
		if (rval.boolValue()) {
			this.takenorecords();
		}
		else {
			this.openfailed.setValue(0);
			if (!(this.report==null)) {
				this.report.open();
				if (!(this.preview==null)) {
					this.report.setClonedProperty(Prop.PREVIEW,this.previewqueue.filename);
				}
			}
		}
		return rval.like();
	}
	public ClarionNumber takeaccepted()
	{
		{
			int case_1=CWin.accepted();
			if (Clarion.newNumber(case_1).equals(this.querycontrol)) {
				this.process.takelocate();
			}
		}
		return super.takeaccepted();
	}
	public ClarionNumber takecloseevent()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber rval=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		if (CWin.event()==Event.CLOSEWINDOW) {
			if (this.waitcursor.boolValue()) {
				CWin.setCursor(null);
			}
			if (!this.keepvisible.boolValue()) {
				CWin.getTarget().setProperty(Prop.HIDE,1);
			}
			final int loop_1=this.processors.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
				this.processors.get(i);
				rval.setValue(this.processors.p.get().takeclose());
			}
			if (!rval.boolValue()) {
				this.askpreview();
			}
			if (!(this.report==null)) {
				this.report.close();
			}
		}
		return rval.like();
	}
	public void takenorecords()
	{
		this.errors._throw(Clarion.newNumber(Msg.NORECORDS));
		this.openfailed.setValue(1);
	}
	public ClarionNumber takerecord()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber rval=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		rval.setValue(this.process.takerecord());
		try {
			takerecord_checkstate(rval);
		} catch (ClarionRoutineResult _crr) {
			return (ClarionNumber)_crr.getResult();
		}
		final int loop_1=this.processors.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.processors.get(i);
			rval.setValue(this.processors.p.get().takerecord());
			try {
				takerecord_checkstate(rval);
			} catch (ClarionRoutineResult _crr) {
				return (ClarionNumber)_crr.getResult();
			}
		}
		if (this.next().boolValue()) {
			CWin.getTarget().setProperty(Prop.TIMER,0);
			return Clarion.newNumber(Level.NOTIFY);
		}
		return rval.like();
	}
	public void takerecord_checkstate(ClarionNumber rval) throws ClarionRoutineResult
	{
		{
			ClarionNumber case_1=rval;
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
	public ClarionNumber takewindowevent()
	{
		ClarionNumber startofcycle=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber starttime=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber timetaken=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber rval=Clarion.newNumber(Level.BENIGN).setEncoding(ClarionNumber.BYTE);
		if (CWin.event()==Event.TIMER) {
			if (this.deferopenreport.boolValue()) {
				this.openreport();
			}
			if (this.openfailed.boolValue()) {
				return Clarion.newNumber(Level.FATAL);
			}
			startofcycle.setValue(this.process.recordsprocessed);
			starttime.setValue(CDate.clock());
			if (this.deferwindow.boolValue() && starttime.subtract(this.starttime).compareTo(this.deferwindow.multiply(100))>0) {
				CWin.getTarget().setProperty(Prop.HIDE,0);
				this.deferwindow.setValue(0);
			}
			while (true) {
				while (this.process.recordsprocessed.subtract(startofcycle).compareTo(this.recordspercycle)<0) {
					rval.setValue(this.takerecord());
					if (rval.boolValue()) {
						return rval.like();
					}
				}
				timetaken.setValue(Clarion.newNumber(CDate.clock()).subtract(starttime));
				if (Clarion.newNumber(5).multiply(timetaken).compareTo(this.timeslice.multiply(4))<0) {
					this.recordspercycle.increment(this.recordspercycle);
				}
				if (!(Clarion.newNumber(2).multiply(timetaken).compareTo(this.timeslice)<0)) break;
			}
			if (Clarion.newNumber(2).multiply(timetaken).compareTo(this.timeslice.multiply(3))>0 && this.recordspercycle.compareTo(1)>0) {
				this.recordspercycle.setValue(this.recordspercycle.multiply("0.5"));
			}
		}
		return super.takewindowevent();
	}
}
