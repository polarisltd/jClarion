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

import org.jclarion.clarion.compile.java.JavaDependencyCollector;

public class NullExprType extends FilledExprType {

    public NullExprType()
    {
        super("null",null,0);
    }
    
    @Override
    public FilledExprType cloneType() {
        return new NullExprType();
    }

    @Override
    public void generateDefinition(StringBuilder out) {
        out.append("void");
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
    }

    @Override
    public boolean isa(ExprType test) {
        // null can be anything
        return true;
    }

    
    
}
