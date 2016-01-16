package org.jclarion.clarion.compile.expr;

import java.util.Set;

import org.jclarion.clarion.compile.java.JavaDependencyCollector;
import org.jclarion.clarion.compile.var.Variable;

public class ArrayExpr extends Expr
{
	private Expr left;
	private Expr index;

	public ArrayExpr(Expr left,Expr index)
	{
		super(JavaPrec.POSTFIX,left.type().changeArrayIndexCount(-1));
		this.left=left.wrap(JavaPrec.POSTFIX);
		this.index=ExprType.rawint.cast(index);
	}

	@Override
	public void toJavaString(StringBuilder target) {
		left.toJavaString(target);
		target.append(".get(");
		index.toJavaString(target);
		target.append(")");
	}

	@Override
	public void collate(JavaDependencyCollector collector) {
		left.collate(collector);
		index.collate(collector);
	}

	@Override
	public boolean utilises(Set<Variable> vars) {
		if (left.utilises(vars)) return true;
		if (index.utilises(vars)) return true;
		return false;
	}

	@Override
	public boolean utilisesReferenceVariables() {
		return left.utilisesReferenceVariables() || index.utilisesReferenceVariables();
	}

	public Expr assignArray(final Expr right) {
        return new Expr(JavaPrec.POSTFIX,null) {
            @Override
            public void toJavaString(StringBuilder target) 
            {
                left.toJavaString(target);
                target.append(".set(");
                index.toJavaString(target);
                target.append(",");
                right.toJavaString(target);
                target.append(");");
            }
            
            @Override
            public void collate(JavaDependencyCollector collector) {
                left.collate(collector);
                index.collate(collector);
            }

            @Override
            public boolean utilises(Set<Variable> vars) {
                if (left.utilises(vars)) return true;
                if (right.utilises(vars)) return true;
                return false;
            }

            @Override
            public boolean utilisesReferenceVariables() {
                if (left.utilisesReferenceVariables()) return true;
                if (right.utilisesReferenceVariables()) return true;
                return false;
            }
        };
	}
}
