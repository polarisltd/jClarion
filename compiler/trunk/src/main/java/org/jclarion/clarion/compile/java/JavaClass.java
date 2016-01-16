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

import java.util.HashSet;
import java.util.Set;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.hook.HookContentResolver;
import org.jclarion.clarion.compile.hook.HookEntry;
import org.jclarion.clarion.compile.hook.HookFactory;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.scope.Scope;
import org.jclarion.clarion.compile.var.ClassExprType;
import org.jclarion.clarion.compile.var.ClassedVariable;
import org.jclarion.clarion.compile.var.EquateVariable;
import org.jclarion.clarion.compile.var.ReferenceVariable;
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
    private boolean threaded;
    private boolean compiled=true;
    
    
    public boolean isThreaded()
    {
        return threaded;
    }
    
    public boolean isCompiled()
    {
    	return compiled;
    }
    
    public void clearCompiled()
    {
    	compiled=false;
    }
    
    public void setCompiled()
    {
    	compiled=true;
    }
    
    public void setThreaded()
    {
        if (threaded) return;
        threaded=true;
        for (Variable v : getFields()) {
            ExprType et = v.getType().getReal();
            if (et instanceof ClassExprType) {
                ((ClassExprType)et).getJavaClass().setThreaded();
            }
            if (v instanceof ReferenceVariable) {
                ((ReferenceVariable)v).escalateReference();
            }
        }
    }
    
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
    
    public String toJavaSource(ClarionCompiler compiler)
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
        
        main.append("@SuppressWarnings(\"all\")\n");
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
        
        buildStaticInit(main,collector,compiler);

        buildPostFields(main,collector);

        buildConstructor(main,collector);
        
        buildThread(main,collector);
        
        
        if (getMethods().iterator().hasNext()) {
            Set<JavaMethodPrototype> dups=new HashSet<JavaMethodPrototype>();
            main.append("\n");
            
            for (Procedure m : getMethods() ) {
                m.write(main,collector,dups);
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
            if (isStatic(v)) {
            	main.append("static ");
            }
            if (getScope()!=null && isStatic(v)) {
                v.generateDefinition(main);
            } else {
                v.generate(main);
            }
            v.collate(collector);
            main.append(";\n");
        }
    }

    protected boolean isStatic(Variable v)
    {
    	return v.isStatic();
    }
    
    protected boolean generateBlankStatics()
    {
    	return false;
    }

    protected void buildStaticInit(StringBuilder main,JavaDependencyCollector collector,ClarionCompiler compiler) 
    {
    	if (getFields()==null) return;
    	
    	boolean any=generateBlankStatics();
    	boolean anyDestruct=generateBlankStatics();
    	if (!any || !anyDestruct) {
    		for (Variable v : getFields() ) {
    			if ( v instanceof EquateVariable) continue;
    			if (isStatic(v)) {
    				any=true;
    				if (v.isReference()) continue;
    				if (!v.getType().isDestroyable()) continue;
    				anyDestruct=true;
    				break;
    			}
    		}
    	}
        
        if (!any) return;

        compiler.main().getJavaClass().collate(collector);
        
        buildStatic(main,collector,anyDestruct);
        

    	main.append("\tpublic static void __static_init() {\n");        
    	buildPreStaticInit(main,collector);    	
        for ( Variable v : getFields() ) {
        	if (v instanceof EquateVariable) continue;
        	if (!isStatic(v)) continue;
        	main.append("\t\t");        
            if (v.getScope()!=getScope()) {
                v.getScope().getJavaClass().collate(collector);
                main.append(v.getScope().getJavaClass().getName());
                main.append('.');
            }
            v.getConstructionDependency().collate(collector);
            main.append(v.getJavaName());
            main.append("=");
            v.generateConstruction(main);
            main.append(";\n");
            
        }
    	buildPostStaticInit(main,collector);
    	main.append("\t}\n\n");
    	
    	if (anyDestruct) {
        	main.append("\tpublic static void __static_destruct() {\n");        
        	buildPreStaticDestruct(main,collector);    	        	
            for ( Variable v : getFields() ) {
            	if (v instanceof EquateVariable) continue;
            	if (v.isReference()) continue;
            	if (!isStatic(v)) continue;
                if (!v.getType().isDestroyable()) continue;
                main.append("\t\t");
                v.getType().destroy(v.getExpr(compiler.main())).toJavaString(main);
                main.append(";\n");
            }
        	buildPostStaticDestruct(main,collector);    	        	            
        	main.append("\t}\n\n");
    		
    	}
    }
    

	protected void buildStatic(StringBuilder main,JavaDependencyCollector collector,boolean anyDestruct) {
        main.append("\tstatic {\n");
        main.append("\t\tMain.__register_init(new Runnable() { public void run() { __static_init(); } });\n");
        if (anyDestruct) {
        	main.append("\t\tMain.__register_destruct(new Runnable() { public void run() { __static_destruct(); } });\n");
        }
        main.append("\t\t__static_init();\n");    	
    	main.append("\t}\n\n");
	}

	protected void buildPreStaticInit(StringBuilder main,JavaDependencyCollector collector) 
	{
	}

	protected void buildPostStaticInit(StringBuilder main,JavaDependencyCollector collector) 
    {
	}

	protected void buildPreStaticDestruct(StringBuilder main,JavaDependencyCollector collector) {
	}

	protected void buildPostStaticDestruct(StringBuilder main,JavaDependencyCollector collector) {
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
        } else {
            if (isThreaded()) {
                main.append(" extends org.jclarion.clarion.AbstractThreaded");
            }
        }
    }

    protected abstract void buildConstructor(StringBuilder main,JavaDependencyCollector collector);

    public void buildThread(StringBuilder main,JavaDependencyCollector collector)
    {
        if (!isThreaded()) return;
        main.append("\tpublic void initThread() {\n");
        
        main.append("\t\tsuper.initThread();\n");
        
        Iterable<? extends Variable> fields = getFields();
        if (fields!=null) {
            for (Variable v : fields ) {
                main.append("\t\t").append(v.getJavaName());
                if (v.isReference()) {
                    main.append(".setThread();\n");
                } else {
                    if (v instanceof ClassedVariable) {
                        main.append(".getThread();\n");
                    } else {
                        main.append(".setThread();\n");
                    }
                }
            }
        }

        registerConstructor(main,collector);
        
        main.append("\t}\n");

        main.append("\tprotected void lock(");
        main.append(getName());
        main.append(" base,Thread thread)\n");
        main.append("\t{\n");
        main.append("\t\tsuper.lock(base,thread);\n");
        if (fields!=null) {
            for (Variable v : fields ) {
                main.append("\t\tthis.").append(v.getJavaName());
                main.append("=(");
                v.generateType(main);
                main.append(")this.");
                main.append(v.getJavaName());
                main.append(".getLockedObject(thread);\n");
            }
        }
        main.append("\t}\n");
        main.append("\tpublic Object getLockedObject(Thread thread)\n");
        main.append("\t{\n");
        main.append("\t\t");
        main.append(getName());
        main.append(" result=new ");
        main.append(getName());
        main.append("();\n");
        main.append("\t\tresult.lock(this,thread);\n");
        main.append("\t\treturn result;\n");
        main.append("\t}\n");
        
    }
    
    protected void registerConstructor(StringBuilder main,JavaDependencyCollector collector) {
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