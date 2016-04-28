package clarion.abtoolba;

import clarion.Windowcomponent;
import clarion.abbrowse.Browseclass;
import clarion.abtoolba.equates.Mtoolbar;
import clarion.abwindow.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.equates.Toolbar;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CWin;

@SuppressWarnings("all")
public class Browsetoolbarclass
{
	public Browseclass browse=null;
	public Windowmanager window=null;
	public ClarionArray<ClarionNumber> button=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED).dim(Toolbar.LAST+1-Toolbar.FIRST);

	private static class _Windowcomponent_Impl extends Windowcomponent
	{
		private Browsetoolbarclass _owner;
		public _Windowcomponent_Impl(Browsetoolbarclass _owner)
		{
			this._owner=_owner;
		}
		public void kill()
		{
		}
		public void reset(ClarionNumber force)
		{
			_owner.resetfrombrowse();
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
			_owner.resetfrombrowse();
		}
	}
	private Windowcomponent _Windowcomponent_inst;
	public Windowcomponent windowcomponent()
	{
		if (_Windowcomponent_inst==null) _Windowcomponent_inst=new _Windowcomponent_Impl(this);
		return _Windowcomponent_inst;
	}
	public Browsetoolbarclass()
	{
		browse=null;
		window=null;
		button=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED).dim(Toolbar.LAST+1-Toolbar.FIRST);
	}

	public void init(Windowmanager window,Browseclass browse)
	{
		ClarionNumber index=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		this.window=window;
		this.browse=browse;
		final int loop_1=Toolbar.LAST;for (index.setValue(Toolbar.FIRST);index.compareTo(loop_1)<=0;index.increment(1)) {
			this.button.get(index.subtract(Mtoolbar.BASE).intValue()).setValue(0);
		}
	}
	public void initmisc(ClarionNumber history,ClarionNumber help)
	{
		this.button.get(Toolbar.HISTORY-Mtoolbar.BASE).setValue(history);
		this.button.get(Toolbar.HELP-Mtoolbar.BASE).setValue(help);
	}
	public void initbrowse(ClarionNumber insert,ClarionNumber change,ClarionNumber delete,ClarionNumber select)
	{
		this.button.get(Toolbar.INSERT-Mtoolbar.BASE).setValue(insert);
		this.button.get(Toolbar.CHANGE-Mtoolbar.BASE).setValue(change);
		this.button.get(Toolbar.DELETE-Mtoolbar.BASE).setValue(delete);
		this.button.get(Toolbar.SELECT-Mtoolbar.BASE).setValue(select);
	}
	public void initvcr(ClarionNumber top,ClarionNumber bottom,ClarionNumber pageup,ClarionNumber pagedown,ClarionNumber up,ClarionNumber down,ClarionNumber locate)
	{
		this.button.get(Toolbar.BOTTOM-Mtoolbar.BASE).setValue(bottom);
		this.button.get(Toolbar.TOP-Mtoolbar.BASE).setValue(top);
		this.button.get(Toolbar.UP-Mtoolbar.BASE).setValue(up);
		this.button.get(Toolbar.DOWN-Mtoolbar.BASE).setValue(down);
		this.button.get(Toolbar.PAGEUP-Mtoolbar.BASE).setValue(pageup);
		this.button.get(Toolbar.PAGEDOWN-Mtoolbar.BASE).setValue(pagedown);
		this.button.get(Toolbar.LOCATE-Mtoolbar.BASE).setValue(locate);
	}
	public void resetfrombrowse()
	{
		this.resetbutton(Clarion.newNumber(Toolbar.SELECT),this.browse.selectcontrol.like());
		this.resetbutton(Clarion.newNumber(Toolbar.INSERT),this.browse.insertcontrol.like());
		this.resetbutton(Clarion.newNumber(Toolbar.CHANGE),this.browse.changecontrol.like());
		this.resetbutton(Clarion.newNumber(Toolbar.DELETE),this.browse.deletecontrol.like());
		this.resetbutton(Clarion.newNumber(Toolbar.HISTORY),Clarion.newNumber(0));
		this.resetbutton(Clarion.newNumber(Toolbar.HELP),Clarion.newNumber(0));
		this.resetbutton(Clarion.newNumber(Toolbar.LOCATE),this.browse.querycontrol.like());
	}
	public ClarionNumber takeevent()
	{
		ClarionNumber browsefeq=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		browsefeq.setValue(this.browse.ilc.getcontrol());
		{
			int case_1=CWin.accepted();
			boolean case_1_break=false;
			if (case_1==0) {
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.button.get(Toolbar.INSERT-Mtoolbar.BASE))) {
				CWin.post(Event.ACCEPTED,this.browse.insertcontrol.intValue());
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.button.get(Toolbar.CHANGE-Mtoolbar.BASE))) {
				CWin.post(Event.ACCEPTED,this.browse.changecontrol.intValue());
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.button.get(Toolbar.DELETE-Mtoolbar.BASE))) {
				CWin.post(Event.ACCEPTED,this.browse.deletecontrol.intValue());
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.button.get(Toolbar.SELECT-Mtoolbar.BASE))) {
				CWin.post(Event.ACCEPTED,this.browse.selectcontrol.intValue());
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.button.get(Toolbar.BOTTOM-Mtoolbar.BASE))) {
				CWin.post(Event.SCROLLBOTTOM,browsefeq.intValue());
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.button.get(Toolbar.TOP-Mtoolbar.BASE))) {
				CWin.post(Event.SCROLLTOP,browsefeq.intValue());
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.button.get(Toolbar.PAGEDOWN-Mtoolbar.BASE))) {
				CWin.post(Event.PAGEDOWN,browsefeq.intValue());
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.button.get(Toolbar.PAGEUP-Mtoolbar.BASE))) {
				CWin.post(Event.PAGEUP,browsefeq.intValue());
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.button.get(Toolbar.DOWN-Mtoolbar.BASE))) {
				CWin.post(Event.SCROLLDOWN,browsefeq.intValue());
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.button.get(Toolbar.UP-Mtoolbar.BASE))) {
				CWin.post(Event.SCROLLUP,browsefeq.intValue());
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.button.get(Toolbar.LOCATE-Mtoolbar.BASE))) {
				CWin.post(Event.LOCATE,browsefeq.intValue());
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.button.get(Toolbar.HISTORY-Mtoolbar.BASE))) {
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.button.get(Toolbar.HELP-Mtoolbar.BASE))) {
				CWin.pressKey(Constants.F1KEY);
				case_1_break=true;
			}
		}
		if (Clarion.newNumber(CWin.field()).equals(browsefeq) && CWin.event()==Event.NEWSELECTION) {
			this.resetfrombrowse();
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public void resetbutton(ClarionNumber toolbutton,ClarionNumber browsebutton)
	{
		ClarionNumber toolbuttonfeq=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		toolbuttonfeq.setValue(this.button.get(toolbutton.subtract(Mtoolbar.BASE).intValue()));
		if (toolbuttonfeq.boolValue()) {
			if (!browsebutton.boolValue() || Clarion.getControl(browsebutton).getProperty(Prop.DISABLE).boolValue()) {
				CWin.disable(toolbuttonfeq.intValue());
			}
			else {
				CWin.enable(toolbuttonfeq.intValue());
			}
			if (!browsebutton.boolValue() || Clarion.getControl(browsebutton).getProperty(Prop.HIDE).boolValue()) {
				CWin.hide(toolbuttonfeq.intValue());
			}
			else {
				CWin.unhide(toolbuttonfeq.intValue());
			}
		}
	}
}
