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
import org.jclarion.clarion.compile.grammar.Parser;

public class ExprSettingParser extends AbstractPropertySettingParser<Expr>
{

    public ExprSettingParser(String... key) {
        super(key);
    }

    @Override
    protected Expr getValue(Parser p) {
        return p.expression();
    }

    @Override
    protected Expr getDefaultValue() {
        return null;
    }

}
