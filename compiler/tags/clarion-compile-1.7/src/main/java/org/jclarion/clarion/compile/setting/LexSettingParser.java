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

import org.jclarion.clarion.compile.grammar.Parser;
import org.jclarion.clarion.lang.Lex;

public class LexSettingParser extends AbstractPropertySettingParser<Lex>
{
    private Lex def;

    public LexSettingParser(String key,Lex def) {
        super(key);
        this.def=def;
    }

    @Override
    protected Lex getValue(Parser p) {
        return p.getLexer().next();
    }

    @Override
    protected Lex getDefaultValue() {
        return def;
    }
}
