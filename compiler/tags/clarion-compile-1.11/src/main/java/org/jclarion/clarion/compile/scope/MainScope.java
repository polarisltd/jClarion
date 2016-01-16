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
import java.util.List;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.expr.DanglingExprType;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.java.ClassRepository;
import org.jclarion.clarion.compile.java.JavaCode;
import org.jclarion.clarion.compile.java.MainVariableInitCode;
import org.jclarion.clarion.compile.java.ScopedJavaClass;
import org.jclarion.clarion.compile.var.EquateVariable;
import org.jclarion.clarion.compile.var.Variable;

public class MainScope extends Scope implements StaticScope
{
    public static MainScope main;
    
    static {
        clean();
    }

    public static void clean() {
        main=new MainScope();
        ClassRepository.add(new ScopedJavaClass(main,ClarionCompiler.BASE),"Main");
    }

    @Override
    public String getName() {
        return "Main";
    }

    private List<Variable> staticVariables=new ArrayList<Variable>();
    
    @Override
    public void addStaticVariable(Variable v) {
        staticVariables.add(v);
    }

    @Override
    public Iterable<Variable> getStaticVarIterable() {
        return staticVariables;
    }

    @Override
    public ExprType getType(String name) {
        ExprType e = super.getType(name);
        if (e==null) e = DanglingExprType.find(name);
        return e;
    }
    
    public JavaCode getMainInitVariables()
    {
        return new MainVariableInitCode(allStaticVariables.getVariables());
    }
    
    private static class AllStaticScope extends Scope
    {
        @Override
        public String getName() {
            return "allStaticVariables";
        }
        
        @Override
        public void addVariable(Variable aVariable)
        {
            simpleAddVariable(aVariable);
        }
        
        protected String getLookupVariableName(Variable aVariable)
        {
            return aVariable.getScope()+"."+aVariable.getJavaName();
        }
        
    }
    
    private Scope allStaticVariables = new AllStaticScope();
    
    public void registerStaticVariable(Variable v)
    {
        if (v instanceof EquateVariable) return;
        allStaticVariables.addVariable(v);
    }
}
