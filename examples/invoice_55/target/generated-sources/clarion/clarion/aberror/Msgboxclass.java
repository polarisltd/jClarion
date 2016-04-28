package clarion.aberror;

import clarion.Windowcomponent;
import clarion.aberror.Errorclass;
import clarion.abwindow.Windowmanager;
import clarion.equates.Button;
import clarion.equates.Constants;
import clarion.equates.Icon;
import clarion.equates.Level;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Msgboxclass extends Windowmanager
{
	public ClarionNumber buttontypes=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionString caption=null;
	public Errorclass err=null;
	public ClarionNumber icon=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public Windowcomponent historyhandler=null;
	public ClarionNumber msgbuttons=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionArray<ClarionNumber> msgbuttonid=Clarion.newNumber().setEncoding(ClarionNumber.LONG).dim(8);
	public ClarionNumber msgrval=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionNumber style=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
	public ClarionWindow win=null;
	public Msgboxclass()
	{
		buttontypes=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		caption=null;
		err=null;
		icon=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		historyhandler=null;
		msgbuttons=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		msgbuttonid=Clarion.newNumber().setEncoding(ClarionNumber.LONG).dim(8);
		msgrval=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		style=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		win=null;
	}

	public ClarionNumber fetchfeq(ClarionNumber btn)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		final ClarionNumber loop_1=this.msgbuttons.like();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			if (this.msgbuttonid.get(i.intValue()).equals(btn)) {
				return Clarion.newNumber(Constants.BASEBUTTONFEQ).add(i).subtract(1).getNumber();
			}
		}
		return Clarion.newNumber(0);
	}
	public ClarionNumber fetchstdbutton(ClarionNumber feq)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		final ClarionObject loop_1=Clarion.newNumber(Constants.BASEBUTTONFEQ).add(this.msgbuttons).subtract(1);for (i.setValue(Constants.BASEBUTTONFEQ);i.compareTo(loop_1)<=0;i.increment(1)) {
			if (feq.equals(i)) {
				return this.msgbuttonid.get(i.subtract(Constants.BASEBUTTONFEQ).add(1).intValue()).like();
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
	public void init(ClarionWindow win,Errorclass err,ClarionString caption,ClarionNumber icon,ClarionNumber buttons,ClarionNumber defaultbutton,ClarionNumber style)
	{
		this.win=win;
		this.err=err;
		this.caption=Clarion.newString(caption.len());
		this.caption.setValue(caption);
		this.icon.setValue(icon);
		this.buttontypes.setValue(buttons);
		this.msgrval.setValue(defaultbutton);
		this.style.setValue(style);
	}
	public ClarionNumber init()
	{
		ClarionNumber rval=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		ClarionNumber feq=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		int __choose_hold=0;
		rval.setValue(super.init());
		if (rval.equals(Level.BENIGN)) {
			if (!(this.historyhandler==null)) {
				this.additem(this.historyhandler);
			}
			this.win.open();
			this.opened.setValue(Constants.TRUE);
			if (this.caption.boolValue()) {
				this.win.setClonedProperty(Prop.TEXT,this.caption);
			}
			this.msgbuttons.setValue(0);
			for (i.setValue(7);i.compareTo(0)>=0;i.increment(-1)) {
				if ((this.buttontypes.intValue() & Clarion.newNumber(2).power(i).intValue())!=0) {
					this.msgbuttons.increment(1);
					this.msgbuttonid.get(this.msgbuttons.intValue()).setValue(Clarion.newNumber(2).power(i));
					feq.setValue(Clarion.newNumber(Constants.BASEBUTTONFEQ).add(this.msgbuttons).subtract(1));
					Clarion.getControl(feq).setProperty(Prop.TEXT,(__choose_hold=i.add(1).intValue())==1 ?"O&k" : __choose_hold==2 ? "&Yes" : __choose_hold==3 ? "&No" : __choose_hold==4 ? "&Abort" : __choose_hold==5 ? "&Retry" : __choose_hold==6 ? "&Ignore" : __choose_hold==7 ? "&Cancel" : "&Help");
					if (this.msgrval.equals(Clarion.newNumber(2).power(i))) {
						Clarion.getControl(feq).setProperty(Prop.DEFAULT,Constants.TRUE);
						CWin.select(feq.intValue());
					}
					CWin.unhide(feq.intValue());
				}
			}
			this.setupadditionalfeqs();
		}
		return rval.like();
	}
	public ClarionNumber kill()
	{
		ClarionNumber rval=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		rval.setValue(super.kill());
		if (rval.equals(Level.BENIGN)) {
			//this.caption;
			this.win.close();
			this.opened.setValue(Constants.FALSE);
		}
		return rval.like();
	}
	public void setupadditionalfeqs()
	{
		if (this.icon.equals(0)) {
			Clarion.getControl(Constants.IMAGEFEQ).setProperty(Prop.TEXT,Icon.EXCLAMATION);
		}
		else {
			Clarion.getControl(Constants.IMAGEFEQ).setClonedProperty(Prop.TEXT,this.icon);
		}
	}
	public ClarionNumber takeaccepted()
	{
		ClarionNumber rval=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		rval.setValue(super.takeaccepted());
		if (rval.equals(Level.BENIGN)) {
			i.setValue(this.fetchstdbutton(Clarion.newNumber(CWin.accepted())));
			if (i.boolValue()) {
				this.msgrval.setValue(i);
				return Clarion.newNumber(Level.FATAL);
			}
		}
		return rval.like();
	}
}
