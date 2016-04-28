package clarion;

import clarion.Errorclass;
import clarion.Windowcomponent;
import clarion.Windowmanager;
import clarion.equates.Button;
import clarion.equates.Constants;
import clarion.equates.Icon;
import clarion.equates.Level;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.runtime.CWin;

public class Msgboxclass extends Windowmanager
{
	public ClarionNumber buttonTypes;
	public ClarionString caption;
	public Errorclass err;
	public ClarionNumber icon;
	public Windowcomponent historyHandler;
	public ClarionNumber msgButtons;
	public ClarionArray<ClarionNumber> msgButtonID;
	public ClarionNumber msgRVal;
	public ClarionNumber style;
	public ClarionWindow win;
	public Msgboxclass()
	{
		buttonTypes=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		caption=null;
		err=null;
		icon=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		historyHandler=null;
		msgButtons=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		msgButtonID=Clarion.newNumber().setEncoding(ClarionNumber.LONG).dim(8);
		msgRVal=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		style=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		win=null;
	}

	public ClarionNumber fetchFeq(ClarionNumber btn)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		for (i.setValue(1);i.compareTo(this.msgButtons)<=0;i.increment(1)) {
			if (this.msgButtonID.get(i.intValue()).equals(btn)) {
				return Clarion.newNumber(Constants.BASEBUTTONFEQ).add(i).subtract(1).getNumber();
			}
		}
		return Clarion.newNumber(0);
	}
	public ClarionNumber fetchStdButton(ClarionNumber feq)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		for (i.setValue(Constants.BASEBUTTONFEQ);i.compareTo(Clarion.newNumber(Constants.BASEBUTTONFEQ).add(this.msgButtons).subtract(1))<=0;i.increment(1)) {
			if (feq.equals(i)) {
				return this.msgButtonID.get(i.subtract(Constants.BASEBUTTONFEQ).add(1).intValue()).like();
			}
		}
		return Clarion.newNumber(0);
	}
	public void init(ClarionWindow p0,Errorclass p1,ClarionString p2,ClarionNumber p3,ClarionNumber p4,ClarionNumber p5)
	{
		init(p0,p1,p2,p3,p4,p5,Clarion.newNumber(0));
	}
	public void init(ClarionWindow p0,Errorclass p1,ClarionString p2,ClarionNumber p3,ClarionNumber p4)
	{
		init(p0,p1,p2,p3,p4,Clarion.newNumber(0));
	}
	public void init(ClarionWindow p0,Errorclass p1,ClarionString p2,ClarionNumber p3)
	{
		init(p0,p1,p2,p3,Clarion.newNumber(Button.OK));
	}
	public void init(ClarionWindow p0,Errorclass p1,ClarionNumber p3)
	{
		init(p0,p1,(ClarionString)null,p3);
	}
	public void init(ClarionWindow win,Errorclass err,ClarionString caption,ClarionNumber icon,ClarionNumber buttons,ClarionNumber defaultButton,ClarionNumber style)
	{
		this.win=win;
		this.err=err;
		this.caption=Clarion.newString(caption.len());
		this.caption.setValue(caption);
		this.icon.setValue(icon);
		this.buttonTypes.setValue(buttons);
		this.msgRVal.setValue(defaultButton);
		this.style.setValue(style);
	}
	public ClarionNumber init()
	{
		ClarionNumber rVal=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber feq=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		int __choose_hold=0;
		rVal.setValue(super.init());
		if (rVal.equals(Level.BENIGN)) {
			if (!(this.historyHandler==null)) {
				this.addItem(this.historyHandler);
			}
			this.win.open();
			this.opened.setValue(Constants.TRUE);
			if (this.caption.boolValue()) {
				this.win.setClonedProperty(Prop.TEXT,this.caption);
			}
			this.msgButtons.setValue(0);
			for (i.setValue(7);i.compareTo(0)>=0;i.increment(-1)) {
				if ((this.buttonTypes.intValue() & Clarion.newNumber(2).power(i).intValue())!=0) {
					this.msgButtons.increment(1);
					this.msgButtonID.get(this.msgButtons.intValue()).setValue(Clarion.newNumber(2).power(i));
					feq.setValue(Clarion.newNumber(Constants.BASEBUTTONFEQ).add(this.msgButtons).subtract(1));
					Clarion.getControl(feq).setProperty(Prop.TEXT,(__choose_hold=i.add(1).intValue())==1 ?"O&k" : __choose_hold==2 ? "&Yes" : __choose_hold==3 ? "&No" : __choose_hold==4 ? "&Abort" : __choose_hold==5 ? "&Retry" : __choose_hold==6 ? "&Ignore" : __choose_hold==7 ? "&Cancel" : "&Help");
					if (this.msgRVal.equals(Clarion.newNumber(2).power(i))) {
						Clarion.getControl(feq).setProperty(Prop.DEFAULT,Constants.TRUE);
						CWin.select(feq.intValue());
					}
					CWin.unhide(feq.intValue());
				}
			}
			this.setupAdditionalFeqs();
		}
		return rVal.like();
	}
	public ClarionNumber kill()
	{
		ClarionNumber rVal=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		rVal.setValue(super.kill());
		if (rVal.equals(Level.BENIGN)) {
			//this.caption;
			this.win.close();
			this.opened.setValue(Constants.FALSE);
		}
		return rVal.like();
	}
	public void setupAdditionalFeqs()
	{
		if (this.icon.equals(0)) {
			Clarion.getControl(Constants.IMAGEFEQ).setProperty(Prop.TEXT,Icon.EXCLAMATION);
		}
		else {
			Clarion.getControl(Constants.IMAGEFEQ).setClonedProperty(Prop.TEXT,this.icon);
		}
	}
	public ClarionNumber takeAccepted()
	{
		ClarionNumber rVal=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		rVal.setValue(super.takeAccepted());
		if (rVal.equals(Level.BENIGN)) {
			i.setValue(this.fetchStdButton(Clarion.newNumber(CWin.accepted())));
			if (i.boolValue()) {
				this.msgRVal.setValue(i);
				return Clarion.newNumber(Level.FATAL);
			}
		}
		return rVal.like();
	}
}
