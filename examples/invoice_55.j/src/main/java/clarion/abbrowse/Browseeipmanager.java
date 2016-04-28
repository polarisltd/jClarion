package clarion.abbrowse;

import clarion.abbrowse.Browseclass;
import clarion.abeip.Eipmanager;
import clarion.equates.Button;
import clarion.equates.Constants;
import clarion.equates.Eipaction;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Msg;
import clarion.equates.Prop;
import clarion.equates.Proplist;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Browseeipmanager extends Eipmanager
{
	public Browseclass bc=null;
	public Browseeipmanager()
	{
		bc=null;
	}

	public void clearcolumn()
	{
		if (this.lastcolumn.boolValue()) {
			CWin.update();
			this.bc.listqueue.update();
			CRun._assert(!(CError.errorCode()!=0));
		}
		super.clearcolumn();
	}
	public ClarionNumber init()
	{
		ClarionNumber retval=Clarion.newNumber(Constants.REQUESTCANCELLED).setEncoding(ClarionNumber.BYTE);
		ClarionNumber atend=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.bc.currentchoice.setValue(CWin.choice(this.listcontrol.intValue()));
		{
			ClarionNumber case_1=this.req;
			boolean case_1_break=false;
			if (case_1.equals(Constants.INSERTRECORD)) {
				if (this.bc.listqueue.records().boolValue()) {
					if (this.insert.equals(Eipaction.APPEND)) {
						this.bc.scrollend(Clarion.newNumber(Event.SCROLLBOTTOM));
					}
					if (this.bc.primerecord().boolValue()) {
						return Clarion.newNumber(Level.FATAL);
					}
					this.bc.primary.save();
					atend.setValue(this.bc.currentchoice.equals(this.bc.listqueue.records()) ? 1 : 0);
					this.bc.currentchoice.setValue(this.insert.equals(Eipaction.BEFORE) ? this.bc.currentchoice : this.bc.currentchoice.add(1));
					if (this.bc.listqueue.records().compareTo(this.bc.lastitems)>=0) {
						if (atend.boolValue()) {
							this.bc.listqueue.fetch(Clarion.newNumber(1));
							this.bc.currentchoice.decrement(1);
						}
						else {
							this.bc.listqueue.fetch(this.bc.listqueue.records());
						}
						this.bc.listqueue.delete();
					}
				}
				else {
					if (this.bc.primerecord().boolValue()) {
						return Clarion.newNumber(Level.FATAL);
					}
					this.bc.primary.save();
					this.bc.currentchoice.setValue(1);
				}
				this.bc.setqueuerecord();
				this.bc.listqueue.insert(this.bc.currentchoice.like());
				CRun._assert(!(CError.errorCode()!=0));
				CWin.display(this.listcontrol.intValue());
				CWin.select(this.listcontrol.intValue(),this.bc.currentchoice.intValue());
				this.column.setValue(1);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.DELETERECORD)) {
				retval.setValue(this.bc.primary.delete().equals(Level.BENIGN) ? Clarion.newNumber(Constants.REQUESTCOMPLETED) : Clarion.newNumber(Constants.REQUESTCANCELLED));
				this.response.setValue(retval);
				return Clarion.newNumber(Level.FATAL);
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.CHANGERECORD)) {
				this.bc.setqueuerecord();
				this.bc.listqueue.update();
				this.bc.primary.save();
				if (CWin.keyCode()==Constants.MOUSELEFT2) {
					this.column.setValue(Clarion.getControl(this.listcontrol).getProperty(Proplist.MOUSEUPFIELD));
				}
				case_1_break=true;
			}
			if (!case_1_break) {
				CRun._assert(0!=0);
			}
		}
		this.bc.listqueue.fetch(this.bc.currentchoice.like());
		Clarion.getControl(this.listcontrol).setProperty(Prop.ALRT,Constants.MOUSELEFT2INDEX,0);
		return super.init();
	}
	public ClarionNumber kill()
	{
		this.bc.resetfromask(this.req,this.response);
		return super.kill();
	}
	public void takecompleted(ClarionNumber force)
	{
		ClarionNumber saveans=Clarion.newNumber().setEncoding(ClarionNumber.UNSIGNED);
		ClarionNumber id=Clarion.newNumber().setEncoding(ClarionNumber.USHORT);
		this.again.setValue(0);
		this.clearcolumn();
		saveans.setValue(force.equals(0) ? Clarion.newNumber(Button.YES) : force);
		if (this.fields.equal().boolValue()) {
			saveans.setValue(Button.NO);
		}
		else {
			if (!force.boolValue()) {
				saveans.setValue(this.errors.message(Clarion.newNumber(Msg.SAVERECORD),Clarion.newNumber(Button.YES+Button.NO+Button.CANCEL),Clarion.newNumber(Button.YES)));
			}
		}
		force.setValue(0);
		this.response.setValue(Constants.REQUESTCANCELLED);
		{
			ClarionNumber case_1=saveans;
			boolean case_1_break=false;
			if (case_1.equals(Button.CANCEL)) {
				this.again.setValue(1);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Button.NO)) {
				if (this.req.equals(Constants.INSERTRECORD)) {
					this.bc.listqueue.delete();
					if (this.bc.currentchoice.boolValue() && !this.insert.equals(Eipaction.BEFORE)) {
						this.bc.currentchoice.decrement(1);
					}
					this.bc.primary.me.cancelautoinc();
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Button.YES)) {
				id.setValue(this.bc.primary.me.savebuffer());
				this.bc.updatebuffer();
				if (!(this.req.equals(Constants.INSERTRECORD) ? this.bc.primary.me.insert() : this.bc.primary.update()).equals(Level.BENIGN)) {
					this.again.setValue(1);
				}
				else {
					this.response.setValue(Constants.REQUESTCOMPLETED);
				}
				this.bc.primary.me.restorebuffer(id,this.again.like());
				this.bc.view.flush();
				case_1_break=true;
			}
		}
		super.takecompleted(force.like());
	}
	public ClarionNumber takenewselection()
	{
		if (Clarion.newNumber(CWin.field()).equals(this.listcontrol)) {
			if (Clarion.newNumber(CWin.choice(this.listcontrol.intValue())).equals(this.bc.currentchoice)) {
				return super.takenewselection();
			}
			else {
				this.takefocusloss();
				if (this.again.boolValue()) {
					CWin.select(this.listcontrol.intValue(),this.bc.currentchoice.intValue());
					return Clarion.newNumber(Level.BENIGN);
				}
				else {
					this.bc.currentchoice.setValue(CWin.choice(this.listcontrol.intValue()));
					this.response.setValue(Constants.REQUESTCANCELLED);
					return Clarion.newNumber(Level.FATAL);
				}
			}
		}
		return Clarion.newNumber();
	}
}
