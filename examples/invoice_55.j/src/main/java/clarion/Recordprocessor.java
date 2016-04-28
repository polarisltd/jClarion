package clarion;

import org.jclarion.clarion.ClarionNumber;

@SuppressWarnings("all")
public abstract class Recordprocessor
{

	public abstract ClarionNumber takerecord();
	public abstract ClarionNumber takeclose();
}
