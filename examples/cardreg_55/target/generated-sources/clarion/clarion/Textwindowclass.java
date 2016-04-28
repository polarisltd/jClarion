package clarion;

import clarion.Abeip;
import clarion.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Level;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CWin;

public class Textwindowclass extends Windowmanager
{
	public ClarionString title;
	public ClarionNumber entryFEQ;
	public ClarionNumber selS;
	public ClarionNumber selE;
	public ClarionAny txt;
	public Textwindowclass()
	{
		title=Clarion.newString(64);
		entryFEQ=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		selS=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		selE=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		txt=Clarion.newAny();
	}

	public ClarionNumber init()
	{
		ClarionNumber readOnlyFlag=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		super.init();
		this.selS.setValue(Clarion.getControl(this.entryFEQ).getProperty(Prop.SELSTART));
		this.selE.setValue(Clarion.getControl(this.entryFEQ).getProperty(Prop.SELEND));
		CWin.update(this.entryFEQ.intValue());
		this.txt.setValue(Clarion.getControl(this.entryFEQ).getProperty(Prop.USE));
		readOnlyFlag.setValue(Clarion.getControl(this.entryFEQ).getProperty(Prop.READONLY));
		Abeip.txtWindow.open();
		Abeip.txtWindow.setClonedProperty(Prop.TEXT,this.title);
		Clarion.getControl(Abeip.txtWindow._text).setProperty(Prop.USE,this.txt);
		Clarion.getControl(Abeip.txtWindow._text).setClonedProperty(Prop.SELSTART,this.selS);
		if (this.selE.boolValue()) {
			Clarion.getControl(Abeip.txtWindow._text).setClonedProperty(Prop.SELEND,this.selE);
		}
		if (readOnlyFlag.boolValue()) {
			Clarion.getControl(Abeip.txtWindow._text).setProperty(Prop.READONLY,Constants.TRUE);
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public void init(ClarionNumber entryFEQ,ClarionString title)
	{
		this.title.setValue(title);
		this.entryFEQ.setValue(entryFEQ);
	}
	public ClarionNumber takeAccepted()
	{
		{
			int case_1=CWin.field();
			boolean case_1_break=false;
			if (case_1==Abeip.txtWindow._txtOk) {
				this.setResponse(Clarion.newNumber(Constants.REQUESTCOMPLETED));
				case_1_break=true;
			}
			if (!case_1_break && case_1==Abeip.txtWindow._txtCancel) {
				this.setResponse(Clarion.newNumber(Constants.REQUESTCANCELLED));
				case_1_break=true;
			}
		}
		return super.takeAccepted();
	}
	public ClarionNumber kill()
	{
		this.selS.setValue(Clarion.getControl(Abeip.txtWindow._text).getProperty(Prop.SELSTART));
		this.selE.setValue(Clarion.getControl(Abeip.txtWindow._text).getProperty(Prop.SELEND));
		this.txt.setValue(Clarion.getControl(Abeip.txtWindow._text).getProperty(Prop.USE));
		Abeip.txtWindow.close();
		if (this.response.equals(Constants.REQUESTCOMPLETED)) {
			CWin.change(this.entryFEQ.intValue(),this.txt);
			CWin.display(this.entryFEQ.intValue());
			Clarion.getControl(this.entryFEQ).setClonedProperty(Prop.SELSTART,this.selS);
			if (this.selE.boolValue()) {
				Clarion.getControl(this.entryFEQ).setClonedProperty(Prop.SELEND,this.selE);
			}
		}
		return super.kill();
	}
}
