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

import org.jclarion.clarion.compile.java.JavaClass;
import org.jclarion.clarion.compile.java.JavaDependencyCollector;

public abstract class ClassedExprType extends FilledExprType
{
    public abstract JavaClass getJavaClass();
    
    
    @Override
    public void generateDefinition(StringBuilder out) {
        out.append(getJavaClass().getName());
        for (int scan=0;scan<getArrayDimSize();scan++) {
            out.append("[]");
        }
    }

    public ClassedExprType() {
        super();
    }

    public ClassedExprType(String name, ExprType base, int array) {
        super(name, base, array);
    }

    @Override
    public void collate(JavaDependencyCollector collector) {
        getJavaClass().collate(collector);
    }
}
