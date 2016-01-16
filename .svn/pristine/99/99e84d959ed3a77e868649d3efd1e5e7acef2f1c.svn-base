package org.jclarion.clarion.appgen.template.cmd;

import org.jclarion.clarion.appgen.symbol.SymbolValue;


public class CodeResult 
{
	public static final int CODE_OK=0;
	public static final int CODE_BREAK=1;
	public static final int CODE_CYCLE=2;
	public static final int CODE_ABORT=3;
	public static final int CODE_RETURN=4;
	public static final int CODE_ACCEPT=5;
	public static final int CODE_REJECT=6;
	
	public static final CodeResult OK= new CodeResult(CODE_OK);
	public static final CodeResult BREAK= new CodeResult(CODE_BREAK);
	public static final CodeResult CYCLE= new CodeResult(CODE_CYCLE);
	public static final CodeResult ABORT= new CodeResult(CODE_ABORT);
	public static final CodeResult ACCEPT= new CodeResult(CODE_ACCEPT);
	public static final CodeResult REJECT= new CodeResult(CODE_REJECT);
	
	private int code;
	private SymbolValue value;
	
	public CodeResult(int code)
	{
		this.code=code;
	}

	public CodeResult(int code,SymbolValue rv)
	{
		this.code=code;
		this.value=rv;
	}
	
	public int getCode()
	{
		return code;
	}

	public SymbolValue getReturnValue() 
	{
		return value; 
	}
}

