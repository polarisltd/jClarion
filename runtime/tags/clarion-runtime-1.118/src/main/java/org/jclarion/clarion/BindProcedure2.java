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
package org.jclarion.clarion;


import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.CExprScope;
import org.jclarion.clarion.runtime.expr.LabelExprResult;

/**
 * Model a procedure bound using Clarion bind command. See CExpression
 * @author barney
 *
 */
public abstract class BindProcedure2 implements LabelExprResult
{
    public abstract ClarionObject execute(ClarionObject p[]);
    
	public ClarionObject execute(CExprScope scope, CExpr... params) 
	{        
		ClarionObject[] r=null;
        if (params==null) {
        	r=new ClarionString[0];
        } else {
            r=new ClarionObject[params.length];
            int scan=0;
            for ( CExpr param : params ) {
                r[scan++]=param.eval(scope);
            }
        }
        
        ClarionObject co = execute(r);
        if (co==null) return new ClarionBool(false);
        return co;
	}
}
