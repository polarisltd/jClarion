package org.jclarion.clarion.runtime.expr;

import org.jclarion.clarion.runtime.CExprImpl;

public abstract class CExprScope 
{
	public static final CExprScope DEFAULT =new CExprScope()
	{
		@Override
		public LabelExprResult resolveBind(String name, boolean mustBeProcedure) {
			return CExprImpl.getInstance().resolveBind(name, mustBeProcedure);
		}
	};
	
    public abstract LabelExprResult resolveBind(String name,boolean mustBeProcedure);
}
