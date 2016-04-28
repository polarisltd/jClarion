package clarion;

import clarion.Childlist;
import clarion.Queryclass;
import clarion.Relationmanager;
import clarion.Stepclass;
import clarion.Viewmanager;
import clarion.equates.Constants;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.equates.Propagate;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.view.ClarionView;

public class Processclass extends Viewmanager
{
	public ClarionNumber bytesRead;
	public ClarionNumber fileSize;
	public ClarionNumber childRead;
	public Childlist children;
	public ClarionNumber percentile;
	public ClarionNumber pText;
	public Queryclass query;
	public ClarionNumber recordsProcessed;
	public ClarionNumber recordsToProcess;
	public Stepclass stepMgr;
	public ClarionAny valueField;
	public ClarionNumber caseSensitiveValue;
	public Processclass()
	{
		bytesRead=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		fileSize=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		childRead=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		children=null;
		percentile=null;
		pText=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		query=null;
		recordsProcessed=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		recordsToProcess=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		stepMgr=null;
		valueField=Clarion.newAny();
		caseSensitiveValue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	}

	public ClarionNumber addItem(Viewmanager vm)
	{
		if (this.children==null) {
			this.children=new Childlist();
		}
		this.children.vm.set(vm);
		this.children.add();
		return Clarion.newNumber(this.children.records());
	}
	public void init(ClarionView p0,Relationmanager p1,ClarionNumber p2,ClarionNumber p3)
	{
		init(p0,p1,p2,p3,Clarion.newNumber(0));
	}
	public void init(ClarionView p0,Relationmanager p1,ClarionNumber p2)
	{
		init(p0,p1,p2,(ClarionNumber)null);
	}
	public void init(ClarionView p0,Relationmanager p1)
	{
		init(p0,p1,Clarion.newNumber(0));
	}
	public void init(ClarionView v,Relationmanager r,ClarionNumber progressText,ClarionNumber percentProgress,ClarionNumber guessRecords)
	{
		this.percentile=percentProgress;
		if (!(this.percentile==null)) {
			this.percentile.setValue(0);
		}
		this.recordsToProcess.setValue(guessRecords);
		this.pText.setValue(progressText);
		super.init(v,r);
	}
	public void init(ClarionView p0,Relationmanager p1,ClarionNumber p2,Stepclass p4,ClarionObject p5)
	{
		init(p0,p1,p2,(ClarionNumber)null,p4,p5);
	}
	public void init(ClarionView p0,Relationmanager p1,Stepclass p4,ClarionObject p5)
	{
		init(p0,p1,Clarion.newNumber(0),p4,p5);
	}
	public void init(ClarionView v,Relationmanager r,ClarionNumber progressText,ClarionNumber percentProgress,Stepclass stepManager,ClarionObject valueField)
	{
		this.percentile=percentProgress;
		if (!(this.percentile==null)) {
			this.percentile.setValue(0);
		}
		this.pText.setValue(progressText);
		this.stepMgr=stepManager;
		this.valueField.setReferenceValue(valueField);
		this.caseSensitiveValue.setValue(Constants.TRUE);
		super.init(v,r);
	}
	public void kill()
	{
		this.percentile=null;
		this.valueField.setReferenceValue(null);
		this.primary.setQuickScan(Clarion.newNumber(0),Clarion.newNumber(Propagate.ONEMANY));
		//this.children;
		if (!(this.stepMgr==null)) {
			this.stepMgr.kill();
		}
		super.kill();
	}
	public ClarionNumber next()
	{
		return next(Clarion.newNumber(Constants.TRUE));
	}
	public ClarionNumber next(ClarionNumber processRecords)
	{
		ClarionNumber retVal=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber progress=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (this.recordsProcessed.boolValue() && !(this.children==null) && this.childRead.compareTo(this.children.records())<0) {
			this.childRead.increment(1);
			this.children.get(this.childRead);
			this.children.vm.get().applyRange();
			this.children.vm.get().reset();
		}
		while (true) {
			retVal.setValue(!this.childRead.boolValue() ? super.next() : this.children.vm.get().next());
			if (!retVal.boolValue() || !this.childRead.boolValue()) {
				break;
			}
			this.childRead.decrement(1);
			this.children.get(this.childRead);
		}
		if (!retVal.boolValue() && processRecords.boolValue()) {
			if (this.fileSize.boolValue()) {
				this.bytesRead.increment(this.primary.me.file.getBytes());
			}
			this.recordsProcessed.increment(1);
			if (!(this.percentile==null) && !this.childRead.boolValue()) {
				if (this.stepMgr==null) {
					if (this.fileSize.boolValue()) {
						progress.setValue(Clarion.newNumber(100).multiply(this.bytesRead).divide(this.fileSize));
					}
					else {
						progress.setValue(this.recordsProcessed.divide(this.recordsToProcess).multiply(100));
					}
				}
				else if (this.caseSensitiveValue.boolValue()) {
					progress.setValue(this.stepMgr.getPercentile(this.valueField.like()));
				}
				else {
					progress.setValue(this.stepMgr.getPercentile(this.valueField.getString().upper()));
				}
				if (progress.compareTo(100)>0) {
					progress.setValue(100);
				}
				if (!progress.equals(this.percentile)) {
					this.percentile.setValue(progress);
					this.updateDisplay();
				}
			}
		}
		return retVal.like();
	}
	public void reset()
	{
		this.recordsProcessed.setValue(0);
		if (!(this.stepMgr==null)) {
			this.setProgressLimits();
		}
		else if (!this.recordsToProcess.boolValue()) {
			this.primary.me.useFile();
			this.recordsToProcess.setValue(this.primary.me.file.records());
			if (!this.recordsToProcess.boolValue()) {
				this.fileSize.setValue(this.primary.me.file.getProperty(Prop.FILESIZE));
			}
		}
		this.childRead.setValue(0);
		super.reset();
	}
	public void setProgressLimits()
	{
		ClarionString lo=Clarion.newString(64);
		ClarionString hi=Clarion.newString(64);
		CRun._assert(!(this.valueField.getValue()==null));
		super.reset();
		if (this.previous().boolValue()) {
			this.valueField.clear(1);
		}
		hi.setValue(this.valueField);
		super.reset();
		if (this.next(Clarion.newNumber(Constants.FALSE)).boolValue()) {
			this.valueField.clear(-1);
		}
		lo.setValue(this.valueField);
		this.setProgressLimits(lo.like(),hi.like());
	}
	public void setProgressLimits(ClarionString lo,ClarionString hi)
	{
		CRun._assert(!(this.stepMgr==null));
		if (this.caseSensitiveValue.boolValue()) {
			this.stepMgr.setLimit(lo.like(),hi.like());
		}
		else {
			this.stepMgr.setLimit(lo.upper(),hi.upper());
		}
	}
	public void takeAccepted()
	{
	}
	public void takeLocate()
	{
		if (!(this.query==null) && this.query.ask().boolValue()) {
			this.setFilter(this.query.getFilter());
		}
	}
	public ClarionNumber takeRecord()
	{
		return Clarion.newNumber(Level.BENIGN);
	}
	public void updateDisplay()
	{
		Clarion.getControl(this.pText).setProperty(Prop.TEXT,this.percentile==null ? Clarion.newString("") : this.percentile.concat(Constants.COMPLETEDTEXT));
		CWin.display();
	}
}
