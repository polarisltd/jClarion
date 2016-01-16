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
import org.jclarion.clarion.compile.java.JavaClass;
import org.jclarion.clarion.compile.java.JavaDependencyCollector;
import org.jclarion.clarion.compile.prototype.Procedure;

public class ViewJavaClass extends JavaClass
{
    private ViewConstruct group;
    private String base;
    
    public ViewJavaClass(String base,ViewConstruct group)
    {
        this.group=group;
        this.base=base;
    }

    @Override
    public Iterable<Variable> getFields() {
        return noFields;
    }

    @Override
    public Iterable<Procedure> getMethods() {
        return noMethods;
    }

    @Override
    public String getPackage() {
        return base;
    }

    @Override
    protected void buildConstructor(StringBuilder main,
            JavaDependencyCollector collector) {
        
        main.append("\n");
        main.append("\tpublic ");
        main.append(getName());
        main.append("()\n");
        main.append("\t{\n");

        group.getPropertyCode().write(main,2,false);
        group.getPropertyCode().collate(collector);
        
        main.append("\t}\n");
    }

    @Override
    protected void buildExtends(StringBuilder main,
            JavaDependencyCollector collector) {
        
        main.append(" extends ClarionView");
        collector.add(ClarionCompiler.CLARION+".view.*");
    }
}
