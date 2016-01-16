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
package org.jclarion.clarion.compile.var;

import org.jclarion.clarion.compile.expr.ClassedExprType;
import org.jclarion.clarion.compile.expr.DanglingExprType;
import org.jclarion.clarion.compile.expr.DependentExpr;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprBuffer;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.JavaPrec;
import org.jclarion.clarion.compile.expr.JoinExpr;
import org.jclarion.clarion.compile.expr.SimpleExpr;
import org.jclarion.clarion.compile.expr.UsesExprIterableType;
import org.jclarion.clarion.compile.expr.VariableExpr;
import org.jclarion.clarion.compile.java.JavaClass;
import org.jclarion.clarion.compile.scope.RoutineScope;
import org.jclarion.clarion.compile.scope.Scope;

public class ClassedVariable extends Variable
{
    private JavaClass       _clazz;
    private Scope           _targetImplementingScope;
    private VariableExpr    over;
    private Boolean         thread;
    
    private DanglingExprType dangle;
    
    public ClassedVariable(String name,ExprType type,JavaClass clazz,boolean reference,boolean st,Boolean thread)
    {
        super(name,type,reference,st);
        this.thread=thread;
        this._clazz=clazz;
    }

    public ClassedVariable(String label, DanglingExprType cet,boolean reference,boolean st,boolean thread)
    {
        super(label,cet,reference,st);
        this.thread=thread;
        this.dangle=cet;
    }

    public void setOver(VariableExpr over)
    {
        this.over=over;
    }
    
    public JavaClass getJavaClass()
    {
        if (_clazz==null) _clazz=((ClassedExprType)dangle.getReal()).getJavaClass();
        return _clazz;
    }
    
    public Scope getTargetImplementingScope()
    {
        if (_targetImplementingScope==null && dangle!=null) {
            if (dangle.getReal()==null) {
                throw new IllegalStateException("Something wants implementing scope but we are still dangling!:"+dangle.getName());
            }
            _targetImplementingScope=((ClassedExprType)dangle.getReal()).getDefinitionScope();
        }
        return _targetImplementingScope;
    }

    @Override
    public final Expr[] makeConstructionExpr() {
        return makeConstructionExpr(thread!=null?thread.booleanValue():false);
    }

    public Expr[] makeConstructionExpr(boolean thread) 
    {
        Expr e[] = new Expr[3];
        e[1] = new SimpleExpr(JavaPrec.CREATE,getType(),"new "+getJavaClass().getName()+"()");
        e[1] = new DependentExpr(e[1],getJavaClass());

        if (getTargetImplementingScope()==null) {
            e[0] = e[1];
        } else {
            ExprBuffer params = new ExprBuffer(JavaPrec.LABEL,null);

            boolean first=true;
            if (getTargetImplementingScope().getEscalatedModule()!=null) {
                Scope owner = getScope();
                if (owner instanceof RoutineScope) owner=owner.getParent();
                
                if (getTargetImplementingScope().getEscalatedModule()==owner.getParent()) {
                    params.add("this");
                } else {
                    params.add("_owner");
                }
                first=false;
            }
            
            for (Variable v :getTargetImplementingScope().getEscalatedVariables() ) {
                if (!first) {
                    params.add(",");
                } else {
                    first=false;
                }
                params.add(v.getEscalatedJavaName(getScope()));
            }
            
            ExprBuffer eb = null;
            eb = new ExprBuffer(JavaPrec.CREATE,getType());
            eb.add("new ");
            eb.add(getJavaClass().getName());
            eb.add("(");
            eb.add(params);
            eb.add(")");
            e[0]=eb;
            e[0]=new UsesExprIterableType(e[0],getTargetImplementingScope().getEscalatedVariables());
            e[0]=new DependentExpr(e[0],getJavaClass());

            eb = new ExprBuffer(JavaPrec.POSTFIX,null);
            eb.add(getJavaName());
            eb.add(".__Init__");
            eb.add("(");
            eb.add(params);
            eb.add(")");
            e[2]=eb;
            e[2]=new UsesExprIterableType(e[2],getTargetImplementingScope().getEscalatedVariables());
        }
        
        if (over!=null) {
            e[0]=new JoinExpr(JavaPrec.POSTFIX,e[0].type(),"("+getJavaClass().getName()+")",
                    e[0].wrap(JavaPrec.POSTFIX),
                    ".setOver(",over,")");

            e[1]=new JoinExpr(JavaPrec.POSTFIX,e[1].type(),"("+getJavaClass().getName()+")",
                    e[1].wrap(JavaPrec.POSTFIX),
                    ".setOver(",over,")");
        }
        if (thread) {
            if (thread) {
                ExprBuffer eb; 

                for (int scan=0;scan<1;scan++) {
                    eb = new ExprBuffer(JavaPrec.POSTFIX,e[scan].type());
                    eb.add("(");
                    eb.add(getJavaClass().getName());
                    eb.add(")");
                    eb.add(e[scan].wrap(JavaPrec.POSTFIX));
                    eb.add(".getThread()");
                    e[scan]=eb;
                }
            }
        }
        
        return e;
    }

    public void setTargetImplementingScope(Scope targetImplementingScope) {
        this._targetImplementingScope = targetImplementingScope;
    }

    @Override
    public Variable clone() {
        
        if (_clazz!=null) {
            return new ClassedVariable(getName(),getType(),_clazz,isReference(),isStatic(),false);
        } else {
            return new ClassedVariable(getName(),dangle,isReference(),isStatic(),false);
        }
    }

    @Override
    public void setInitConstructionMode(boolean initConstructionMode) {
        super.setInitConstructionMode(initConstructionMode);
        if (_clazz!=null) {
            _clazz.setInitConstructionMode(initConstructionMode);
        }
    }
    
}
