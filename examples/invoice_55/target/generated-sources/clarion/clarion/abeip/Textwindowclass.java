package clarion.abeip;

import clarion.abeip.Abeip;
import clarion.abwindow.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Level;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Textwindowclass extends Windowmanager
{
	public ClarionString title=Clarion.newString(64);
	public ClarionNumber entryfeq=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber sels=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
	public ClarionNumber sele=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
	public ClarionAny txt=Clarion.newAny();
	public Textwindowclass()
	{
		title=Clarion.newString(64);
		entryfeq=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		sels=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		sele=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		txt=Clarion.newAny();
	}

	public ClarionNumber init()
	{
		ClarionNumber readonlyflag=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		super.init();
		this.sels.setValue(Clarion.getControl(this.entryfeq).getProperty(Prop.SELSTART));
		this.sele.setValue(Clarion.getControl(this.entryfeq).getProperty(Prop.SELEND));
		CWin.update(this.entryfeq.intValue());
		this.txt.setValue(Clarion.getControl(this.entryfeq).getProperty(Prop.USE));
		readonlyflag.setValue(Clarion.getControl(this.entryfeq).getProperty(Prop.READONLY));
		Abeip.txtwindow.open();
		Abeip.txtwindow.setClonedProperty(Prop.TEXT,this.title);
		Clarion.getControl(Abeip.txtwindow._text).setProperty(Prop.USE,this.txt);
		Clarion.getControl(Abeip.txtwindow._text).setClonedProperty(Prop.SELSTART,this.sels);
		if (this.sele.boolValue()) {
			Clarion.getControl(Abeip.txtwindow._text).setClonedProperty(Prop.SELEND,this.sele);
		}
		if (readonlyflag.boolValue()) {
			Clarion.getControl(Abeip.txtwindow._text).setProperty(Prop.READONLY,Constants.TRUE);
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public void init(ClarionNumber entryfeq,ClarionString title)
	{
		this.title.setValue(title);
		this.entryfeq.setValue(entryfeq);
	}
	public ClarionNumber takeaccepted()
	{
		{
			int case_1=CWin.field();
			boolean case_1_break=false;
			if (case_1==Abeip.txtwindow._txtok) {
				this.setresponse(Clarion.newNumber(Constants.REQUESTCOMPLETED));
				case_1_break=true;
			}
			if (!case_1_break && case_1==Abeip.txtwindow._txtcancel) {
				this.setresponse(Clarion.newNumber(Constants.REQUESTCANCELLED));
				case_1_break=true;
			}
		}
		return super.takeaccepted();
	}
	public ClarionNumber kill()
	{
		this.sels.setValue(Clarion.getControl(Abeip.txtwindow._text).getProperty(Prop.SELSTART));
		this.sele.setValue(Clarion.getControl(Abeip.txtwindow._text).getProperty(Prop.SELEND));
		this.txt.setValue(Clarion.getControl(Abeip.txtwindow._text).getProperty(Prop.USE));
		Abeip.txtwindow.close();
		if (this.response.equals(Constants.REQUESTCOMPLETED)) {
			CWin.change(this.entryfeq.intValue(),this.txt);
			CWin.display(this.entryfeq.intValue());
			Clarion.getControl(this.entryfeq).setClonedProperty(Prop.SELSTART,this.sels);
			if (this.sele.boolValue()) {
				Clarion.getControl(this.entryfeq).setClonedProperty(Prop.SELEND,this.sele);
			}
		}
		return super.kill();
	}
}
