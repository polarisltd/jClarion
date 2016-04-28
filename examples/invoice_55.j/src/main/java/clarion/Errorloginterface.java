package clarion;

import clarion.equates.Constants;
import org.jclarion.clarion.Clarion;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public abstract class Errorloginterface
{

	public ClarionNumber close()
	{
		return close(Clarion.newNumber(Constants.FALSE));
	}
	public abstract ClarionNumber close(ClarionNumber force);
	public ClarionNumber open()
	{
		return open(Clarion.newNumber(Constants.FALSE));
	}
	public abstract ClarionNumber open(ClarionNumber force);
	public abstract ClarionNumber take(ClarionString errtext);
}
