package org.jclarion.clarion.compile.expr;

public class MemoryModelCastFactory extends CastFactory 
{
    public MemoryModelCastFactory(ExprType type) 
    {
        super(type);
    }

    @Override
    public Expr cast(ExprType base,Expr in) 
    {
        System.out.println("***** WARNING **** Doing memory cast of "+in.type()+" to "+base);
        
        ExprBuffer eb = new ExprBuffer(JavaPrec.POSTFIX,base);
        eb.add("(");
        eb.add(new ExprTypeExpr(base));
        eb.add(")");
        eb.add(in);
        eb.add(".castTo(");
        eb.add(new ExprTypeExpr(base));
        eb.add(".class)");
        return eb;
    }

}
