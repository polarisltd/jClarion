package clarion;

import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

public abstract class Sqlcallbackinterface
{

	public abstract ClarionString executingCode(ClarionString inStr,ClarionNumber err,ClarionString fileErrCode,ClarionString fileErrMsg);
}
