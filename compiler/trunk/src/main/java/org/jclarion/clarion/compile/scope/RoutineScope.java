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
package org.jclarion.clarion.compile.scope;

import java.util.HashMap;
import java.util.Map;

import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.ReturningExpr;
import org.jclarion.clarion.compile.java.JavaCode;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.var.Variable;

public class RoutineScope extends Scope implements ReturningScope
{
    private String          name;
    private JavaCode        code;
    private ReturningScope  owner;
    
    public RoutineScope(ScopeStack stack,String name,ReturningScope owner)
    {
    	super(stack);
        this.name=name;
        this.owner=owner;
    }
    
    public String getName()
    {
        return name;
    }

    public JavaCode getCode() {
        return code;
    }

    public void setCode(JavaCode code) {
        this.code = code;
    }

    @Override
    public Procedure getProcedure() {
       return owner.getProcedure();
    }

    @Override
    public ReturningExpr getReturnValue() {
        return owner.getReturnValue();
    }
    
    private Map<String,RoutineScope> callingRoutines = new HashMap<String, RoutineScope>();
    
    public void addCallingRoutine(RoutineScope scope)
    {
        callingRoutines.put(scope.getName(),scope);

        if (mayReturnToProcedure()) scope.setMayReturnToProcedure();

        for ( Variable v : getEscalatedVariables() ) {
            scope.escalateVariable(v);
        }
    }

    public Iterable<RoutineScope> getCallingRoutines()
    {
        return callingRoutines.values();
    }

    @Override
    public boolean escalateVariable(Variable v) {
        if (!super.escalateVariable(v)) return false;
        
        for (RoutineScope rs : getCallingRoutines()) {
            rs.escalateVariable(v);
        }
        
        return true;
    }

    private boolean mayReturnToProcedure;
    
    public boolean mayReturnToProcedure() 
    {
        return mayReturnToProcedure;
    }
    
    public void setMayReturnToProcedure() {
        
        if (mayReturnToProcedure) return;
        mayReturnToProcedure=true;
        
        for (RoutineScope rs : getCallingRoutines()) {
            rs.setMayReturnToProcedure();
        }
    }
    
    @Override
    public ModuleScope getEscalatedModule()
    {
        return null;
    }

    
    @Override
    public Variable getParameter(int offset) {
        return owner.getParameter(offset);
    }

    @Override
    public int getParameterCount() {
        return owner.getParameterCount();
    }
    
    @Override
    public void addType(ExprType type,Scope originatingScope) {
        // push new types up a single level, maybe
        getParent().addType(type,originatingScope);
    }
    
}
