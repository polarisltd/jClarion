package clarion;

import clarion.Params;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;

@SuppressWarnings("all")
public abstract class Filecallbackinterface implements org.jclarion.clarion.hooks.Filecallbackinterface
{
      @Override
      public void functionCalled(ClarionNumber newNumber,
              org.jclarion.clarion.hooks.FilecallbackParams params, ClarionString newString,
              ClarionString newString2) {
          functionCalled(newNumber,(Params)params,newString,newString2);
      }
      @Override
      public void functionDone(ClarionNumber newNumber,
              org.jclarion.clarion.hooks.FilecallbackParams params, ClarionString newString,
              ClarionString newString2) {
          functionDone(newNumber,(Params)params,newString,newString2);
      }

	public abstract ClarionNumber functioncalled(ClarionNumber opcode,Params parameters,ClarionString errcode,ClarionString errmsg);
	public abstract ClarionNumber functiondone(ClarionNumber opcode,Params parameters,ClarionString errcode,ClarionString errmsg);
}
