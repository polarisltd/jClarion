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
    public Expr assign(final Expr right,boolean byReference)
    {
        if (byReference && !var.isReference()) {
            if (type().isa(ExprType.concrete_any)) {
                return new JoinExpr(JavaPrec.POSTFIX,null,getBase(),".setReferenceValue(",right,");");
            }
            log.warning("Not appropriate to use reference assigment for variable:"+toJavaString());
            byReference=false;
        }
        
        if (byReference) {
            if (!right.type().isa(type())) {
                throw new IllegalStateException("Cannot assign "+right.type()+" to "+type());
            }

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
