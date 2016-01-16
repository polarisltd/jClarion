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
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;

public class ExprListSettingParser extends SettingParser<Expr[]> {

    private String key;
    private int min;
    private int max;
    
    public ExprListSettingParser(String key,int min,int max)
    {
        this.key=key;
        this.min=min;
        this.max=max;
    }
    
    @Override
    public SettingResult<Expr[]> get(Parser p) {
        
        Lexer l = p.getLexer();
        
        if (l.lookahead(0).type!=LexType.label) return null;
        if (!l.lookahead(0).value.equalsIgnoreCase(key)) return null;
        
        l.next();
        
        Expr[] result=null;
        if (l.lookahead(0).type==LexType.lparam) {
            l.next();
            result=p.expressionList(LexType.rparam);
            if (l.next().type!=LexType.rparam) l.error("Expected ')'");
        } else {
            result=new Expr[0];
        }
        
        if (result.length<min) l.error("Too few parameters");
        if (result.length>max) l.error("Too many parameters");
        return new SettingResult<Expr[]>(key,result);
    }
}
