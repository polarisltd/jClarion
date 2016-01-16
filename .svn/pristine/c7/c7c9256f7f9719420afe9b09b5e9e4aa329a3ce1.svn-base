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
package org.jclarion.clarion.compile.var;

import org.jclarion.clarion.compile.expr.Expr;
import org.jclarion.clarion.compile.expr.VariableExpr;
import org.jclarion.clarion.compile.grammar.Parser;
import org.jclarion.clarion.compile.setting.SettingParser;
import org.jclarion.clarion.compile.setting.SettingResult;
import org.jclarion.clarion.lang.Lex;
import org.jclarion.clarion.lang.LexType;
import org.jclarion.clarion.lang.Lexer;

public class UseVarSettingParser extends SettingParser<UseVar> {

    @Override
    public SettingResult<UseVar> get(Parser p) 
    {
        Lexer l = p.getLexer();
        
        if (l.lookahead().type!=LexType.label) return null;
        if (!l.lookahead().value.equalsIgnoreCase("use")) return null;
        if (l.lookahead(1).type!=LexType.lparam) return null;
        
        l.next();
        l.next();

        // check three different types of use defs

        UseVar result=null;
        
        if (l.lookahead().type==LexType.use) {
            l.next();
            String label = l.next().value;
            if (l.lookahead().type==LexType.param) {
                l.next();
                Expr e = p.expression();
                if (l.lookahead().type==LexType.param && l.lookahead(1).type==LexType.use) {
                    l.next();
                    l.next();
                    label=l.next().value;
                }
                result =  new UseVar(label,null,e);
            } else {
                result = new UseVar(label);
            }
        } else {
            
            int lstart=p.getLexer().begin();
            Expr var = p.expression();
            Lex[] bits = p.getLexer().capture(lstart);
            p.getLexer().commit(lstart);
            
            if (var==null) l.error("Expected variable");
            if (!(var instanceof VariableExpr)) l.error("Expected variable - got "+var.getClass().toString());
            
            Expr number=null;
            if (l.lookahead().type==LexType.param) {
                l.next();
                number=p.expression();
            }
            
            String label=null;
            if (l.lookahead().type==LexType.param) {
                l.next();
                if (l.lookahead().type==LexType.use) l.next();
                label = l.next().value;
            } else {
                //label = ((VariableExpr)var).getVariable().getName();
                
                StringBuilder labelBuilder=new StringBuilder();
                for (int scan=0;scan<bits.length;scan++) {
                    Lex b = bits[scan];
                    if (b.type==LexType.label) {
                        labelBuilder.append(b.value);
                        continue;
                    }
                    if (b.type==LexType.lbrack) {
                        labelBuilder.append("_");
                        continue;
                    }
                    if (b.type==LexType.rbrack) {
                        continue;
                    }
                    if (b.type==LexType.dot) {
                        labelBuilder.append(":");
                        continue;
                    }

                    if (b.type==LexType.integer) {
                        labelBuilder.append(b.value);
                        continue;
                    }
                    
                    throw new IllegalStateException("What to do with this?:"+b); 
                }
                
                label=labelBuilder.toString();
            }
            result=new UseVar(label,var,number);
        }

        if (l.next().type!=LexType.rparam) l.error("expected ')'");
        
        return new SettingResult<UseVar>("use",result);
    }

}
