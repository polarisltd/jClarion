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
package org.jclarion.clarion.compile.java;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.hook.HookContentResolver;
import org.jclarion.clarion.compile.hook.HookEntry;
import org.jclarion.clarion.compile.hook.HookFactory;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.scope.Scope;
import org.jclarion.clarion.compile.scope.StaticScope;
import org.jclarion.clarion.compile.var.Variable;
import org.jclarion.clarion.util.EmptyIterable;

/**
 * Model a java class. Java class is broken down into several components:
 * 
 * Package namespace
 * 
 * Dependency list
 * 
 * Class definition
 * 
 * instance/static field list
 * 
 * constructor (special type of method)
 * 
 * methods
 *  
 * @author barney
 */

public abstract class JavaClass implements JavaDependency, HookContentResolver  
{
    
    public abstract String                      getPackage();
    
    private String name;
    
    private boolean initConstructionMode;
    
    public final String getName()
    {
        return name;
    }
    
    public final void setName(String name)
    {
        this.name=name;
    }
    
    protected final static Iterable<Procedure> noMethods = new EmptyIterable<Procedure>(); 
    public abstract Iterable<? extends Procedure>       getMethods();

    protected final static Iterable<Variable> noFields= new EmptyIterable<Variable>(); 
    public abstract Iterable<? extends Variable>        getFields();

    public JavaClass getSuper()
    {
        return null;
    }
    
    private String dependency=null;
    
    @Override
    public void collate(JavaDependencyCollector collector) {
        if (dependency==null) {
            if (name==null) throw new IllegalStateException("No name set");
            dependency=getPackage()+"."+name;
        }
        collector.add(dependency);
    }

    public void appendFieldModifier(StringBuilder out)
    {
    }
    
    public boolean isAbstract()
    {
        /*
        for ( Procedure p : getMethods() ) {
            if (p.isAbstract()) {
                return true;
            }
        }
        */
        return false;
    }
    
    public String toJavaSource()
    {
        HookEntry entry=null;
        
        if (getScope()!=null) {
            entry=HookFactory.getInstance().getHook(getScope());
        }
        
        StringBuilder pkg=new StringBuilder();
        StringBuilder main=new StringBuilder();
        
        pkg.append("package ");
        pkg.append(getPackage());
        pkg.append(";\n");
        pkg.append("\n");
        
        JavaDependencyCollector collector=new JavaDependencyCollector(getPackage()+"."+getName());
        
        main.append("public ");
        
        if (isAbstract()) main.append("abstract ");
        
        main.append("class ");
        main.append(getName());
        
        buildExtends(main,collector);

        if (entry!=null && entry.getHook()!=null) {
            main.append(" implements ");
            main.append(entry.getHook());
        }
        
        main.append("\n");
        
        main.append("{\n");

        if (entry!=null) {
            main.append(entry.getContents(this));
        }

        buildPreFields(main,collector);

        buildVariables(main,collector);
        

        buildPostFields(main,collector);

        buildConstructor(main,collector);
        
        if (getMethods().iterator().hasNext()) {
            main.append("\n");
            
            for (Procedure m : getMethods() ) {
                m.write(main,collector);
            }
        }
        
        main.append("}\n");

        if (!collector.get().isEmpty()) {
            for (String s : collector.get()) {
                pkg.append("import ");
                pkg.append(s);
                pkg.append(";\n");
            }
            pkg.append("\n");
        }
        
        pkg.append(main);
        
        return pkg.toString();
    }

    protected void buildVariables(StringBuilder main,
            JavaDependencyCollector collector) {
        for (Variable v : getFields() ) {
            main.append("\tpublic ");
            appendFieldModifier(main);
            if (getScope()!=null && (getScope() instanceof StaticScope)) {
                v.generateDefinition(main);
            } else {
                v.generate(main);
            }
            v.collate(collector);
            main.append(";\n");
        }
    }

    protected void buildPostFields(StringBuilder main,
            JavaDependencyCollector collector) {
    }

    protected void buildPreFields(StringBuilder main,
            JavaDependencyCollector collector) {
    }

    protected void buildExtends(StringBuilder main,
            JavaDependencyCollector collector) {
        if (getSuper()!=null) {
            main.append(" extends ");
            main.append(getSuper().getName());
            getSuper().collate(collector);
        }
    }

    protected void buildConstructor(StringBuilder main,
            JavaDependencyCollector collector) {
    }
    
    public Scope getScope()
    {
        return null;
    }

    @Override
    public String resolve(String key) {
        if (key.equals("clarion")) return ClarionCompiler.CLARION;
        if (key.startsWith("type:")) {
            return getScope().getType(key.substring(5)).generateDefinition();
        }
        return null;
    }

    public boolean isInitConstructionMode() {
        return initConstructionMode;
    }

    public void setInitConstructionMode(boolean initConstructionMode) {
        this.initConstructionMode = initConstructionMode;
    }
}
