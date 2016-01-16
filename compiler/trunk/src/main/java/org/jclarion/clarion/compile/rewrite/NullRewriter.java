package org.jclarion.clarion.compile.rewrite;

import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.NullExpr;

public class NullRewriter implements Rewriter
{
	private String name;
	
	public NullRewriter(String name)
	{
		this.name=name;
	}
	
	@Override
	public int getMax() {
		return -1;
	}

	@Override
	public int getMin() {
		return -1;
	}

	@Override
	public String getName() {
		return name;
	}

	@Override
	public ExprType getType() {
		return null;
	}

	@Override
	public RewrittenExpr rewrite(Expr[] in) {
		return new RewrittenExpr(new NullExpr(),RewrittenExpr.WEAK);
	}

}
