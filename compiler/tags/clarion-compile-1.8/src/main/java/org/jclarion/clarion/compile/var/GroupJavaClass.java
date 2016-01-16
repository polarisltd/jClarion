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
import org.jclarion.clarion.compile.grammar.GrammarHelper;
import org.jclarion.clarion.compile.java.JavaClass;
import org.jclarion.clarion.compile.java.JavaDependencyCollector;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.scope.Scope;

public class GroupJavaClass extends JavaClass
{
    private GroupConstruct group;
    
    public GroupJavaClass(GroupConstruct group)
    {
        this.group=group;
    }

    @Override
    protected void buildVariables(StringBuilder main,
            JavaDependencyCollector collector) {
        for (Variable v : group.getVariables() ) {
            main.append("\tpublic ");

            if (group.anyEscalatedVariables()) {
                v.generateDefinition(main);
            } else {
                v.generate(main);
            }
            v.collate(collector);
            main.append(";\n");
        }
    }
    
    @Override
    public Iterable<Procedure> getMethods() {
        return noMethods;
    }

    @Override
    public String getPackage() {
        return ClarionCompiler.BASE;
    }

    @Override
    protected void buildConstructor(StringBuilder main,
            JavaDependencyCollector collector) {
        
        main.append("\n");
        main.append("\tpublic ");
        main.append(getName());
        main.append("(");

        group.renderEscalatedPrototypeList(main, collector);
        
        main.append(")\n");
        main.append("\t{\n");
        
        for ( Variable v : group.getVariables() ) {
            
            if (group.anyEscalatedVariables()) {
                main.append("\t\tthis.");
                main.append(v.getJavaName());
                main.append("=");
                v.generateConstruction(main);
                main.append(";\n");
            }
            
            if (v.isReference()) {
                main.append("\t\tthis.addReference(\"");
            } else {
                main.append("\t\tthis.addVariable(\"");
            }
            main.append(v.getName());
            main.append("\",this.");
            main.append(v.getJavaName());
            main.append(");\n");
        }

        main.append("\t}\n");
    }

    @Override
    protected void buildExtends(StringBuilder main,
            JavaDependencyCollector collector) {
        
        if (getSuper()!=null) {
            super.buildExtends(main, collector);
        } else {
            String name = GrammarHelper.capitalise(group.getBaseType().getName());
            main.append(" extends Clarion"+name);
            collector.add(ClarionCompiler.CLARION+".Clarion"+name);
        }
    }

    @Override
    public JavaClass getSuper() {
        if (group.getSuper()!=null) {
            return group.getSuper().getJavaClass();
        }
        return null;
    }

    @Override
    public Iterable<? extends Variable> getFields() {
        // TODO Auto-generated method stub
        return null;
    }
    
    @Override
    public Scope getScope()
    {
        return group;
    }

    @Override
    public void setInitConstructionMode(boolean initConstructionMode) {
        if (initConstructionMode) throw new RuntimeException("Not Allowed");
        super.setInitConstructionMode(initConstructionMode);
    }
}
