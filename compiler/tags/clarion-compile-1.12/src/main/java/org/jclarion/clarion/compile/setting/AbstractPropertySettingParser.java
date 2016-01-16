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
import org.jclarion.clarion.lang.Lexer;

public abstract class AbstractPropertySettingParser<T> extends SettingParser<T>
{
    private String key;
    private Set<String> keys;
    
    public AbstractPropertySettingParser(String... key)
    {
        if (key.length==1) {
            this.key=key[0];
        } else {
            keys=new HashSet<String>();
            for (int scan=0;scan<key.length;scan++) {
                keys.add(key[scan].toLowerCase());
            }
        }
    }

    protected abstract T getValue(Parser p);

    protected abstract T getDefaultValue();
    
    @Override
    public SettingResult<T> get(Parser p) {
        
        Lexer l = p.getLexer();
        
        Lex label = l.lookahead();
        if (label.type!=LexType.label) return null;
        if (key!=null) {
            if (!label.value.equalsIgnoreCase(key)) return null;
        } else {
            if (!keys.contains(label.value.toLowerCase())) return null;
        }
        
        if (l.lookahead(1).type!=LexType.lparam) {
            T result = getDefaultValue();
            if (result==null) return null;
            l.next(); // skip label
            return new SettingResult<T>(key,result);
        }
        
        int pos = l.begin();
        l.next(); // skip label
        l.next(); // skip '('
        
        T result = getValue(p);
        if (result==null) {
            l.rollback(pos);
            return null;
        }
        
        if (l.next().type!=LexType.rparam) {
            l.rollback(pos);
            return null;
        }

        l.commit(pos);
        
        return new SettingResult<T>(key!=null?key:label.value.toLowerCase(),result);
    }
}
