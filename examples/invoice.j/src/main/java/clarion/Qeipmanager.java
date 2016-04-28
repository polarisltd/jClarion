package clarion;

import clarion.Eipmanager;
import clarion.Querylistvisual;
import clarion.Valuelist;
import clarion.equates.Button;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.equates.Proplist;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CError;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

public class Qeipmanager extends Eipmanager
{
	public Valuelist q;
	public Querylistvisual visual;
	public Qeipmanager()
	{
		q=null;
		visual=null;
	}

	public void clearColumn()
	{
		if (this.lastColumn.boolValue()) {
			CWin.update();
			this.fields.assignRightToLeft();
			this.q.put();
			CRun._assert(!(CError.errorCode()!=0));
		}
		super.clearColumn();
	}
	public ClarionNumber init()
	{
		ClarionNumber rv=Clarion.newNumber().setEncoding(ClarionNumber.BYTE);
		this.q.get(CWin.choice(this.listControl.intValue()));
		{
			ClarionNumber case_1=this.req;
			boolean case_1_break=false;
			if (case_1.equals(Constants.INSERTRECORD)) {
				this.q.clear();
				this.q.add(this.q.getPointer()+1);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.DELETERECORD)) {
				this.q.delete();
				CRun._assert(!(CError.errorCode()!=0));
				this.response.setValue(Constants.REQUESTCOMPLETED);
				return Clarion.newNumber(Level.FATAL);
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Constants.CHANGERECORD)) {
				if (CWin.keyCode()==Constants.MOUSELEFT2) {
					this.column.setValue(Clarion.getControl(this.listControl).getProperty(Proplist.MOUSEUPFIELD));
				}
				case_1_break=true;
			}
			if (!case_1_break) {
				CRun._assert(0!=0);
			}
		}
		rv.setValue(super.init());
		Clarion.getControl(this.visual.fldsEIP.feq).setProperty(Prop.FROM,this.visual.flds.getString());
		Clarion.getControl(this.visual.opsEIP.feq).setProperty(Prop.FROM,this.visual.ops.getString());
		Clarion.getControl(this.visual.fldsEIP.feq).setProperty(Prop.VSCROLL,1);
		Clarion.getControl(this.visual.opsEIP.feq).setProperty(Prop.VSCROLL,1);
		{
			ClarionNumber case_2=this.req;
			boolean case_2_break=false;
			if (case_2.equals(Constants.INSERTRECORD)) {
				CWin.display(this.listControl.intValue());
				CWin.select(this.listControl,this.q.getPointer());
				this.column.setValue(1);
				case_2_break=true;
			}
			if (!case_2_break && case_2.equals(Constants.DELETERECORD)) {
				case_2_break=true;
			}
			if (!case_2_break && case_2.equals(Constants.CHANGERECORD)) {
				this.fields.assignLeftToRight();
				this.visual.flds.value.setValue(Clarion.getControl(this.visual.fldsEIP.feq).getProperty(Prop.VALUE));
				this.visual.flds.get(this.visual.flds.ORDER().ascend(this.visual.flds.value));
				Clarion.getControl(this.visual.fldsEIP.feq).setProperty(Prop.SELSTART,this.visual.flds.getPointer());
				this.visual.ops.value.setValue(Clarion.getControl(this.visual.opsEIP.feq).getProperty(Prop.VALUE));
				this.visual.ops.get(this.visual.ops.ORDER().ascend(this.visual.ops.value));
				Clarion.getControl(this.visual.opsEIP.feq).setProperty(Prop.SELSTART,this.visual.ops.getPointer());
				if (CWin.keyCode()==Constants.MOUSELEFT2) {
					this.column.setValue(Clarion.getControl(this.listControl).getProperty(Proplist.MOUSEUPFIELD));
				}
				case_2_break=true;
			}
			if (!case_2_break) {
				CRun._assert(0!=0);
			}
		}
		return rv.like();
	}
	public void takeCompleted(ClarionNumber force)
	{
		this.again.setValue(0);
		this.clearColumn();
		if (!this.q.field.boolValue() || !this.q.ops.boolValue()) {
			force.setValue(Button.NO);
		}
		{
			ClarionNumber case_1=force;
			boolean case_1_break=false;
			if (case_1.equals(Button.CANCEL)) {
				this.again.setValue(1);
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Button.NO)) {
				if (this.req.equals(Constants.INSERTRECORD)) {
					this.q.delete();
				}
				case_1_break=true;
			}
			if (!case_1_break && case_1.equals(Button.YES)) {
				this.q.put();
				this.response.setValue(Constants.REQUESTCOMPLETED);
				case_1_break=true;
			}
		}
		super.takeCompleted(force.like());
	}
	public ClarionNumber takeNewSelection()
	{
		this.clearColumn();
		return (this.q.getPointer()!=CWin.choice(this.listControl.intValue()) ? Clarion.newNumber(Level.FATAL) : super.takeNewSelection()).getNumber();
	}
	public ClarionNumber takeEvent()
	{
		if (CWin.event()==Event.ALERTKEY) {
			if (CWin.keyCode()==Constants.MOUSERIGHT) {
				this.visual.updateControl(this.q.field.like());
			}
		}
		return super.takeEvent();
	}
}
