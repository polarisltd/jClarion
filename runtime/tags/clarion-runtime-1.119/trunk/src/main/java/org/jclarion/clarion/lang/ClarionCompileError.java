package org.jclarion.clarion.lang;

public class ClarionCompileError extends RuntimeException
{
    private static final long serialVersionUID = 4311569365306703898L;

    public ClarionCompileError(String name)
    {
        super(name);
    }

    public ClarionCompileError(String name,Throwable base)
    {
        super(name,base);
    }

    public ClarionCompileError(Throwable base)
    {
        super(base);
    }
}
