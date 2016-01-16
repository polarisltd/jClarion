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
import org.jclarion.clarion.compile.prototype.Param;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.var.PassedVariable;
import org.jclarion.clarion.compile.var.Variable;

public class ProcedureScope extends Scope implements ReturningScope
{
    private Procedure procedure;
    protected Map<String,PassedVariable>  passedVariables;
    private PassedVariable[]             pvArray;                                    
    
    public ProcedureScope(Procedure p)
    {
        this.procedure=p;
    }

    public void reset()
    {
        passedVariables=null;
    }
    
    private void initPassedVariables()
    {
        if (passedVariables==null) {
            passedVariables=new HashMap<String, PassedVariable>();
            pvArray=new PassedVariable[procedure.getParams().length];
            for (int scan=0;scan<procedure.getParams().length;scan++) {
                Param p = procedure.getParams()[scan];
                PassedVariable v = new PassedVariable(this,p);
                passedVariables.put(p.getName().toLowerCase(),v);
                pvArray[scan]=v;
            }
        }
    }
    
    @Override
    public Variable getVariableThisScopeOnly(String name) {
        
        Variable result = super.getVariableThisScopeOnly(name);
        if (result!=null) return result;

        initPassedVariables();
        return passedVariables.get(name.toLowerCase());
    }    

    public Procedure getProcedure()
    {
        return procedure;
    }

    @Override
    public ReturningExpr getReturnValue() {
        return procedure.getResult();
    }


    private ProcedureScope origin; 
    
    public void setOrigin(ProcedureScope origin) {
        this.origin=origin;
    }

    @Override
    public Scope getParent() {
        if (origin!=null) return origin;
        return super.getParent();
    }

    @Override
    public Scope getStackParent() {
        return super.getParent();
    }

    @Override
    public Variable getParameter(int offset) {
        initPassedVariables();
        if (offset<1 || offset>pvArray.length)
            throw new IllegalArgumentException("Parameter out of bounds");
        
        return pvArray[offset-1];
        //return new PassedVariable(this,procedure.getParams()[offset-1]);
    }


    @Override
    public int getParameterCount() {
        initPassedVariables();
        return pvArray.length;
        //return procedure.getParams().length;
    }

    @Override
    public String getName() {
        
        StringBuilder name=new StringBuilder();
        name.append(procedure.getName());
        Param[] p=procedure.getParams();
        for (int scan=0;scan<p.length;scan++) {
            name.append("_");
            name.append(p[scan].getType().getName());
        }
        return name.toString();
    }
    
    @Override
    public void addType(ExprType type,Scope originatingScope) {
        // push new types up a single level, maybe
        getParent().addType(type,originatingScope);
    }
}
