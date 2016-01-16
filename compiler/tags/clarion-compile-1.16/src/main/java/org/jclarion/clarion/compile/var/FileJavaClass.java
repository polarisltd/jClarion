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
import org.jclarion.clarion.compile.expr.ExprType;
import org.jclarion.clarion.compile.java.JavaClass;
import org.jclarion.clarion.compile.java.JavaDependencyCollector;
import org.jclarion.clarion.compile.prototype.Procedure;

public class FileJavaClass extends JavaClass
{
    private FileConstruct group;
    
    public FileJavaClass(FileConstruct group)
    {
        this.group=group;
    }

    @Override
    public Iterable<Variable> getFields() {
        return group.getVariables();
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
        main.append("()\n");
        main.append("\t{\n");
    
        group.getPropertyCode().write(main,2,false);
        group.getPropertyCode().collate(collector);
        
        for ( Variable v : group.getVariables() ) {
            if (v.getType().same(ExprType.key)) continue;
            
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

        for ( Variable v : group.getVariables() ) {
            if (!v.getType().same(ExprType.key)) continue;
            
            main.append("\t\t");
            ((KeyVariable)v).getInitExpr().toJavaString(main);
            main.append(";\n");
            main.append("\t\tthis.addKey(");
            main.append(v.getJavaName());
            main.append(");\n");
        }

        main.append("\t}\n");
    }

    @Override
    protected void buildExtends(StringBuilder main,
            JavaDependencyCollector collector) {
        
        String name = "Clarion"+group.getDriverType()+"File";
        main.append(" extends ");
        main.append(name);
        collector.add(ClarionCompiler.CLARION+"."+name);
    }

    @Override
    public void setThreaded() {
        // do nothing. ClarionGroups know how to thread at runtime. 
    }
}
