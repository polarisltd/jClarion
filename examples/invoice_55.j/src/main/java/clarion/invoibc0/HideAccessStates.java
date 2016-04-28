package clarion.invoibc0;

import clarion.Main;
import clarion.abfile.Filemanager;
import org.jclarion.clarion.Clarion;

@SuppressWarnings("all")
public class HideAccessStates extends Filemanager
{
	public HideAccessStates()
	{
	}

	public void init()
	{
		this.init(Main.states,Main.globalerrors);
		this.filenamevalue.setValue("States");
		this.buffer=Main.states;
		this.lockrecover.setValue(10);
		this.addkey(Main.states.statecodekey,Clarion.newString("STA:StateCodeKey"),Clarion.newNumber(0));
		Main.accessStates=this;
	}
	public void kill()
	{
		super.kill();
		Main.accessStates=null;
	}
}
