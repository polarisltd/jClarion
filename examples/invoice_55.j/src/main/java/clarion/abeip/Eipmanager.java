package clarion.abeip;

import clarion.Editqueue;
import clarion.abeip.Editclass;
import clarion.abeip.Editentryclass;
import clarion.abutil.Fieldpairsclass;
import clarion.abwindow.Windowmanager;
import clarion.equates.Button;
import clarion.equates.Color;
import clarion.equates.Constants;
import clarion.equates.Create;
import clarion.equates.Editaction;
import clarion.equates.Eipaction;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.equates.Proplist;
import clarion.equates.Vcr;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Eipmanager extends Windowmanager
{
	public ClarionNumber again=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber arrow=null;
	public ClarionNumber column=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
	public ClarionNumber enter=null;
	public Editqueue eq=null;
	public Fieldpairsclass fields=null;
	public ClarionNumber focusloss=null;
	public ClarionNumber insert=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber listcontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
	public ClarionNumber lastcolumn=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber repost=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
	public ClarionNumber repostfield=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
	public ClarionNumber req=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber seekforward=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
	public ClarionNumber tab=null;
	public Eipmanager()
	{
		again=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		arrow=null;
		column=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		enter=null;
		eq=null;
		fields=null;
		focusloss=null;
		insert=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		listcontrol=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		lastcolumn=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		repost=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		repostfield=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		req=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		seekforward=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		tab=null;
	}

	public void addcontrol(Editclass p0,ClarionNumber p1)
	{
		addcontrol(p0,p1,Clarion.newNumber(0));
	}
	public void addcontrol(ClarionNumber p1)
	{
		addcontrol((Editclass)null,p1);
	}
	public void addcontrol(Editclass ec,ClarionNumber id,ClarionNumber free)
	{
		this.eq.control.set(ec);
		this.eq.field.setValue(id);
		this.eq.freeup.setValue(free);
		this.eq.add(this.eq.ORDER().ascend(this.eq.field));
		CRun._assert(!(CError.errorCode()!=0));
	}
	public void clearcolumn()
	{
		if (this.lastcolumn.boolValue()) {
			Clarion.getControl(this.listcontrol).setProperty(Prop.EDIT,this.column,0);
			this.lastcolumn.setValue(0);
		}
	}
	public ClarionNumber init()
	{
		if (this.column.equals(0)) {
			this.column.setValue(1);
		}
		this.lastcolumn.setValue(0);
		this.repost.setValue(0);
		this.repostfield.setValue(0);
		CRun._assert(!(this.eq==null));
		this.eq.field.setValue(1);
		this.initcontrols();
		this.resetcolumn();
		return Clarion.newNumber(Level.BENIGN);
	}
	public void initcontrols()
	{
		CRun._assert(!(this.fields==null));
		while (Clarion.getControl(this.listcontrol).getProperty(Proplist.EXISTS,this.eq.field).boolValue()) {
			this.eq.get(this.eq.ORDER().ascend(this.eq.field));
			if (CError.errorCode()!=0) {
				this.eq.control.set(new Editentryclass());
				this.addcontrol(this.eq.control.get(),this.eq.field.like(),Clarion.newNumber(1));
			}
			this.fields.list.get(this.eq.field);
			CRun._assert(!(CError.errorCode()!=0));
			if (!(this.eq.control.get()==null)) {
				this.eq.control.get().init(this.eq.field.like(),this.listcontrol.like(),this.fields.list.right);
			}
			else {
				Clarion.getControl(this.listcontrol).setProperty(Proplist.TEXTCOLOR,this.eq.field,Color.GRAYTEXT);
			}
			this.eq.field.increment(1);
		}
	}
	public ClarionNumber kill()
	{
		ClarionNumber i=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		final int loop_1=this.eq.records();for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			this.eq.get(i);
			if (this.eq.control.get()==null) {
				Clarion.getControl(this.listcontrol).setProperty(Proplist.TEXTCOLOR,this.eq.field,Color.NONE);
			}
			else {
				this.eq.control.get().kill();
			}
		}
		Clarion.getControl(this.listcontrol).setProperty(Prop.ALRT,Constants.MOUSELEFT2INDEX,Constants.MOUSELEFT2);
		if (this.repost.boolValue()) {
			CWin.post(this.repost.intValue(),this.repostfield.intValue());
			this.repost.setValue(0);
		}
		return super.kill();
	}
	public void next()
	{
		ClarionNumber scanned=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		ClarionNumber lastcol=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		this.eq.get(this.eq.records());
		lastcol.setValue(this.eq.field);
		while (true) {
			this.eq.clear();
			this.eq.field.setValue(this.column);
			this.eq.get(this.eq.ORDER().ascend(this.eq.field));
			if (!(CError.errorCode()!=0) && this.getedit().boolValue()) {
				break;
			}
			if (this.seekforward.boolValue()) {
				if (this.column.compareTo(lastcol)>=0) {
					CRun._assert(!scanned.boolValue());
					this.seekforward.setValue(0);
					scanned.setValue(1);
				}
				else {
					this.column.increment(1);
				}
			}
			else {
				if (this.column.compareTo(1)<=0) {
					this.seekforward.setValue(1);
					CRun._assert(!scanned.boolValue());
					scanned.setValue(1);
				}
				else {
					this.column.decrement(1);
				}
			}
		}
		this.seekforward.setValue(0);
	}
	public ClarionNumber getedit()
	{
		return (this.eq.control.get()==null ? Clarion.newNumber(Constants.FALSE) : Clarion.newNumber(Constants.TRUE)).getNumber();
	}
	public void resetcolumn()
	{
		CWin.setKeyCode(0);
		this.next();
		if (!this.column.equals(this.lastcolumn)) {
			Clarion.getControl(this.listcontrol).setClonedProperty(Prop.EDIT,this.eq.field,this.eq.control.get().feq);
			CWin.select(this.eq.control.get().feq.intValue());
			this.lastcolumn.setValue(this.column);
		}
	}
	public ClarionNumber run(ClarionNumber req)
	{
		this.req.setValue(req);
		return this.run();
	}
	public void takeaction(ClarionNumber action)
	{
		ClarionNumber rem=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber savecol=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		{
			ClarionNumber case_1=action;
			boolean case_1_break=false;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1.equals(Editaction.FORWARD)) {
				this.clearcolumn();
				rem.setValue(this.column);
				this.column.increment(1);
				this.seekforward.setValue(1);
				this.next();
				if (!rem.equals(this.column)) {
					this.resetcolumn();
				}
				else {
					{
						ClarionObject case_2=this.tab==null ? Clarion.newNumber(Eipaction.ALWAYS) : Clarion.newNumber(this.tab.intValue() & Eipaction.SAVE);
						boolean case_2_break=false;
						if (case_2.equals(Eipaction.ALWAYS)) {
							this.takecompleted(Clarion.newNumber(Button.YES));
							case_2_break=true;
						}
						if (!case_2_break && case_2.equals(Eipaction.NEVER)) {
							this.takecompleted(Clarion.newNumber(Button.NO));
							case_2_break=true;
						}
						if (!case_2_break) {
							this.takecompleted(Clarion.newNumber(0));
						}
					}
					if (!(this.tab==null) && (this.tab.intValue() & Eipaction.REMAIN)!=0 && !this.again.boolValue()) {
						this.vcrrequest.setValue(Vcr.FORWARD);
					}
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Editaction.BACKWARD)) {
				if (this.column.compareTo(1)>0) {
					this.clearcolumn();
					rem.setValue(this.column);
					this.column.decrement(1);
					this.resetcolumn();
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Editaction.NEXT)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Editaction.PREVIOUS)) {
				savecol.setValue(this.column);
				{
					ClarionObject case_3=this.arrow==null ? Clarion.newNumber(Eipaction.DEFAULT) : Clarion.newNumber(this.arrow.intValue() & Eipaction.SAVE);
					boolean case_3_break=false;
					boolean case_3_match=false;
					case_3_match=false;
					if (case_3.equals(Eipaction.ALWAYS)) {
						case_3_match=true;
					}
					if (case_3_match || case_3.equals(Eipaction.DEFAULT)) {
						this.takecompleted(Clarion.newNumber(Button.YES));
						case_3_break=true;
					}
					case_3_match=false;
					if (!case_3_break && case_3.equals(Eipaction.NEVER)) {
						this.takecompleted(Clarion.newNumber(Button.NO));
						case_3_break=true;
					}
					if (!case_3_break) {
						this.takecompleted(Clarion.newNumber(0));
					}
				}
				if (!(this.arrow==null) && (this.arrow.intValue() & Eipaction.REMAIN)!=0 && !this.again.boolValue()) {
					this.vcrrequest.setValue(action.equals(Editaction.NEXT) ? Clarion.newNumber(Vcr.FORWARD) : Clarion.newNumber(Vcr.BACKWARD));
				}
				if (!(this.arrow==null) && (this.arrow.intValue() & Eipaction.RETAINCOLUMN)!=0 && !this.again.boolValue()) {
					this.column.setValue(savecol);
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Editaction.COMPLETE)) {
				{
					ClarionObject case_4=this.enter==null ? Clarion.newNumber(Eipaction.DEFAULT) : Clarion.newNumber(this.enter.intValue() & Eipaction.SAVE);
					boolean case_4_break=false;
					boolean case_4_match=false;
					case_4_match=false;
					if (case_4.equals(Eipaction.ALWAYS)) {
						case_4_match=true;
					}
					if (case_4_match || case_4.equals(Eipaction.DEFAULT)) {
						this.takecompleted(Clarion.newNumber(Button.YES));
						case_4_break=true;
					}
					case_4_match=false;
					if (!case_4_break && case_4.equals(Eipaction.NEVER)) {
						this.takecompleted(Clarion.newNumber(Button.NO));
						case_4_break=true;
					}
					if (!case_4_break) {
						this.takecompleted(Clarion.newNumber(0));
					}
				}
				if (!(this.enter==null) && (this.enter.intValue() & Eipaction.REMAIN)!=0 && !this.again.boolValue()) {
					this.vcrrequest.setValue(Vcr.FORWARD);
				}
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Editaction.CANCEL)) {
				this.takecompleted(Clarion.newNumber(Button.NO));
				case_1_break=true;
			}
		}
	}
	public void takecompleted(ClarionNumber force)
	{
		this.column.setValue(1);
		if (this.again.boolValue()) {
			this.resetcolumn();
		}
	}
	public ClarionNumber takeevent()
	{
		ClarionNumber rv=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		{
			int case_1=CWin.event();
			boolean case_1_break=false;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1==Event.SIZE) {
				case_1_match=true;
			}
			if (case_1_match || case_1==Event.ICONIZE) {
				case_1_match=true;
			}
			if (case_1_match || case_1==Event.MAXIMIZE) {
				return Clarion.newNumber(Level.NOTIFY);
				// UNREACHABLE! :case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1==Event.CLOSEDOWN) {
				case_1_match=true;
			}
			if (case_1_match || case_1==Event.CLOSEWINDOW) {
				case_1_match=true;
			}
			if (case_1_match || case_1==Event.SIZED) {
				this.takefocusloss();
				this.repost.setValue(CWin.event());
				return Clarion.newNumber(Level.FATAL);
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break) {
				this.again.setValue(1);
				rv.setValue(super.takeevent());
				return (rv.equals(Level.BENIGN) ? !this.again.equals(0) ? Clarion.newNumber(Level.BENIGN) : Clarion.newNumber(Level.FATAL) : rv).getNumber();
			}
		}
		return Clarion.newNumber();
	}
	public ClarionNumber takefieldevent()
	{
		ClarionNumber i=Clarion.newNumber(1).setEncoding(ClarionNumber.UNSIGNED);
		if (Clarion.newNumber(CWin.field()).equals(this.listcontrol)) {
			return Clarion.newNumber(Level.BENIGN);
		}
		final int loop_1=this.eq.records()+1;for (i.setValue(1);i.compareTo(loop_1)<=0;i.increment(1)) {
			if (!(this.eq.control.get()==null) && this.eq.control.get().feq.equals(CWin.field())) {
				this.takeaction(this.eq.control.get().takeevent(Clarion.newNumber(CWin.event())));
				return Clarion.newNumber(Level.BENIGN);
			}
			this.eq.get(i);
		}
		if (!Clarion.getControl(CWin.field()).getProperty(Prop.TYPE).equals(Create.BUTTON) || CWin.event()!=Event.SELECTED) {
			this.repost.setValue(CWin.event());
			this.repostfield.setValue(CWin.field());
			this.takefocusloss();
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public void takefocusloss()
	{
		{
			ClarionObject case_1=this.focusloss==null ? Clarion.newNumber(Eipaction.DEFAULT) : Clarion.newNumber(this.focusloss.intValue() & Eipaction.SAVE);
			boolean case_1_break=false;
			boolean case_1_match=false;
			case_1_match=false;
			if (case_1.equals(Eipaction.ALWAYS)) {
				case_1_match=true;
			}
			if (case_1_match || case_1.equals(Eipaction.DEFAULT)) {
				this.takecompleted(Clarion.newNumber(Button.YES));
				case_1_break=true;
			}
			case_1_match=false;
			if (!case_1_break && case_1.equals(Eipaction.NEVER)) {
				this.takecompleted(Clarion.newNumber(Button.NO));
				case_1_break=true;
			}
			if (!case_1_break) {
				this.takecompleted(Clarion.newNumber(0));
			}
		}
	}
	public ClarionNumber takenewselection()
	{
		if (Clarion.newNumber(CWin.field()).equals(this.listcontrol) && CWin.keyCode()==Constants.MOUSELEFT) {
			this.clearcolumn();
			this.column.setValue(Clarion.getControl(this.listcontrol).getProperty(Proplist.MOUSEUPFIELD));
			this.resetcolumn();
		}
		return Clarion.newNumber(Level.BENIGN);
	}
}
