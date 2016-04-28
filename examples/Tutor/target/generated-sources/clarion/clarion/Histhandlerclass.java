package clarion;

import clarion.Errorclass;
import clarion.Errorhistorylist;
import clarion.Windowcomponent;
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
import org.jclarion.clarion.runtime.CWin;

public class Histhandlerclass
{
	public Errorclass err;
	public Errorhistorylist history;
	public ClarionNumber lBColumns;
	public ClarionWindow win;

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
		public ClarionNumber resetRequired()
		{
			return Clarion.newNumber(Constants.FALSE);
		}
		public void setAlerts()
		{
		}
		public ClarionNumber takeEvent()
		{
			return _owner.takeEvent();
		}
		public void update()
		{
		}
		public void updateWindow()
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
		lBColumns=Clarion.newNumber().setEncoding(ClarionNumber.SHORT);
		win=null;
	}

	public ClarionString _vLBProc(ClarionNumber rowNum,ClarionNumber colNum)
	{
		return this.vLBProc(rowNum.like(),colNum.like());
	}
	public void init(ClarionWindow win,Errorclass err,Errorhistorylist history)
	{
		this.win=win;
		this.err=err;
		this.history=history;
	}
	public ClarionNumber takeEvent()
	{
		{
			int case_1=CWin.event();
			if (case_1==Event.OPENWINDOW) {
				Clarion.getControl(Constants.LISTFEQ).setProperty(Prop.SELECTED,this.history.records());
				this.lBColumns.setValue(this.win.getControl(Constants.LISTFEQ).getProperty(Proplist.EXISTS,0));
				this.win.getControl(Constants.LISTFEQ).setProperty(Prop.VLBVAL,CMemory.address(this));
				this.win.getControl(Constants.LISTFEQ).setProperty(Prop.VLBPROC,CMemory.getAddressPrototype("_VLBProc"));
			}
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public ClarionString vLBProc(ClarionNumber rowNum,ClarionNumber colNum)
	{
		{
			ClarionNumber case_1=rowNum;
			boolean case_1_break=false;
			if (case_1.equals(-1)) {
				return Clarion.newString(String.valueOf(this.history.records()));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(-2)) {
				return this.lBColumns.getString();
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break && case_1.equals(-3)) {
				return Clarion.newString(String.valueOf(Constants.TRUE));
				// UNREACHABLE! :case_1_break=true;
			}
			if (!case_1_break) {
				this.history.get(rowNum);
				{
					ClarionNumber case_2=colNum;
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
