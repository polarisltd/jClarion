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

import java.util.Set;

import org.jclarion.clarion.compile.expr.ClassedExprType;
import org.jclarion.clarion.compile.expr.DanglingExprType;
import org.jclarion.clarion.compile.expr.DependentExpr;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprBuffer;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.ExprTypeExpr;
import org.jclarion.clarion.compile.expr.JavaPrec;
import org.jclarion.clarion.compile.expr.JoinExpr;
import org.jclarion.clarion.compile.expr.SimpleExpr;
import org.jclarion.clarion.compile.expr.UsesExprIterableType;
import org.jclarion.clarion.compile.expr.VariableExpr;
import org.jclarion.clarion.compile.java.JavaClass;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.scope.RoutineScope;
import org.jclarion.clarion.compile.scope.Scope;

public class ClassedVariable extends Variable
{
    private JavaClass       _clazz;
    private Scope           _targetImplementingScope;
    private VariableExpr    over;
    private Boolean         thread;
    private Expr[]      dim=null;
    
    private DanglingExprType dangle;
    
    public boolean constructionUtilises(Set<Variable> vars) {
        boolean result = super.constructionUtilises(vars);
        if (result) return true ;
        
        if (!Expr.DEEP_UTILISATION_TEST) return false;
        
        Scope s = getTargetImplementingScope();
        if (s==null) return false;
        
        Iterable<Procedure> list = s.getProcedures("construct");
        if (list==null) return false;
        
        for (Procedure scan : list ) {
            if (scan.getParams().length==0) {
               if (scan.getCode()!=null) {
                   if (scan.getCode().utilises(vars)) return true;
               }
            }
        }
        return false;
    }
    
    public ClassedVariable(String name,ExprType type,JavaClass clazz,boolean reference,boolean st,Boolean thread,Expr[] dim)
    {
    	this.dim=dim;
    	if (dim!=null) {
    		init(name,type.changeArrayIndexCount(dim.length),reference,st);
    	} else {
    		init(name,type,reference,st);
    	}
        this.thread=thread;
        this._clazz=clazz;
        if (thread) clazz.setThreaded();
    }

    public ClassedVariable(String label, DanglingExprType cet,boolean reference,boolean st,boolean thread,Expr[] dim)
    {
    	this.dim=dim;
    	if (dim!=null) {
    		init(label,cet.changeArrayIndexCount(dim.length),reference,st);
    	} else {
    		init(label,cet,reference,st);    		
    	}
        this.thread=thread;
        this.dangle=cet;
    }

    public void setOver(VariableExpr over)
    {
        this.over=over;
    }

    
    public JavaClass getJavaClass()
    {
        if (_clazz==null) {
        	if (dangle!=null) {
        		if (dangle.getReal()==null) {
        			throw new RuntimeException("Cannot resolve dangle:"+dangle.getName());
        		}
        	}
            _clazz=((ClassedExprType)dangle.getReal()).getJavaClass();
            if (thread) {
                _clazz.setThreaded();
            }
        }
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
    	if (dim!=null) {
    		JavaClass jc = getJavaClass();
    		if (jc!=null && jc instanceof ClassJavaClass) {
    			((ClassJavaClass)jc).setInitConstructionMode(false);
    		}
    	}
        return makeConstructionExpr(thread!=null?thread.booleanValue():false);
    }

    private Expr makeArrayExpr(Expr e)
    {
    	if (dim==null || dim.length==0) return e;
    	ExprBuffer eb = new ExprBuffer(JavaPrec.CREATE,getType());
        if (dim.length>1) eb.add("(");
        eb.add("new ");
        eb.add(new ExprTypeExpr(e.type()));
        eb.add("(");
        eb.add(e);
        eb.add(",");
        eb.add(ExprType.rawint.cast(dim[dim.length-1]));
        eb.add(")");
        if (dim.length>1) eb.add(")");
        for (int scan=dim.length-2;scan>=0;scan--) {
            eb.add(".dim(");
            eb.add(ExprType.rawint.cast(dim[scan]));
            eb.add(")");
        }
        return eb;
    }
    
    public Expr[] makeConstructionExpr(boolean thread) 
    {
        Expr e[] = new Expr[3];
        e[1] = new SimpleExpr(JavaPrec.CREATE,getType(),"new "+getJavaClass().getName()+"()");
        
        e[1]=makeArrayExpr(e[1]);
        
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
            e[0]=makeArrayExpr(e[0]);
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
        
        if (dim!=null) {
        	// wrap expressions
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
            return new ClassedVariable(getName(),getType(),_clazz,isReference(),isStatic(),false,null);
        } else {
            return new ClassedVariable(getName(),dangle,isReference(),isStatic(),false,dim);
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
