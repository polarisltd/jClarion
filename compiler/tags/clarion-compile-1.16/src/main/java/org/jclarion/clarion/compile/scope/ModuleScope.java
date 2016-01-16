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
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.grammar.LexerSource;
import org.jclarion.clarion.compile.java.ClassRepository;
import org.jclarion.clarion.compile.java.JavaClass;
import org.jclarion.clarion.compile.java.Labeller;
import org.jclarion.clarion.compile.java.ModuleScopedJavaClass;
import org.jclarion.clarion.compile.var.Variable;

public class ModuleScope extends Scope implements StaticScope
{
    private static Map<String,ModuleScope> modules=new HashMap<String, ModuleScope>();

    private static LinkedList<ModuleScope> uncompiledModules=new LinkedList<ModuleScope>();
    
    private String module_name;
    
//    private static Set<String> systemModules = GrammarHelper.list("winapi","c55runx","core","api_function_call","c runtime");
    
    public static ModuleScope get(String name)
    {
        name = name.replaceAll("\"","");
        name = LexerSource.getInstance().cleanName(name);
        
        ModuleScope scope = modules.get(name);
        if (scope==null) {
            scope=new ModuleScope(name);
            scope.setParent(MainScope.main);
            
            if (name.length()!=0) { 
                modules.put(name,scope);
                
                if (name.indexOf('.')>-1) {
                //if (!systemModules.contains(name.toLowerCase())) {
                    // QUIRK: do not compile winapi module. winapi
                    // is special placeholder fo windows hooks
                    uncompiledModules.add(scope);
                }

                String class_name = name;
                int dot = class_name.indexOf('.');
                if (dot>-1) {
                    class_name=class_name.substring(0,dot);
                }
                class_name=Labeller.get(class_name,true);
                JavaClass jc = new ModuleScopedJavaClass(scope,ClarionCompiler.BASE);
                ClassRepository.add(jc,class_name);
                scope.module_name=class_name;
            }
        }
        
        return scope;
    }

    private String file;
    
    private ModuleScope(String file)
    {
        this.file=file;
    }

    public String getFile()
    {
        return file;
    }
    
    public static void removeAll() {
        modules.clear();
        uncompiledModules.clear();
    }
    
    public static Collection<ModuleScope> getModules()
    {
        return modules.values();
    }

    public static ModuleScope getNextUncompiledModule()
    {
        if (uncompiledModules.isEmpty()) return null;
        return uncompiledModules.removeFirst();
    }

    public ModuleScopedJavaClass getModuleClass() {
        return (ModuleScopedJavaClass)getJavaClass();
    }
    
    @Override
    public String getName() {
        return module_name;
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

    public static void fixModuleScopes() {
        for (ModuleScope ms : modules.values() ) {
            ms.fixDisorder();
        }
    }

    @Override
    public void fixDisorder()
    {
        ((ModuleScopedJavaClass)getJavaClass()).fixSingleDisorder();
        super.fixDisorder();
    }
}
