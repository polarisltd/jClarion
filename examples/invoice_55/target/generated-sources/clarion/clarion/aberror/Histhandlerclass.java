package clarion.aberror;

import clarion.Errorhistorylist;
import clarion.Windowcomponent;
import clarion.aberror.Errorclass;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.equates.Proplist;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.ClarionWindow;
import org.jclarion.clarion.runtime.CMemory;
import org.jclarion.clarion.runtime.CRun;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Histhandlerclass
{
	public Errorclass err=null;
	public Errorhistorylist history=null;
	public ClarionNumber lbcolumns=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
	public ClarionWindow win=null;

	private static class _Windowcomponent_Impl extends Windowcomponent
	{
		private Histhandlerclass _owner;
		public _Windowcomponent_Impl(Histhandlerclass _owner)
		{
			this._owner=_owner;
		}
		public void kill()
		{
		}
		public void reset(ClarionNumber force)
		{
		}
		public ClarionNumber resetrequired()
		{
			return Clarion.newNumber(Constants.FALSE);
		}
		public void setalerts()
		{
		}
		public ClarionNumber takeevent()
		{
			return _owner.takeevent();
		}
		public void update()
		{
		}
		public void updatewindow()
		{
			CWin.display(Constants.LISTFEQ);
		}
	}
	private Windowcomponent _Windowcomponent_inst;
	public Windowcomponent windowcomponent()
	{
		if (_Windowcomponent_inst==null) _Windowcomponent_inst=new _Windowcomponent_Impl(this);
		return _Windowcomponent_inst;
	}
	public Histhandlerclass()
	{
		err=null;
		history=null;
		lbcolumns=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		win=null;
	}

	public ClarionString _vlbproc(ClarionNumber rownum,ClarionNumber colnum)
	{
		return this.vlbproc(rownum.like(),colnum.like());
	}
	public void init(ClarionWindow win,Errorclass err,Errorhistorylist history)
	{
		this.win=win;
		this.err=err;
		this.history=history;
	}
	public ClarionNumber takeevent()
	{
		ClarionNumber _i_number=Clarion.newNumber();
		{
			int case_1=CWin.event();
			if (case_1==Event.OPENWINDOW) {
				Clarion.getControl(Constants.LISTFEQ).setProperty(Prop.SELECTED,this.history.records());
				for (_i_number.setValue(1);_i_number.compareTo(100)<=0;_i_number.increment(1)) {
					if (this.win.getControl(Constants.LISTFEQ).getProperty(Proplist.WIDTH,_i_number).equals("")) {
						break;
					}
				}
				CRun._assert(!_i_number.equals(100));
				this.lbcolumns.setValue(_i_number);
				this.win.getControl(Constants.LISTFEQ).setProperty(Prop.VLBVAL,CMemory.address(this));
				this.win.getControl(Constants.LISTFEQ).setProperty(Prop.VLBPROC,CMemory.getAddressPrototype("_VLBProc"));
			}
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionString vlbproc(ClarionNumber rownum,ClarionNumber colnum)
	{
		{
			ClarionNumber case_1=rownum;
			boolean case_1_break=false;
			if (case_1.equals(-1)) {
				return Clarion.newString(String.valueOf(this.history.records()));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(-2)) {
				return this.lbcolumns.getString();
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(-3)) {
				return Clarion.newString(String.valueOf(Constants.TRUE));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break) {
				this.history.get(rownum);
				{
					ClarionNumber case_2=colnum;
					boolean case_2_break=false;
					if (case_2.equals(1)) {
						return this.history.txt.like();
						// UNREACHABLE! :case_2_break=true;
					}
					if (!case_2_break && case_2.equals(2)) {
						return this.history.category.like();
						// UNREACHABLE! :case_2_break=true;
					}
				}
			}
		}
		return Clarion.newString("");
	}
}
