package clarion;

import clarion.abutil.Bufferedpairsclass;
import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public abstract class Idbchangeaudit
{

	public abstract void changefield(ClarionObject left,ClarionObject right,ClarionString name,ClarionString filename);
	public abstract void onchange(ClarionString filename,ClarionFile file);
	public abstract void beforechange(ClarionString filename,Bufferedpairsclass bfp);
}
