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
package org.jclarion.clarion.compile.var;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.java.JavaClass;
import org.jclarion.clarion.compile.java.JavaDependencyCollector;
import org.jclarion.clarion.compile.java.Labeller;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.scope.Scope;

public class ClassJavaClass extends JavaClass
{
    private ClassConstruct group;
    
    public ClassJavaClass(ClassConstruct group)
    {
        this.group=group;
    }

    @Override
    public Iterable<Variable> getFields() {
        return group.getVariables();
    }

    @Override
    public Iterable<Procedure> getMethods() {
        return group.getProcedures();
    }

    @Override
    public String getPackage() {
        return ClarionCompiler.BASE;
    }

    @Override
    public JavaClass getSuper() {
        if (group.getSuper()!=null) {
            return group.getSuper().getJavaClass();
        }
        return null;
    }
    
    @Override
    protected void buildVariables(StringBuilder main,
            JavaDependencyCollector collector) {
        for (Variable v : getFields() ) {
            main.append("\tpublic ");
            appendFieldModifier(main);
            v.generateDefinition(main);
            v.collate(collector);
            main.append(";\n");
        }
    }
    
    @Override
    protected void buildConstructor(StringBuilder main,
            JavaDependencyCollector collector) {
    
        if (group.getEscalatedModule()!=null) {
            main.append("\tpublic ");
            main.append(group.getEscalatedModule().getModuleClass().getName());
            main.append(" _owner;\n");
            group.getEscalatedModule().getModuleClass().collate(collector);
        }
        for (Variable v : group.getEscalatedVariables() ) {
            main.append("\t");
            v.generateDefinition(main);
            main.append(";\n");
            v.getType().collate(collector);
        }
        
        main.append("\tpublic ");
        main.append(getName());
        main.append("(");
        group.renderEscalatedPrototypeList(main, collector);
        main.append(")\n");
        main.append("\t{\n");

        if (group.getEscalatedModule()!=null) {
            main.append("\t\tthis._owner=_owner;\n");
        }
        for (Variable v : group.getEscalatedVariables() ) {
            main.append("\t\tthis.");
            main.append(v.getJavaName());
            main.append("=");
            main.append(v.getJavaName());
            main.append(";\n");
        }
        
        for (Variable v : getFields() ) {
            main.append("\t\t");
            main.append(v.getJavaName());
            main.append("=");
            v.generateConstruction(main);
            main.append(";\n");
        }

        // call construct
        Procedure p = group.matchProcedureThisScopeOnly("construct",new Expr[0]);
        if (p!=null) {
            main.append("\t\t");
            main.append(Labeller.get(p.getName(),false));
            main.append("();\n");
        }
        main.append("\t}\n");
        
        // call destruct
        /*
        p = group.matchProcedureThisScopeOnly("destruct",new Expr[0]);
        if (p!=null) {
            main.append("\tpublic void finalize() { ");
            main.append(Labeller.get(p.getName(),false));
            main.append("(); }\n");
        }
        */
        
        if (isInitConstructionMode() && group.anyEscalatedVariables()) {
            main.append("\tpublic ");
            main.append(getName());
            main.append("() {}\n");
            
            main.append("\tpublic void __Init__");
            main.append("(");
            group.renderEscalatedPrototypeList(main, collector);
            main.append(")\n");
            main.append("\t{\n");

            if (group.getEscalatedModule()!=null) {
                main.append("\t\tthis._owner=_owner;\n");
            }
            for (Variable v : group.getEscalatedVariables() ) {
                main.append("\t\tthis.");
                main.append(v.getJavaName());
                main.append("=");
                main.append(v.getJavaName());
                main.append(";\n");
            }
            
            for (Variable v : getFields() ) {
                main.append("\t\t");
                main.append(v.getJavaName());
                main.append("=");
                v.generateConstruction(main);
                main.append(";\n");
            }

            // call construct
            p = group.matchProcedureThisScopeOnly("construct",new Expr[0]);
            if (p!=null) {
                main.append("\t\t");
                main.append(Labeller.get(p.getName(),false));
                main.append("();\n");
            }
            main.append("\t}\n");
        }
    }
    

    @Override
    protected void buildPostFields(StringBuilder main,
            JavaDependencyCollector collector) {
        
        // build interface lazy gettors etc
        for (InterfaceImplementationConstruct iic : group.getInterfaces() ) {

            main.append("\n");
            main.append("\tprivate static class _");
            
            String name=iic.getBaseInterface().getJavaClass().getName();
            
            main.append(name);
            main.append("_Impl extends ");
            main.append(name);
            main.append("\n");
            main.append("\t{\n");
            main.append("\t\tprivate ").append(getName()).append(" _owner;\n");
            main.append("\t\tpublic _").append(name).append("_Impl(").append(getName()).append(" _owner)\n");
            main.append("\t\t{\n");
            main.append("\t\t\tthis._owner=_owner;\n");
            main.append("\t\t}\n");
            
            for ( Procedure proc : iic.getProcedures() ) {
                proc.write("\t\t",main,collector);
            }
            
            main.append("\t}\n");
            
            main.append("\tprivate ");
            main.append(name);
            main.append(" _");
            main.append(name);
            main.append("_inst;\n");
            
            main.append("\tpublic ");
            main.append(name);
            main.append(" ");
            main.append(Labeller.get(name,false));
            main.append("()\n");
            main.append("\t{\n");
            main.append("\t\tif (_").append(name).append("_inst==null) ");
            main.append("_").append(name).append("_inst=new _").append(name).append("_Impl(this);\n");
            main.append("\t\treturn _").append(name).append("_inst;\n");
            main.append("\t}\n");
            
 
            iic.getBaseInterface().getJavaClass().collate(collector);
        }
    }

    @Override
    public Scope getScope()
    {
        return group;
    }
    
    
}
