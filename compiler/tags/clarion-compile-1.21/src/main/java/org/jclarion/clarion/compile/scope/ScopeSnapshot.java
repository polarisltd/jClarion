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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.var.Variable;

public class ScopeSnapshot 
{
    private Map<String,Variable>    variables;
    private List<Procedure>         procedures;
    private Map<String,ExprType>    types;
    
    ScopeSnapshot(Map<String,Variable> variables,List<Procedure> procedures,Map<String,ExprType> types,boolean clone)
    {
        this.variables=variables;
        this.procedures=procedures;
        this.types=types;
        
        if (clone) cloneStructure();
    }
    
    public void remove(ScopeSnapshot oldScope) 
    {
        this.variables.keySet().removeAll(oldScope.variables.keySet());
        this.types.keySet().removeAll(oldScope.types.keySet());
        this.procedures.removeAll(oldScope.procedures);
    }

    public void add(ScopeSnapshot childScope) 
    {
        this.variables.putAll(childScope.variables);
        this.types.putAll(childScope.types);
        this.procedures.removeAll(childScope.procedures);
        this.procedures.addAll(childScope.procedures);
    }
    
    private void cloneStructure()
    {
        variables=new LinkedHashMap<String, Variable>(variables);
        procedures=new ArrayList<Procedure>(procedures);
        types=new HashMap<String, ExprType>(types);
    }
    
    public Iterable<Variable> getVariables()
    {
        return variables.values();
    }
    
    public Iterable<Map.Entry<String,ExprType>> getTypes()
    {
        return types.entrySet();
    }
    
    public Iterable<Procedure> getProcedures()
    {
        return procedures;
    }
}
