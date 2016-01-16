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
package org.jclarion.clarion.runtime.expr;

import org.jclarion.clarion.ClarionObject;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.CExprScope;

/**
 * Model a procedure bound using Clarion bind command. See CExpression
 * @author barney
 *
 */
public interface LabelExprResult {
	public abstract ClarionObject execute(CExprScope scope, CExpr... params); 
}
