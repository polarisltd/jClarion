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
package org.jclarion.clarion.compile.prototype;

import java.util.Iterator;

import org.jclarion.clarion.compile.expr.ExprType;

public class ParamExprTypeIterator implements Iterator<ExprType>
{
    private Param[] params;
    int pos=0;
    
    public ParamExprTypeIterator(Param[] params)
    {
        this.params=params;
    }
    
    @Override
    public boolean hasNext() {
        return (pos<params.length);
    }

    @Override
    public ExprType next() {
        return params[pos++].getType();
    }

    @Override
    public void remove() {
        // TODO Auto-generated method stub
    }
}
