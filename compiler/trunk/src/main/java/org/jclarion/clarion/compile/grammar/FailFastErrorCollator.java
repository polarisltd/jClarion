package org.jclarion.clarion.compile.grammar;

import org.jclarion.clarion.lang.Lexer;

public class FailFastErrorCollator extends AbstractErrorCollator
{
	@Override
	public void error(Lexer source, int lineNumber, int charStart,int charEnd,String message, Throwable t,boolean canRecover) 
	{
		if (t!=null) {
			source.error(message,t);
		} else {
			source.error(message);
		}
	}

	@Override
	public void warning(Lexer source, int lineNumber, int charStart,int charEnd, String message) {
		System.err.println(message+" at "+source.getStream().getName()+" line "+lineNumber);
	}

}
