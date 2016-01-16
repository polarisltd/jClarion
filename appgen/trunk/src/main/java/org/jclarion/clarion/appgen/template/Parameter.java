package org.jclarion.clarion.appgen.template;

import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;


public abstract class Parameter
{
	public abstract int getInt() throws ParseException;
	public abstract String getString()  throws ParseException;
	public abstract CExpr getExpression()  throws ParseException;
	public boolean isEmpty()
	{
		return false;
	}
	
	public boolean isLabel() {
		return false;
	}
}