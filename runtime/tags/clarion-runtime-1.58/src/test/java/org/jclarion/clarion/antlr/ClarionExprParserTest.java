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
package org.jclarion.clarion.antlr;

import java.io.StringReader;

import org.jclarion.clarion.lang.Lexer;
import org.jclarion.clarion.runtime.expr.CExpr;
import org.jclarion.clarion.runtime.expr.ParseException;
import org.jclarion.clarion.runtime.expr.Parser;

import junit.framework.TestCase;

public class ClarionExprParserTest extends TestCase {

    public void testSimpleBrokenConstructs()
    {
        assertBad("hello!");
        assertBad("  100x10 ");
        assertBad("  this < not that ");
        assertSimple("  10 > 20 > 30 ");
    }
    
    public void testSimpleConstructs()
    {
        assertSimple("hello ");
        assertSimple("hello and world");
        assertSimple("hello or world");
        assertSimple("  hello or world  ");
        assertSimple("  hello and 0  ");
        assertSimple("  hello or 1234  ");
        assertSimple("  hello or 1234.567  ");
        assertSimple("  hello or 'this'  ");
        assertSimple("  clip('that') ");
        assertSimple("  clip('that '' and ',(10 or 1)) ");
        assertSimple("  this and ~ that ");

        assertSimple("  this < that ");
        assertSimple("  this > that ");
        assertSimple("  this >= that ");
        assertSimple("  this <= that ");
        assertSimple("  this = that ");
        assertSimple("  this not = that ");
        assertSimple("  this not < that ");
        assertSimple("  this < (not that) ");
        assertSimple("  clip(mf:partnum) & ' world ' & ' domination' ");
        assertSimple("  100 + 200 * 50 / 10 + -100 ");
        assertSimple("  100 + 200 * 50 / 10 + -height ");
        assertSimple("  100 + 200 * 50 / 10 ^ +height ");
        assertSimple("  10 > 20 ");

    }

    public void testSimpleEvaluations()
    {
        // level 1
        assertSimpleEval("1","1");
        assertSimpleEval("1 and 1","1");
        assertSimpleEval("1 and 0","");
        assertSimpleEval("0 and 1","");
        assertSimpleEval("0 and 0","");
        assertSimpleEval("1 or 1","1");
        assertSimpleEval("1 or 0","1");
        assertSimpleEval("0 or 1","1");
        assertSimpleEval("0 or 0","");
        assertSimpleEval("0 or 0 or 0","");
        assertSimpleEval("0 or 0 or 1","1");
        assertSimpleEval("1 and 1 and 1","1");
        assertSimpleEval("1 and 1 and 0","");
        assertSimpleEval("1 and 1 and 0 or 0","");
        assertSimpleEval("1 and 1 and 0 or 1","1");
        assertSimpleEval("1 and 3 and 0 or 5","1");

        
        // level 2
        assertSimpleEval("not 5","");
        assertSimpleEval("not 1","");
        assertSimpleEval("not 0","1");

        // level 3
        assertSimpleEval("5>1","1");
        assertSimpleEval("5>=1","1");
        assertSimpleEval("5<1","");
        assertSimpleEval("5<=1","");
        assertSimpleEval("5<>1","1");
        assertSimpleEval("5=1","");

        assertSimpleEval("5>7","");
        assertSimpleEval("5>=7","");
        assertSimpleEval("5<7","1");
        assertSimpleEval("5<=7","1");
        assertSimpleEval("5<>7","1");
        assertSimpleEval("5=7","");

        assertSimpleEval("5>5","");
        assertSimpleEval("5>=5","1");
        assertSimpleEval("5<5","");
        assertSimpleEval("5<=5","1");
        assertSimpleEval("5<>5","");
        assertSimpleEval("5=5","1");

        
        // level 4
        assertSimpleEval("'hello ' & 'world'","hello world");
        assertSimpleEval("'hello'&' world'","hello world");
        assertSimpleEval("5&' world'","5 world");
        assertSimpleEval("5&' world'&' '''","5 world '");
        
        // level 5
        assertSimpleEval("1","1");
        assertSimpleEval("1+1","2");
        assertSimpleEval("1+1+1","3");
        assertSimpleEval("1+5-2","4");

        // level 6
        assertSimpleEval("3*4","12");
        assertSimpleEval("1.6*4","6.4");
        assertSimpleEval("10/2","5");
        assertSimpleEval("10%8","2");
        assertSimpleEval("10%8*8","16");
        assertSimpleEval("10%8*8/4","4");
        
        // level 7
        assertSimpleEval("2^6","64");

        // level 8
        assertSimpleEval("-10","-10");
        assertSimpleEval("15 + -10","5");
        
        // mix
        assertSimpleEval("(2+3)*(4+5)","45");
        assertSimpleEval("2+3*4+5","19");
        
        // complex - where precedence is same but 
        // order of execution yields different results
        assertSimpleEval("8%5*3","9");
        assertSimpleEval("8%(5*3)","8");
    }
    
    public void assertSimple(String s)
    {
        Lexer l = new Lexer(new StringReader(s));
        l.setIgnoreWhitespace(true);
        l.setJavaMode(false);
        Parser cep = new Parser(l);
        try {
            cep.expr();
        } catch (ParseException e) {
            e.printStackTrace();
            fail(e.getMessage());
        }
    }

    public void assertSimpleEval(String s,String res)
    {
        Lexer l = new Lexer(new StringReader(s));
        l.setIgnoreWhitespace(true);
        l.setJavaMode(false);
        Parser cep = new Parser(l);
        try {
            CExpr e= cep.expr();
            assertEquals(res,e.eval().toString());
        } catch (ParseException e) {
            e.printStackTrace();
            fail(e.getMessage());
        }
        
    }
    
    public void assertBad(String s)
    {
        Lexer l = new Lexer(new StringReader(s));
        l.setIgnoreWhitespace(true);
        l.setJavaMode(false);
        Parser cep = new Parser(l);
        try {
            cep.expr();
            fail();
        } catch (ParseException e) {
        }
    }
    
}
