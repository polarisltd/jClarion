package clarion;

import clarion.Errorclass;
import clarion.Ireportgenerator;
import clarion.Printpreviewfilequeue;
import clarion.ProgressWindow_7;
import clarion.Wmfparser;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CWin;

public class Wmfdocumentparser
{
	public Errorclass errors;
	public ClarionNumber errorsCreated;
	public Printpreviewfilequeue wMFQueue;
	public Wmfparser parser;
	public Ireportgenerator reportGenerator;
	public Wmfdocumentparser()
	{
		errors=null;
		errorsCreated=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		wMFQueue=null;
		parser=null;
		reportGenerator=null;
	}

	public ClarionNumber generateReport()
	{
		return generateReport(Clarion.newNumber(Constants.TRUE));
	}
	public ClarionNumber generateReport(ClarionNumber showProgress)
	{
		ClarionNumber idx=Clarion.newNumber(0).setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber ret=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber totalPages=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber progressThermometer=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ProgressWindow_7 progressWindow=new ProgressWindow_7(progressThermometer);
		try {
			this.parser=new Wmfparser();
			totalPages.setValue(this.wMFQueue.records());
			ret.setValue(this.reportGenerator.openDocument(totalPages.like()));
			if (ret.equals(Level.BENIGN)) {
				if (showProgress.boolValue()) {
					progressWindow.open();
					Clarion.getControl(progressWindow._imageGenerator).setProperty(Prop.TEXT,this.reportGenerator.displayIcon());
					Clarion.getControl(progressWindow._progressUserString).setProperty(Prop.TEXT,ClarionString.staticConcat("Exporting to ",this.reportGenerator.displayName()));
					Clarion.getControl(progressWindow._progressPctText).setProperty(Prop.TEXT,ClarionString.staticConcat("Page 0 of ",totalPages));
					while (Clarion.getWindowTarget().accept()) {
						{
							int case_1=CWin.event();
							boolean case_1_break=false;
							if (case_1==Event.OPENWINDOW) {
								case_1_break=true;
							}
							if (!case_1_break && case_1==Event.TIMER) {
								idx.increment(1);
								progressWindow.setProperty(Prop.TIMER,0);
								this.wMFQueue.get(idx);
								if (CError.errorCode()!=0 || totalPages.compareTo(idx)<0) {
									CWin.post(Event.CLOSEWINDOW);
								}
								Clarion.getControl(progressWindow._progressPctText).setProperty(Prop.TEXT,ClarionString.staticConcat("Page ",idx," of ",totalPages));
								progressThermometer.setValue(idx.multiply(100).divide(totalPages));
								CWin.display(progressWindow._progressThermometer,progressWindow._progressPctText);
								generateReport_ProcessDocument(ret);
								if (!ret.equals(Level.BENIGN)) {
									CWin.post(Event.CLOSEWINDOW);
								}
								if (totalPages.equals(idx)) {
									ret.setValue(this.reportGenerator.closeDocument());
									CWin.post(Event.CLOSEWINDOW);
								}
								else {
									progressWindow.setProperty(Prop.TIMER,1);
								}
								case_1_break=true;
							}
						}
						Clarion.getWindowTarget().consumeAccept();
					}
					progressWindow.close();
				}
				else {
					for (idx.setValue(1);idx.compareTo(totalPages)<=0;idx.increment(1)) {
						this.wMFQueue.get(idx);
						if (CError.errorCode()!=0) {
							break;
						}
						generateReport_ProcessDocument(ret);
						if (!ret.equals(Level.BENIGN)) {
							break;
						}
						if (totalPages.equals(idx)) {
							ret.setValue(this.reportGenerator.closeDocument());
						}
					}
				}
			}
			this.parser.destruct();
			this.parser.destruct();
			return ret.like();
		} finally {
			progressWindow.close();
		}
	}
	public void generateReport_ProcessDocument(ClarionNumber ret)
	{
		ret.setValue(this.openDocument());
		if (ret.equals(Level.BENIGN)) {
			ret.setValue(this.processDocument());
			if (ret.equals(Level.BENIGN)) {
				ret.setValue(this.closeDocument());
			}
		}
	}
	public void init(Printpreviewfilequeue p0,Ireportgenerator p1)
	{
		init(p0,p1,(Errorclass)null);
	}
	public void init(Printpreviewfilequeue wMFQueue,Ireportgenerator rptgen,Errorclass ec)
	{
		this.wMFQueue=wMFQueue;
		this.reportGenerator=rptgen;
		if (!(ec==null)) {
			if (this.errorsCreated.boolValue()) {
				this.errors.kill();
				this.errors.destruct();
				this.errorsCreated.setValue(Constants.FALSE);
			}
			this.errors=ec;
		}
		else {
			if (this.errorsCreated.equals(Constants.FALSE)) {
				this.errorsCreated.setValue(Constants.TRUE);
				this.errors=new Errorclass();
				this.errors.init();
			}
		}
	}
	public ClarionNumber closeDocument()
	{
		ClarionNumber ret=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ret.setValue(this.reportGenerator.closePage());
		if (ret.equals(Level.BENIGN)) {
			ret.setValue(this.parser.closeFile());
		}
		this.parser.kill();
		return ret.like();
	}
	public ClarionNumber openDocument()
	{
		ClarionNumber ret=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.parser.init(this.wMFQueue.filename.like(),this.reportGenerator,this.errors);
		ret.setValue(this.parser.openFile());
		if (ret.equals(Level.BENIGN)) {
			ret.setValue(this.parser.processHeader());
			if (ret.equals(Level.BENIGN)) {
				ret.setValue(this.reportGenerator.openPage(this.parser.getBoxLeft(),this.parser.getBoxTop(),this.parser.getBoxRight(),this.parser.getBoxBottom()));
			}
		}
		return ret.like();
	}
	public ClarionNumber processDocument()
	{
		return this.parser.run();
	}
	public void destructor()
	{
		if (this.errorsCreated.boolValue()) {
			this.errors.kill();
			this.errors.destruct();
		}
	}
}
