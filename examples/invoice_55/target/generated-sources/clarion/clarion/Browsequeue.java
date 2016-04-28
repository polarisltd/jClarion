package clarion;

import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public abstract class Browsequeue
{

	public abstract ClarionNumber records();
	public abstract void insert();
	public abstract void insert(ClarionNumber rownum);
	public abstract void fetch(ClarionNumber rownum);
	public abstract void update();
	public abstract void delete();
	public abstract void free();
	public abstract ClarionString who(ClarionNumber colnum);
	public abstract ClarionString getviewposition();
	public abstract void setviewposition(ClarionString s);
}
