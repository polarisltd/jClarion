package clarion;

import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

public abstract class Browsequeue
{

	public abstract ClarionNumber records();
	public abstract void insert();
	public abstract void insert(ClarionNumber rowNum);
	public abstract void fetch(ClarionNumber rowNum);
	public abstract void update();
	public abstract void delete();
	public abstract void free();
	public abstract ClarionString who(ClarionNumber colNum);
	public abstract ClarionString getViewPosition();
	public abstract void setViewPosition(ClarionString s);
}
