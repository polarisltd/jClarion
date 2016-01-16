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
package org.jclarion.clarion.runtime;

import org.jclarion.clarion.BindProcedure;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.CExprType;

/**
 * A bind procedure that has a SQL analogue
 * @author barney
 */
public abstract class SQLBindProcedure extends BindProcedure
{
    private String name;
    private CExprType returnType;
    private CExprType[] paramTypes;

    public SQLBindProcedure(String name,CExprType returnType,CExprType... paramTypes)
    {
        this.name=name;
        this.returnType=returnType;
        this.paramTypes=paramTypes;
    }
    
    public boolean generateString(StringBuilder out,boolean strict,CExpr params[]) 
    {
        int pos = out.length();
        if (params.length!=paramTypes.length) return false;
        
        out.append(name);
        out.append('(');
        
        for (int scan=0;scan<params.length;scan++) {
            if (params[scan].getType()!=paramTypes[scan]) {
                if (!params[scan].isRecastableType()) {
                    out.setLength(pos);
                    return false;
                }
                params[scan].cast(paramTypes[scan]);
            }
            if (scan>0) out.append(',');
            if (!params[scan].generateString(out,strict)) {
                out.setLength(pos);
                return false;
            }
        }
        out.append(')');
        return true;
    }
    
    public CExprType getReturnType()
    {
        return returnType;
    }
}
