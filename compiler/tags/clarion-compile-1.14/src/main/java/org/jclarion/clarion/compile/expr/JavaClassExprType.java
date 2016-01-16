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

public class JavaClassExprType extends ClassedExprType
{
    private JavaClass jc;

    public JavaClassExprType(JavaClass jc)
    {
        super(jc.getName(),ExprType.object,0);
        this.jc=jc;
    }
    
    @Override
    public JavaClass getJavaClass() {
        return jc;
    }

    @Override
    public FilledExprType cloneType() {
        return new JavaClassExprType(jc);
    }

}
