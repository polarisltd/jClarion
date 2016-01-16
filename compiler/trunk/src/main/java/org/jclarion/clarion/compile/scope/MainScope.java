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

import java.util.Collection;
import java.util.HashMap;
import java.util.IdentityHashMap;
import java.util.LinkedList;
import java.util.Map;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.grammar.LocalIncludeCache;
import org.jclarion.clarion.compile.java.MainJavaClass;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.var.Variable;


public class MainScope extends Scope 
{
    private Map<String,ModuleScope> modules=new HashMap<String, ModuleScope>();
    private LinkedList<ModuleScope> uncompiledModules=new LinkedList<ModuleScope>();
    
    public MainScope(ScopeStack stack)
    {
    	super(stack);
    	stack.setMain(this);
        for (Class<?> c : ExprType.BASE_CLASSES ) { 
            addType(ExprType.getBasicJavaMapping(c));
        }
        stack.compiler().repository().add(new MainJavaClass(this,ClarionCompiler.RAW_BASE),getPackage(),"Main");
    }
    
    public ModuleScope get(String name)
    {
        name = name.replaceAll("\"","");
        name = getStack().compiler().source().cleanName(name);
        
        ModuleScope scope = modules.get(name);
        if (scope==null) {
            scope=new ModuleScope(name,this);
            if (name.length()>0) {
            	modules.put(name,scope);
            	if (name.indexOf('.')>-1) {
            		uncompiledModules.add(scope);
            	}
            }
        }        
        return scope;
    }

    public Collection<ModuleScope> getModules()
    {
        return modules.values();
    }

    public ModuleScope getNextUncompiledModule()
    {
        if (uncompiledModules.isEmpty()) return null;
        return uncompiledModules.removeFirst();
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

    @Override
    public String getName() {
        return "Main";
    }

    @Override
    public ExprType getType(String name) {
        ExprType e = super.getType(name);
        if (e==null) e = getStack().compiler().dangles().find(name);
        return e;
    }
    
    private IdentityHashMap<Procedure,String> registeredPrototypes;
    private Map<String,Procedure> registeredPrototypesByName;
	private LocalIncludeCache localIncludeCache;
    
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
	
	@Override
	public String getPackage()
	{
		return ClarionCompiler.RAW_BASE;
	}

	@Override
	public LocalIncludeCache getLocalIncludeCache(boolean create)
	{
		if (localIncludeCache==null) localIncludeCache=new LocalIncludeCache();
		return localIncludeCache;
	}
	
	@Override
	public LocalIncludeCache getLocalIncludeCache(String variable) 
	{
		if (localIncludeCache==null) return null;
		if (localIncludeCache.getIncludeSnapshot(getStack().compiler().source(),variable)!=null) return localIncludeCache;
		return null;
	}	

    public boolean isStaticScope()
    {
    	return true;
    }	
}
