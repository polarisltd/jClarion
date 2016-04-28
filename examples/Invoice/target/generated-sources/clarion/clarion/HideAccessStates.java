package clarion;

import clarion.Filemanager;
import clarion.Main;
import org.jclarion.clarion.Clarion;

public class HideAccessStates extends Filemanager
{
	public HideAccessStates()
	{
	}

	public void init()
	{
		this.init(Main.states,Main.globalErrors);
		this.fileNameValue.setValue("States");
		this.buffer=Main.states;
		this.lockRecover.setValue(10);
		this.addKey(Main.states.stateCodeKey,Clarion.newString("STA:StateCodeKey"),Clarion.newNumber(0));
		Main.accessStates.set(this);
	}
	public void kill()
	{
		super.kill();
		Main.accessStates.set(null);
	}
}
