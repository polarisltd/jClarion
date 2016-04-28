package clarion;

import clarion.Bufferedpairsclass;
import org.jclarion.clarion.ClarionFile;
import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.ClarionString;

public abstract class Idbchangeaudit
{

	public abstract void changeField(ClarionObject left,ClarionObject right,ClarionString name,ClarionString filename);
	public abstract void onChange(ClarionString filename,ClarionFile file);
	public abstract void beforeChange(ClarionString filename,Bufferedpairsclass bfp);
}
