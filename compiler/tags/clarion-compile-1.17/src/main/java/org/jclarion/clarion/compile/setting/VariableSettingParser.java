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
package org.jclarion.clarion.compile.setting;

import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.VariableExpr;
import org.jclarion.clarion.compile.grammar.Parser;

public class VariableSettingParser extends AbstractPropertySettingParser<VariableExpr>
{

    public VariableSettingParser(String key) {
        super(key);
    }

    @Override
    protected VariableExpr getValue(Parser p) {
        
        int pos = p.getLexer().begin();
        Expr e = p.expression();
        if (e!=null && (e instanceof VariableExpr)) {
            p.getLexer().commit(pos);
            return (VariableExpr)e;
        }
        
        p.getLexer().rollback(pos);
        return null;
    }

    @Override
    protected VariableExpr getDefaultValue() {
        return null;
    }

}
