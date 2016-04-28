package clarion;

import clarion.Windowcomponent;
import org.jclarion.clarion.ClarionNumber;

public abstract class Formvcrwindowcomponent extends Windowcomponent
{

	public abstract ClarionNumber primaryBufferSaveRequired();
	public abstract ClarionNumber primaryBufferRestoreRequired();
	public abstract void primaryBufferSaved();
	public abstract void primaryBufferRestored();
}
