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

import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.JavaPrec;
import org.jclarion.clarion.compile.expr.SimpleExpr;
import org.jclarion.clarion.compile.expr.VariableExpr;
import org.jclarion.clarion.compile.java.Labeller;
import org.jclarion.clarion.compile.scope.ClassCodeScope;
import org.jclarion.clarion.compile.scope.PolymorphicScope;
import org.jclarion.clarion.compile.scope.RoutineScope;
import org.jclarion.clarion.compile.scope.Scope;

public class ClassSelfReferenceVariable extends Variable 
{
    private String clarionName;
    private PolymorphicScope clazz;
    
    public ClassSelfReferenceVariable(PolymorphicScope clazz,String name,String clarionName)
    {
        super(name,clazz.getClassType(),false,false);
        this.clazz=clazz;
        this.clarionName=Labeller.get(clarionName,false);
    }
    
    
    
    @Override
    public Expr[] makeConstructionExpr() 
    {
        return null;
    }

    @Override
    public String getJavaName() {
        return getName();
    }

    private boolean sameAs(PolymorphicScope c1,PolymorphicScope c2)
    {
        PolymorphicScope scan=c1;
        while (scan!=null) {
            if (scan==c2) return true;
            scan=scan.getBase();
        }

        scan=c2;
        while (scan!=null) {
            if (scan==c1) return true;
            scan=scan.getBase();
        }
        
        return false;
    }
    
    @Override
    public boolean isEscalatedScope(Scope callingScope)
    {
        if (callingScope==getScope()) return false;
        if (callingScope instanceof ClassCodeScope) {
            if (sameAs(((ClassCodeScope)callingScope).getClassScope(),clazz)) {
                return false;
            }
        }
        if (callingScope instanceof RoutineScope) {
            if (callingScope.getParent() instanceof ClassCodeScope) {
                if (sameAs(((ClassCodeScope)callingScope.getParent()).getClassScope(),clazz)) {
                    return false;
                }
            }
        }
        
        return true;
    }
    
    @Override
    public VariableExpr getExpr(Scope callingScope) {
        
        Expr e;
        
        if (isEscalatedScope(callingScope)) {
            e = new SimpleExpr(JavaPrec.LABEL,getType(),clarionName);

            Scope scan=callingScope;
            
            while ( true ) {
                
                if (scan==null)                     break;
                if (scan==clazz)                    break;
                if (!isEscalatedScope(scan))        break;
                
                if (!scan.escalateVariable(this))   break;
                scan=scan.getParent();
            }
        } else {
            e = new SimpleExpr(JavaPrec.LABEL,getType(),getJavaName());
            
        }
        return new VariableExpr(e,this);
    }



    @Override
    public String getEscalatedJavaName(Scope useScope) {
        if (isEscalatedScope(useScope)) {
            return clarionName;
        } else {
            return getJavaName();
        }
    }



    @Override
    public Variable clone() {
        return new ClassSelfReferenceVariable(clazz,getName(),clarionName); 
    }

    
    
}
