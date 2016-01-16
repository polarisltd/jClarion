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

import java.util.Set;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.grammar.GrammarHelper;
import org.jclarion.clarion.compile.java.JavaClass;
import org.jclarion.clarion.compile.java.JavaCode;
import org.jclarion.clarion.compile.java.JavaDependencyCollector;
import org.jclarion.clarion.compile.java.LinearJavaBlock;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.util.JoinedIterable;

public class TargetJavaClass extends JavaClass {

    private TargetConstruct group;
    
    private LinearJavaBlock init;
    private String base;
    
    public TargetJavaClass(String base,TargetConstruct group)
    {
        this.group=group;
        this.base=base;
        init=new LinearJavaBlock();
    }
    
    @SuppressWarnings("unchecked")
    @Override
    public Iterable<? extends Variable> getFields() {
        return new JoinedIterable<Variable>(
                group.getUseVariables(),
                group.getVariables());
    }

    @Override
    public Iterable<Procedure> getMethods() {
        return noMethods;
    }

    @Override
    public String getPackage() {
        return base;
    }

    public void addInit(JavaCode code)
    {
        init.add(code);
    }


    @Override
    protected void buildConstructor(StringBuilder main,
            JavaDependencyCollector collector) {
        
        main.append("\tpublic ");
        main.append(getName());
        main.append("(");
        
        if (!isInitConstructionMode()) {
            group.renderEscalatedPrototypeList(main,collector);
        } 
        
        main.append(")\n");
        main.append("\t{\n");
        
        if (isInitConstructionMode()) {
            main.append("\t}\n");
            main.append("\tpublic void __Init__(");
            group.renderEscalatedPrototypeList(main,collector);
            main.append(")\n");
            main.append("\t{\n");
        }
        
        init.write(main,2,false);
        init.collate(collector);
        
        main.append("\t}\n");
    }



    @Override
    protected void buildExtends(StringBuilder main,
            JavaDependencyCollector collector) {
        
        String type = GrammarHelper.capitalise(group.getBaseType().getName());
        
        main.append(" extends Clarion");
        main.append(type);
        collector.add(ClarionCompiler.CLARION+".Clarion"+type);
    }


    public boolean initUtilises(Set<Variable> var)
    {
        return init.utilises(var);
    }

    public boolean initUtilisesReferenceVariables()
    {
       return init.utilisesReferenceVariables();
    }
}
