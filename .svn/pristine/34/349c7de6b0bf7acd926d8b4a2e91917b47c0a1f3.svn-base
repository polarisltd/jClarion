package org.jclarion.clarion.compile.grammar;

import org.jclarion.clarion.lang.Lexer;

public abstract class AbstractErrorCollator 
{
	public abstract void error(Lexer source,int lineNumber,int charStart,int charEnd,String message,Throwable t,boolean canRecover);

	public abstract void warning(Lexer source,int lineNumber, int charStart, int charEnd,String message);
}
