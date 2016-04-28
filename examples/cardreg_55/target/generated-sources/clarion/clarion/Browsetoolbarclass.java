package clarion;

import clarion.Browseclass;
import clarion.Windowcomponent;
import clarion.Windowmanager;
import clarion.equates.Constants;
import clarion.equates.Event;
import clarion.equates.Level;
import clarion.equates.Prop;
import clarion.equates.Toolbar;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionArray;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.runtime.CWin;

public class Browsetoolbarclass
{
	public Browseclass browse;
	public Windowmanager window;
	public ClarionArray<ClarionNumber> button;

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
			_owner.resetFromBrowse();
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
			_owner.resetFromBrowse();
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
		for (index.setValue(Toolbar.FIRST);index.compareTo(Toolbar.LAST)<=0;index.increment(1)) {
			this.button.get(index.subtract(Toolbar.BASE).intValue()).setValue(0);
		}
	}
	public void initMisc(ClarionNumber history,ClarionNumber help)
	{
		this.button.get(Toolbar.HISTORY-Toolbar.BASE).setValue(history);
		this.button.get(Toolbar.HELP-Toolbar.BASE).setValue(help);
	}
	public void initBrowse(ClarionNumber insert,ClarionNumber change,ClarionNumber delete,ClarionNumber select)
	{
		this.button.get(Toolbar.INSERT-Toolbar.BASE).setValue(insert);
		this.button.get(Toolbar.CHANGE-Toolbar.BASE).setValue(change);
		this.button.get(Toolbar.DELETE-Toolbar.BASE).setValue(delete);
		this.button.get(Toolbar.SELECT-Toolbar.BASE).setValue(select);
	}
	public void initVCR(ClarionNumber top,ClarionNumber bottom,ClarionNumber pageUp,ClarionNumber pageDown,ClarionNumber up,ClarionNumber down,ClarionNumber locate)
	{
		this.button.get(Toolbar.BOTTOM-Toolbar.BASE).setValue(bottom);
		this.button.get(Toolbar.TOP-Toolbar.BASE).setValue(top);
		this.button.get(Toolbar.UP-Toolbar.BASE).setValue(up);
		this.button.get(Toolbar.DOWN-Toolbar.BASE).setValue(down);
		this.button.get(Toolbar.PAGEUP-Toolbar.BASE).setValue(pageUp);
		this.button.get(Toolbar.PAGEDOWN-Toolbar.BASE).setValue(pageDown);
		this.button.get(Toolbar.LOCATE-Toolbar.BASE).setValue(locate);
	}
	public void resetFromBrowse()
	{
		this.resetButton(Clarion.newNumber(Toolbar.SELECT),this.browse.selectControl.like());
		this.resetButton(Clarion.newNumber(Toolbar.INSERT),this.browse.insertControl.like());
		this.resetButton(Clarion.newNumber(Toolbar.CHANGE),this.browse.changeControl.like());
		this.resetButton(Clarion.newNumber(Toolbar.DELETE),this.browse.deleteControl.like());
		this.resetButton(Clarion.newNumber(Toolbar.HISTORY),Clarion.newNumber(0));
		this.resetButton(Clarion.newNumber(Toolbar.HELP),Clarion.newNumber(0));
		this.resetButton(Clarion.newNumber(Toolbar.LOCATE),this.browse.queryControl.like());
	}
	public ClarionNumber takeEvent()
	{
		ClarionNumber browseFeq=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		browseFeq.setValue(this.browse.ilc.getControl());
		{
			int case_1=CWin.accepted();
			boolean case_1_break=false;
			if (case_1==0) {
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.button.get(Toolbar.INSERT-Toolbar.BASE))) {
				CWin.post(Event.ACCEPTED,this.browse.insertControl.intValue());
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.button.get(Toolbar.CHANGE-Toolbar.BASE))) {
				CWin.post(Event.ACCEPTED,this.browse.changeControl.intValue());
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.button.get(Toolbar.DELETE-Toolbar.BASE))) {
				CWin.post(Event.ACCEPTED,this.browse.deleteControl.intValue());
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.button.get(Toolbar.SELECT-Toolbar.BASE))) {
				CWin.post(Event.ACCEPTED,this.browse.selectControl.intValue());
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.button.get(Toolbar.BOTTOM-Toolbar.BASE))) {
				CWin.post(Event.SCROLLBOTTOM,browseFeq.intValue());
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.button.get(Toolbar.TOP-Toolbar.BASE))) {
				CWin.post(Event.SCROLLTOP,browseFeq.intValue());
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.button.get(Toolbar.PAGEDOWN-Toolbar.BASE))) {
				CWin.post(Event.PAGEDOWN,browseFeq.intValue());
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.button.get(Toolbar.PAGEUP-Toolbar.BASE))) {
				CWin.post(Event.PAGEUP,browseFeq.intValue());
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.button.get(Toolbar.DOWN-Toolbar.BASE))) {
				CWin.post(Event.SCROLLDOWN,browseFeq.intValue());
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.button.get(Toolbar.UP-Toolbar.BASE))) {
				CWin.post(Event.SCROLLUP,browseFeq.intValue());
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.button.get(Toolbar.LOCATE-Toolbar.BASE))) {
				CWin.post(Event.LOCATE,browseFeq.intValue());
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.button.get(Toolbar.HISTORY-Toolbar.BASE))) {
				case_1_break=true;
			}
			if (!case_1_break && Clarion.newNumber(case_1).equals(this.button.get(Toolbar.HELP-Toolbar.BASE))) {
				CWin.pressKey(Constants.F1KEY);
				case_1_break=true;
			}
		}
		if (Clarion.newNumber(CWin.field()).equals(browseFeq) && CWin.event()==Event.NEWSELECTION) {
			this.resetFromBrowse();
		}
		return Clarion.newNumber(Level.BENIGN);
	}
	public void resetButton(ClarionNumber toolButton,ClarionNumber browseButton)
	{
		ClarionNumber toolButtonFeq=Clarion.newNumber().setEncoding(ClarionNumber.SIGNED);
		toolButtonFeq.setValue(this.button.get(toolButton.subtract(Toolbar.BASE).intValue()));
		if (toolButtonFeq.boolValue()) {
			if (!browseButton.boolValue() || Clarion.getControl(browseButton).getProperty(Prop.DISABLE).boolValue()) {
				CWin.disable(toolButtonFeq.intValue());
			}
			else {
				CWin.enable(toolButtonFeq.intValue());
			}
			if (!browseButton.boolValue() || Clarion.getControl(browseButton).getProperty(Prop.HIDE).boolValue()) {
				CWin.hide(toolButtonFeq.intValue());
			}
			else {
				CWin.unhide(toolButtonFeq.intValue());
			}
		}
	}
}
