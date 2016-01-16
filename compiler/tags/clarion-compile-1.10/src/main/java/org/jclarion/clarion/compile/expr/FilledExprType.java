/**
 * Copyright 2010, by Andrew Barnham
 *
 * The contents of this file are subject to
 * GNU Lesser General Public License (LGPL), v.3
 * http://www.gnu.org/licenses/lgpl.txt
 * 
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied.
 */
package org.jclarion.clarion.compile.expr;

import java.util.LinkedHashMap;
import java.util.Map;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.scope.Scope;


/**
 * Define output types for expressions
 * 
 * This object codifies concerns such as how to apply postfixing 
 * operations
 * 
 * @author barney
 */

public abstract class FilledExprType extends ExprType 
{
    private String      _name;
    private ExprType    _base;
    private int         _array;
    
    protected FilledExprType()
    {
        super();
    }

    public FilledExprType(String name,ExprType base,int array)
    {
        this._name=name;
        this._base=base;
        this._array=array;
        
        if (array==0) {
            char c = name.charAt(0);
            if (c>='a' && c<='z') {
                ExprType.put(name,this);
            }
        }
    }

    @Override
    public String getName()
    {
        return _name;
    }
    
    @Override
    public int getArrayDimSize()
    {
        return _array;
    }
    
    @Override
    public ExprType getBase()
    {
        return _base;
    }
    
    @Override
    public boolean isRaw()
    {
        return getName().startsWith("raw");
    }
    

    @Override
    public boolean isSystem()
    {
        char c = getName().charAt(0);
        return (c>='a' && c<='z');
    }

    @Override
    public boolean same(ExprType test)
    {
        if (getArrayDimSize()!=test.getArrayDimSize()) return false;
        return (getName().equals(test.getName()));
    }
    
    /**
     * Return true if this type can be consider same type as test
     * 
     *  string.isa(any) return true
     *  any.isa(string) return false
     * 
     * @param test
     * @return
     */
    @Override
    public boolean isa(ExprType test)
    {
        if (getArrayDimSize()!=test.getArrayDimSize()) return false;
        
        ExprType scan = this;
        while (scan!=null) {
            if (scan.getName().equals(test.getName())) return true;
            scan=scan.getBase();
        }
        
        return false;
    }

    private Map<String,CastFactory> _map=new LinkedHashMap<String, CastFactory>();

    public void add(CastFactory... factory) {
        for (int scan=0;scan<factory.length;scan++) {
            _map.put(factory[scan].getType().getName().toString(),factory[scan]);
        }
    }
    
    @Override
    public Expr cast(Expr in)
    {
        if (in.type().isa(this)) return in;
        CastFactory cf = _map.get(in.type().getName().toString());
        if (cf!=null) return cf.cast(in);
        
        for (CastFactory test : _map.values() ) {
            if (in.type().isa(test.getType())) {
                return test.cast(in);
            }
        }
        
        return null;
    }

    @Override
    public Expr array(Expr in,Expr subscript)
    {
        if (getArrayDimSize()>0) {
            Expr ne = new JoinExpr(null,in,
                    "[",
                    ExprType.rawint.cast(subscript),
                    "]",JavaPrec.POSTFIX,changeArrayIndexCount(-1));
            
            if (in instanceof VariableExpr) {
                return new VariableExpr(ne,((VariableExpr)in).getVariable());
            }
            
            return ne;
            
        }
        
        in = FilledExprType.string.cast(in);
        
        Expr e = new JoinExpr(null,
                in,
                ".stringAt(",
                subscript,
                ")",JavaPrec.POSTFIX,FilledExprType.string);
        
        return new StringSpliceExpr(e,in,subscript,null);
    }
    
    @Override
    public Expr splice(Expr in,Expr left,Expr right)
    {

        Expr params=new JoinExpr(null,
                left,
                ",",
                right,
                null,JavaPrec.POSTFIX,FilledExprType.string);
        

        Expr e = new JoinExpr(null,
                FilledExprType.string.cast(in),
                ".stringAt(",
                params,
                ")",JavaPrec.POSTFIX,FilledExprType.string);

        return new StringSpliceExpr(e,in,left,right);
    }
    
    @Override
    public Expr property(Expr in,Expr keys[]) 
    {
        if (!in.type().isa(ExprType.bean) && !in.type().isa(ExprType.file)) {
            in=new DecoratedExpr(JavaPrec.POSTFIX,ExprType.bean,"Clarion.getControl(",in,")");
            in=new DependentExpr(in,ClarionCompiler.CLARION+".Clarion");
        }
        
        Expr rewrite = PropertyRewriter.getInstance().rewrite(in,keys);
        if (rewrite!=null) return rewrite;
        
        return new PropertyExpr(in,keys);
    }

    @Override
    public Expr field(Expr in,String field) {
        return null;
    }

    @Override
    public Expr method(Expr in,String field,Expr params[])
    {
        return null;
    }

    @Override
    public Expr prototype(Expr in,String field)
    {
        return null;
    }

    
    @Override
    public ExprType changeArrayIndexCount(int count)
    {
        if (getArrayDimSize()+count==0) {
            ExprType candidate = ExprType.get(getName());
            if (candidate!=null) return candidate;
        }
        
        FilledExprType type = cloneType();
        type._array=getArrayDimSize()+count;
        type._base=getBase();
        type._name=getName();
        type._map=this._map;
        
        return type;
    }
    
    public abstract FilledExprType cloneType();
    
    @Override
    public String toString()
    {
        return getName();
    }
    
    @Override
    public String generateDefinition()
    {
        StringBuilder out = new StringBuilder();
        generateDefinition(out);
        return out.toString();
    }
    
    public abstract void generateDefinition(StringBuilder out);

    @Override
    public ExprType getReal() {
        return this;
    }
    
    @Override
    public Scope getDefinitionScope() {
        return null;
    }

}
