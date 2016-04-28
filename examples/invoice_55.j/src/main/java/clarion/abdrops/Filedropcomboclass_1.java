package clarion.abdrops;

import clarion.Main; // missing import %%%%%%%%%%%%%%%
import clarion.abdrops.Abdrops;
import clarion.abdrops.Filedropclass_1;
import clarion.aberror.Errorclass;
import clarion.abfile.Relationmanager;
import clarion.abwindow.Windowmanager;
import clarion.equates.Button;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Msg;
import clarion.equates.Prop;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionAny;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionQueue;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;
import org.jclarion.clarion.view.ClarionView;

@SuppressWarnings("all")
public class Filedropcomboclass_1 extends Filedropclass_1
{
	public ClarionNumber askprocedure=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
	public ClarionAny usefield=Clarion.newAny();
	public ClarionNumber buttonfield=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber entryfield=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber entrycompletion=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber removeduplicatesflag=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Errorclass errmgr=null;
	public ClarionNumber autoaddflag=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber casesensitiveflag=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber syncronizeviewflag=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionString promptcaption=Clarion.newString(80).setEncoding(ClarionString.PSTRING);
	public ClarionString prompttext=Clarion.newString(256).setEncoding(ClarionString.PSTRING);
	public ClarionNumber econ=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public Filedropcomboclass_1()
	{
		askprocedure=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		usefield=Clarion.newAny();
		buttonfield=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		entryfield=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		entrycompletion=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		removeduplicatesflag=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		errmgr=null;
		autoaddflag=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		casesensitiveflag=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		syncronizeviewflag=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		promptcaption=Clarion.newString(80).setEncoding(ClarionString.PSTRING);
		prompttext=Clarion.newString(256).setEncoding(ClarionString.PSTRING);
		econ=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	}

	public ClarionNumber addrecord()
	{
		if (!this.removeduplicatesflag.boolValue() || !this.uniqueposition().equals(0)) {
			if (this.casesensitiveflag.boolValue()) {
				this.listqueue.add(Main.__CaseSensitiveCompare);
			}
			else {
				this.listqueue.add(Main.__CaseInsensitiveCompare);
			}
			CRun._assert(!(CError.errorCode()!=0));
			return Clarion.newNumber(Constants.TRUE);
		}
		return Clarion.newNumber(Constants.FALSE);
	}
	public ClarionNumber ask()
	{
		ClarionNumber rval=Clarion.newNumber(Level.NOTIFY).setEncoding(ClarionNumber.BYTE);
		if (this.askprocedure.boolValue()) {
			ask_primeforadd();
			if (this.window.run(this.askprocedure.like(),Clarion.newNumber(Constants.INSERTRECORD)).equals(Constants.REQUESTCOMPLETED)) {
				rval.setValue(Level.BENIGN);
			}
		}
		else if (this.autoaddflag.boolValue()) {
			if (this.errmgr.message(Clarion.newNumber(Msg.ADDNEWRECORD),Clarion.newNumber(Button.YES+Button.NO),Clarion.newNumber(Button.YES)).equals(Button.YES)) {
				ask_primeforadd();
				rval.setValue(this.primary.me.insert());
			}
		}
		return rval.like();
	}
	public void ask_primeforadd()
	{
		ClarionAny cvalue=Clarion.newAny();
		cvalue.setValue(this.usefield);
		this.primerecord();
		this.displayfields.list.get(1);
		CRun._assert(!(CError.errorCode()!=0));
		this.displayfields.list.left.setValue(cvalue);
	}
	public ClarionNumber buffermatches()
	{
		if (this.initsyncpair.boolValue()) {
			return super.buffermatches();
		}
		else {
			this.displayfields.list.get(1);
			return Clarion.newNumber(this.usefield.equals(this.displayfields.list.left) ? 1 : 0);
		}
	}
	public ClarionNumber getqueuematch(ClarionString lookfor)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		this.displayfields.list.get(1);
		CRun._assert(!(CError.errorCode()!=0));
		this.displayfields.list.right.setValue(lookfor.clip());
		i.setValue(this.listqueue.getPosition());
		if (CError.errorCode()==0) {
			return i.like();
		}
		if (i.compareTo(this.listqueue.records())>0) {
			return Clarion.newNumber(0);
		}
		this.listqueue.get(i);
		if (this.casesensitiveflag.boolValue()) {
			if (this.displayfields.list.right.getString().sub(1,lookfor.clip().len()).equals(lookfor)) {
				return i.like();
			}
		}
		else {
			if (this.displayfields.list.right.getString().sub(1,lookfor.clip().len()).upper().equals(lookfor.upper())) {
				return i.like();
			}
		}
		return Clarion.newNumber(0);
	}
	public void init(ClarionObject p0,ClarionNumber p1,ClarionString p2,ClarionView p3,ClarionQueue p4,Relationmanager p5,Windowmanager p6,Errorclass p7,ClarionNumber p8,ClarionNumber p9)
	{
		init(p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,Clarion.newNumber(0));
	}
	public void init(ClarionObject p0,ClarionNumber p1,ClarionString p2,ClarionView p3,ClarionQueue p4,Relationmanager p5,Windowmanager p6,Errorclass p7,ClarionNumber p8)
	{
		init(p0,p1,p2,p3,p4,p5,p6,p7,p8,Clarion.newNumber(1));
	}
	public void init(ClarionObject p0,ClarionNumber p1,ClarionString p2,ClarionView p3,ClarionQueue p4,Relationmanager p5,Windowmanager p6,Errorclass p7)
	{
		init(p0,p1,p2,p3,p4,p5,p6,p7,Clarion.newNumber(1));
	}
	public void init(ClarionObject usefield,ClarionNumber fieldid,ClarionString pos,ClarionView v,ClarionQueue q,Relationmanager relmgr,Windowmanager wm,Errorclass errmgr,ClarionNumber autoadd,ClarionNumber autosync,ClarionNumber casesense)
	{
		super.init(fieldid.like(),pos,v,q,relmgr,wm);
		this.usefield.setReferenceValue(usefield);
		this.errmgr=errmgr;
		this.autoaddflag.setValue(autoadd);
		this.syncronizeviewflag.setValue(autosync);
		this.casesensitiveflag.setValue(casesense);
		this.entrycompletion.setValue(Constants.TRUE);
		this.removeduplicatesflag.setValue(Constants.FALSE);
	}
	public void kill()
	{
		this.usefield.setReferenceValue(null);
		super.kill();
	}
	public ClarionNumber keyvalid()
	{
		if (!(CWin.keyChar()!=0)) {
			return Clarion.newNumber(Constants.FALSE);
		}
		if ((CWin.keyState() & 0x400+0x200)!=0) {
			return Clarion.newNumber(Constants.FALSE);
		}
		if (CRun.inlist(String.valueOf(CWin.keyCode()),new ClarionString[] {Clarion.newString(String.valueOf(Constants.LEFTKEY)),Clarion.newString(String.valueOf(Constants.RIGHTKEY)),Clarion.newString(String.valueOf(Constants.SHIFTLEFT)),Clarion.newString(String.valueOf(Constants.SHIFTRIGHT))}).boolValue()) {
			return Clarion.newNumber(Constants.FALSE);
		}
		return Clarion.newNumber(Constants.TRUE);
	}
	public ClarionNumber resetqueue()
	{
		return resetqueue(Clarion.newNumber(0));
	}
	public ClarionNumber resetqueue(ClarionNumber force)
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		i.setValue(super.resetqueue(force.like()));
		if (i.boolValue()) {
			this.listqueue.get(i);
			CRun._assert(!(CError.errorCode()!=0));
			this.displayfields.list.get(1);
			CRun._assert(!(CError.errorCode()!=0));
			this.usefield.setValue(this.displayfields.list.right);
		}
		return i.like();
	}
	public void resetfromlist()
	{
		ClarionNumber s=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		s.setValue(CWin.choice(this.listcontrol.intValue()));
		if (s.boolValue()) {
			this.listqueue.get(s);
			CRun._assert(!(CError.errorCode()!=0));
			this.reset();
			this.view.reset(this.viewposition);
			if (this.next().equals(Level.BENIGN)) {
				this.displayfields.list.get(1);
				this.usefield.setValue(this.displayfields.list.left);
				this.updatefields.assignlefttoright();
				this.allowreset.setValue(Constants.TRUE);
			}
			else {
				this.updatefields.clearright();
			}
			this.close();
		}
		else {
			this.updatefields.clearright();
		}
	}
	public void takeaccepted()
	{
		ClarionNumber qm=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		if (Clarion.newNumber(CWin.field()).equals(this.entryfield) && !Clarion.getControl(0).getProperty(Prop.ACCEPTALL).boolValue()) {
			this.usefield.setValue(Clarion.getControl(this.entryfield).getProperty(Prop.SCREENTEXT));
			qm.setValue(this.getqueuematch(this.usefield.getString()));
			if (qm.equals(0)) {
				if (!this.ask().equals(Level.BENIGN)) {
					CWin.select(this.entryfield.intValue());
					this.usefield.clear();
					return;
				}
				this.updatefields.assignlefttoright();
				this.resetqueue(Clarion.newNumber(1));
				qm.setValue(this.getqueuematch(this.usefield.getString()));
			}
			Clarion.getControl(this.listfield).setClonedProperty(Prop.SELECTED,qm);
			this.resetfromlist();
		}
	}
	public void takenewselection()
	{
		this.takenewselection(Clarion.newNumber(CWin.field()));
	}
	public void takenewselection(ClarionNumber field)
	{
		ClarionString currententry=Clarion.newString(256).setEncoding(ClarionString.CSTRING);
		ClarionNumber s=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		{
			ClarionNumber case_1=field;
			boolean case_1_break=false;
			if (case_1.equals(this.entryfield)) {
				if (this.entrycompletion.boolValue()) {
					if (this.keyvalid().boolValue()) {
						if (!this.econ.boolValue()) {
							if (!Clarion.getControl(this.entryfield).getProperty(Prop.SELSTART).equals(Clarion.getControl(this.entryfield).getProperty(Prop.SELEND)) || Clarion.getControl(this.entryfield).getProperty(Prop.SCREENTEXT).getString().len()==0) {
								this.econ.setValue(Constants.TRUE);
							}
						}
						if (this.econ.boolValue()) {
							if (CWin.keyCode()==Constants.BSKEY) {
								currententry.setValue(Abdrops.takenewselection_number_lastentry.equals("") ? Clarion.newString("") : Abdrops.takenewselection_number_lastentry.sub(1,Abdrops.takenewselection_number_lastentry.len()-1));
							}
							else {
								currententry.setValue(Clarion.getControl(this.entryfield).getProperty(Prop.SCREENTEXT).getString().sub(1,Clarion.getControl(this.entryfield).getProperty(Prop.SELSTART).subtract(1).intValue()));
							}
							if (!currententry.equals(Abdrops.takenewselection_number_lastentry)) {
								if (currententry.boolValue()) {
									s.setValue(this.getqueuematch(currententry.like()));
									if (s.boolValue()) {
										this.displayfields.list.get(1);
										CRun._assert(!(CError.errorCode()!=0));
										this.usefield.setValue(this.displayfields.list.right);
										Clarion.getControl(this.entryfield).setClonedProperty(Prop.SCREENTEXT,this.usefield);
										Clarion.getControl(this.entryfield).setProperty(Prop.SELSTART,currententry.len()+1);
										Clarion.getControl(this.entryfield).setProperty(Prop.SELEND,this.usefield.getString().clip().len());
										Clarion.getControl(this.listfield).setClonedProperty(Prop.SELECTED,s);
										this.updatefields.assignlefttoright();
										if (this.syncronizeviewflag.boolValue()) {
											this.resetfromlist();
										}
									}
									else {
										CWin.change(this.listcontrol.intValue(),Clarion.getControl(this.entryfield).getProperty(Prop.SCREENTEXT));
										this.econ.setValue(Constants.FALSE);
									}
								}
								Abdrops.takenewselection_number_lastentry.setValue(currententry);
							}
						}
						else {
							this.econ.setValue(Constants.TRUE);
						}
					}
					else {
						this.econ.setValue(Constants.FALSE);
					}
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(this.listfield)) {
				this.resetfromlist();
				case_1_break=true;
			}
		}
	}
	public void takeevent()
	{
		ClarionNumber qm=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		super.takeevent();
		{
			int case_1=CWin.event();
			boolean case_1_break=false;
			if (case_1==Event.OPENWINDOW) {
				this.entryfield.setValue(this.listcontrol);
				this.listfield.setValue(this.listcontrol.add(1000));
				Clarion.getControl(this.listcontrol).setClonedProperty(Prop.LISTFEQ,this.listfield);
				this.buttonfield.setValue(this.listcontrol.add(2000));
				Clarion.getControl(this.listcontrol).setClonedProperty(Prop.BUTTONFEQ,this.buttonfield);
				if (this.entrycompletion.boolValue()) {
					Clarion.getControl(this.entryfield).setProperty(Prop.IMM,Constants.TRUE);
					Clarion.getControl(this.listcontrol).setProperty(Prop.AUTO,Constants.FALSE);
				}
				Clarion.getControl(this.listfield).setProperty(Prop.IMM,Constants.FALSE);
				case_1_break=true;
			}
			if (!case_1_break && case_1==Event.SELECTED) {
				if (Clarion.newNumber(CWin.field()).equals(this.listcontrol)) {
					this.econ.setValue(this.entrycompletion);
				}
				case_1_break=true;
			}
		}
	}
	public ClarionNumber uniqueposition()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.LONG);
		i.setValue(this.listqueue.getPosition());
		if (CError.errorCode()==0) {
			return Clarion.newNumber(0);
		}
		return i.like();
	}
}
