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

import java.util.Set;
import java.util.logging.Logger;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.java.JavaDependencyCollector;
import org.jclarion.clarion.compile.var.Variable;

public class VariableExpr extends AssignableExpr 
{
    private static Logger log = Logger.getLogger(VariableExpr.class.getName()); 
    
    private Variable var;
    private Expr base;
    
    public VariableExpr(Expr base,Variable v) {
        super(base.precendence(),base.type());
        this.var=v;
        this.base=base;
    }

    public VariableExpr(int precedence,ExprType type,Variable v) {
        super(precedence,type);
        this.var=v;
    }
    
    @Override
    public void toJavaString(StringBuilder target) {
        base.toJavaString(target);
        if (var.isEscalatedReference()) target.append(".get()");
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        base.collate(collector);
    }

    public Variable getVariable()
    {
        return var;
    }
    
    public Expr getBase()
    {
        return base;
    }

    
    @Override
    public Expr assign(Expr rght,boolean byReference)
    {
        if (byReference && !var.isReference()) {
            if (type().isa(ExprType.concrete_any)) {
                return new JoinExpr(JavaPrec.POSTFIX,null,getBase(),".setReferenceValue(",rght,");");
            }
            log.warning("Not appropriate to use reference assigment for variable:"+toJavaString());
            byReference=false;
        }
        
        if (byReference) {
        	
        	if (base instanceof ArrayExpr) {
        		return ((ArrayExpr)base).assignArray(rght);
        	}
        	
            if (!rght.type().isa(type())) {
                if (rght.type().isa(ExprType.rawint) || rght.type().isa(ExprType.number) || rght.type().isa(ExprType.any)) {
                    ExprBuffer eb = new ExprBuffer(JavaPrec.ASSIGNMENT,null);
                    eb.add("(");
                    eb.add(new ExprTypeExpr(this.type()));
                    eb.add(")");
                    eb.add("CMemory.resolveAddress(");
                    eb.add(ExprType.rawint.cast(rght));
                    eb.add(")");
                    rght=new DependentExpr(eb,ClarionCompiler.CLARION+".runtime.CMemory");
                } else if ( (type().isa(ExprType.group) || type().isa(ExprType.any)) &&
                    (type().isa(ExprType.group) || type().isa(ExprType.any)) ) {
                    ExprBuffer eb = new ExprBuffer(JavaPrec.ASSIGNMENT,null);
                    eb.add("(");
                    eb.add(new ExprTypeExpr(this.type()));
                    eb.add(")CMemory.castTo(");
                    eb.add(rght);
                    eb.add(",");
                    eb.add(new ExprTypeExpr(this.type()));
                    eb.add(".class)");
                    rght=new DependentExpr(eb,ClarionCompiler.CLARION+".runtime.CMemory");
                } else {
                    throw new IllegalStateException("Cannot ref assign");
                }
            }
            
            final Expr right=rght;

            return new Expr(JavaPrec.POSTFIX,null) {

                @Override
                public void toJavaString(StringBuilder target) {
                    getBase().toJavaString(target);
                    if (var.isEscalatedReference()) {
                        target.append(".set(");
                        right.toJavaString(target);
                    } else {
                        target.append("=");
                        right.wrap(JavaPrec.ASSIGNMENT).toJavaString(target);
                    }
                    if (var.isEscalatedReference()) {
                        target.append(");");
                    } else {
                        target.append(";");
                    }
                }
                
                @Override
                public void collate(JavaDependencyCollector collector) {
                    getBase().collate(collector);
                    right.collate(collector);
                }

                @Override
                public boolean utilises(Set<Variable> vars) {
                    if (vars.contains(getVariable())) return true;
                    if (getBase().utilises(vars)) return true;
                    if (right.utilises(vars)) return true;
                    return false;
                }

                @Override
                public boolean utilisesReferenceVariables() {
                    if (getBase().utilisesReferenceVariables()) return true;
                    if (right.utilisesReferenceVariables()) return true;
                    return false;
                }

                
                
            };
            
        } else {
            final Expr right=rght;

            return new Expr(JavaPrec.POSTFIX,null) {

                @Override
                public void toJavaString(StringBuilder target) {
                    getBase().toJavaString(target);
                    if (var.isEscalatedReference()) target.append(".get()");
                    target.append(".setValue(");
                    right.toJavaString(target);
                    target.append(");");
                }
                
                @Override
                public void collate(JavaDependencyCollector collector) {
                    getBase().collate(collector);
                    right.collate(collector);
                }

                @Override
                public boolean utilises(Set<Variable> vars) {
                    if (vars.contains(getVariable())) return true;
                    if (getBase().utilises(vars)) return true;
                    if (right.utilises(vars)) return true;
                    return false;
                }
                
                @Override
                public boolean utilisesReferenceVariables() {
                    if (getBase().utilisesReferenceVariables()) return true;
                    if (right.utilisesReferenceVariables()) return true;
                    return false;
                }
                
            };
        }
    }

    @Override
    public boolean utilises(Set<Variable> vars) {
        if (vars.contains(var)) return true;
        if (base.utilises(vars)) return true;
        return false;
    }

    @Override
    public boolean utilisesReferenceVariables() {
        if (var.isReference()) return true;
        if (base.utilisesReferenceVariables()) return true;
        return false;
    }
    
    
}
