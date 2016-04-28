package clarion.abreport;

import clarion.abbrowse.Stepclass;
import clarion.abfile.Relationmanager;
import clarion.abfile.Viewmanager;
import clarion.abquery.Queryclass_4;
import clarion.abreport.Childlist;
import clarion.abreport.equates.Mconstants;
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

@SuppressWarnings("all")
public class Processclass_2 extends Viewmanager
{
	public ClarionNumber bytesread=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber filesize=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber childread=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Childlist children=null;
	public ClarionNumber percentile=null;
	public ClarionNumber ptext=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public Queryclass_4 query=null;
	public ClarionNumber recordsprocessed=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber recordstoprocess=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public Stepclass stepmgr=null;
	public ClarionAny valuefield=Clarion.newAny();
	public ClarionNumber casesensitivevalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Processclass_2()
	{
		bytesread=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		filesize=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		childread=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		children=null;
		percentile=null;
		ptext=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		query=null;
		recordsprocessed=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		recordstoprocess=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		stepmgr=null;
		valuefield=Clarion.newAny();
		casesensitivevalue=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	}

	public ClarionNumber additem(Viewmanager vm)
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
	public void init(ClarionView v,Relationmanager r,ClarionNumber progresstext,ClarionNumber percentprogress,ClarionNumber guessrecords)
	{
		this.percentile=percentprogress;
		if (!(this.percentile==null)) {
			this.percentile.setValue(0);
		}
		this.recordstoprocess.setValue(guessrecords);
		this.ptext.setValue(progresstext);
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
	public void init(ClarionView v,Relationmanager r,ClarionNumber progresstext,ClarionNumber percentprogress,Stepclass stepmanager,ClarionObject valuefield)
	{
		this.percentile=percentprogress;
		if (!(this.percentile==null)) {
			this.percentile.setValue(0);
		}
		this.ptext.setValue(progresstext);
		this.stepmgr=stepmanager;
		this.valuefield.setReferenceValue(valuefield);
		this.casesensitivevalue.setValue(Constants.TRUE);
		super.init(v,r);
	}
	public void kill()
	{
		this.percentile=null;
		this.valuefield.setReferenceValue(null);
		this.primary.setquickscan(Clarion.newNumber(0),Clarion.newNumber(Propagate.ONEMANY));
		//this.children;
		if (!(this.stepmgr==null)) {
			this.stepmgr.kill();
		}
		super.kill();
	}
	public ClarionNumber next()
	{
		return next(Clarion.newNumber(Constants.TRUE));
	}
	public ClarionNumber next(ClarionNumber processrecords)
	{
		ClarionNumber retval=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber progress=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		if (this.recordsprocessed.boolValue() && !(this.children==null) && this.childread.compareTo(this.children.records())<0) {
			this.childread.increment(1);
			this.children.get(this.childread);
			this.children.vm.get().applyrange();
			this.children.vm.get().reset();
		}
		while (true) {
			retval.setValue(!this.childread.boolValue() ? super.next() : this.children.vm.get().next());
			if (!retval.boolValue() || !this.childread.boolValue()) {
				break;
			}
			this.childread.decrement(1);
			this.children.get(this.childread);
		}
		if (!retval.boolValue() && processrecords.boolValue()) {
			if (this.filesize.boolValue()) {
				this.bytesread.increment(this.primary.me.file.getBytes());
			}
			this.recordsprocessed.increment(1);
			if (!(this.percentile==null) && !this.childread.boolValue()) {
				if (this.stepmgr==null) {
					if (this.filesize.boolValue()) {
						progress.setValue(Clarion.newNumber(100).multiply(this.bytesread).divide(this.filesize));
					}
					else {
						progress.setValue(this.recordsprocessed.divide(this.recordstoprocess).multiply(100));
					}
				}
				else if (this.casesensitivevalue.boolValue()) {
					progress.setValue(this.stepmgr.getpercentile(this.valuefield.like()));
				}
				else {
					progress.setValue(this.stepmgr.getpercentile(this.valuefield.getString().upper()));
				}
				if (progress.compareTo(100)>0) {
					progress.setValue(100);
				}
				if (!progress.equals(this.percentile)) {
					this.percentile.setValue(progress);
					this.updatedisplay();
				}
			}
		}
		return retval.like();
	}
	public void reset()
	{
		this.recordsprocessed.setValue(0);
		if (!(this.stepmgr==null)) {
			this.setprogresslimits();
		}
		else if (!this.recordstoprocess.boolValue()) {
			this.primary.me.usefile();
			this.recordstoprocess.setValue(this.primary.me.file.records());
			if (!this.recordstoprocess.boolValue()) {
				this.filesize.setValue(this.primary.me.file.getProperty(Prop.FILESIZE));
			}
		}
		this.childread.setValue(0);
		super.reset();
	}
	public void setprogresslimits()
	{
		ClarionString lo=Clarion.newString(64);
		ClarionString hi=Clarion.newString(64);
		CRun._assert(!(this.valuefield.getValue()==null));
		super.reset();
		if (this.previous().boolValue()) {
			this.valuefield.clear(1);
		}
		hi.setValue(this.valuefield);
		super.reset();
		if (this.next(Clarion.newNumber(Constants.FALSE)).boolValue()) {
			this.valuefield.clear(-1);
		}
		lo.setValue(this.valuefield);
		this.setprogresslimits(lo.like(),hi.like());
	}
	public void setprogresslimits(ClarionString lo,ClarionString hi)
	{
		CRun._assert(!(this.stepmgr==null));
		if (this.casesensitivevalue.boolValue()) {
			this.stepmgr.setlimit(lo.like(),hi.like());
		}
		else {
			this.stepmgr.setlimit(lo.upper(),hi.upper());
		}
	}
	public void takeaccepted()
	{
	}
	public void takelocate()
	{
		if (!(this.query==null) && this.query.ask().boolValue()) {
			this.setfilter(this.query.getfilter());
		}
	}
	public ClarionNumber takerecord()
	{
		return Clarion.newNumber(Level.BENIGN);
	}
	public void updatedisplay()
	{
		Clarion.getControl(this.ptext).setProperty(Prop.TEXT,this.percentile==null ? Clarion.newString("") : this.percentile.concat(Mconstants.COMPLETEDTEXT));
		CWin.display();
	}
}
