package clarion;

import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public abstract class Sqlcallbackinterface
{

	public abstract ClarionString executingcode(ClarionString instr,ClarionNumber err,ClarionString errcode,ClarionString errmsg);
}
