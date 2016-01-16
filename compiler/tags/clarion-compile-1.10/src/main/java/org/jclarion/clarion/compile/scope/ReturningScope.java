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
package org.jclarion.clarion.compile.scope;

import org.jclarion.clarion.compile.expr.ReturningExpr;
import org.jclarion.clarion.compile.prototype.Procedure;
import org.jclarion.clarion.compile.var.Variable;

public interface ReturningScope {
    
    public abstract Variable getParameter(int offset);
    public abstract int      getParameterCount();
    
    public abstract Procedure getProcedure();
    
    public abstract ReturningExpr getReturnValue();
}
