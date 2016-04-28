package clarion;

import clarion.Ireportgenerator;
import clarion.PlugInChoiceWindow;
import clarion.Targetreportgeneratorqueue;
import clarion.equates.Constants;
import clarion.equates.Create;
import clarion.equates.Event;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

public class Reporttargetselectorclass
{
	public ClarionNumber horizontal;
	public ClarionNumber stretch;
	public ClarionNumber withPrinter;
	public ClarionNumber printSelected;
	public Ireportgenerator plugInSelected;
	public Targetreportgeneratorqueue qPlugIn;
	public Reporttargetselectorclass()
	{
		horizontal=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		stretch=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		withPrinter=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		printSelected=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		plugInSelected=null;
		qPlugIn=null;
		construct();
	}

	public void setSize(ClarionNumber p0)
	{
		setSize(p0,Clarion.newNumber(1));
	}
	public void setSize()
	{
		setSize(Clarion.newNumber(6));
	}
	public void setSize(ClarionNumber pHorizontal,ClarionNumber pStretch)
	{
		this.stretch.setValue(pStretch);
		this.horizontal.setValue(pHorizontal);
	}
	public void addItem(Ireportgenerator p0)
	{
		addItem(p0,Clarion.newNumber(1));
	}
	public void addItem(Ireportgenerator pPlugIn,ClarionNumber pEnableOnPreview)
	{
		this.qPlugIn.reportGenerator.set(pPlugIn);
		this.qPlugIn.enableOnPreview.setValue(pEnableOnPreview);
		this.qPlugIn.add();
	}
	public ClarionNumber ask(ClarionNumber p0)
	{
		return ask(p0,Clarion.newNumber(0));
	}
	public ClarionNumber ask()
	{
		return ask(Clarion.newNumber(0));
	}
	public ClarionNumber ask(ClarionNumber pWithPrinter,ClarionNumber pFromPreview)
	{
		ClarionNumber lButton_W=Clarion.newNumber(32).setEncoding(ClarionNumber.SHORT);
		ClarionNumber lButton_H=Clarion.newNumber(36).setEncoding(ClarionNumber.SHORT);
		ClarionNumber lLeft_Margin=Clarion.newNumber(2).setEncoding(ClarionNumber.SHORT);
		ClarionNumber lTop_Margin=Clarion.newNumber(2).setEncoding(ClarionNumber.SHORT);
		ClarionNumber lSeparation=Clarion.newNumber(2).setEncoding(ClarionNumber.SHORT);
		ClarionNumber lPlugInChoice=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber lFirstFeq=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber lFEQ=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber lIndexH=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber lIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber lHOR=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber lVER=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber lHorizontal=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		ClarionNumber lPrinterFEQ=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber lOK=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		PlugInChoiceWindow plugInChoiceWindow=new PlugInChoiceWindow(lPlugInChoice);
		try {
			this.withPrinter.setValue(pWithPrinter);
			if (pWithPrinter.boolValue()) {
				if (this.qPlugIn.records()==0) {
					this.printSelected.setValue(Constants.TRUE);
					return Clarion.newNumber(Constants.TRUE);
				}
				pWithPrinter.setValue(1);
			}
			else {
				if (this.qPlugIn.records()==1) {
					this.qPlugIn.get(1);
					this.plugInSelected=this.qPlugIn.reportGenerator.get();
					this.printSelected.setValue(Constants.FALSE);
					return Clarion.newNumber(Constants.TRUE);
				}
			}
			lOK.setValue(Constants.FALSE);
			ask_PrepareWindow(lButton_W,lButton_H,lHorizontal,pWithPrinter);
			plugInChoiceWindow.open();
			ask_CreateControls(lIndexH,lVER,lTop_Margin,lHOR,lLeft_Margin,lIndex,pWithPrinter,lHorizontal,lButton_H,lSeparation,lFEQ,plugInChoiceWindow,lPrinterFEQ,lButton_W,lFirstFeq,lPlugInChoice);
			while (Clarion.getWindowTarget().accept()) {
				{
					int case_1=CWin.event();
					if (case_1==Event.OPENWINDOW) {
						CWin.select(plugInChoiceWindow._bOk);
					}
				}
				{
					int case_2=CWin.field();
					boolean case_2_break=false;
					if (case_2==plugInChoiceWindow._bOk) {
						{
							int case_3=CWin.event();
							if (case_3==Event.ACCEPTED) {
								lOK.setValue(Constants.TRUE);
								CWin.post(Event.CLOSEWINDOW);
							}
						}
						case_2_break=true;
					}
					if (!case_2_break && case_2==plugInChoiceWindow._bCancel) {
						{
							int case_4=CWin.event();
							if (case_4==Event.ACCEPTED) {
								lOK.setValue(Constants.FALSE);
								CWin.post(Event.CLOSEWINDOW);
							}
						}
						case_2_break=true;
					}
				}
				Clarion.getWindowTarget().consumeAccept();
			}
			if (lOK.boolValue()) {
				if (!pWithPrinter.boolValue()) {
					this.qPlugIn.get(lPlugInChoice);
					this.plugInSelected=this.qPlugIn.reportGenerator.get();
					this.printSelected.setValue(Constants.FALSE);
				}
				else {
					if (lPlugInChoice.equals(1)) {
						this.printSelected.setValue(Constants.TRUE);
					}
					else {
						this.qPlugIn.get(lPlugInChoice.subtract(1));
						this.plugInSelected=this.qPlugIn.reportGenerator.get();
						this.printSelected.setValue(Constants.FALSE);
					}
				}
			}
			return lOK.like();
		} finally {
			plugInChoiceWindow.close();
		}
	}
	public void ask_PrepareWindow(ClarionNumber lButton_W,ClarionNumber lButton_H,ClarionNumber lHorizontal,ClarionNumber pWithPrinter)
	{
		lButton_W.setValue(32);
		lButton_H.setValue(36);
		lHorizontal.setValue(this.horizontal);
		if (this.stretch.boolValue()) {
			if (lHorizontal.compareTo(Clarion.newNumber(this.qPlugIn.records()).add(pWithPrinter))>0) {
				lHorizontal.setValue(Clarion.newNumber(this.qPlugIn.records()).add(pWithPrinter));
			}
			else {
				if (Clarion.newNumber(this.qPlugIn.records()).add(pWithPrinter).equals(lHorizontal.add(1))) {
					lHorizontal.increment(1);
				}
			}
		}
		if (lHorizontal.compareTo(3)<0) {
			lHorizontal.setValue(3);
		}
	}
	public void ask_CreateControls(ClarionNumber lIndexH,ClarionNumber lVER,ClarionNumber lTop_Margin,ClarionNumber lHOR,ClarionNumber lLeft_Margin,ClarionNumber lIndex,ClarionNumber pWithPrinter,ClarionNumber lHorizontal,ClarionNumber lButton_H,ClarionNumber lSeparation,ClarionNumber lFEQ,PlugInChoiceWindow plugInChoiceWindow,ClarionNumber lPrinterFEQ,ClarionNumber lButton_W,ClarionNumber lFirstFeq,ClarionNumber lPlugInChoice)
	{
		lIndexH.setValue(0);
		lVER.setValue(lTop_Margin);
		lHOR.setValue(lLeft_Margin);
		for (lIndex.setValue(1);lIndex.compareTo(Clarion.newNumber(this.qPlugIn.records()).add(pWithPrinter))<=0;lIndex.increment(1)) {
			lIndexH.increment(1);
			if (lIndexH.compareTo(lHorizontal)>0) {
				lIndexH.setValue(1);
				lHOR.setValue(lLeft_Margin);
				lVER.setValue(lVER.add(lButton_H).add(lSeparation));
			}
			lFEQ.setValue(CWin.createControl(0,Create.RADIO,plugInChoiceWindow._lPlugInChoice,null));
			Clarion.getControl(lFEQ).setClonedProperty(Prop.VALUE,lIndex);
			Clarion.getControl(lFEQ).setProperty(Prop.FLAT,Constants.TRUE);
			if (!(lIndex.equals(1) && pWithPrinter.boolValue())) {
				this.qPlugIn.get(lIndex.subtract(pWithPrinter));
				Clarion.getControl(lFEQ).setProperty(Prop.ICON,this.qPlugIn.reportGenerator.get().displayIcon());
				Clarion.getControl(lFEQ).setProperty(Prop.TEXT,this.qPlugIn.reportGenerator.get().displayName());
			}
			else {
				Clarion.getControl(lFEQ).setProperty(Prop.VALUE,1);
				lPrinterFEQ.setValue(lFEQ);
				Clarion.getControl(lFEQ).setProperty(Prop.ICON,"~EXP_PRI.ICO");
				Clarion.getControl(lFEQ).setProperty(Prop.TEXT,"Print");
			}
			CWin.setPosition(lFEQ.intValue(),lHOR.intValue(),lVER.intValue(),lButton_W.intValue(),lButton_H.intValue());
			CWin.unhide(lFEQ.intValue());
			if (lIndex.equals(1)) {
				lFirstFeq.setValue(lFEQ);
			}
			lHOR.setValue(lHOR.add(lButton_W).add(lSeparation));
		}
		lPlugInChoice.setValue(1);
		Clarion.getControl(plugInChoiceWindow._lPlugInChoice).setProperty(Prop.SELECTED,1);
		lHOR.setValue(lButton_W.add(lSeparation).multiply(lHorizontal).add(2));
		Clarion.getControl(plugInChoiceWindow._bCancel).setProperty(Prop.WIDTH,lButton_W.add(lSeparation.divide(2)).add(lButton_W.divide(2)));
		Clarion.getControl(plugInChoiceWindow._bOk).setProperty(Prop.WIDTH,Clarion.getControl(plugInChoiceWindow._bCancel).getProperty(Prop.WIDTH));
		lVER.setValue(lVER.add(Clarion.newNumber(2).multiply(lSeparation)).add(Clarion.getControl(plugInChoiceWindow._bCancel).getProperty(Prop.HEIGHT)).add(lButton_H).add(lSeparation));
		Clarion.getControl(plugInChoiceWindow._bCancel).setProperty(Prop.XPOS,lHOR.subtract(Clarion.getControl(plugInChoiceWindow._bCancel).getProperty(Prop.WIDTH)).subtract(lSeparation));
		Clarion.getControl(plugInChoiceWindow._bOk).setProperty(Prop.XPOS,Clarion.getControl(plugInChoiceWindow._bCancel).getProperty(Prop.XPOS).subtract(lSeparation).subtract(Clarion.getControl(plugInChoiceWindow._bOk).getProperty(Prop.WIDTH)));
		Clarion.getControl(plugInChoiceWindow._bCancel).setProperty(Prop.YPOS,lVER.subtract(lSeparation).subtract(Clarion.getControl(plugInChoiceWindow._bCancel).getProperty(Prop.HEIGHT)));
		Clarion.getControl(plugInChoiceWindow._bOk).setProperty(Prop.YPOS,Clarion.getControl(plugInChoiceWindow._bCancel).getProperty(Prop.YPOS));
		plugInChoiceWindow.setClonedProperty(Prop.AT,3,lHOR);
		plugInChoiceWindow.setClonedProperty(Prop.AT,4,lVER);
	}
	public ClarionNumber items()
	{
		return Clarion.newNumber(this.qPlugIn.records());
	}
	public ClarionNumber getPrintSelected()
	{
		if (this.withPrinter.boolValue()) {
			return this.printSelected.like();
		}
		else {
			return Clarion.newNumber(Constants.FALSE);
		}
	}
	public Ireportgenerator getSelected()
	{
		if (this.getPrintSelected().boolValue()) {
			CRun._assert(Constants.FALSE!=0,"Printer was selected as the output,it is not expected to call this method: GetSelected");
			return null;
		}
		else {
			CRun._assert(!(this.plugInSelected==null),"PlugIn not selected method: GetSelected");
			return this.plugInSelected;
		}
	}
	public void fillQueue(ClarionQueue p0)
	{
		fillQueue(p0,Clarion.newNumber(1));
	}
	public void fillQueue(ClarionQueue queueToFill,ClarionNumber columnToFill)
	{
		ClarionAny lColumn=Clarion.newAny();
		ClarionNumber lIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		queueToFill.free();
		if (this.qPlugIn.records()!=0) {
			lColumn.setReferenceValue(queueToFill.what(columnToFill.intValue()));
			for (lIndex.setValue(1);lIndex.compareTo(this.qPlugIn.records())<=0;lIndex.increment(1)) {
				this.qPlugIn.get(lIndex);
				if (CError.errorCode()!=0) {
					break;
				}
				lColumn.setValue(this.qPlugIn.reportGenerator.get().displayName());
				queueToFill.add();
			}
		}
	}
	public Ireportgenerator getReportGenerator(ClarionString generatorName)
	{
		ClarionNumber lIndex=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		if (generatorName.isNumeric()) {
			lIndex.setValue(generatorName);
			this.qPlugIn.get(lIndex);
			if (!(CError.errorCode()!=0)) {
				return this.qPlugIn.reportGenerator.get();
			}
			CRun._assert(Constants.FALSE!=0,ClarionString.staticConcat("The number \"",generatorName,"\" is not a valid Generator: GetReportGenerator"));
		}
		else {
			for (lIndex.setValue(1);lIndex.compareTo(this.qPlugIn.records())<=0;lIndex.increment(1)) {
				this.qPlugIn.get(lIndex);
				if (CError.errorCode()!=0) {
					break;
				}
				if (generatorName.clip().upper().equals(this.qPlugIn.reportGenerator.get().displayName().upper())) {
					return this.qPlugIn.reportGenerator.get();
				}
			}
			CRun._assert(Constants.FALSE!=0,ClarionString.staticConcat("The name \"",generatorName,"\" is not a valid Generator Name: GetReportGenerator"));
		}
		return null;
	}
	public ClarionString getReportGeneratorName(ClarionNumber generatorPos)
	{
		this.qPlugIn.get(generatorPos);
		if (!(CError.errorCode()!=0)) {
			return this.qPlugIn.reportGenerator.get().displayName();
		}
		CRun._assert(Constants.FALSE!=0,ClarionString.staticConcat("The number \"",generatorPos,"\" is not a valid Generator: GetReportGeneratorName"));
		return Clarion.newString("");
	}
	public void construct()
	{
		this.horizontal.setValue(6);
		this.stretch.setValue(1);
		this.qPlugIn=new Targetreportgeneratorqueue();
	}
	public void destruct()
	{
		this.qPlugIn.free();
		//this.qPlugIn;
	}
}
