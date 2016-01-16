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


import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.grammar.LocalIncludeCache;
import org.jclarion.clarion.compile.java.Labeller;
import org.jclarion.clarion.compile.java.ModuleScopedJavaClass;
import org.jclarion.clarion.compile.var.Variable;


public class ModuleScope extends Scope
{
    
    private String module_name;
    
    private String base;
    
    @Override
    public Iterable<Variable> getVariables() {
    	Expr.DEEP_UTILISATION_TEST=true;
    	try {
    		return super.getVariables();
    	} finally {
    		Expr.DEEP_UTILISATION_TEST=false;
    	}
    }
        

    private String file;

    public ModuleScope(String file,MainScope parent)
    {
    	super(parent.getStack());
        this.file=file;        
        setParent(parent);
        base=parent.getPackage();
        String ext = file.toLowerCase();
        if (ext.indexOf('.')>-1) {
        	ext=ext.substring(0,ext.indexOf('.'));
        	if (ext.length()>0) {
        		base=base+"."+ext;
        	}
        }
        
        if (file.length()!=0) { 
            String class_name = file;
            int dot = class_name.indexOf('.');
            if (dot>-1) {
                class_name=class_name.substring(0,dot);
            }
            class_name=Labeller.get(class_name,true);            
            if (dot>-1) {
            	ModuleScopedJavaClass javaClass = new ModuleScopedJavaClass(this,getPackage());
            	parent.getStack().compiler().repository().add(javaClass,getPackage(),class_name);
            }
            module_name=class_name;
        }
        
    }

    public String getFile()
    {
        return file;
    }
    
 
 
    public ModuleScopedJavaClass getModuleClass() {
        return (ModuleScopedJavaClass)getJavaClass();
    }
    
    @Override
    public String getName() {
        return module_name;
    }
    
	private LocalIncludeCache localIncludeCache;
    
    @Override
    public String getPackage()
    {
    	if (base!=null) {
    		return base;
    	}
    	return super.getPackage();
    }
    
	@Override
	public LocalIncludeCache getLocalIncludeCache(boolean create)
	{
		if (localIncludeCache==null && create) localIncludeCache=new LocalIncludeCache();
		if (localIncludeCache!=null) return localIncludeCache;
		return getParent().getLocalIncludeCache(create);
	}
	
	@Override
	public LocalIncludeCache getLocalIncludeCache(String variable) 
	{
		LocalIncludeCache result = super.getLocalIncludeCache(variable);
		if (result==null && localIncludeCache!=null && localIncludeCache.getIncludeSnapshot(getStack().compiler().source(),variable)!=null) result=localIncludeCache;
		return result;
	}	
    public boolean isStaticScope()
    {
    	return true;
    }

	public void clean() {
		super.clean();
		localIncludeCache=null;
		ClarionCompiler compiler = getStack().compiler();
		compiler.repository().clear(getPackage());
    	compiler.repository().add(getJavaClass(),getPackage(),module_name);
    	compiler.equates().clean(getPackage());
	}	
}
