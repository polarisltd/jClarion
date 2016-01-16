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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jclarion.clarion.ClarionDecimal;
import org.jclarion.clarion.ClarionNumber;
import org.jclarion.clarion.ClarionString;
import org.jclarion.clarion.lang.*;

public class Parser {

    private Lexer stream;

    public Parser(Lexer stream)
    {
        this.stream=stream;
    }
    
    public CExpr expr() throws ParseException
    {
        CExpr result = expr1();
        enforceNext(LexType.eof,"Expected EOF");
        return result;
    }
    
    private CExpr expr1() throws ParseException
    {
        CExpr result = expr2();
        if (result==null) return null;
        
        while ( true ) {
            Lex la = stream.lookahead();
            if (la.type==LexType.label && 
                (la.value.equalsIgnoreCase("and") ||
                 la.value.equalsIgnoreCase("or")))
            {
                stream.begin();
                stream.next();
                CExpr right = expr2();
                if (right!=null) {
                    result=BoolExpr.construct(result,la.value,right);
                    stream.commit();
                    continue;
                } else {
                    stream.rollback();
                }
            }
            break;
        }
        return result;
    }
    
    private CExpr expr2()  throws ParseException {
        
        Lex la = stream.lookahead();
        
        if ((la.type==LexType.comparator && la.value.equals("~")) ||
            (la.type==LexType.label && la.value.equalsIgnoreCase("not"))) 
        {
            stream.begin();
            stream.next();
            CExpr result = expr3();
            if (result!=null) {
                result=new NotExpr(result);
                stream.commit();
            } else {
                stream.rollback();
            }
            return result;
        }
        
        return expr3();
    }

    private static Map<String,String> opMap=new HashMap<String,String>();
    private static Map<String,String> negMap=new HashMap<String,String>();
    static {
        opMap.put("<>","<>");
        opMap.put("~=","<>");
        opMap.put("=>",">=");
        opMap.put(">=",">=");
        opMap.put("=<","<=");
        opMap.put("<=","<=");
        opMap.put("<","<");
        opMap.put(">",">");
        opMap.put("=","=");
        opMap.put("&=","&=");

        negMap.put("<>","=");
        negMap.put("=","<>");
        negMap.put("<",">=");
        negMap.put("<=",">");
        negMap.put(">","<=");
        negMap.put(">=","<");
    };
    
    private CExpr expr3()  throws ParseException {
        CExpr result = expr4();
        if (result==null) return null;
        
        while ( true ) {
            
            stream.begin();
            boolean not=false;
            
            Lex la = stream.lookahead();
            if ((la.type==LexType.comparator && la.value.equals("~")) ||
                    (la.type==LexType.label && la.value.equalsIgnoreCase("not"))) 
            {
                stream.next();
                not=true;
                la = stream.lookahead();
            }
        
            String op=null;
            if (la.type!=LexType.string) {
                op=opMap.get(la.value);
            }

            if (op!=null && not) {
                op=negMap.get(op);
            }
            
            if (op==null) {
                stream.rollback();
                break;
            }
            
            stream.next();
            CExpr right = expr4();
            if (right==null) {
                stream.rollback();
                break;
            }
            stream.commit();
            result=new CmpExpr(result,op,right);
        }
        
        return result;
    }

    private CExpr expr4()  throws ParseException {
        CExpr result = expr5();
        if (result==null) return null;
        
        while ( true ) {
            if (stream.lookahead().type!=LexType.reference) break;
            stream.begin();
            stream.next();
            CExpr right=expr5();
            if (right!=null) {
                stream.commit();
                result=ConcatExpr.construct(result,right);
                continue;
            }
            stream.rollback();
            break;
        }
        return result;
    }

    private CExpr expr5()  throws ParseException 
    {
        CExpr result = expr6();
        if (result==null) return null;
        
        while ( true ) {
            Lex la = stream.lookahead();
            if (la.type==LexType.operator && 
                (la.value.equalsIgnoreCase("+") ||
                 la.value.equalsIgnoreCase("-")))
            {
                stream.begin();
                stream.next();
                CExpr right = expr6();
                if (right!=null) {
                    result=SumExpr.construct(result,la.value,right);
                    stream.commit();
                    continue;
                } else {
                    stream.rollback();
                }
            }
            break;
        }
        return result;
    }

    private CExpr expr6()  throws ParseException {
        CExpr result = expr7();
        if (result==null) return null;
        
        while ( true ) {
            Lex la = stream.lookahead();
            if (la.type==LexType.operator && 
                (la.value.equalsIgnoreCase("*") ||
                 la.value.equalsIgnoreCase("%") ||
                 la.value.equalsIgnoreCase("/")))
            {
                stream.begin();
                stream.next();
                CExpr right = expr7();
                if (right!=null) {
                    result=ProdExpr.construct(result,la.value,right);
                    stream.commit();
                    continue;
                } else {
                    stream.rollback();
                }
            }
            break;
        }
        return result;
    }

    private CExpr expr7()  throws ParseException {
        CExpr result = expr8();
        if (result==null) return null;
        
        while ( true ) {
            Lex la = stream.lookahead();
            if (la.type==LexType.operator && la.value.equalsIgnoreCase("^"))
            {
                stream.begin();
                stream.next();
                CExpr right = expr8();
                if (right!=null) {
                    result=new PowExpr(result,right);
                    stream.commit();
                    continue;
                } else {
                    stream.rollback();
                }
            }
            break;
        }
        return result;
    }

    private CExpr expr8() throws ParseException 
    {
        Lex la = stream.lookahead();
        if (la.type==LexType.operator && la.value.equals("+")) {
            stream.begin();
            stream.next();
            CExpr result = expr9();
            if (result!=null) {
                stream.commit();
                return result;
            }
            stream.rollback();
            return null;
        }

        if (la.type==LexType.operator && la.value.equals("-")) {
            stream.begin();
            stream.next();
            CExpr result = expr9();
            if (result!=null) {
                stream.commit();
                return new NegExpr(result);
            }
            stream.rollback();
            return null;
        }
        
        return expr9();
    }

    private CExpr expr9() throws ParseException 
    {
        Lex la = stream.lookahead();
        
        if (la.type==LexType.decimal) {
            stream.next();
            return new ConstExpr(new ClarionDecimal(la.value));
        }

        if (la.type==LexType.integer) {
            stream.next();
            return new ConstExpr(new ClarionNumber(la.value));
        }

        if (la.type==LexType.string) {
            stream.next();
            return new ConstExpr(new ClarionString(la.value));
        }
        
        if (la.type==LexType.lparam) {
            stream.begin();
            stream.next();
            CExpr contents = expr1();
            if (contents==null) {
                stream.rollback();
                error("No contents in param");
            }
            if (stream.next().type!=LexType.rparam) {
                stream.rollback();
                error("Missing ')'");
            }
            stream.commit();
            return contents;
        }

        if (la.type==LexType.label) {
            
            String label=la.value;
            
            stream.begin();
            stream.next();
            
            if (stream.lookahead().type==LexType.lparam) {
                List<CExpr> bits=new ArrayList<CExpr>();
                stream.next();
                while ( true ) {
                    CExpr param = expr1();
                    if (param==null) break;
                    bits.add(param);
                    if (stream.lookahead().type==LexType.param) {
                        stream.next();
                    } else {
                        break;
                    }
                }
                if (stream.next().type!=LexType.rparam) {
                    stream.rollback();
                    error("Missing ')'");
                }
                
                
                stream.commit();
                return new LabelExpr(label,bits); 
            }
            
            stream.commit();
            return new LabelExpr(label);
        }
        
        return null;
    }

    private Lex enforceNext(LexType type,String error) throws ParseException
    {
        Lex l = stream.next();
        if (l.type!=type) error(error);
        return l;
    }
    
    private void error(String error) throws ParseException
    {
        throw new ParseException(error);
    }
}