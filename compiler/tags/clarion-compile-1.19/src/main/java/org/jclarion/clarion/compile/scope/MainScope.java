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
import java.util.IdentityHashMap;
import java.util.List;
import java.util.Map;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.expr.DanglingExprType;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.expr.JavaExprTypeMapper;
import org.jclarion.clarion.compile.java.ClassRepository;
import org.jclarion.clarion.compile.java.JavaCode;
import org.jclarion.clarion.compile.java.MainJavaClass;
import org.jclarion.clarion.compile.java.MainVariableDestroyCode;
import org.jclarion.clarion.compile.java.MainVariableInitCode;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.var.EquateVariable;
import org.jclarion.clarion.compile.var.Variable;
import org.jclarion.clarion.runtime.concurrent.ICriticalSection;
import org.jclarion.clarion.runtime.concurrent.IMutex;
import org.jclarion.clarion.runtime.concurrent.IReaderWriterLock;
import org.jclarion.clarion.runtime.concurrent.ISemaphore;
import org.jclarion.clarion.runtime.concurrent.ISyncObject;
import org.jclarion.clarion.runtime.concurrent.IWaitableSyncObject;

public class MainScope extends Scope implements StaticScope
{
    public static MainScope main;
    
    static {
        clean();
    }

    public static void clean() {
        main=new MainScope();
        ClassRepository.add(new MainJavaClass(main,ClarionCompiler.BASE),"Main");
        
        for (Class<?> c : new Class<?>[] { 
                ICriticalSection.class,
                ISyncObject.class,
                IWaitableSyncObject.class,
                IMutex.class,
                ISemaphore.class,
                IReaderWriterLock.class,
        } ) {
            main.addType(JavaExprTypeMapper.importJava(c));
        }
        
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
        Iterable<Variable> var = allStaticVariables.getVariables();
        //System.out.println(var);
        return new MainVariableInitCode(var);
    }

    public JavaCode getMainDestroyVariables()
    {
        Iterable<Variable> var = allStaticVariables.getVariables();
        //System.out.println(var);
        return new MainVariableDestroyCode(var);
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

        @Override
        public Iterable<Variable> getVariables() {
            Expr.DEEP_UTILISATION_TEST=true;
            try {
                return super.getVariables();
            } finally {
                Expr.DEEP_UTILISATION_TEST=false;
            }
        }

        
    }
    
    private Scope allStaticVariables = new AllStaticScope();
    
    public void registerStaticVariable(Variable v)
    {
        if (v instanceof EquateVariable) return;
        allStaticVariables.addVariable(v);
    }

    private IdentityHashMap<Procedure,String> registeredPrototypes;
    private Map<String,Procedure> registeredPrototypesByName;
    
	public String registerPrototype(Procedure match) 
	{
		if (registeredPrototypes==null) {
			registeredPrototypes=new IdentityHashMap<Procedure, String>();
			registeredPrototypesByName=new HashMap<String, Procedure>();
		}
		
		String name = registeredPrototypes.get(match);
		if (name!=null) return name;
		name = match.getName();
		int count=1;
		while ( true ) {
			if (registeredPrototypesByName.containsKey(name)) {
				count++;
				name=match.getName()+"_"+count;
			} else {
				break;
			}
		}
		
		registeredPrototypesByName.put(name,match);
		registeredPrototypes.put(match,name);
		return name;
	}
	
	public Map<String,Procedure> getPrototypes()
	{
		return registeredPrototypesByName;
	}
}
