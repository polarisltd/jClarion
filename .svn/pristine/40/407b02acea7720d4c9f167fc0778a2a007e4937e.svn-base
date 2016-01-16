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
package org.jclarion.clarion.compile.expr;

import org.jclarion.clarion.compile.ClarionCompiler;
import org.jclarion.clarion.compile.java.JavaDependencyCollector;

public class ControlExprType extends FilledExprType
{
    public ControlExprType(String name)
    {
        super(name,ExprType.control,0);
    }

    private ControlExprType()
    {
    }
    
    @Override
    public FilledExprType cloneType() {
        return new ControlExprType();
    }

    @Override
    public void generateDefinition(StringBuilder out) {
        out.append(getName());
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        collector.add(ClarionCompiler.CLARION+".control."+getName());
    }

}
