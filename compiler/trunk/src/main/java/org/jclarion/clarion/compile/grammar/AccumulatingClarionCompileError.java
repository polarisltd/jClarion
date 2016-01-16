package org.jclarion.clarion.compile.grammar;

import org.jclarion.clarion.lang.ClarionCompileError;

public class AccumulatingClarionCompileError extends ClarionCompileError
{

	public AccumulatingClarionCompileError(String name) 
	{
		super(name);
	}

	public AccumulatingClarionCompileError(String name,Throwable t) 
	{
		super(name,t);
	}

	public AccumulatingClarionCompileError(RuntimeException ex) {
		super(ex);
	}

	private static final long serialVersionUID = -830534552701936205L;
}
