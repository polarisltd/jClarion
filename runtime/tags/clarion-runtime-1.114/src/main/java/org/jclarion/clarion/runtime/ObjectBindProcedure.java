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

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.CExprScope;
import org.jclarion.clarion.runtime.expr.LabelExprResult;

public class ObjectBindProcedure implements LabelExprResult
{
    private ClarionObject value;
        
    public ObjectBindProcedure(ClarionObject value) {
        this.value=value;
    }

	@Override
	public ClarionObject execute(CExprScope scope, CExpr... params) {
		return value;
	}        
}
