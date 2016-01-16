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

import java.util.HashSet;
import java.util.Set;

import org.jclarion.clarion.compile.grammar.Parser;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;

public class SimpleSettingParser extends SettingParser<Boolean>
{
    private Set<String> match=new HashSet<String>();
    
    public SimpleSettingParser(String... match)
    {
        for (int scan=0;scan<match.length;scan++) {
            this.match.add(match[scan].toLowerCase());
        }
    }

    @Override
    public SettingResult<Boolean> get(Parser p) {
        Lex n = p.getLexer().lookahead();
        if (n.type!=LexType.label) return null;
        String type = n.value.toLowerCase();
        if (!this.match.contains(type)) return null;
        p.getLexer().next();
        return new SettingResult<Boolean>(type,true);
    }
}
